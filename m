Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CF0C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE2A213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXzlrEfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE2A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbeK3Bht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732374AbeK3Bhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:37:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F8022146F;
        Thu, 29 Nov 2018 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501935;
        bh=5waDm38YEX2H96UoK++/WInocGUSiwC9n0yHhA0lAHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXzlrEfAu7+avzKCZFCQattGuxqSktcSx2Nru7H2nMQNTXQ3L3QH86Jb5rsrSSjw9
         Fkn14UOSkv2MsQJGLe/5MXsf3JzPSKDghPbb6OTFVi49q5Heb2I42RaQdI+pauBGYS
         Q+I04B1bRDxlI07NKjyNFGDbr68FNkY/Q7Tr6csA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, aszlig <aszlig@nix.build>,
        Milan Broz <gmazyland@gmail.com>,
        Daniel Zatovic <daniel.zatovic@gmail.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 4.19 102/110] tty: wipe buffer if not echoing data
Date:   Thu, 29 Nov 2018 15:13:13 +0100
Message-Id: <20181129135925.367655198@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <greg@kroah.com>

commit b97b3d9fb57860a60592859e332de7759fd54c2e upstream.

If we are not echoing the data to userspace or the console is in icanon
mode, then perhaps it is a "secret" so we should wipe it once we are
done with it.

This mirrors the logic that the audit code has.

Reported-by: aszlig <aszlig@nix.build>
Tested-by: Milan Broz <gmazyland@gmail.com>
Tested-by: Daniel Zatovic <daniel.zatovic@gmail.com>
Tested-by: aszlig <aszlig@nix.build>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/n_tty.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -152,17 +152,28 @@ static inline unsigned char *echo_buf_ad
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
+		zero_buffer(tty, from, size - uncopied);
 		if (uncopied)
 			return uncopied;
 		to += size;
@@ -171,7 +182,9 @@ static int tty_copy_to_user(struct tty_s
 	}
 
 	tty_audit_add_data(tty, from, n);
-	return copy_to_user(to, from, n);
+	uncopied = copy_to_user(to, from, n);
+	zero_buffer(tty, from, n - uncopied);
+	return uncopied;
 }
 
 /**
@@ -1960,11 +1973,12 @@ static int copy_from_read_buf(struct tty
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


