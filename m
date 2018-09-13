Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1B2C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D392146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D392146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeIMHsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43660 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeIMHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYp-0006Qn-MF; Thu, 13 Sep 2018 02:40:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/50] ark3116: switch to ->get_serial()
Date:   Thu, 13 Sep 2018 03:40:18 +0100
Message-Id: <20180913024049.24567-19-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/serial/ark3116.c | 38 ++++++++------------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 7796ad8e33c6..ff38aa8963cf 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -397,38 +397,16 @@ static int ark3116_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return result;
 }
 
-static int ark3116_get_serial_info(struct usb_serial_port *port,
-			struct serial_struct __user *retinfo)
-{
-	struct serial_struct tmp;
-
-	memset(&tmp, 0, sizeof(tmp));
-
-	tmp.type = PORT_16654;
-	tmp.line = port->minor;
-	tmp.port = port->port_number;
-	tmp.baud_base = 460800;
-
-	if (copy_to_user(retinfo, &tmp, sizeof(tmp)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int ark3116_ioctl(struct tty_struct *tty,
-			 unsigned int cmd, unsigned long arg)
+static int ark3116_get_serial_info(struct tty_struct *tty,
+			struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	void __user *user_arg = (void __user *)arg;
-
-	switch (cmd) {
-	case TIOCGSERIAL:
-		return ark3116_get_serial_info(port, user_arg);
-	default:
-		break;
-	}
 
-	return -ENOIOCTLCMD;
+	ss->type = PORT_16654;
+	ss->line = port->minor;
+	ss->port = port->port_number;
+	ss->baud_base = 460800;
+	return 0;
 }
 
 static int ark3116_tiocmget(struct tty_struct *tty)
@@ -668,7 +646,7 @@ static struct usb_serial_driver ark3116_device = {
 	.port_remove =		ark3116_port_remove,
 	.set_termios =		ark3116_set_termios,
 	.init_termios =		ark3116_init_termios,
-	.ioctl =		ark3116_ioctl,
+	.get_serial =		ark3116_get_serial_info,
 	.tiocmget =		ark3116_tiocmget,
 	.tiocmset =		ark3116_tiocmset,
 	.tiocmiwait =		usb_serial_generic_tiocmiwait,
-- 
2.11.0

