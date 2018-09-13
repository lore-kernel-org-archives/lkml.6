Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6277BC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C392146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C392146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeIMHuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:50:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43730 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeIMHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYr-0006S8-CG; Thu, 13 Sep 2018 02:40:53 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 31/50] ti_usb_3410_5052: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:30 +0100
Message-Id: <20180913024049.24567-31-viro@ZenIV.linux.org.uk>
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
 drivers/usb/serial/ti_usb_3410_5052.c | 74 ++++++++++++-----------------------
 1 file changed, 24 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 3010878f7f8e..265738228094 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -313,8 +313,6 @@ static int ti_chars_in_buffer(struct tty_struct *tty);
 static bool ti_tx_empty(struct usb_serial_port *port);
 static void ti_throttle(struct tty_struct *tty);
 static void ti_unthrottle(struct tty_struct *tty);
-static int ti_ioctl(struct tty_struct *tty,
-		unsigned int cmd, unsigned long arg);
 static void ti_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios);
 static int ti_tiocmget(struct tty_struct *tty);
@@ -330,10 +328,10 @@ static void ti_recv(struct usb_serial_port *port, unsigned char *data,
 static void ti_send(struct ti_port *tport);
 static int ti_set_mcr(struct ti_port *tport, unsigned int mcr);
 static int ti_get_lsr(struct ti_port *tport, u8 *lsr);
-static int ti_get_serial_info(struct ti_port *tport,
-	struct serial_struct __user *ret_arg);
-static int ti_set_serial_info(struct tty_struct *tty, struct ti_port *tport,
-	struct serial_struct __user *new_arg);
+static int ti_get_serial_info(struct tty_struct *tty,
+	struct serial_struct *ss);
+static int ti_set_serial_info(struct tty_struct *tty,
+	struct serial_struct *ss);
 static void ti_handle_new_msr(struct ti_port *tport, u8 msr);
 
 static void ti_stop_read(struct ti_port *tport, struct tty_struct *tty);
@@ -436,7 +434,8 @@ static struct usb_serial_driver ti_1port_device = {
 	.tx_empty		= ti_tx_empty,
 	.throttle		= ti_throttle,
 	.unthrottle		= ti_unthrottle,
-	.ioctl			= ti_ioctl,
+	.get_serial		= ti_get_serial_info,
+	.set_serial		= ti_set_serial_info,
 	.set_termios		= ti_set_termios,
 	.tiocmget		= ti_tiocmget,
 	.tiocmset		= ti_tiocmset,
@@ -469,7 +468,8 @@ static struct usb_serial_driver ti_2port_device = {
 	.tx_empty		= ti_tx_empty,
 	.throttle		= ti_throttle,
 	.unthrottle		= ti_unthrottle,
-	.ioctl			= ti_ioctl,
+	.get_serial		= ti_get_serial_info,
+	.set_serial		= ti_set_serial_info,
 	.set_termios		= ti_set_termios,
 	.tiocmget		= ti_tiocmget,
 	.tiocmset		= ti_tiocmset,
@@ -902,24 +902,6 @@ static void ti_unthrottle(struct tty_struct *tty)
 	}
 }
 
-static int ti_ioctl(struct tty_struct *tty,
-	unsigned int cmd, unsigned long arg)
-{
-	struct usb_serial_port *port = tty->driver_data;
-	struct ti_port *tport = usb_get_serial_port_data(port);
-
-	switch (cmd) {
-	case TIOCGSERIAL:
-		return ti_get_serial_info(tport,
-				(struct serial_struct __user *)arg);
-	case TIOCSSERIAL:
-		return ti_set_serial_info(tty, tport,
-				(struct serial_struct __user *)arg);
-	}
-	return -ENOIOCTLCMD;
-}
-
-
 static void ti_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
@@ -1417,45 +1399,37 @@ static int ti_get_lsr(struct ti_port *tport, u8 *lsr)
 }
 
 
-static int ti_get_serial_info(struct ti_port *tport,
-	struct serial_struct __user *ret_arg)
+static int ti_get_serial_info(struct tty_struct *tty,
+	struct serial_struct *ss)
 {
-	struct usb_serial_port *port = tport->tp_port;
-	struct serial_struct ret_serial;
+	struct usb_serial_port *port = tty->driver_data;
+	struct ti_port *tport = usb_get_serial_port_data(port);
 	unsigned cwait;
 
 	cwait = port->port.closing_wait;
 	if (cwait != ASYNC_CLOSING_WAIT_NONE)
 		cwait = jiffies_to_msecs(cwait) / 10;
 
-	memset(&ret_serial, 0, sizeof(ret_serial));
-
-	ret_serial.type = PORT_16550A;
-	ret_serial.line = port->minor;
-	ret_serial.port = port->port_number;
-	ret_serial.xmit_fifo_size = kfifo_size(&port->write_fifo);
-	ret_serial.baud_base = tport->tp_tdev->td_is_3410 ? 921600 : 460800;
-	ret_serial.closing_wait = cwait;
-
-	if (copy_to_user(ret_arg, &ret_serial, sizeof(*ret_arg)))
-		return -EFAULT;
-
+	ss->type = PORT_16550A;
+	ss->line = port->minor;
+	ss->port = port->port_number;
+	ss->xmit_fifo_size = kfifo_size(&port->write_fifo);
+	ss->baud_base = tport->tp_tdev->td_is_3410 ? 921600 : 460800;
+	ss->closing_wait = cwait;
 	return 0;
 }
 
 
-static int ti_set_serial_info(struct tty_struct *tty, struct ti_port *tport,
-	struct serial_struct __user *new_arg)
+static int ti_set_serial_info(struct tty_struct *tty,
+	struct serial_struct *ss)
 {
-	struct serial_struct new_serial;
+	struct usb_serial_port *port = tty->driver_data;
+	struct ti_port *tport = usb_get_serial_port_data(port);
 	unsigned cwait;
 
-	if (copy_from_user(&new_serial, new_arg, sizeof(new_serial)))
-		return -EFAULT;
-
-	cwait = new_serial.closing_wait;
+	cwait = ss->closing_wait;
 	if (cwait != ASYNC_CLOSING_WAIT_NONE)
-		cwait = msecs_to_jiffies(10 * new_serial.closing_wait);
+		cwait = msecs_to_jiffies(10 * ss->closing_wait);
 
 	tport->tp_port->port.closing_wait = cwait;
 
-- 
2.11.0

