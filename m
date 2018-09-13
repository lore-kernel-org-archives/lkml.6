Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D905C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F0F2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F0F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeIMHuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:50:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43744 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeIMHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYr-0006ST-OS; Thu, 13 Sep 2018 02:40:53 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 34/50] complete ->[sg]et_serial() switchover
Date:   Thu, 13 Sep 2018 03:40:33 +0100
Message-Id: <20180913024049.24567-34-viro@ZenIV.linux.org.uk>
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
 drivers/tty/tty_io.c            | 12 ++++--------
 drivers/usb/serial/usb-serial.c |  4 ++--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 91d73732e11c..80d6c041c87e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2474,7 +2474,7 @@ static int tty_tiocsserial(struct tty_struct *tty, struct serial_struct __user *
 		pr_warn("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
 			__func__, get_task_comm(comm, current), flags);
 	if (!tty->ops->set_serial)
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	return tty->ops->set_serial(tty, &v);
 }
 
@@ -2485,7 +2485,7 @@ static int tty_tiocgserial(struct tty_struct *tty, struct serial_struct __user *
 	memset(&v, 0, sizeof(struct serial_struct));
 
 	if (!tty->ops->set_serial)
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	err = tty->ops->get_serial(tty, &v);
 	if (!err && copy_to_user(ss, &v, sizeof(struct serial_struct)))
 		err = -EFAULT;
@@ -2621,13 +2621,9 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	case TIOCSSERIAL:
-		retval = tty_tiocsserial(tty, p);
-		if (retval != -ENOIOCTLCMD)
-			return retval;
+		return tty_tiocsserial(tty, p);
 	case TIOCGSERIAL:
-		retval = tty_tiocgserial(tty, p);
-		if (retval != -ENOIOCTLCMD)
-			return retval;
+		return tty_tiocgserial(tty, p);
 	case TIOCGPTPEER:
 		/* Special because the struct file is needed */
 		return ptm_open_peer(file, tty, (int)arg);
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 8bdc48fa5a67..b633f57a86ec 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -401,7 +401,7 @@ static int serial_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 	struct usb_serial_port *port = tty->driver_data;
 	if (port->serial->type->get_serial)
 		return port->serial->type->get_serial(tty, ss);
-	return -ENOIOCTLCMD;
+	return -ENOTTY;
 }
 
 static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
@@ -409,7 +409,7 @@ static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
 	struct usb_serial_port *port = tty->driver_data;
 	if (port->serial->type->set_serial)
 		return port->serial->type->get_serial(tty, ss);
-	return -ENOIOCTLCMD;
+	return -ENOTTY;
 }
 
 static int serial_ioctl(struct tty_struct *tty,
-- 
2.11.0

