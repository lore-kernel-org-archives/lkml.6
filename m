Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A00C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9737721476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9737721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeIMHsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43678 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeIMHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYq-0006R7-26; Thu, 13 Sep 2018 02:40:52 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/50] fdti_sio: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:21 +0100
Message-Id: <20180913024049.24567-22-viro@ZenIV.linux.org.uk>
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
 drivers/usb/serial/ftdi_sio.c | 48 +++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b5cef322826f..758ba789e997 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1055,6 +1055,10 @@ static int  ftdi_tiocmset(struct tty_struct *tty,
 			unsigned int set, unsigned int clear);
 static int  ftdi_ioctl(struct tty_struct *tty,
 			unsigned int cmd, unsigned long arg);
+static int get_serial_info(struct tty_struct *tty,
+				struct serial_struct *ss);
+static int set_serial_info(struct tty_struct *tty,
+				struct serial_struct *ss);
 static void ftdi_break_ctl(struct tty_struct *tty, int break_state);
 static bool ftdi_tx_empty(struct usb_serial_port *port);
 static int ftdi_get_modem_status(struct usb_serial_port *port,
@@ -1091,6 +1095,8 @@ static struct usb_serial_driver ftdi_sio_device = {
 	.tiocmiwait =		usb_serial_generic_tiocmiwait,
 	.get_icount =           usb_serial_generic_get_icount,
 	.ioctl =		ftdi_ioctl,
+	.get_serial =		get_serial_info,
+	.set_serial =		set_serial_info,
 	.set_termios =		ftdi_set_termios,
 	.break_ctl =		ftdi_break_ctl,
 	.tx_empty =		ftdi_tx_empty,
@@ -1443,48 +1449,42 @@ static int read_latency_timer(struct usb_serial_port *port)
 	return 0;
 }
 
-static int get_serial_info(struct usb_serial_port *port,
-				struct serial_struct __user *retinfo)
+static int get_serial_info(struct tty_struct *tty,
+				struct serial_struct *ss)
 {
+	struct usb_serial_port *port = tty->driver_data;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	struct serial_struct tmp;
 
-	memset(&tmp, 0, sizeof(tmp));
-	tmp.flags = priv->flags;
-	tmp.baud_base = priv->baud_base;
-	tmp.custom_divisor = priv->custom_divisor;
-	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-		return -EFAULT;
+	ss->flags = priv->flags;
+	ss->baud_base = priv->baud_base;
+	ss->custom_divisor = priv->custom_divisor;
 	return 0;
 }
 
 static int set_serial_info(struct tty_struct *tty,
-	struct usb_serial_port *port, struct serial_struct __user *newinfo)
+	struct serial_struct *ss)
 {
+	struct usb_serial_port *port = tty->driver_data;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	struct serial_struct new_serial;
 	struct ftdi_private old_priv;
 
-	if (copy_from_user(&new_serial, newinfo, sizeof(new_serial)))
-		return -EFAULT;
-
 	mutex_lock(&priv->cfg_lock);
 	old_priv = *priv;
 
 	/* Do error checking and permission checking */
 
 	if (!capable(CAP_SYS_ADMIN)) {
-		if ((new_serial.flags ^ priv->flags) & ~ASYNC_USR_MASK) {
+		if ((ss->flags ^ priv->flags) & ~ASYNC_USR_MASK) {
 			mutex_unlock(&priv->cfg_lock);
 			return -EPERM;
 		}
 		priv->flags = ((priv->flags & ~ASYNC_USR_MASK) |
-			       (new_serial.flags & ASYNC_USR_MASK));
-		priv->custom_divisor = new_serial.custom_divisor;
+			       (ss->flags & ASYNC_USR_MASK));
+		priv->custom_divisor = ss->custom_divisor;
 		goto check_and_exit;
 	}
 
-	if (new_serial.baud_base != priv->baud_base) {
+	if (ss->baud_base != priv->baud_base) {
 		mutex_unlock(&priv->cfg_lock);
 		return -EINVAL;
 	}
@@ -1492,8 +1492,8 @@ static int set_serial_info(struct tty_struct *tty,
 	/* Make the changes - these are privileged changes! */
 
 	priv->flags = ((priv->flags & ~ASYNC_FLAGS) |
-					(new_serial.flags & ASYNC_FLAGS));
-	priv->custom_divisor = new_serial.custom_divisor;
+					(ss->flags & ASYNC_FLAGS));
+	priv->custom_divisor = ss->custom_divisor;
 
 check_and_exit:
 	write_latency_timer(port);
@@ -1507,10 +1507,8 @@ static int set_serial_info(struct tty_struct *tty,
 			dev_warn_ratelimited(&port->dev, "use of SPD flags is deprecated\n");
 
 		change_speed(tty, port);
-		mutex_unlock(&priv->cfg_lock);
 	}
-	else
-		mutex_unlock(&priv->cfg_lock);
+	mutex_unlock(&priv->cfg_lock);
 	return 0;
 }
 
@@ -2452,10 +2450,6 @@ static int ftdi_ioctl(struct tty_struct *tty,
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case TIOCGSERIAL:
-		return get_serial_info(port, argp);
-	case TIOCSSERIAL:
-		return set_serial_info(tty, port, argp);
 	case TIOCSERGETLSR:
 		return get_lsr_info(port, argp);
 	default:
-- 
2.11.0

