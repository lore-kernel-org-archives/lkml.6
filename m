Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56356C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1898E2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1898E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeIMHtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:49:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43786 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeIMHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYs-0006TH-WE; Thu, 13 Sep 2018 02:40:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 41/50] dgnc: break-related ioctls won't reach ->ioctl()
Date:   Thu, 13 Sep 2018 03:40:40 +0100
Message-Id: <20180913024049.24567-41-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

kill the dead code, especially since ->break_ctl() will do the
right thing anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/dgnc/dgnc_tty.c | 75 -----------------------------------------
 1 file changed, 75 deletions(-)

diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
index 9accaa705820..040af55e9e68 100644
--- a/drivers/staging/dgnc/dgnc_tty.c
+++ b/drivers/staging/dgnc/dgnc_tty.c
@@ -2081,81 +2081,6 @@ static int dgnc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 
 	switch (cmd) {
 	/* Here are all the standard ioctl's that we MUST implement */
-
-	case TCSBRK:
-		/*
-		 * TCSBRK is SVID version: non-zero arg --> no break
-		 * this behaviour is exploited by tcdrain().
-		 *
-		 * According to POSIX.1 spec (7.2.2.1.2) breaks should be
-		 * between 0.25 and 0.5 seconds so we'll ask for something
-		 * in the middle: 0.375 seconds.
-		 */
-		rc = tty_check_change(tty);
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-		if (rc)
-			return rc;
-
-		rc = ch_bd_ops->drain(tty, 0);
-		if (rc)
-			return -EINTR;
-
-		spin_lock_irqsave(&ch->ch_lock, flags);
-
-		if (((cmd == TCSBRK) && (!arg)) || (cmd == TCSBRKP))
-			ch_bd_ops->send_break(ch, 250);
-
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-
-		return 0;
-
-	case TCSBRKP:
-		/*
-		 * support for POSIX tcsendbreak()
-		 * According to POSIX.1 spec (7.2.2.1.2) breaks should be
-		 * between 0.25 and 0.5 seconds so we'll ask for something
-		 * in the middle: 0.375 seconds.
-		 */
-		rc = tty_check_change(tty);
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-		if (rc)
-			return rc;
-
-		rc = ch_bd_ops->drain(tty, 0);
-		if (rc)
-			return -EINTR;
-
-		spin_lock_irqsave(&ch->ch_lock, flags);
-
-		ch_bd_ops->send_break(ch, 250);
-
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-
-		return 0;
-
-	case TIOCSBRK:
-		rc = tty_check_change(tty);
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-		if (rc)
-			return rc;
-
-		rc = ch_bd_ops->drain(tty, 0);
-		if (rc)
-			return -EINTR;
-
-		spin_lock_irqsave(&ch->ch_lock, flags);
-
-		ch_bd_ops->send_break(ch, 250);
-
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-
-		return 0;
-
-	case TIOCCBRK:
-		/* Do Nothing */
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-		return 0;
-
 	case TIOCGSOFTCAR:
 
 		spin_unlock_irqrestore(&ch->ch_lock, flags);
-- 
2.11.0

