Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F39C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCB12146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCB12146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeIMHuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:50:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43762 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbeIMHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYs-0006Sp-B2; Thu, 13 Sep 2018 02:40:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 37/50] kill capinc_tty_ioctl()
Date:   Thu, 13 Sep 2018 03:40:36 +0100
Message-Id: <20180913024049.24567-37-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

NULL ->ioctl() in tty_operations is treated as "returns -ENOIOCTLCMD"...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/isdn/capi/capi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index ef5560b848ab..e1da70a9530c 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1155,12 +1155,6 @@ static int capinc_tty_chars_in_buffer(struct tty_struct *tty)
 	return mp->outbytes;
 }
 
-static int capinc_tty_ioctl(struct tty_struct *tty,
-			    unsigned int cmd, unsigned long arg)
-{
-	return -ENOIOCTLCMD;
-}
-
 static void capinc_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 {
 	pr_debug("capinc_tty_set_termios\n");
@@ -1236,7 +1230,6 @@ static const struct tty_operations capinc_ops = {
 	.flush_chars = capinc_tty_flush_chars,
 	.write_room = capinc_tty_write_room,
 	.chars_in_buffer = capinc_tty_chars_in_buffer,
-	.ioctl = capinc_tty_ioctl,
 	.set_termios = capinc_tty_set_termios,
 	.throttle = capinc_tty_throttle,
 	.unthrottle = capinc_tty_unthrottle,
-- 
2.11.0

