Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8992CC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF052146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF052146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeIMHvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:51:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43620 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeIMHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYn-0006PB-S3; Thu, 13 Sep 2018 02:40:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/50] tty_ioctl(): start taking TIOC[SG]SERIAL into separate methods
Date:   Thu, 13 Sep 2018 03:40:04 +0100
Message-Id: <20180913024049.24567-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

->set_serial() and ->get_serial() resp., both taking tty and
a kernel pointer to serial_struct.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/tty/tty_io.c       | 36 ++++++++++++++++++++++++++++++------
 include/linux/tty_driver.h |  3 +++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 2b34ccf269e0..91d73732e11c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -97,6 +97,7 @@
 #include <linux/seq_file.h>
 #include <linux/serial.h>
 #include <linux/ratelimit.h>
+#include <linux/compat.h>
 
 #include <linux/uaccess.h>
 
@@ -2455,22 +2456,40 @@ static int tty_tiocgicount(struct tty_struct *tty, void __user *arg)
 	return 0;
 }
 
-static void tty_warn_deprecated_flags(struct serial_struct __user *ss)
+static int tty_tiocsserial(struct tty_struct *tty, struct serial_struct __user *ss)
 {
 	static DEFINE_RATELIMIT_STATE(depr_flags,
 			DEFAULT_RATELIMIT_INTERVAL,
 			DEFAULT_RATELIMIT_BURST);
 	char comm[TASK_COMM_LEN];
+	struct serial_struct v;
 	int flags;
 
-	if (get_user(flags, &ss->flags))
-		return;
+	if (copy_from_user(&v, ss, sizeof(struct serial_struct)))
+		return -EFAULT;
 
-	flags &= ASYNC_DEPRECATED;
+	flags = v.flags & ASYNC_DEPRECATED;
 
 	if (flags && __ratelimit(&depr_flags))
 		pr_warn("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
 			__func__, get_task_comm(comm, current), flags);
+	if (!tty->ops->set_serial)
+		return -ENOIOCTLCMD;
+	return tty->ops->set_serial(tty, &v);
+}
+
+static int tty_tiocgserial(struct tty_struct *tty, struct serial_struct __user *ss)
+{
+	struct serial_struct v;
+	int err;
+	memset(&v, 0, sizeof(struct serial_struct));
+
+	if (!tty->ops->set_serial)
+		return -ENOIOCTLCMD;
+	err = tty->ops->get_serial(tty, &v);
+	if (!err && copy_to_user(ss, &v, sizeof(struct serial_struct)))
+		err = -EFAULT;
+	return err;
 }
 
 /*
@@ -2602,8 +2621,13 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	case TIOCSSERIAL:
-		tty_warn_deprecated_flags(p);
-		break;
+		retval = tty_tiocsserial(tty, p);
+		if (retval != -ENOIOCTLCMD)
+			return retval;
+	case TIOCGSERIAL:
+		retval = tty_tiocgserial(tty, p);
+		if (retval != -ENOIOCTLCMD)
+			return retval;
 	case TIOCGPTPEER:
 		/* Special because the struct file is needed */
 		return ptm_open_peer(file, tty, (int)arg);
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 71dbc891851a..358446247ccd 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -249,6 +249,7 @@
 struct tty_struct;
 struct tty_driver;
 struct serial_icounter_struct;
+struct serial_struct;
 
 struct tty_operations {
 	struct tty_struct * (*lookup)(struct tty_driver *driver,
@@ -287,6 +288,8 @@ struct tty_operations {
 	int (*set_termiox)(struct tty_struct *tty, struct termiox *tnew);
 	int (*get_icount)(struct tty_struct *tty,
 				struct serial_icounter_struct *icount);
+	int  (*get_serial)(struct tty_struct *tty, struct serial_struct *p);
+	int  (*set_serial)(struct tty_struct *tty, struct serial_struct *p);
 	void (*show_fdinfo)(struct tty_struct *tty, struct seq_file *m);
 #ifdef CONFIG_CONSOLE_POLL
 	int (*poll_init)(struct tty_driver *driver, int line, char *options);
-- 
2.11.0

