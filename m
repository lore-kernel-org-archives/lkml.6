Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50708C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154A221476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154A221476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeIMHsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43680 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeIMHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYq-0006RF-9P; Thu, 13 Sep 2018 02:40:52 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/50] io_edgeport: switch to ->get_serial()
Date:   Thu, 13 Sep 2018 03:40:22 +0100
Message-Id: <20180913024049.24567-23-viro@ZenIV.linux.org.uk>
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
 drivers/usb/serial/io_edgeport.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 97c69d373ca6..4ca31c0e4174 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1637,24 +1637,20 @@ static int edge_tiocmget(struct tty_struct *tty)
 	return result;
 }
 
-static int get_serial_info(struct edgeport_port *edge_port,
-				struct serial_struct __user *retinfo)
+static int get_serial_info(struct tty_struct *tty,
+				struct serial_struct *ss)
 {
-	struct serial_struct tmp;
-
-	memset(&tmp, 0, sizeof(tmp));
-
-	tmp.type		= PORT_16550A;
-	tmp.line		= edge_port->port->minor;
-	tmp.port		= edge_port->port->port_number;
-	tmp.irq			= 0;
-	tmp.xmit_fifo_size	= edge_port->maxTxCredits;
-	tmp.baud_base		= 9600;
-	tmp.close_delay		= 5*HZ;
-	tmp.closing_wait	= 30*HZ;
+	struct usb_serial_port *port = tty->driver_data;
+	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
 
-	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-		return -EFAULT;
+	ss->type		= PORT_16550A;
+	ss->line		= edge_port->port->minor;
+	ss->port		= edge_port->port->port_number;
+	ss->irq			= 0;
+	ss->xmit_fifo_size	= edge_port->maxTxCredits;
+	ss->baud_base		= 9600;
+	ss->close_delay		= 5*HZ;
+	ss->closing_wait	= 30*HZ;
 	return 0;
 }
 
@@ -1667,17 +1663,12 @@ static int edge_ioctl(struct tty_struct *tty,
 					unsigned int cmd, unsigned long arg)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	DEFINE_WAIT(wait);
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
 
 	switch (cmd) {
 	case TIOCSERGETLSR:
 		dev_dbg(&port->dev, "%s TIOCSERGETLSR\n", __func__);
 		return get_lsr_info(edge_port, (unsigned int __user *) arg);
-
-	case TIOCGSERIAL:
-		dev_dbg(&port->dev, "%s TIOCGSERIAL\n", __func__);
-		return get_serial_info(edge_port, (struct serial_struct __user *) arg);
 	}
 	return -ENOIOCTLCMD;
 }
@@ -3126,6 +3117,7 @@ static struct usb_serial_driver edgeport_2port_device = {
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
+	.get_serial		= get_serial_info,
 	.tiocmiwait		= usb_serial_generic_tiocmiwait,
 	.get_icount		= usb_serial_generic_get_icount,
 	.write			= edge_write,
@@ -3161,6 +3153,7 @@ static struct usb_serial_driver edgeport_4port_device = {
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
+	.get_serial		= get_serial_info,
 	.tiocmiwait		= usb_serial_generic_tiocmiwait,
 	.get_icount		= usb_serial_generic_get_icount,
 	.write			= edge_write,
@@ -3196,6 +3189,7 @@ static struct usb_serial_driver edgeport_8port_device = {
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
+	.get_serial		= get_serial_info,
 	.tiocmiwait		= usb_serial_generic_tiocmiwait,
 	.get_icount		= usb_serial_generic_get_icount,
 	.write			= edge_write,
@@ -3231,6 +3225,7 @@ static struct usb_serial_driver epic_device = {
 	.set_termios		= edge_set_termios,
 	.tiocmget		= edge_tiocmget,
 	.tiocmset		= edge_tiocmset,
+	.get_serial		= get_serial_info,
 	.tiocmiwait		= usb_serial_generic_tiocmiwait,
 	.get_icount		= usb_serial_generic_get_icount,
 	.write			= edge_write,
-- 
2.11.0

