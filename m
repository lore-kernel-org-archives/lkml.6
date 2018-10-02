Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D6FC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122812064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122812064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeJCABr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:01:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJCABp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:01:45 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45A90EBC;
        Tue,  2 Oct 2018 17:17:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com, aszlig@nix.build,
        gmazyland@gmail.com, torvalds@linux-foundation.org, w@1wt.eu,
        Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] tty: wipe buffer if not echoing data
Date:   Tue,  2 Oct 2018 10:17:08 -0700
Message-Id: <20181002171708.1311-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002171708.1311-1-gregkh@linuxfoundation.org>
References: <20181002171708.1311-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>

If we are not echoing the data to userspace, then perhaps it is a
"secret" so we should wipe it once we are done with it.

This mirrors the logic that the audit code has.

Reported-by: aszlig <aszlig@nix.build>
Tested-by: Milan Broz <gmazyland@gmail.com>
Tested-by: aszlig <aszlig@nix.build>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_tty.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 431742201709..d259a6585dbe 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -152,17 +152,28 @@ static inline unsigned char *echo_buf_addr(struct n_tty_data *ldata, size_t i)
 	return &ldata->echo_buf[i & (N_TTY_BUF_SIZE - 1)];
 }
 
+/* If we are not echoing the data, perhaps this is a secret so erase it */
+static void zero_buffer(struct tty_struct *tty, u8 *buffer, int size)
+{
+	bool icanon = !!L_ICANON(tty);
+	bool no_echo = !L_ECHO(tty);
+
+	if (icanon && no_echo)
+		memset(buffer, 0x00, size);
+}
+
 static int tty_copy_to_user(struct tty_struct *tty, void __user *to,
 			    size_t tail, size_t n)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t size = N_TTY_BUF_SIZE - tail;
-	const void *from = read_buf_addr(ldata, tail);
+	void *from = read_buf_addr(ldata, tail);
 	int uncopied;
 
 	if (n > size) {
 		tty_audit_add_data(tty, from, size);
 		uncopied = copy_to_user(to, from, size);
+		zero_buffer(tty, from, size);
 		if (uncopied)
 			return uncopied;
 		to += size;
@@ -171,7 +182,9 @@ static int tty_copy_to_user(struct tty_struct *tty, void __user *to,
 	}
 
 	tty_audit_add_data(tty, from, n);
-	return copy_to_user(to, from, n);
+	uncopied = copy_to_user(to, from, n);
+	zero_buffer(tty, from, n);
+	return uncopied;
 }
 
 /**
@@ -1960,11 +1973,12 @@ static int copy_from_read_buf(struct tty_struct *tty,
 	n = min(head - ldata->read_tail, N_TTY_BUF_SIZE - tail);
 	n = min(*nr, n);
 	if (n) {
-		const unsigned char *from = read_buf_addr(ldata, tail);
+		unsigned char *from = read_buf_addr(ldata, tail);
 		retval = copy_to_user(*b, from, n);
 		n -= retval;
 		is_eof = n == 1 && *from == EOF_CHAR(tty);
 		tty_audit_add_data(tty, from, n);
+		zero_buffer(tty, from, n);
 		smp_store_release(&ldata->read_tail, ldata->read_tail + n);
 		/* Turn single EOF into zero-length read */
 		if (L_EXTPROC(tty) && ldata->icanon && is_eof &&
-- 
2.19.0

