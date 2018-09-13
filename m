Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D6EC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E6821476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E6821476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeIMHtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:49:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43802 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeIMHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYt-0006TU-95; Thu, 13 Sep 2018 02:40:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 43/50] dgnc: leave TIOC[GS]SOFTCAR to ldisc
Date:   Thu, 13 Sep 2018 03:40:42 +0100
Message-Id: <20180913024049.24567-43-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

no point duplicating that in tty_operations ->ioctl()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/dgnc/dgnc_tty.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
index 040af55e9e68..c01616f9e609 100644
--- a/drivers/staging/dgnc/dgnc_tty.c
+++ b/drivers/staging/dgnc/dgnc_tty.c
@@ -2080,31 +2080,7 @@ static int dgnc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 	}
 
 	switch (cmd) {
-	/* Here are all the standard ioctl's that we MUST implement */
-	case TIOCGSOFTCAR:
-
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-
-		return put_user(C_CLOCAL(tty) ? 1 : 0,
-				(unsigned long __user *)arg);
-
-	case TIOCSSOFTCAR:
-
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-		rc = get_user(arg, (unsigned long __user *)arg);
-		if (rc)
-			return rc;
-
-		spin_lock_irqsave(&ch->ch_lock, flags);
-		tty->termios.c_cflag = ((tty->termios.c_cflag & ~CLOCAL) |
-				       (arg ? CLOCAL : 0));
-		ch_bd_ops->param(tty);
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-
-		return 0;
-
 		/* Here are any additional ioctl's that we want to implement */
-
 	case TCFLSH:
 		/*
 		 * The linux tty driver doesn't have a flush
-- 
2.11.0

