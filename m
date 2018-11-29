Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D6FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732A021104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm9NwdOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732A021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbeK3B0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:26:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbeK3B0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:26:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04833213A2;
        Thu, 29 Nov 2018 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501230;
        bh=Z/JqYMHqAqMKnmhPzxfZHw1rhanlhfm80HyFYNcPbPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bm9NwdOADqSFYuuiK4vv0ZhNlhHEvj2wPM/7nj+R6TLc3kJcwH/1MUxKmtmyvT+ih
         VGpVwNv34nRqKJV/L5X6yfL/pE/6e257v1NmTxT9FA4tvKYT3+VzzOqjFK3AwhR+Vn
         gCneIkK3JtXIjFzuWfwcxYGBVHttGTKulDyJAhy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, aszlig <aszlig@nix.build>,
        Milan Broz <gmazyland@gmail.com>,
        Daniel Zatovic <daniel.zatovic@gmail.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 4.4 80/86] tty: wipe buffer if not echoing data
Date:   Thu, 29 Nov 2018 15:12:45 +0100
Message-Id: <20181129140116.199938408@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/tty/n_tty.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -165,15 +165,29 @@ static inline int tty_put_user(struct tt
 	return put_user(x, ptr);
 }
 
+/* If we are not echoing the data, perhaps this is a secret so erase it */
+static inline void zero_buffer(struct tty_struct *tty, u8 *buffer, int size)
+{
+	bool icanon = !!L_ICANON(tty);
+	bool no_echo = !L_ECHO(tty);
+
+	if (icanon && no_echo)
+		memset(buffer, 0x00, size);
+}
+
 static inline int tty_copy_to_user(struct tty_struct *tty,
 					void __user *to,
-					const void *from,
+					void *from,
 					unsigned long n)
 {
 	struct n_tty_data *ldata = tty->disc_data;
+	int retval;
 
 	tty_audit_add_data(tty, from, n, ldata->icanon);
-	return copy_to_user(to, from, n);
+	retval = copy_to_user(to, from, n);
+	if (!retval)
+		zero_buffer(tty, from, n);
+	return retval;
 }
 
 /**
@@ -2005,6 +2019,7 @@ static int copy_from_read_buf(struct tty
 		is_eof = n == 1 && read_buf(ldata, tail) == EOF_CHAR(tty);
 		tty_audit_add_data(tty, read_buf_addr(ldata, tail), n,
 				ldata->icanon);
+		zero_buffer(tty, read_buf_addr(ldata, tail), n);
 		smp_store_release(&ldata->read_tail, ldata->read_tail + n);
 		/* Turn single EOF into zero-length read */
 		if (L_EXTPROC(tty) && ldata->icanon && is_eof &&


