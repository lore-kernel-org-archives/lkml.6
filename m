Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EFDC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBEE2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBEE2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeIMHsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43698 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeIMHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYq-0006RS-G8; Thu, 13 Sep 2018 02:40:52 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/50] mos7720: switch to ->get_serial()
Date:   Thu, 13 Sep 2018 03:40:24 +0100
Message-Id: <20180913024049.24567-25-viro@ZenIV.linux.org.uk>
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
 drivers/usb/serial/mos7720.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 4c06357b3ef8..451fca707e04 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1786,24 +1786,22 @@ static int mos7720_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
-static int get_serial_info(struct moschip_port *mos7720_port,
-			   struct serial_struct __user *retinfo)
+static int get_serial_info(struct tty_struct *tty,
+			   struct serial_struct *ss)
 {
-	struct serial_struct tmp;
-
-	memset(&tmp, 0, sizeof(tmp));
-
-	tmp.type		= PORT_16550A;
-	tmp.line		= mos7720_port->port->minor;
-	tmp.port		= mos7720_port->port->port_number;
-	tmp.irq			= 0;
-	tmp.xmit_fifo_size	= NUM_URBS * URB_TRANSFER_BUFFER_SIZE;
-	tmp.baud_base		= 9600;
-	tmp.close_delay		= 5*HZ;
-	tmp.closing_wait	= 30*HZ;
-
-	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-		return -EFAULT;
+	struct usb_serial_port *port = tty->driver_data;
+	struct moschip_port *mos7720_port;
+	mos7720_port = usb_get_serial_port_data(port);
+	if (mos7720_port == NULL)
+		return -ENODEV;
+	ss->type		= PORT_16550A;
+	ss->line		= mos7720_port->port->minor;
+	ss->port		= mos7720_port->port->port_number;
+	ss->irq			= 0;
+	ss->xmit_fifo_size	= NUM_URBS * URB_TRANSFER_BUFFER_SIZE;
+	ss->baud_base		= 9600;
+	ss->close_delay		= 5*HZ;
+	ss->closing_wait	= 30*HZ;
 	return 0;
 }
 
@@ -1822,11 +1820,6 @@ static int mos7720_ioctl(struct tty_struct *tty,
 		dev_dbg(&port->dev, "%s TIOCSERGETLSR\n", __func__);
 		return get_lsr_info(tty, mos7720_port,
 					(unsigned int __user *)arg);
-
-	case TIOCGSERIAL:
-		dev_dbg(&port->dev, "%s TIOCGSERIAL\n", __func__);
-		return get_serial_info(mos7720_port,
-				       (struct serial_struct __user *)arg);
 	}
 
 	return -ENOIOCTLCMD;
@@ -1963,6 +1956,7 @@ static struct usb_serial_driver moschip7720_2port_driver = {
 	.ioctl			= mos7720_ioctl,
 	.tiocmget		= mos7720_tiocmget,
 	.tiocmset		= mos7720_tiocmset,
+	.get_serial		= get_serial_info,
 	.set_termios		= mos7720_set_termios,
 	.write			= mos7720_write,
 	.write_room		= mos7720_write_room,
-- 
2.11.0

