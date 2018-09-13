Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6B4C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC692146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC692146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIMHsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43626 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeIMHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYo-0006QB-UE; Thu, 13 Sep 2018 02:40:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/50] mxser: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:13 +0100
Message-Id: <20180913024049.24567-14-viro@ZenIV.linux.org.uk>
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
 drivers/tty/mxser.c | 97 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 8bc15cb67a58..9d00ff5ef961 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1207,76 +1207,90 @@ static int mxser_chars_in_buffer(struct tty_struct *tty)
  * ------------------------------------------------------------
  */
 static int mxser_get_serial_info(struct tty_struct *tty,
-		struct serial_struct __user *retinfo)
+		struct serial_struct *ss)
 {
 	struct mxser_port *info = tty->driver_data;
-	struct serial_struct tmp = {
-		.type = info->type,
-		.line = tty->index,
-		.port = info->ioaddr,
-		.irq = info->board->irq,
-		.flags = info->port.flags,
-		.baud_base = info->baud_base,
-		.close_delay = info->port.close_delay,
-		.closing_wait = info->port.closing_wait,
-		.custom_divisor = info->custom_divisor,
-	};
-	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-		return -EFAULT;
+	struct tty_port *port = &info->port;
+
+	if (tty->index == MXSER_PORTS)
+		return -ENOTTY;
+
+	mutex_lock(&port->mutex);
+	ss->type = info->type,
+	ss->line = tty->index,
+	ss->port = info->ioaddr,
+	ss->irq = info->board->irq,
+	ss->flags = info->port.flags,
+	ss->baud_base = info->baud_base,
+	ss->close_delay = info->port.close_delay,
+	ss->closing_wait = info->port.closing_wait,
+	ss->custom_divisor = info->custom_divisor,
+	mutex_unlock(&port->mutex);
 	return 0;
 }
 
 static int mxser_set_serial_info(struct tty_struct *tty,
-		struct serial_struct __user *new_info)
+		struct serial_struct *ss)
 {
 	struct mxser_port *info = tty->driver_data;
 	struct tty_port *port = &info->port;
-	struct serial_struct new_serial;
 	speed_t baud;
 	unsigned long sl_flags;
 	unsigned int flags;
 	int retval = 0;
 
-	if (!new_info || !info->ioaddr)
+	if (tty->index == MXSER_PORTS)
+		return -ENOTTY;
+	if (tty_io_error(tty))
+		return -EIO;
+
+	mutex_lock(&port->mutex);
+	if (!info->ioaddr) {
+		mutex_unlock(&port->mutex);
 		return -ENODEV;
-	if (copy_from_user(&new_serial, new_info, sizeof(new_serial)))
-		return -EFAULT;
+	}
 
-	if (new_serial.irq != info->board->irq ||
-			new_serial.port != info->ioaddr)
+	if (ss->irq != info->board->irq ||
+			ss->port != info->ioaddr) {
+		mutex_unlock(&port->mutex);
 		return -EINVAL;
+	}
 
 	flags = port->flags & ASYNC_SPD_MASK;
 
 	if (!capable(CAP_SYS_ADMIN)) {
-		if ((new_serial.baud_base != info->baud_base) ||
-				(new_serial.close_delay != info->port.close_delay) ||
-				((new_serial.flags & ~ASYNC_USR_MASK) != (info->port.flags & ~ASYNC_USR_MASK)))
+		if ((ss->baud_base != info->baud_base) ||
+				(ss->close_delay != info->port.close_delay) ||
+				((ss->flags & ~ASYNC_USR_MASK) != (info->port.flags & ~ASYNC_USR_MASK))) {
+			mutex_unlock(&port->mutex);
 			return -EPERM;
+		}
 		info->port.flags = ((info->port.flags & ~ASYNC_USR_MASK) |
-				(new_serial.flags & ASYNC_USR_MASK));
+				(ss->flags & ASYNC_USR_MASK));
 	} else {
 		/*
 		 * OK, past this point, all the error checking has been done.
 		 * At this point, we start making changes.....
 		 */
 		port->flags = ((port->flags & ~ASYNC_FLAGS) |
-				(new_serial.flags & ASYNC_FLAGS));
-		port->close_delay = new_serial.close_delay * HZ / 100;
-		port->closing_wait = new_serial.closing_wait * HZ / 100;
+				(ss->flags & ASYNC_FLAGS));
+		port->close_delay = ss->close_delay * HZ / 100;
+		port->closing_wait = ss->closing_wait * HZ / 100;
 		port->low_latency = (port->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST &&
-				(new_serial.baud_base != info->baud_base ||
-				new_serial.custom_divisor !=
+				(ss->baud_base != info->baud_base ||
+				ss->custom_divisor !=
 				info->custom_divisor)) {
-			if (new_serial.custom_divisor == 0)
+			if (ss->custom_divisor == 0) {
+				mutex_unlock(&port->mutex);
 				return -EINVAL;
-			baud = new_serial.baud_base / new_serial.custom_divisor;
+			}
+			baud = ss->baud_base / ss->custom_divisor;
 			tty_encode_baud_rate(tty, baud, baud);
 		}
 	}
 
-	info->type = new_serial.type;
+	info->type = ss->type;
 
 	process_txrx_fifo(info);
 
@@ -1291,6 +1305,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 		if (retval == 0)
 			tty_port_set_initialized(port, 1);
 	}
+	mutex_unlock(&port->mutex);
 	return retval;
 }
 
@@ -1660,11 +1675,9 @@ static int mxser_ioctl(struct tty_struct *tty,
 		unsigned int cmd, unsigned long arg)
 {
 	struct mxser_port *info = tty->driver_data;
-	struct tty_port *port = &info->port;
 	struct async_icount cnow;
 	unsigned long flags;
 	void __user *argp = (void __user *)arg;
-	int retval;
 
 	if (tty->index == MXSER_PORTS)
 		return mxser_ioctl_special(cmd, argp);
@@ -1708,20 +1721,10 @@ static int mxser_ioctl(struct tty_struct *tty,
 		return 0;
 	}
 
-	if (cmd != TIOCGSERIAL && cmd != TIOCMIWAIT && tty_io_error(tty))
+	if (cmd != TIOCMIWAIT && tty_io_error(tty))
 		return -EIO;
 
 	switch (cmd) {
-	case TIOCGSERIAL:
-		mutex_lock(&port->mutex);
-		retval = mxser_get_serial_info(tty, argp);
-		mutex_unlock(&port->mutex);
-		return retval;
-	case TIOCSSERIAL:
-		mutex_lock(&port->mutex);
-		retval = mxser_set_serial_info(tty, argp);
-		mutex_unlock(&port->mutex);
-		return retval;
 	case TIOCSERGETLSR:	/* Get line status register */
 		return  mxser_get_lsr_info(info, argp);
 		/*
@@ -2325,6 +2328,8 @@ static const struct tty_operations mxser_ops = {
 	.wait_until_sent = mxser_wait_until_sent,
 	.tiocmget = mxser_tiocmget,
 	.tiocmset = mxser_tiocmset,
+	.set_serial = mxser_set_serial_info,
+	.get_serial = mxser_get_serial_info,
 	.get_icount = mxser_get_icount,
 };
 
-- 
2.11.0

