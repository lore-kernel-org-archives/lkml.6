Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF06EC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB7E2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB7E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeIMHuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:50:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43756 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeIMHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYs-0006Si-2g; Thu, 13 Sep 2018 02:40:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 36/50] take compat TIOC[SG]SERIAL treatment into tty_compat_ioctl()
Date:   Thu, 13 Sep 2018 03:40:35 +0100
Message-Id: <20180913024049.24567-36-viro@ZenIV.linux.org.uk>
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
 drivers/tty/tty_io.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/compat_ioctl.c    | 67 -------------------------------------------
 2 files changed, 81 insertions(+), 67 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 80d6c041c87e..b389163c4c5e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2651,6 +2651,81 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 
 #ifdef CONFIG_COMPAT
+
+struct serial_struct32 {
+        compat_int_t    type;
+        compat_int_t    line;
+        compat_uint_t   port;
+        compat_int_t    irq;
+        compat_int_t    flags;
+        compat_int_t    xmit_fifo_size;
+        compat_int_t    custom_divisor;
+        compat_int_t    baud_base;
+        unsigned short  close_delay;
+        char    io_type;
+        char    reserved_char[1];
+        compat_int_t    hub6;
+        unsigned short  closing_wait; /* time to wait before closing */
+        unsigned short  closing_wait2; /* no longer used... */
+        compat_uint_t   iomem_base;
+        unsigned short  iomem_reg_shift;
+        unsigned int    port_high;
+     /* compat_ulong_t  iomap_base FIXME */
+        compat_int_t    reserved[1];
+};
+
+static int compat_tty_tiocsserial(struct tty_struct *tty,
+		struct serial_struct32 __user *ss)
+{
+	static DEFINE_RATELIMIT_STATE(depr_flags,
+			DEFAULT_RATELIMIT_INTERVAL,
+			DEFAULT_RATELIMIT_BURST);
+	char comm[TASK_COMM_LEN];
+	struct serial_struct32 v32;
+	struct serial_struct v;
+	int flags;
+
+	if (copy_from_user(&v32, ss, sizeof(struct serial_struct32)))
+		return -EFAULT;
+
+	memcpy(&v, &v32, offsetof(struct serial_struct32, iomem_base));
+	v.iomem_base = compat_ptr(v32.iomem_base);
+	v.iomem_reg_shift = v32.iomem_reg_shift;
+	v.port_high = v32.port_high;
+	v.iomap_base = 0;
+
+	flags = v.flags & ASYNC_DEPRECATED;
+
+	if (flags && __ratelimit(&depr_flags))
+		pr_warn("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
+			__func__, get_task_comm(comm, current), flags);
+	if (!tty->ops->set_serial)
+		return -ENOTTY;
+	return tty->ops->set_serial(tty, &v);
+}
+
+static int compat_tty_tiocgserial(struct tty_struct *tty,
+			struct serial_struct32 __user *ss)
+{
+	struct serial_struct32 v32;
+	struct serial_struct v;
+	int err;
+	memset(&v, 0, sizeof(struct serial_struct));
+
+	if (!tty->ops->set_serial)
+		return -ENOTTY;
+	err = tty->ops->get_serial(tty, &v);
+	if (!err) {
+		memcpy(&v32, &v, offsetof(struct serial_struct32, iomem_base));
+		v32.iomem_base = (unsigned long)v.iomem_base >> 32 ?
+			0xfffffff : ptr_to_compat(v.iomem_base);
+		v32.iomem_reg_shift = v.iomem_reg_shift;
+		v32.port_high = v.port_high;
+		if (copy_to_user(ss, &v32, sizeof(struct serial_struct32)))
+			err = -EFAULT;
+	}
+	return err;
+}
 static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 				unsigned long arg)
 {
@@ -2736,6 +2811,12 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
 		return -EINVAL;
 
+	switch (cmd) {
+	case TIOCSSERIAL:
+		return compat_tty_tiocsserial(tty, compat_ptr(arg));
+	case TIOCGSERIAL:
+		return compat_tty_tiocgserial(tty, compat_ptr(arg));
+	}
 	if (tty->ops->compat_ioctl) {
 		retval = tty->ops->compat_ioctl(tty, cmd, arg);
 		if (retval != -ENOIOCTLCMD)
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 670b8cbd0896..2b35c6707e3d 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -560,69 +560,6 @@ static int mt_ioctl_trans(struct file *file,
 #define HIDPGETCONNLIST	_IOR('H', 210, int)
 #define HIDPGETCONNINFO	_IOR('H', 211, int)
 
-
-struct serial_struct32 {
-        compat_int_t    type;
-        compat_int_t    line;
-        compat_uint_t   port;
-        compat_int_t    irq;
-        compat_int_t    flags;
-        compat_int_t    xmit_fifo_size;
-        compat_int_t    custom_divisor;
-        compat_int_t    baud_base;
-        unsigned short  close_delay;
-        char    io_type;
-        char    reserved_char[1];
-        compat_int_t    hub6;
-        unsigned short  closing_wait; /* time to wait before closing */
-        unsigned short  closing_wait2; /* no longer used... */
-        compat_uint_t   iomem_base;
-        unsigned short  iomem_reg_shift;
-        unsigned int    port_high;
-     /* compat_ulong_t  iomap_base FIXME */
-        compat_int_t    reserved[1];
-};
-
-static int serial_struct_ioctl(struct file *file,
-		unsigned cmd, struct serial_struct32 __user *ss32)
-{
-        typedef struct serial_struct32 SS32;
-        int err;
-	struct serial_struct __user *ss = compat_alloc_user_space(sizeof(*ss));
-        __u32 udata;
-	unsigned int base;
-	unsigned char *iomem_base;
-
-	if (ss == NULL)
-		return -EFAULT;
-        if (cmd == TIOCSSERIAL) {
-		if (copy_in_user(ss, ss32, offsetof(SS32, iomem_base)) ||
-		    get_user(udata, &ss32->iomem_base))
-			return -EFAULT;
-		iomem_base = compat_ptr(udata);
-		if (put_user(iomem_base, &ss->iomem_base) ||
-		    convert_in_user(&ss32->iomem_reg_shift,
-		      &ss->iomem_reg_shift) ||
-		    convert_in_user(&ss32->port_high, &ss->port_high) ||
-		    put_user(0UL, &ss->iomap_base))
-			return -EFAULT;
-        }
-	err = do_ioctl(file, cmd, (unsigned long)ss);
-        if (cmd == TIOCGSERIAL && err >= 0) {
-		if (copy_in_user(ss32, ss, offsetof(SS32, iomem_base)) ||
-		    get_user(iomem_base, &ss->iomem_base))
-			return -EFAULT;
-		base = (unsigned long)iomem_base  >> 32 ?
-			0xffffffff : (unsigned)(unsigned long)iomem_base;
-		if (put_user(base, &ss32->iomem_base) ||
-		    convert_in_user(&ss->iomem_reg_shift,
-		      &ss32->iomem_reg_shift) ||
-		    convert_in_user(&ss->port_high, &ss32->port_high))
-			return -EFAULT;
-        }
-        return err;
-}
-
 #define RTC_IRQP_READ32		_IOR('p', 0x0b, compat_ulong_t)
 #define RTC_IRQP_SET32		_IOW('p', 0x0c, compat_ulong_t)
 #define RTC_EPOCH_READ32	_IOR('p', 0x0d, compat_ulong_t)
@@ -1242,10 +1179,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	case MTIOCPOS32:
 		return mt_ioctl_trans(file, cmd, argp);
 #endif
-	/* Serial */
-	case TIOCGSERIAL:
-	case TIOCSSERIAL:
-		return serial_struct_ioctl(file, cmd, argp);
 	/* Not implemented in the native kernel */
 	case RTC_IRQP_READ32:
 	case RTC_IRQP_SET32:
-- 
2.11.0

