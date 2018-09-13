Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6561CC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3472146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3472146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeIMHsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43668 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeIMHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYp-0006R0-Ue; Thu, 13 Sep 2018 02:40:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/50] f81534: switch to ->get_serial()
Date:   Thu, 13 Sep 2018 03:40:20 +0100
Message-Id: <20180913024049.24567-21-viro@ZenIV.linux.org.uk>
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
 drivers/usb/serial/f81534.c | 38 ++++++++------------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index 4dfbff20bda4..380933db34dd 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -1139,43 +1139,21 @@ static void f81534_close(struct usb_serial_port *port)
 	mutex_unlock(&serial_priv->urb_mutex);
 }
 
-static int f81534_get_serial_info(struct usb_serial_port *port,
-				  struct serial_struct __user *retinfo)
+static int f81534_get_serial_info(struct tty_struct *tty,
+				  struct serial_struct *ss)
 {
+	struct usb_serial_port *port = tty->driver_data;
 	struct f81534_port_private *port_priv;
-	struct serial_struct tmp;
 
 	port_priv = usb_get_serial_port_data(port);
 
-	memset(&tmp, 0, sizeof(tmp));
-
-	tmp.type = PORT_16550A;
-	tmp.port = port->port_number;
-	tmp.line = port->minor;
-	tmp.baud_base = port_priv->baud_base;
-
-	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-		return -EFAULT;
-
+	ss->type = PORT_16550A;
+	ss->port = port->port_number;
+	ss->line = port->minor;
+	ss->baud_base = port_priv->baud_base;
 	return 0;
 }
 
-static int f81534_ioctl(struct tty_struct *tty, unsigned int cmd,
-			unsigned long arg)
-{
-	struct usb_serial_port *port = tty->driver_data;
-	struct serial_struct __user *buf = (struct serial_struct __user *)arg;
-
-	switch (cmd) {
-	case TIOCGSERIAL:
-		return f81534_get_serial_info(port, buf);
-	default:
-		break;
-	}
-
-	return -ENOIOCTLCMD;
-}
-
 static void f81534_process_per_serial_block(struct usb_serial_port *port,
 		u8 *data)
 {
@@ -1581,7 +1559,7 @@ static struct usb_serial_driver f81534_device = {
 	.break_ctl =		f81534_break_ctl,
 	.dtr_rts =		f81534_dtr_rts,
 	.process_read_urb =	f81534_process_read_urb,
-	.ioctl =		f81534_ioctl,
+	.get_serial =		f81534_get_serial_info,
 	.tiocmget =		f81534_tiocmget,
 	.tiocmset =		f81534_tiocmset,
 	.write_bulk_callback =	f81534_write_usb_callback,
-- 
2.11.0

