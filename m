Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BCDC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E769A21476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E769A21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeIMHuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:50:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43702 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeIMHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYq-0006Rh-SO; Thu, 13 Sep 2018 02:40:52 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/50] opticon: switch to ->get_serial()
Date:   Thu, 13 Sep 2018 03:40:26 +0100
Message-Id: <20180913024049.24567-27-viro@ZenIV.linux.org.uk>
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
 drivers/usb/serial/opticon.c | 43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index caa0746326fd..cb7aac9cd9e7 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -328,42 +328,23 @@ static int opticon_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
-static int get_serial_info(struct usb_serial_port *port,
-			   struct serial_struct __user *serial)
+static int get_serial_info(struct tty_struct *tty,
+			   struct serial_struct *ss)
 {
-	struct serial_struct tmp;
-
-	memset(&tmp, 0x00, sizeof(tmp));
+	struct usb_serial_port *port = tty->driver_data;
 
 	/* fake emulate a 16550 uart to make userspace code happy */
-	tmp.type		= PORT_16550A;
-	tmp.line		= port->minor;
-	tmp.port		= 0;
-	tmp.irq			= 0;
-	tmp.xmit_fifo_size	= 1024;
-	tmp.baud_base		= 9600;
-	tmp.close_delay		= 5*HZ;
-	tmp.closing_wait	= 30*HZ;
-
-	if (copy_to_user(serial, &tmp, sizeof(*serial)))
-		return -EFAULT;
+	ss->type		= PORT_16550A;
+	ss->line		= port->minor;
+	ss->port		= 0;
+	ss->irq			= 0;
+	ss->xmit_fifo_size	= 1024;
+	ss->baud_base		= 9600;
+	ss->close_delay		= 5*HZ;
+	ss->closing_wait	= 30*HZ;
 	return 0;
 }
 
-static int opticon_ioctl(struct tty_struct *tty,
-			 unsigned int cmd, unsigned long arg)
-{
-	struct usb_serial_port *port = tty->driver_data;
-
-	switch (cmd) {
-	case TIOCGSERIAL:
-		return get_serial_info(port,
-				       (struct serial_struct __user *)arg);
-	}
-
-	return -ENOIOCTLCMD;
-}
-
 static int opticon_port_probe(struct usb_serial_port *port)
 {
 	struct opticon_private *priv;
@@ -404,7 +385,7 @@ static struct usb_serial_driver opticon_device = {
 	.write_room = 		opticon_write_room,
 	.throttle =		usb_serial_generic_throttle,
 	.unthrottle =		usb_serial_generic_unthrottle,
-	.ioctl =		opticon_ioctl,
+	.get_serial =		get_serial_info,
 	.tiocmget =		opticon_tiocmget,
 	.tiocmset =		opticon_tiocmset,
 	.process_read_urb =	opticon_process_read_urb,
-- 
2.11.0

