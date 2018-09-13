Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8B8C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A212146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A212146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeIMHsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43624 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIMHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYo-0006Q3-PK; Thu, 13 Sep 2018 02:40:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/50] moxa: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:12 +0100
Message-Id: <20180913024049.24567-13-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Pointless dead assignments in moxa_set_serial_info() killed off;
they would've been a bug, if not for the fact that user-settable
flags had never been used in that driver.  Bogus from day 1,
though...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/tty/moxa.c | 79 +++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 250a19f042d7..3a1a5e0ee93f 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -221,8 +221,8 @@ static int MoxaPortRxQueue(struct moxa_port *);
 static int MoxaPortTxFree(struct moxa_port *);
 static void MoxaPortTxDisable(struct moxa_port *);
 static void MoxaPortTxEnable(struct moxa_port *);
-static int moxa_get_serial_info(struct moxa_port *, struct serial_struct __user *);
-static int moxa_set_serial_info(struct moxa_port *, struct serial_struct __user *);
+static int moxa_get_serial_info(struct tty_struct *, struct serial_struct *);
+static int moxa_set_serial_info(struct tty_struct *, struct serial_struct *);
 static void MoxaSetFifo(struct moxa_port *port, int enable);
 
 /*
@@ -375,16 +375,6 @@ static int moxa_ioctl(struct tty_struct *tty,
 		}
 		break;
 	}
-	case TIOCGSERIAL:
-	        mutex_lock(&ch->port.mutex);
-		ret = moxa_get_serial_info(ch, argp);
-		mutex_unlock(&ch->port.mutex);
-		break;
-	case TIOCSSERIAL:
-	        mutex_lock(&ch->port.mutex);
-		ret = moxa_set_serial_info(ch, argp);
-		mutex_unlock(&ch->port.mutex);
-		break;
 	default:
 		ret = -ENOIOCTLCMD;
 	}
@@ -415,6 +405,8 @@ static const struct tty_operations moxa_ops = {
 	.break_ctl = moxa_break_ctl,
 	.tiocmget = moxa_tiocmget,
 	.tiocmset = moxa_tiocmset,
+	.set_serial = moxa_set_serial_info,
+	.get_serial = moxa_get_serial_info,
 };
 
 static const struct tty_port_operations moxa_port_ops = {
@@ -2034,46 +2026,55 @@ static void MoxaPortTxEnable(struct moxa_port *port)
 	moxafunc(port->tableAddr, FC_SetXonState, Magic_code);
 }
 
-static int moxa_get_serial_info(struct moxa_port *info,
-		struct serial_struct __user *retinfo)
+static int moxa_get_serial_info(struct tty_struct *tty,
+		struct serial_struct *ss)
 {
-	struct serial_struct tmp = {
-		.type = info->type,
-		.line = info->port.tty->index,
-		.flags = info->port.flags,
-		.baud_base = 921600,
-		.close_delay = info->port.close_delay
-	};
-	return copy_to_user(retinfo, &tmp, sizeof(*retinfo)) ? -EFAULT : 0;
+	struct moxa_port *info = tty->driver_data;
+
+	if (tty->index == MAX_PORTS)
+		return -EINVAL;
+	if (!info)
+		return -ENODEV;
+	mutex_lock(&info->port.mutex);
+	ss->type = info->type,
+	ss->line = info->port.tty->index,
+	ss->flags = info->port.flags,
+	ss->baud_base = 921600,
+	ss->close_delay = info->port.close_delay;
+	mutex_unlock(&info->port.mutex);
+	return 0;
 }
 
 
-static int moxa_set_serial_info(struct moxa_port *info,
-		struct serial_struct __user *new_info)
+static int moxa_set_serial_info(struct tty_struct *tty,
+		struct serial_struct *ss)
 {
-	struct serial_struct new_serial;
+	struct moxa_port *info = tty->driver_data;
 
-	if (copy_from_user(&new_serial, new_info, sizeof(new_serial)))
-		return -EFAULT;
+	if (tty->index == MAX_PORTS)
+		return -EINVAL;
+	if (!info)
+		return -ENODEV;
 
-	if (new_serial.irq != 0 || new_serial.port != 0 ||
-			new_serial.custom_divisor != 0 ||
-			new_serial.baud_base != 921600)
+	if (ss->irq != 0 || ss->port != 0 ||
+			ss->custom_divisor != 0 ||
+			ss->baud_base != 921600)
 		return -EPERM;
 
+	mutex_lock(&info->port.mutex);
 	if (!capable(CAP_SYS_ADMIN)) {
-		if (((new_serial.flags & ~ASYNC_USR_MASK) !=
-		     (info->port.flags & ~ASYNC_USR_MASK)))
+		if (((ss->flags & ~ASYNC_USR_MASK) !=
+		     (info->port.flags & ~ASYNC_USR_MASK))) {
+			mutex_unlock(&info->port.mutex);
 			return -EPERM;
-	} else
-		info->port.close_delay = new_serial.close_delay * HZ / 100;
-
-	new_serial.flags = (new_serial.flags & ~ASYNC_FLAGS);
-	new_serial.flags |= (info->port.flags & ASYNC_FLAGS);
+		}
+	}
+	info->port.close_delay = ss->close_delay * HZ / 100;
 
-	MoxaSetFifo(info, new_serial.type == PORT_16550A);
+	MoxaSetFifo(info, ss->type == PORT_16550A);
 
-	info->type = new_serial.type;
+	info->type = ss->type;
+	mutex_unlock(&info->port.mutex);
 	return 0;
 }
 
-- 
2.11.0

