Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E1EC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA432146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA432146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeIMHuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:50:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43724 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbeIMHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYr-0006S2-96; Thu, 13 Sep 2018 02:40:53 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/50] ssu100: switch to ->get_serial()
Date:   Thu, 13 Sep 2018 03:40:29 +0100
Message-Id: <20180913024049.24567-30-viro@ZenIV.linux.org.uk>
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
 drivers/usb/serial/ssu100.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 0900b47b5f57..f6aea9f1be1a 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -331,39 +331,19 @@ static int ssu100_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return usb_serial_generic_open(tty, port);
 }
 
-static int get_serial_info(struct usb_serial_port *port,
-			   struct serial_struct __user *retinfo)
-{
-	struct serial_struct tmp;
-
-	memset(&tmp, 0, sizeof(tmp));
-	tmp.line		= port->minor;
-	tmp.port		= 0;
-	tmp.irq			= 0;
-	tmp.xmit_fifo_size	= port->bulk_out_size;
-	tmp.baud_base		= 9600;
-	tmp.close_delay		= 5*HZ;
-	tmp.closing_wait	= 30*HZ;
-
-	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-		return -EFAULT;
-	return 0;
-}
-
-static int ssu100_ioctl(struct tty_struct *tty,
-		    unsigned int cmd, unsigned long arg)
+static int get_serial_info(struct tty_struct *tty,
+			   struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	switch (cmd) {
-	case TIOCGSERIAL:
-		return get_serial_info(port,
-				       (struct serial_struct __user *) arg);
-	default:
-		break;
-	}
-
-	return -ENOIOCTLCMD;
+	ss->line		= port->minor;
+	ss->port		= 0;
+	ss->irq			= 0;
+	ss->xmit_fifo_size	= port->bulk_out_size;
+	ss->baud_base		= 9600;
+	ss->close_delay		= 5*HZ;
+	ss->closing_wait	= 30*HZ;
+	return 0;
 }
 
 static int ssu100_attach(struct usb_serial *serial)
@@ -566,7 +546,7 @@ static struct usb_serial_driver ssu100_device = {
 	.tiocmset            = ssu100_tiocmset,
 	.tiocmiwait          = usb_serial_generic_tiocmiwait,
 	.get_icount	     = usb_serial_generic_get_icount,
-	.ioctl               = ssu100_ioctl,
+	.get_serial          = get_serial_info,
 	.set_termios         = ssu100_set_termios,
 };
 
-- 
2.11.0

