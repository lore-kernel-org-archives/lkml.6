Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60822C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF832146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF832146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeIMHsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43712 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeIMHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYq-0006Rn-VQ; Thu, 13 Sep 2018 02:40:53 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/50] pl2303: switch to ->get_serial()
Date:   Thu, 13 Sep 2018 03:40:27 +0100
Message-Id: <20180913024049.24567-28-viro@ZenIV.linux.org.uk>
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
 drivers/usb/serial/pl2303.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index e41f725ac7aa..a4e0d13fc121 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -808,29 +808,16 @@ static int pl2303_carrier_raised(struct usb_serial_port *port)
 	return 0;
 }
 
-static int pl2303_ioctl(struct tty_struct *tty,
-			unsigned int cmd, unsigned long arg)
+static int pl2303_get_serial(struct tty_struct *tty,
+			struct serial_struct *ss)
 {
-	struct serial_struct ser;
 	struct usb_serial_port *port = tty->driver_data;
 
-	switch (cmd) {
-	case TIOCGSERIAL:
-		memset(&ser, 0, sizeof ser);
-		ser.type = PORT_16654;
-		ser.line = port->minor;
-		ser.port = port->port_number;
-		ser.baud_base = 460800;
-
-		if (copy_to_user((void __user *)arg, &ser, sizeof ser))
-			return -EFAULT;
-
-		return 0;
-	default:
-		break;
-	}
-
-	return -ENOIOCTLCMD;
+	ss->type = PORT_16654;
+	ss->line = port->minor;
+	ss->port = port->port_number;
+	ss->baud_base = 460800;
+	return 0;
 }
 
 static void pl2303_set_break(struct usb_serial_port *port, bool enable)
@@ -1016,7 +1003,7 @@ static struct usb_serial_driver pl2303_device = {
 	.close =		pl2303_close,
 	.dtr_rts =		pl2303_dtr_rts,
 	.carrier_raised =	pl2303_carrier_raised,
-	.ioctl =		pl2303_ioctl,
+	.get_serial =		pl2303_get_serial,
 	.break_ctl =		pl2303_break_ctl,
 	.set_termios =		pl2303_set_termios,
 	.tiocmget =		pl2303_tiocmget,
-- 
2.11.0

