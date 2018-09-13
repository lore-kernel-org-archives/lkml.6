Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D40AC63681
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DD0214C1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DD0214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeIMHsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43684 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeIMHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYq-0006RM-CI; Thu, 13 Sep 2018 02:40:52 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/50] io_ti: switch to ->get_serial()
Date:   Thu, 13 Sep 2018 03:40:23 +0100
Message-Id: <20180913024049.24567-24-viro@ZenIV.linux.org.uk>
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
 drivers/usb/serial/io_ti.c | 47 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index 6d1d6efa3055..c327d4cf7928 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2437,47 +2437,28 @@ static int edge_tiocmget(struct tty_struct *tty)
 	return result;
 }
 
-static int get_serial_info(struct edgeport_port *edge_port,
-				struct serial_struct __user *retinfo)
+static int get_serial_info(struct tty_struct *tty,
+				struct serial_struct *ss)
 {
-	struct serial_struct tmp;
+	struct usb_serial_port *port = tty->driver_data;
+	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
 	unsigned cwait;
 
 	cwait = edge_port->port->port.closing_wait;
 	if (cwait != ASYNC_CLOSING_WAIT_NONE)
 		cwait = jiffies_to_msecs(cwait) / 10;
 
-	memset(&tmp, 0, sizeof(tmp));
-
-	tmp.type		= PORT_16550A;
-	tmp.line		= edge_port->port->minor;
-	tmp.port		= edge_port->port->port_number;
-	tmp.irq			= 0;
-	tmp.xmit_fifo_size	= edge_port->port->bulk_out_size;
-	tmp.baud_base		= 9600;
-	tmp.close_delay		= 5*HZ;
-	tmp.closing_wait	= cwait;
-
-	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-		return -EFAULT;
+	ss->type		= PORT_16550A;
+	ss->line		= edge_port->port->minor;
+	ss->port		= edge_port->port->port_number;
+	ss->irq			= 0;
+	ss->xmit_fifo_size	= edge_port->port->bulk_out_size;
+	ss->baud_base		= 9600;
+	ss->close_delay		= 5*HZ;
+	ss->closing_wait	= cwait;
 	return 0;
 }
 
-static int edge_ioctl(struct tty_struct *tty,
-					unsigned int cmd, unsigned long arg)
-{
-	struct usb_serial_port *port = tty->driver_data;
-	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
-
-	switch (cmd) {
-	case TIOCGSERIAL:
-		dev_dbg(&port->dev, "%s - TIOCGSERIAL\n", __func__);
-		return get_serial_info(edge_port,
-				(struct serial_struct __user *) arg);
-	}
-	return -ENOIOCTLCMD;
-}
-
 static void edge_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
@@ -2738,7 +2719,7 @@ static struct usb_serial_driver edgeport_1port_device = {
 	.release		= edge_release,
 	.port_probe		= edge_port_probe,
 	.port_remove		= edge_port_remove,
-	.ioctl			= edge_ioctl,
+	.get_serial		= get_serial_info,
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
@@ -2777,7 +2758,7 @@ static struct usb_serial_driver edgeport_2port_device = {
 	.release		= edge_release,
 	.port_probe		= edge_port_probe,
 	.port_remove		= edge_port_remove,
-	.ioctl			= edge_ioctl,
+	.get_serial		= get_serial_info,
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
-- 
2.11.0

