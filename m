Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B43C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8926B2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8926B2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeIMHwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:52:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43594 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeIMHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYo-0006PZ-8K; Thu, 13 Sep 2018 02:40:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/50] amiserial: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:08 +0100
Message-Id: <20180913024049.24567-9-viro@ZenIV.linux.org.uk>
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
 drivers/tty/amiserial.c | 83 ++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 45 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 34dead614149..17fc8bb6c6b8 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -996,63 +996,60 @@ static void rs_unthrottle(struct tty_struct * tty)
  * ------------------------------------------------------------
  */
 
-static int get_serial_info(struct tty_struct *tty, struct serial_state *state,
-			   struct serial_struct __user * retinfo)
+static int get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
-	struct serial_struct tmp;
-   
-	memset(&tmp, 0, sizeof(tmp));
+	struct serial_state *state = tty->driver_data;
+
+	if (serial_paranoia_check(state, tty->name, "rs_ioctl"))
+		return -ENODEV;
+
 	tty_lock(tty);
-	tmp.line = tty->index;
-	tmp.port = state->port;
-	tmp.flags = state->tport.flags;
-	tmp.xmit_fifo_size = state->xmit_fifo_size;
-	tmp.baud_base = state->baud_base;
-	tmp.close_delay = state->tport.close_delay;
-	tmp.closing_wait = state->tport.closing_wait;
-	tmp.custom_divisor = state->custom_divisor;
+	ss->line = tty->index;
+	ss->port = state->port;
+	ss->flags = state->tport.flags;
+	ss->xmit_fifo_size = state->xmit_fifo_size;
+	ss->baud_base = state->baud_base;
+	ss->close_delay = state->tport.close_delay;
+	ss->closing_wait = state->tport.closing_wait;
+	ss->custom_divisor = state->custom_divisor;
 	tty_unlock(tty);
-	if (copy_to_user(retinfo,&tmp,sizeof(*retinfo)))
-		return -EFAULT;
 	return 0;
 }
 
-static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
-			   struct serial_struct __user * new_info)
+static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
+	struct serial_state *state = tty->driver_data;
 	struct tty_port *port = &state->tport;
-	struct serial_struct new_serial;
 	bool change_spd;
-	int 			retval = 0;
 
-	if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
-		return -EFAULT;
+	if (serial_paranoia_check(state, tty->name, "rs_ioctl"))
+		return -ENODEV;
 
 	tty_lock(tty);
-	change_spd = ((new_serial.flags ^ port->flags) & ASYNC_SPD_MASK) ||
-		new_serial.custom_divisor != state->custom_divisor;
-	if (new_serial.irq || new_serial.port != state->port ||
-			new_serial.xmit_fifo_size != state->xmit_fifo_size) {
+	change_spd = ((ss->flags ^ port->flags) & ASYNC_SPD_MASK) ||
+		ss->custom_divisor != state->custom_divisor;
+	if (ss->irq || ss->port != state->port ||
+			ss->xmit_fifo_size != state->xmit_fifo_size) {
 		tty_unlock(tty);
 		return -EINVAL;
 	}
   
 	if (!serial_isroot()) {
-		if ((new_serial.baud_base != state->baud_base) ||
-		    (new_serial.close_delay != port->close_delay) ||
-		    (new_serial.xmit_fifo_size != state->xmit_fifo_size) ||
-		    ((new_serial.flags & ~ASYNC_USR_MASK) !=
+		if ((ss->baud_base != state->baud_base) ||
+		    (ss->close_delay != port->close_delay) ||
+		    (ss->xmit_fifo_size != state->xmit_fifo_size) ||
+		    ((ss->flags & ~ASYNC_USR_MASK) !=
 		     (port->flags & ~ASYNC_USR_MASK))) {
 			tty_unlock(tty);
 			return -EPERM;
 		}
 		port->flags = ((port->flags & ~ASYNC_USR_MASK) |
-			       (new_serial.flags & ASYNC_USR_MASK));
-		state->custom_divisor = new_serial.custom_divisor;
+			       (ss->flags & ASYNC_USR_MASK));
+		state->custom_divisor = ss->custom_divisor;
 		goto check_and_exit;
 	}
 
-	if (new_serial.baud_base < 9600) {
+	if (ss->baud_base < 9600) {
 		tty_unlock(tty);
 		return -EINVAL;
 	}
@@ -1062,19 +1059,19 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
 	 * At this point, we start making changes.....
 	 */
 
-	state->baud_base = new_serial.baud_base;
+	state->baud_base = ss->baud_base;
 	port->flags = ((port->flags & ~ASYNC_FLAGS) |
-			(new_serial.flags & ASYNC_FLAGS));
-	state->custom_divisor = new_serial.custom_divisor;
-	port->close_delay = new_serial.close_delay * HZ/100;
-	port->closing_wait = new_serial.closing_wait * HZ/100;
+			(ss->flags & ASYNC_FLAGS));
+	state->custom_divisor = ss->custom_divisor;
+	port->close_delay = ss->close_delay * HZ/100;
+	port->closing_wait = ss->closing_wait * HZ/100;
 	port->low_latency = (port->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 
 check_and_exit:
 	if (tty_port_initialized(port)) {
 		if (change_spd) {
 			/* warn about deprecation unless clearing */
-			if (new_serial.flags & ASYNC_SPD_MASK)
+			if (ss->flags & ASYNC_SPD_MASK)
 				dev_warn_ratelimited(tty->dev, "use of SPD flags is deprecated\n");
 			change_speed(tty, state, NULL);
 		}
@@ -1084,7 +1081,6 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
 	return retval;
 }
 
-
 /*
  * get_lsr_info - get line status register info
  *
@@ -1224,18 +1220,13 @@ static int rs_ioctl(struct tty_struct *tty,
 	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
 		return -ENODEV;
 
-	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
-	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
+	if ((cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
 	    (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
 		if (tty_io_error(tty))
 		    return -EIO;
 	}
 
 	switch (cmd) {
-		case TIOCGSERIAL:
-			return get_serial_info(tty, info, argp);
-		case TIOCSSERIAL:
-			return set_serial_info(tty, info, argp);
 		case TIOCSERCONFIG:
 			return 0;
 
@@ -1607,6 +1598,8 @@ static const struct tty_operations serial_ops = {
 	.tiocmget = rs_tiocmget,
 	.tiocmset = rs_tiocmset,
 	.get_icount = rs_get_icount,
+	.set_serial = set_serial_info,
+	.get_serial = get_serial_info,
 	.proc_show = rs_proc_show,
 };
 
-- 
2.11.0

