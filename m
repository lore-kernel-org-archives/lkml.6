Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA817C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3B42146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3B42146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeIMHuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:50:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43750 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeIMHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYr-0006Sa-TP; Thu, 13 Sep 2018 02:40:53 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 35/50] synclink: reduce pointless checks in ->ioctl()
Date:   Thu, 13 Sep 2018 03:40:34 +0100
Message-Id: <20180913024049.24567-35-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

it's never getting called with TIOC[SG]SERIAL anymore (nor has
it ever supported those, while we are at it)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/pcmcia/synclink_cs.c | 3 +--
 drivers/tty/synclink.c            | 3 +--
 drivers/tty/synclink_gt.c         | 3 +--
 drivers/tty/synclinkmp.c          | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 66b04194aa9f..82f9a6a814ae 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -2237,8 +2237,7 @@ static int mgslpc_ioctl(struct tty_struct *tty,
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_ioctl"))
 		return -ENODEV;
 
-	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
-	    (cmd != TIOCMIWAIT)) {
+	if (cmd != TIOCMIWAIT) {
 		if (tty_io_error(tty))
 		    return -EIO;
 	}
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index fbdf4d01c6a9..d55c858d6058 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -2959,8 +2959,7 @@ static int mgsl_ioctl(struct tty_struct *tty,
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_ioctl"))
 		return -ENODEV;
 
-	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
-	    (cmd != TIOCMIWAIT)) {
+	if (cmd != TIOCMIWAIT) {
 		if (tty_io_error(tty))
 		    return -EIO;
 	}
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index a94086597ebd..b8287a010336 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1029,8 +1029,7 @@ static int ioctl(struct tty_struct *tty,
 		return -ENODEV;
 	DBGINFO(("%s ioctl() cmd=%08X\n", info->device_name, cmd));
 
-	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
-	    (cmd != TIOCMIWAIT)) {
+	if (cmd != TIOCMIWAIT) {
 		if (tty_io_error(tty))
 		    return -EIO;
 	}
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 1e4d5b9c981a..fcb91bf7a15b 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -1259,8 +1259,7 @@ static int ioctl(struct tty_struct *tty,
 	if (sanity_check(info, tty->name, "ioctl"))
 		return -ENODEV;
 
-	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
-	    (cmd != TIOCMIWAIT)) {
+	if (cmd != TIOCMIWAIT) {
 		if (tty_io_error(tty))
 		    return -EIO;
 	}
-- 
2.11.0

