Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE03C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CD12146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CD12146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeIMHsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43574 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeIMHsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYn-0006Ox-Ki; Thu, 13 Sep 2018 02:40:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/50] tty_ioctl(): drop FIONBIO handling
Date:   Thu, 13 Sep 2018 03:40:02 +0100
Message-Id: <20180913024049.24567-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

That code had been live for 11 weeks back in 1992, but it had been 26 years
since sys_ioctl() began handling FIONBIO on its own.  Time to to bury the body,
already...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/tty/tty_io.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c2168b43df0f..2b34ccf269e0 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2288,34 +2288,6 @@ static int tioccons(struct file *file)
 }
 
 /**
- *	fionbio		-	non blocking ioctl
- *	@file: file to set blocking value
- *	@p: user parameter
- *
- *	Historical tty interfaces had a blocking control ioctl before
- *	the generic functionality existed. This piece of history is preserved
- *	in the expected tty API of posix OS's.
- *
- *	Locking: none, the open file handle ensures it won't go away.
- */
-
-static int fionbio(struct file *file, int __user *p)
-{
-	int nonblock;
-
-	if (get_user(nonblock, p))
-		return -EFAULT;
-
-	spin_lock(&file->f_lock);
-	if (nonblock)
-		file->f_flags |= O_NONBLOCK;
-	else
-		file->f_flags &= ~O_NONBLOCK;
-	spin_unlock(&file->f_lock);
-	return 0;
-}
-
-/**
  *	tiocsetd	-	set line discipline
  *	@tty: tty device
  *	@p: pointer to user data
@@ -2561,8 +2533,6 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return tiocswinsz(real_tty, p);
 	case TIOCCONS:
 		return real_tty != tty ? -EINVAL : tioccons(file);
-	case FIONBIO:
-		return fionbio(file, p);
 	case TIOCEXCL:
 		set_bit(TTY_EXCLUSIVE, &tty->flags);
 		return 0;
-- 
2.11.0

