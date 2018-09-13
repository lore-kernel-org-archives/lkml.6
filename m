Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4E6C61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4B2214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4B2214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeIMHsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43622 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIMHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYo-0006PT-5m; Thu, 13 Sep 2018 02:40:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/50] greybus/uart: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:07 +0100
Message-Id: <20180913024049.24567-8-viro@ZenIV.linux.org.uk>
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
 drivers/staging/greybus/uart.c | 47 ++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 8a006323c3c1..3313cb0b60af 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -616,40 +616,33 @@ static void gb_tty_unthrottle(struct tty_struct *tty)
 	}
 }
 
-static int get_serial_info(struct gb_tty *gb_tty,
-			   struct serial_struct __user *info)
+static int get_serial_info(struct tty_struct *tty,
+			   struct serial_struct *ss)
 {
-	struct serial_struct tmp;
-
-	memset(&tmp, 0, sizeof(tmp));
-	tmp.type = PORT_16550A;
-	tmp.line = gb_tty->minor;
-	tmp.xmit_fifo_size = 16;
-	tmp.baud_base = 9600;
-	tmp.close_delay = gb_tty->port.close_delay / 10;
-	tmp.closing_wait =
+	struct gb_tty *gb_tty = tty->driver_data;
+
+	ss->type = PORT_16550A;
+	ss->line = gb_tty->minor;
+	ss->xmit_fifo_size = 16;
+	ss->baud_base = 9600;
+	ss->close_delay = gb_tty->port.close_delay / 10;
+	ss->closing_wait =
 		gb_tty->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 		ASYNC_CLOSING_WAIT_NONE : gb_tty->port.closing_wait / 10;
-
-	if (copy_to_user(info, &tmp, sizeof(tmp)))
-		return -EFAULT;
 	return 0;
 }
 
-static int set_serial_info(struct gb_tty *gb_tty,
-			   struct serial_struct __user *newinfo)
+static int set_serial_info(struct tty_struct *tty,
+			   struct serial_struct *ss)
 {
-	struct serial_struct new_serial;
+	struct gb_tty *gb_tty = tty->driver_data;
 	unsigned int closing_wait;
 	unsigned int close_delay;
 	int retval = 0;
 
-	if (copy_from_user(&new_serial, newinfo, sizeof(new_serial)))
-		return -EFAULT;
-
-	close_delay = new_serial.close_delay * 10;
-	closing_wait = new_serial.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
-			ASYNC_CLOSING_WAIT_NONE : new_serial.closing_wait * 10;
+	close_delay = ss->close_delay * 10;
+	closing_wait = ss->closing_wait == ASYNC_CLOSING_WAIT_NONE ?
+			ASYNC_CLOSING_WAIT_NONE : ss->closing_wait * 10;
 
 	mutex_lock(&gb_tty->port.mutex);
 	if (!capable(CAP_SYS_ADMIN)) {
@@ -728,12 +721,6 @@ static int gb_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 	struct gb_tty *gb_tty = tty->driver_data;
 
 	switch (cmd) {
-	case TIOCGSERIAL:
-		return get_serial_info(gb_tty,
-				       (struct serial_struct __user *)arg);
-	case TIOCSSERIAL:
-		return set_serial_info(gb_tty,
-				       (struct serial_struct __user *)arg);
 	case TIOCMIWAIT:
 		return wait_serial_change(gb_tty, arg);
 	}
@@ -818,6 +805,8 @@ static const struct tty_operations gb_ops = {
 	.tiocmget =		gb_tty_tiocmget,
 	.tiocmset =		gb_tty_tiocmset,
 	.get_icount =		gb_tty_get_icount,
+	.set_serial = 		set_serial_info,
+	.get_serial = 		get_serial_info,
 };
 
 static const struct tty_port_operations gb_port_ops = {
-- 
2.11.0

