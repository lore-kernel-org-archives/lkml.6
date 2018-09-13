Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718FFC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F342133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F342133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeIMHwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:52:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43592 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeIMHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYo-0006PN-3e; Thu, 13 Sep 2018 02:40:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/50] fwserial: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:06 +0100
Message-Id: <20180913024049.24567-7-viro@ZenIV.linux.org.uk>
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
 drivers/staging/fwserial/fwserial.c | 66 ++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index fa0dd425b454..173f451b86b7 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1209,42 +1209,40 @@ static int wait_msr_change(struct fwtty_port *port, unsigned long mask)
 					check_msr_delta(port, mask, &prev));
 }
 
-static int get_serial_info(struct fwtty_port *port,
-			   struct serial_struct __user *info)
+static int get_serial_info(struct tty_struct *tty,
+			   struct serial_struct *ss)
 {
-	struct serial_struct tmp;
-
-	memset(&tmp, 0, sizeof(tmp));
-
-	tmp.type =  PORT_UNKNOWN;
-	tmp.line =  port->port.tty->index;
-	tmp.flags = port->port.flags;
-	tmp.xmit_fifo_size = FWTTY_PORT_TXFIFO_LEN;
-	tmp.baud_base = 400000000;
-	tmp.close_delay = port->port.close_delay;
-
-	return (copy_to_user(info, &tmp, sizeof(*info))) ? -EFAULT : 0;
+	struct fwtty_port *port = tty->driver_data;
+	mutex_lock(&port->port.mutex);
+	ss->type =  PORT_UNKNOWN;
+	ss->line =  port->port.tty->index;
+	ss->flags = port->port.flags;
+	ss->xmit_fifo_size = FWTTY_PORT_TXFIFO_LEN;
+	ss->baud_base = 400000000;
+	ss->close_delay = port->port.close_delay;
+	mutex_unlock(&port->port.mutex);
+	return 0;
 }
 
-static int set_serial_info(struct fwtty_port *port,
-			   struct serial_struct __user *info)
+static int set_serial_info(struct tty_struct *tty,
+			   struct serial_struct *ss)
 {
-	struct serial_struct tmp;
-
-	if (copy_from_user(&tmp, info, sizeof(tmp)))
-		return -EFAULT;
+	struct fwtty_port *port = tty->driver_data;
 
-	if (tmp.irq != 0 || tmp.port != 0 || tmp.custom_divisor != 0 ||
-	    tmp.baud_base != 400000000)
+	if (ss->irq != 0 || ss->port != 0 || ss->custom_divisor != 0 ||
+	    ss->baud_base != 400000000)
 		return -EPERM;
 
+	mutex_lock(&port->port.mutex);
 	if (!capable(CAP_SYS_ADMIN)) {
-		if (((tmp.flags & ~ASYNC_USR_MASK) !=
-		     (port->port.flags & ~ASYNC_USR_MASK)))
+		if (((ss->flags & ~ASYNC_USR_MASK) !=
+		     (port->port.flags & ~ASYNC_USR_MASK))) {
+			mutex_unlock(&port->port.mutex);
 			return -EPERM;
-	} else {
-		port->port.close_delay = tmp.close_delay * HZ / 100;
+		}
 	}
+	port->port.close_delay = ss->close_delay * HZ / 100;
+	mutex_unlock(&port->port.mutex);
 
 	return 0;
 }
@@ -1256,18 +1254,6 @@ static int fwtty_ioctl(struct tty_struct *tty, unsigned int cmd,
 	int err;
 
 	switch (cmd) {
-	case TIOCGSERIAL:
-		mutex_lock(&port->port.mutex);
-		err = get_serial_info(port, (void __user *)arg);
-		mutex_unlock(&port->port.mutex);
-		break;
-
-	case TIOCSSERIAL:
-		mutex_lock(&port->port.mutex);
-		err = set_serial_info(port, (void __user *)arg);
-		mutex_unlock(&port->port.mutex);
-		break;
-
 	case TIOCMIWAIT:
 		err = wait_msr_change(port, arg);
 		break;
@@ -1557,6 +1543,8 @@ static const struct tty_operations fwtty_ops = {
 	.tiocmget =		fwtty_tiocmget,
 	.tiocmset =		fwtty_tiocmset,
 	.get_icount =		fwtty_get_icount,
+	.set_serial =		set_serial_info,
+	.get_serial =		get_serial_info,
 	.proc_show =		fwtty_proc_show,
 };
 
@@ -1578,6 +1566,8 @@ static const struct tty_operations fwloop_ops = {
 	.tiocmget =		fwtty_tiocmget,
 	.tiocmset =		fwtty_tiocmset,
 	.get_icount =		fwtty_get_icount,
+	.set_serial =		set_serial_info,
+	.get_serial =		get_serial_info,
 };
 
 static inline int mgmt_pkt_expected_len(__be16 code)
-- 
2.11.0

