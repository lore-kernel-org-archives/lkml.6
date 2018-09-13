Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAB2C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2BD2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2BD2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeIMHt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:49:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43768 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeIMHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYs-0006Sw-E9; Thu, 13 Sep 2018 02:40:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 38/50] isdn_tty: TCSBRK{,P} won't reach ->ioctl()
Date:   Thu, 13 Sep 2018 03:40:37 +0100
Message-Id: <20180913024049.24567-38-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

kill the long-dead code - it's been unreachable since 2008.  Redundant, as
well - generic will do exact same thing, since ->break_ctl is NULL here...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/isdn/i4l/isdn_tty.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index b730037a0e2d..1b2239c1d569 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1412,31 +1412,12 @@ static int
 isdn_tty_ioctl(struct tty_struct *tty, uint cmd, ulong arg)
 {
 	modem_info *info = (modem_info *) tty->driver_data;
-	int retval;
 
 	if (isdn_tty_paranoia_check(info, tty->name, "isdn_tty_ioctl"))
 		return -ENODEV;
 	if (tty_io_error(tty))
 		return -EIO;
 	switch (cmd) {
-	case TCSBRK:   /* SVID version: non-zero arg --> no break */
-#ifdef ISDN_DEBUG_MODEM_IOCTL
-		printk(KERN_DEBUG "ttyI%d ioctl TCSBRK\n", info->line);
-#endif
-		retval = tty_check_change(tty);
-		if (retval)
-			return retval;
-		tty_wait_until_sent(tty, 0);
-		return 0;
-	case TCSBRKP:  /* support for POSIX tcsendbreak() */
-#ifdef ISDN_DEBUG_MODEM_IOCTL
-		printk(KERN_DEBUG "ttyI%d ioctl TCSBRKP\n", info->line);
-#endif
-		retval = tty_check_change(tty);
-		if (retval)
-			return retval;
-		tty_wait_until_sent(tty, 0);
-		return 0;
 	case TIOCSERGETLSR:	/* Get line status register */
 #ifdef ISDN_DEBUG_MODEM_IOCTL
 		printk(KERN_DEBUG "ttyI%d ioctl TIOCSERGETLSR\n", info->line);
-- 
2.11.0

