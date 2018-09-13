Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0DDC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273432146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273432146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeIMHsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43644 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeIMHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYp-0006QZ-CS; Thu, 13 Sep 2018 02:40:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/50] usb-serial: begin switching to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:16 +0100
Message-Id: <20180913024049.24567-17-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

add such methods for usb_serial_driver, provide tty_operations
->[sg]et_serial() calling those.  For now the lack of methods
in driver means ENOIOCTLCMD from usb-serial ->[sg]et_serial(),
making tty_ioctl() fall back to calling ->ioctl().  Once all
drivers are converted, we'll be returning -ENOTTY instead,
completing the switchover.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/serial/usb-serial.c | 18 ++++++++++++++++++
 include/linux/usb/serial.h      |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index f7aaa7f079e1..8bdc48fa5a67 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -396,6 +396,22 @@ static void serial_unthrottle(struct tty_struct *tty)
 		port->serial->type->unthrottle(tty);
 }
 
+static int serial_get_serial(struct tty_struct *tty, struct serial_struct *ss)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	if (port->serial->type->get_serial)
+		return port->serial->type->get_serial(tty, ss);
+	return -ENOIOCTLCMD;
+}
+
+static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	if (port->serial->type->set_serial)
+		return port->serial->type->get_serial(tty, ss);
+	return -ENOIOCTLCMD;
+}
+
 static int serial_ioctl(struct tty_struct *tty,
 					unsigned int cmd, unsigned long arg)
 {
@@ -1177,6 +1193,8 @@ static const struct tty_operations serial_ops = {
 	.tiocmget =		serial_tiocmget,
 	.tiocmset =		serial_tiocmset,
 	.get_icount =		serial_get_icount,
+	.set_serial =		serial_set_serial,
+	.get_serial =		serial_get_serial,
 	.cleanup =		serial_cleanup,
 	.install =		serial_install,
 	.proc_show =		serial_proc_show,
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 106551a5616e..1c19f77ed541 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -285,6 +285,8 @@ struct usb_serial_driver {
 	int  (*write_room)(struct tty_struct *tty);
 	int  (*ioctl)(struct tty_struct *tty,
 		      unsigned int cmd, unsigned long arg);
+	int  (*get_serial)(struct tty_struct *tty, struct serial_struct *ss);
+	int  (*set_serial)(struct tty_struct *tty, struct serial_struct *ss);
 	void (*set_termios)(struct tty_struct *tty,
 			struct usb_serial_port *port, struct ktermios *old);
 	void (*break_ctl)(struct tty_struct *tty, int break_state);
-- 
2.11.0

