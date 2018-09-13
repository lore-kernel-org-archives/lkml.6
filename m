Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1DEC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC412146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC412146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIMHsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43614 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeIMHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYo-0006Pv-KM; Thu, 13 Sep 2018 02:40:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/50] isicom: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:11 +0100
Message-Id: <20180913024049.24567-12-viro@ZenIV.linux.org.uk>
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
 drivers/tty/isicom.c | 72 ++++++++++++++++++----------------------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index 8d96e86966f1..e04a43e89f6b 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -1091,34 +1091,33 @@ static int isicom_tiocmset(struct tty_struct *tty,
 }
 
 static int isicom_set_serial_info(struct tty_struct *tty,
-					struct serial_struct __user *info)
+					struct serial_struct *ss)
 {
 	struct isi_port *port = tty->driver_data;
-	struct serial_struct newinfo;
 	int reconfig_port;
 
-	if (copy_from_user(&newinfo, info, sizeof(newinfo)))
-		return -EFAULT;
+	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
+		return -ENODEV;
 
 	mutex_lock(&port->port.mutex);
 	reconfig_port = ((port->port.flags & ASYNC_SPD_MASK) !=
-		(newinfo.flags & ASYNC_SPD_MASK));
+		(ss->flags & ASYNC_SPD_MASK));
 
 	if (!capable(CAP_SYS_ADMIN)) {
-		if ((newinfo.close_delay != port->port.close_delay) ||
-				(newinfo.closing_wait != port->port.closing_wait) ||
-				((newinfo.flags & ~ASYNC_USR_MASK) !=
+		if ((ss->close_delay != port->port.close_delay) ||
+				(ss->closing_wait != port->port.closing_wait) ||
+				((ss->flags & ~ASYNC_USR_MASK) !=
 				(port->port.flags & ~ASYNC_USR_MASK))) {
 			mutex_unlock(&port->port.mutex);
 			return -EPERM;
 		}
 		port->port.flags = ((port->port.flags & ~ASYNC_USR_MASK) |
-				(newinfo.flags & ASYNC_USR_MASK));
+				(ss->flags & ASYNC_USR_MASK));
 	} else {
-		port->port.close_delay = newinfo.close_delay;
-		port->port.closing_wait = newinfo.closing_wait;
+		port->port.close_delay = ss->close_delay;
+		port->port.closing_wait = ss->closing_wait;
 		port->port.flags = ((port->port.flags & ~ASYNC_FLAGS) |
-				(newinfo.flags & ASYNC_FLAGS));
+				(ss->flags & ASYNC_FLAGS));
 	}
 	if (reconfig_port) {
 		unsigned long flags;
@@ -1130,46 +1129,24 @@ static int isicom_set_serial_info(struct tty_struct *tty,
 	return 0;
 }
 
-static int isicom_get_serial_info(struct isi_port *port,
-	struct serial_struct __user *info)
-{
-	struct serial_struct out_info;
-
-	mutex_lock(&port->port.mutex);
-	memset(&out_info, 0, sizeof(out_info));
-/*	out_info.type = ? */
-	out_info.line = port - isi_ports;
-	out_info.port = port->card->base;
-	out_info.irq = port->card->irq;
-	out_info.flags = port->port.flags;
-/*	out_info.baud_base = ? */
-	out_info.close_delay = port->port.close_delay;
-	out_info.closing_wait = port->port.closing_wait;
-	mutex_unlock(&port->port.mutex);
-	if (copy_to_user(info, &out_info, sizeof(out_info)))
-		return -EFAULT;
-	return 0;
-}
-
-static int isicom_ioctl(struct tty_struct *tty,
-	unsigned int cmd, unsigned long arg)
+static int isicom_get_serial_info(struct tty_struct *tty,
+	struct serial_struct *ss)
 {
 	struct isi_port *port = tty->driver_data;
-	void __user *argp = (void __user *)arg;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
 		return -ENODEV;
 
-	switch (cmd) {
-	case TIOCGSERIAL:
-		return isicom_get_serial_info(port, argp);
-
-	case TIOCSSERIAL:
-		return isicom_set_serial_info(tty, argp);
-
-	default:
-		return -ENOIOCTLCMD;
-	}
+	mutex_lock(&port->port.mutex);
+/*	ss->type = ? */
+	ss->line = port - isi_ports;
+	ss->port = port->card->base;
+	ss->irq = port->card->irq;
+	ss->flags = port->port.flags;
+/*	ss->baud_base = ? */
+	ss->close_delay = port->port.close_delay;
+	ss->closing_wait = port->port.closing_wait;
+	mutex_unlock(&port->port.mutex);
 	return 0;
 }
 
@@ -1273,7 +1250,6 @@ static const struct tty_operations isicom_ops = {
 	.flush_chars		= isicom_flush_chars,
 	.write_room		= isicom_write_room,
 	.chars_in_buffer	= isicom_chars_in_buffer,
-	.ioctl			= isicom_ioctl,
 	.set_termios		= isicom_set_termios,
 	.throttle		= isicom_throttle,
 	.unthrottle		= isicom_unthrottle,
@@ -1284,6 +1260,8 @@ static const struct tty_operations isicom_ops = {
 	.tiocmget		= isicom_tiocmget,
 	.tiocmset		= isicom_tiocmset,
 	.break_ctl		= isicom_send_break,
+	.get_serial		= isicom_get_serial_info,
+	.set_serial		= isicom_set_serial_info,
 };
 
 static const struct tty_port_operations isicom_port_ops = {
-- 
2.11.0

