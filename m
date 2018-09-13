Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2B0C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513E12146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513E12146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeIMHsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43632 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeIMHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYp-0006QI-0L; Thu, 13 Sep 2018 02:40:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/50] serial_core: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:14 +0100
Message-Id: <20180913024049.24567-15-viro@ZenIV.linux.org.uk>
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
 drivers/tty/serial/serial_core.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 80bb56facfb6..2c8162b8ebf2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -778,17 +778,13 @@ static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
 	return ret;
 }
 
-static int uart_get_info_user(struct tty_port *port,
-			 struct serial_struct __user *retinfo)
+static int uart_get_info_user(struct tty_struct *tty,
+			 struct serial_struct *ss)
 {
-	struct serial_struct tmp;
-
-	if (uart_get_info(port, &tmp) < 0)
-		return -EIO;
+	struct uart_state *state = tty->driver_data;
+	struct tty_port *port = &state->port;
 
-	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
-		return -EFAULT;
-	return 0;
+	return uart_get_info(port, ss) < 0 ? -EIO : 0;
 }
 
 static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
@@ -990,16 +986,13 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	return retval;
 }
 
-static int uart_set_info_user(struct tty_struct *tty, struct uart_state *state,
-			 struct serial_struct __user *newinfo)
+static int uart_set_info_user(struct tty_struct *tty, struct serial_struct *ss)
 {
-	struct serial_struct new_serial;
+	struct uart_state *state = tty->driver_data;
 	struct tty_port *port = &state->port;
 	int retval;
 
-	if (copy_from_user(&new_serial, newinfo, sizeof(new_serial)))
-		return -EFAULT;
-
+	down_write(&tty->termios_rwsem);
 	/*
 	 * This semaphore protects port->count.  It is also
 	 * very useful to prevent opens.  Also, take the
@@ -1008,8 +1001,9 @@ static int uart_set_info_user(struct tty_struct *tty, struct uart_state *state,
 	 * under us.
 	 */
 	mutex_lock(&port->mutex);
-	retval = uart_set_info(tty, port, state, &new_serial);
+	retval = uart_set_info(tty, port, state, ss);
 	mutex_unlock(&port->mutex);
+	up_write(&tty->termios_rwsem);
 	return retval;
 }
 
@@ -1325,16 +1319,6 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	 * These ioctls don't rely on the hardware to be present.
 	 */
 	switch (cmd) {
-	case TIOCGSERIAL:
-		ret = uart_get_info_user(port, uarg);
-		break;
-
-	case TIOCSSERIAL:
-		down_write(&tty->termios_rwsem);
-		ret = uart_set_info_user(tty, state, uarg);
-		up_write(&tty->termios_rwsem);
-		break;
-
 	case TIOCSERCONFIG:
 		down_write(&tty->termios_rwsem);
 		ret = uart_do_autoconfig(tty, state);
@@ -2413,6 +2397,8 @@ static const struct tty_operations uart_ops = {
 #endif
 	.tiocmget	= uart_tiocmget,
 	.tiocmset	= uart_tiocmset,
+	.set_serial	= uart_set_info_user,
+	.get_serial	= uart_get_info_user,
 	.get_icount	= uart_get_icount,
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_init	= uart_poll_init,
-- 
2.11.0

