Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F79C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF6B21476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF6B21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeIMHsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43662 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeIMHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYp-0006Qu-R1; Thu, 13 Sep 2018 02:40:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/50] f81232: switch to ->get_serial()
Date:   Thu, 13 Sep 2018 03:40:19 +0100
Message-Id: <20180913024049.24567-20-viro@ZenIV.linux.org.uk>
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
 drivers/usb/serial/f81232.c | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 96036f87b1de..0dcdcb4b2cde 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -583,36 +583,16 @@ static int f81232_carrier_raised(struct usb_serial_port *port)
 	return 0;
 }
 
-static int f81232_get_serial_info(struct usb_serial_port *port,
-		unsigned long arg)
-{
-	struct serial_struct ser;
-
-	memset(&ser, 0, sizeof(ser));
-
-	ser.type = PORT_16550A;
-	ser.line = port->minor;
-	ser.port = port->port_number;
-	ser.baud_base = F81232_MAX_BAUDRATE;
-
-	if (copy_to_user((void __user *)arg, &ser, sizeof(ser)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int f81232_ioctl(struct tty_struct *tty,
-			unsigned int cmd, unsigned long arg)
+static int f81232_get_serial_info(struct tty_struct *tty,
+		struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	switch (cmd) {
-	case TIOCGSERIAL:
-		return f81232_get_serial_info(port, arg);
-	default:
-		break;
-	}
-	return -ENOIOCTLCMD;
+	ss->type = PORT_16550A;
+	ss->line = port->minor;
+	ss->port = port->port_number;
+	ss->baud_base = F81232_MAX_BAUDRATE;
+	return 0;
 }
 
 static void  f81232_interrupt_work(struct work_struct *work)
@@ -665,7 +645,7 @@ static struct usb_serial_driver f81232_device = {
 	.close =		f81232_close,
 	.dtr_rts =		f81232_dtr_rts,
 	.carrier_raised =	f81232_carrier_raised,
-	.ioctl =		f81232_ioctl,
+	.get_serial =		f81232_get_serial_info,
 	.break_ctl =		f81232_break_ctl,
 	.set_termios =		f81232_set_termios,
 	.tiocmget =		f81232_tiocmget,
-- 
2.11.0

