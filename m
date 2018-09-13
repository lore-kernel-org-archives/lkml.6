Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD6DC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0102146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0102146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeIMHsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43654 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeIMHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYp-0006Qg-Fz; Thu, 13 Sep 2018 02:40:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/50] cdc-acm: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:17 +0100
Message-Id: <20180913024049.24567-18-viro@ZenIV.linux.org.uk>
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
 drivers/usb/class/cdc-acm.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 27346d69f393..5fd59a58de92 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -956,37 +956,28 @@ static int acm_tty_tiocmset(struct tty_struct *tty,
 	return acm_set_control(acm, acm->ctrlout = newctrl);
 }
 
-static int get_serial_info(struct acm *acm, struct serial_struct __user *info)
+static int get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
-	struct serial_struct tmp;
+	struct acm *acm = tty->driver_data;
 
-	memset(&tmp, 0, sizeof(tmp));
-	tmp.xmit_fifo_size = acm->writesize;
-	tmp.baud_base = le32_to_cpu(acm->line.dwDTERate);
-	tmp.close_delay	= acm->port.close_delay / 10;
-	tmp.closing_wait = acm->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
+	ss->xmit_fifo_size = acm->writesize;
+	ss->baud_base = le32_to_cpu(acm->line.dwDTERate);
+	ss->close_delay	= acm->port.close_delay / 10;
+	ss->closing_wait = acm->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 				ASYNC_CLOSING_WAIT_NONE :
 				acm->port.closing_wait / 10;
-
-	if (copy_to_user(info, &tmp, sizeof(tmp)))
-		return -EFAULT;
-	else
-		return 0;
+	return 0;
 }
 
-static int set_serial_info(struct acm *acm,
-				struct serial_struct __user *newinfo)
+static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 {
-	struct serial_struct new_serial;
+	struct acm *acm = tty->driver_data;
 	unsigned int closing_wait, close_delay;
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
 
 	mutex_lock(&acm->port.mutex);
 
@@ -1071,12 +1062,6 @@ static int acm_tty_ioctl(struct tty_struct *tty,
 	int rv = -ENOIOCTLCMD;
 
 	switch (cmd) {
-	case TIOCGSERIAL: /* gets serial port data */
-		rv = get_serial_info(acm, (struct serial_struct __user *) arg);
-		break;
-	case TIOCSSERIAL:
-		rv = set_serial_info(acm, (struct serial_struct __user *) arg);
-		break;
 	case TIOCMIWAIT:
 		rv = usb_autopm_get_interface(acm->control);
 		if (rv < 0) {
@@ -1998,6 +1983,8 @@ static const struct tty_operations acm_ops = {
 	.set_termios =		acm_tty_set_termios,
 	.tiocmget =		acm_tty_tiocmget,
 	.tiocmset =		acm_tty_tiocmset,
+	.get_serial =		get_serial_info,
+	.set_serial =		set_serial_info,
 	.get_icount =		acm_tty_get_icount,
 };
 
-- 
2.11.0

