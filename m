Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0BDC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6B12133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6B12133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeIMHwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:52:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43600 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeIMHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYo-0006Ph-Cf; Thu, 13 Sep 2018 02:40:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/50] cyclades: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:09 +0100
Message-Id: <20180913024049.24567-10-viro@ZenIV.linux.org.uk>
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
 drivers/tty/cyclades.c | 77 ++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 6d3c58051ce3..4562c8060d09 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -2257,44 +2257,45 @@ static void cy_set_line_char(struct cyclades_port *info, struct tty_struct *tty)
 	}
 }				/* set_line_char */
 
-static int cy_get_serial_info(struct cyclades_port *info,
-		struct serial_struct __user *retinfo)
+static int cy_get_serial_info(struct tty_struct *tty,
+				struct serial_struct *ss)
 {
+	struct cyclades_port *info = tty->driver_data;
 	struct cyclades_card *cinfo = info->card;
-	struct serial_struct tmp = {
-		.type = info->type,
-		.line = info->line,
-		.port = (info->card - cy_card) * 0x100 + info->line -
-			cinfo->first_line,
-		.irq = cinfo->irq,
-		.flags = info->port.flags,
-		.close_delay = info->port.close_delay,
-		.closing_wait = info->port.closing_wait,
-		.baud_base = info->baud,
-		.custom_divisor = info->custom_divisor,
-	};
-	return copy_to_user(retinfo, &tmp, sizeof(*retinfo)) ? -EFAULT : 0;
+
+	if (serial_paranoia_check(info, tty->name, "cy_ioctl"))
+		return -ENODEV;
+	ss->type = info->type;
+	ss->line = info->line;
+	ss->port = (info->card - cy_card) * 0x100 + info->line -
+			cinfo->first_line;
+	ss->irq = cinfo->irq;
+	ss->flags = info->port.flags;
+	ss->close_delay = info->port.close_delay;
+	ss->closing_wait = info->port.closing_wait;
+	ss->baud_base = info->baud;
+	ss->custom_divisor = info->custom_divisor;
+	return 0;
 }
 
-static int
-cy_set_serial_info(struct cyclades_port *info, struct tty_struct *tty,
-		struct serial_struct __user *new_info)
+static int cy_set_serial_info(struct tty_struct *tty,
+				struct serial_struct *ss)
 {
-	struct serial_struct new_serial;
+	struct cyclades_port *info = tty->driver_data;
 	int old_flags;
 	int ret;
 
-	if (copy_from_user(&new_serial, new_info, sizeof(new_serial)))
-		return -EFAULT;
+	if (serial_paranoia_check(info, tty->name, "cy_ioctl"))
+		return -ENODEV;
 
 	mutex_lock(&info->port.mutex);
 
 	old_flags = info->port.flags;
 
 	if (!capable(CAP_SYS_ADMIN)) {
-		if (new_serial.close_delay != info->port.close_delay ||
-				new_serial.baud_base != info->baud ||
-				(new_serial.flags & ASYNC_FLAGS &
+		if (ss->close_delay != info->port.close_delay ||
+				ss->baud_base != info->baud ||
+				(ss->flags & ASYNC_FLAGS &
 					~ASYNC_USR_MASK) !=
 				(info->port.flags & ASYNC_FLAGS & ~ASYNC_USR_MASK))
 		{
@@ -2302,9 +2303,9 @@ cy_set_serial_info(struct cyclades_port *info, struct tty_struct *tty,
 			return -EPERM;
 		}
 		info->port.flags = (info->port.flags & ~ASYNC_USR_MASK) |
-				(new_serial.flags & ASYNC_USR_MASK);
-		info->baud = new_serial.baud_base;
-		info->custom_divisor = new_serial.custom_divisor;
+				(ss->flags & ASYNC_USR_MASK);
+		info->baud = ss->baud_base;
+		info->custom_divisor = ss->custom_divisor;
 		goto check_and_exit;
 	}
 
@@ -2313,18 +2314,18 @@ cy_set_serial_info(struct cyclades_port *info, struct tty_struct *tty,
 	 * At this point, we start making changes.....
 	 */
 
-	info->baud = new_serial.baud_base;
-	info->custom_divisor = new_serial.custom_divisor;
+	info->baud = ss->baud_base;
+	info->custom_divisor = ss->custom_divisor;
 	info->port.flags = (info->port.flags & ~ASYNC_FLAGS) |
-			(new_serial.flags & ASYNC_FLAGS);
-	info->port.close_delay = new_serial.close_delay * HZ / 100;
-	info->port.closing_wait = new_serial.closing_wait * HZ / 100;
+			(ss->flags & ASYNC_FLAGS);
+	info->port.close_delay = ss->close_delay * HZ / 100;
+	info->port.closing_wait = ss->closing_wait * HZ / 100;
 
 check_and_exit:
 	if (tty_port_initialized(&info->port)) {
-		if ((new_serial.flags ^ old_flags) & ASYNC_SPD_MASK) {
+		if ((ss->flags ^ old_flags) & ASYNC_SPD_MASK) {
 			/* warn about deprecation unless clearing */
-			if (new_serial.flags & ASYNC_SPD_MASK)
+			if (ss->flags & ASYNC_SPD_MASK)
 				dev_warn_ratelimited(tty->dev, "use of SPD flags is deprecated\n");
 		}
 		cy_set_line_char(info, tty);
@@ -2698,12 +2699,6 @@ cy_ioctl(struct tty_struct *tty,
 	case CYGETWAIT:
 		ret_val = info->port.closing_wait / (HZ / 100);
 		break;
-	case TIOCGSERIAL:
-		ret_val = cy_get_serial_info(info, argp);
-		break;
-	case TIOCSSERIAL:
-		ret_val = cy_set_serial_info(info, tty, argp);
-		break;
 	case TIOCSERGETLSR:	/* Get line status register */
 		ret_val = get_lsr_info(info, argp);
 		break;
@@ -4011,6 +4006,8 @@ static const struct tty_operations cy_ops = {
 	.tiocmget = cy_tiocmget,
 	.tiocmset = cy_tiocmset,
 	.get_icount = cy_get_icount,
+	.set_serial = cy_set_serial_info,
+	.get_serial = cy_get_serial_info,
 	.proc_show = cyclades_proc_show,
 };
 
-- 
2.11.0

