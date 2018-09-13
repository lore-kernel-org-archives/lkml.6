Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86453C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235222146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235222146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeIMHuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:50:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43736 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeIMHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYr-0006SF-GV; Thu, 13 Sep 2018 02:40:53 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 32/50] whiteheat: switch to ->get_serial()
Date:   Thu, 13 Sep 2018 03:40:31 +0100
Message-Id: <20180913024049.24567-32-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and fix the return value - on success it used to have ioctl(2)
fill the user-supplied struct serial_struct and return -ENOTTY.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/serial/whiteheat.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index 1c7b46a8620c..aefd84f88b59 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -83,8 +83,8 @@ static int  whiteheat_port_remove(struct usb_serial_port *port);
 static int  whiteheat_open(struct tty_struct *tty,
 			struct usb_serial_port *port);
 static void whiteheat_close(struct usb_serial_port *port);
-static int  whiteheat_ioctl(struct tty_struct *tty,
-			unsigned int cmd, unsigned long arg);
+static int  whiteheat_get_serial(struct tty_struct *tty,
+			struct serial_struct *ss);
 static void whiteheat_set_termios(struct tty_struct *tty,
 			struct usb_serial_port *port, struct ktermios *old);
 static int  whiteheat_tiocmget(struct tty_struct *tty);
@@ -120,7 +120,7 @@ static struct usb_serial_driver whiteheat_device = {
 	.port_remove =		whiteheat_port_remove,
 	.open =			whiteheat_open,
 	.close =		whiteheat_close,
-	.ioctl =		whiteheat_ioctl,
+	.get_serial =		whiteheat_get_serial,
 	.set_termios =		whiteheat_set_termios,
 	.break_ctl =		whiteheat_break_ctl,
 	.tiocmget =		whiteheat_tiocmget,
@@ -442,33 +442,21 @@ static int whiteheat_tiocmset(struct tty_struct *tty,
 }
 
 
-static int whiteheat_ioctl(struct tty_struct *tty,
-					unsigned int cmd, unsigned long arg)
+static int whiteheat_get_serial(struct tty_struct *tty,
+				struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	struct serial_struct serstruct;
-	void __user *user_arg = (void __user *)arg;
-
-	switch (cmd) {
-	case TIOCGSERIAL:
-		memset(&serstruct, 0, sizeof(serstruct));
-		serstruct.type = PORT_16654;
-		serstruct.line = port->minor;
-		serstruct.port = port->port_number;
-		serstruct.xmit_fifo_size = kfifo_size(&port->write_fifo);
-		serstruct.custom_divisor = 0;
-		serstruct.baud_base = 460800;
-		serstruct.close_delay = CLOSING_DELAY;
-		serstruct.closing_wait = CLOSING_DELAY;
-
-		if (copy_to_user(user_arg, &serstruct, sizeof(serstruct)))
-			return -EFAULT;
-		break;
-	default:
-		break;
-	}
 
-	return -ENOIOCTLCMD;
+	ss->type = PORT_16654;
+	ss->line = port->minor;
+	ss->port = port->port_number;
+	ss->xmit_fifo_size = kfifo_size(&port->write_fifo);
+	ss->custom_divisor = 0;
+	ss->baud_base = 460800;
+	ss->close_delay = CLOSING_DELAY;
+	ss->closing_wait = CLOSING_DELAY;
+
+	return 0;
 }
 
 
-- 
2.11.0

