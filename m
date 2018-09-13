Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822A4C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C522146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C522146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeIMHuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:50:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43738 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeIMHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYr-0006SM-Kq; Thu, 13 Sep 2018 02:40:53 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 33/50] usb_wwan: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:32 +0100
Message-Id: <20180913024049.24567-33-viro@ZenIV.linux.org.uk>
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
 drivers/usb/serial/option.c   |  3 ++-
 drivers/usb/serial/usb-wwan.h |  6 +++--
 drivers/usb/serial/usb_wwan.c | 63 ++++++++++++-------------------------------
 3 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0215b70c4efc..e6e811ac2331 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1962,7 +1962,8 @@ static struct usb_serial_driver option_1port_device = {
 	.chars_in_buffer   = usb_wwan_chars_in_buffer,
 	.tiocmget          = usb_wwan_tiocmget,
 	.tiocmset          = usb_wwan_tiocmset,
-	.ioctl             = usb_wwan_ioctl,
+	.get_serial        = usb_wwan_get_serial_info,
+	.set_serial        = usb_wwan_set_serial_info,
 	.attach            = option_attach,
 	.release           = option_release,
 	.port_probe        = usb_wwan_port_probe,
diff --git a/drivers/usb/serial/usb-wwan.h b/drivers/usb/serial/usb-wwan.h
index d28dab4b9eff..1c120eaf4091 100644
--- a/drivers/usb/serial/usb-wwan.h
+++ b/drivers/usb/serial/usb-wwan.h
@@ -15,8 +15,10 @@ extern int usb_wwan_write_room(struct tty_struct *tty);
 extern int usb_wwan_tiocmget(struct tty_struct *tty);
 extern int usb_wwan_tiocmset(struct tty_struct *tty,
 			     unsigned int set, unsigned int clear);
-extern int usb_wwan_ioctl(struct tty_struct *tty,
-			  unsigned int cmd, unsigned long arg);
+extern int usb_wwan_get_serial_info(struct tty_struct *tty,
+			   struct serial_struct *ss);
+extern int usb_wwan_set_serial_info(struct tty_struct *tty,
+			   struct serial_struct *ss);
 extern int usb_wwan_write(struct tty_struct *tty, struct usb_serial_port *port,
 			  const unsigned char *buf, int count);
 extern int usb_wwan_chars_in_buffer(struct tty_struct *tty);
diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 912472f26e4f..7e855c87e4f7 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -132,38 +132,32 @@ int usb_wwan_tiocmset(struct tty_struct *tty,
 }
 EXPORT_SYMBOL(usb_wwan_tiocmset);
 
-static int get_serial_info(struct usb_serial_port *port,
-			   struct serial_struct __user *retinfo)
+int usb_wwan_get_serial_info(struct tty_struct *tty,
+			   struct serial_struct *ss)
 {
-	struct serial_struct tmp;
-
-	memset(&tmp, 0, sizeof(tmp));
-	tmp.line            = port->minor;
-	tmp.port            = port->port_number;
-	tmp.baud_base       = tty_get_baud_rate(port->port.tty);
-	tmp.close_delay	    = port->port.close_delay / 10;
-	tmp.closing_wait    = port->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
+	struct usb_serial_port *port = tty->driver_data;
+
+	ss->line            = port->minor;
+	ss->port            = port->port_number;
+	ss->baud_base       = tty_get_baud_rate(port->port.tty);
+	ss->close_delay	    = port->port.close_delay / 10;
+	ss->closing_wait    = port->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 				 ASYNC_CLOSING_WAIT_NONE :
 				 port->port.closing_wait / 10;
-
-	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-		return -EFAULT;
 	return 0;
 }
+EXPORT_SYMBOL(usb_wwan_get_serial_info);
 
-static int set_serial_info(struct usb_serial_port *port,
-			   struct serial_struct __user *newinfo)
+int usb_wwan_set_serial_info(struct tty_struct *tty,
+			   struct serial_struct *ss)
 {
-	struct serial_struct new_serial;
+	struct usb_serial_port *port = tty->driver_data;
 	unsigned int closing_wait, close_delay;
 	int retval = 0;
 
-	if (copy_from_user(&new_serial, newinfo, sizeof(new_serial)))
-		return -EFAULT;
-
-	close_delay = new_serial.close_delay * 10;
-	closing_wait = new_serial.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
-			ASYNC_CLOSING_WAIT_NONE : new_serial.closing_wait * 10;
+	close_delay = ss->close_delay * 10;
+	closing_wait = ss->closing_wait == ASYNC_CLOSING_WAIT_NONE ?
+			ASYNC_CLOSING_WAIT_NONE : ss->closing_wait * 10;
 
 	mutex_lock(&port->port.mutex);
 
@@ -181,30 +175,7 @@ static int set_serial_info(struct usb_serial_port *port,
 	mutex_unlock(&port->port.mutex);
 	return retval;
 }
-
-int usb_wwan_ioctl(struct tty_struct *tty,
-		   unsigned int cmd, unsigned long arg)
-{
-	struct usb_serial_port *port = tty->driver_data;
-
-	dev_dbg(&port->dev, "%s cmd 0x%04x\n", __func__, cmd);
-
-	switch (cmd) {
-	case TIOCGSERIAL:
-		return get_serial_info(port,
-				       (struct serial_struct __user *) arg);
-	case TIOCSSERIAL:
-		return set_serial_info(port,
-				       (struct serial_struct __user *) arg);
-	default:
-		break;
-	}
-
-	dev_dbg(&port->dev, "%s arg not supported\n", __func__);
-
-	return -ENOIOCTLCMD;
-}
-EXPORT_SYMBOL(usb_wwan_ioctl);
+EXPORT_SYMBOL(usb_wwan_set_serial_info);
 
 int usb_wwan_write(struct tty_struct *tty, struct usb_serial_port *port,
 		   const unsigned char *buf, int count)
-- 
2.11.0

