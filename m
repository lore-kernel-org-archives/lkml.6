Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB72FC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FDA2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FDA2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeIMHuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:50:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43784 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbeIMHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYs-0006TA-Rl; Thu, 13 Sep 2018 02:40:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 40/50] kill the rest of tty COMPAT_IOCTL() entries
Date:   Thu, 13 Sep 2018 03:40:39 +0100
Message-Id: <20180913024049.24567-40-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

TIOCLINUX is handled by ->compat_ioctl() in the only place that has
native ->ioctl() recognizing it, TIOC{START,STOP} are simply useless
these days - unrecognized compat ioctl won't spew into syslog
anymore.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/compat_ioctl.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 2b35c6707e3d..ca2b51d9cb61 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -647,8 +647,6 @@ static unsigned int ioctl_pointer[] = {
 COMPATIBLE_IOCTL(0x4B50)   /* KDGHWCLK - not in the kernel, but don't complain */
 COMPATIBLE_IOCTL(0x4B51)   /* KDSHWCLK - not in the kernel, but don't complain */
 
-/* Big T */
-COMPATIBLE_IOCTL(TIOCLINUX)
 /* Little t */
 COMPATIBLE_IOCTL(TIOCOUTQ)
 /* Little f */
@@ -1113,17 +1111,6 @@ COMPATIBLE_IOCTL(JSIOCGAXES)
 COMPATIBLE_IOCTL(JSIOCGBUTTONS)
 COMPATIBLE_IOCTL(JSIOCGNAME(0))
 
-#ifdef TIOCSTART
-/*
- * For these two we have definitions in ioctls.h and/or termios.h on
- * some architectures but no actual implemention.  Some applications
- * like bash call them if they are defined in the headers, so we provide
- * entries here to avoid syslog message spew.
- */
-COMPATIBLE_IOCTL(TIOCSTART)
-COMPATIBLE_IOCTL(TIOCSTOP)
-#endif
-
 /* fat 'r' ioctls. These are handled by fat with ->compat_ioctl,
    but we don't want warnings on other file systems. So declare
    them as compatible here. */
-- 
2.11.0

