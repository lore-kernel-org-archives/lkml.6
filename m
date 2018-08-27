Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F88AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0EC208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0EC208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeH0XwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:52:23 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42364 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeH0XwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:52:23 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LthqL-1fkrfP30zt-011E7P; Mon, 27 Aug 2018 22:04:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-rtc@vger.kernel.org
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        keguang.zhang@gmail.com, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] rtc: move compat_ioctl handling into rtc-dev.c
Date:   Mon, 27 Aug 2018 22:03:09 +0200
Message-Id: <20180827200338.220211-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827200338.220211-1-arnd@arndb.de>
References: <20180827200338.220211-1-arnd@arndb.de>
X-Provags-ID: V03:K1:HlLt/0RqtwSSa6ETfdZZQzZE1d5bBmV5dAbSM/dq1QQfDXuuMF2
 8stp7k8tw8S5/k/NQwLZ7yOkdhfGh3pIUcAe5t7Lh4k+j7+5EGAdwejdCCrhJ6kJC7ODQGg
 BlQTGiMyPrlTSXgXgoem8/esWegzJ21AL7z7LVpDXj61zKbpigonx5zLeug1cG3GjyZKPQL
 zE1nD/LSgCZFtbpvqK9NQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1HP3eqmnmJc=:1ylCxVqxTu2KYUNMU4XaDt
 /db9J0+fbprd+7vJCw6losvJDHeHcuK74mCt7dNCpj5W7o5AeTEEUWreU7IW2Q512LjsDqD1U
 wpbToOrJhYoBKw38cp8fqznnciUdPnV3tGCDMrY23wqYAAzPRmXuaN5Nh32poTHyOkY5Fkpo/
 RybySZDKchF/RqvGjQ6ZF1fQmOpDDm7EAq7h+J6g9jO0gx1IDwl0unTXXNTGhh2hB43oBQnsY
 rPALXCZq0CHheSUKe5eaiqKbr8Mv1ssKp1G5DMfzolsFJtlEpMz71IjSrOiPa9oCynvdwHKZY
 h7Zdq8goEYWetQqHSVay50jHGBxXf3sHS7vOfTjCTln0UQFSRQXmY6MW4gecprDj6BGn2JucF
 ZB7FE+61UDuQzJXzzBZ3TY3d6oJAJxboJ1SMRzSVsKAhOTukGN4qGu25DYwRRXuSzOibaHOis
 UOuKCeBFd5lmN0fEfsQve5/6P/Aglr3yeSpyvy32xPJe7MeJ23e91v5Cd4pc2F59Vr0MQeUA0
 actyj88ncbkddonRdsrXWjH+fDgqtW+Abk4MbY/BJDk3F5fBM7a3PimnrSd0yzyy8dIGZFCCe
 WsxJfvQVu2g8h5xOpFb9D3YVnXkOT2/n5HgXnu0H7HocrAXzdTOK1cdZrTV3hKotyi4lPF4SC
 bLBVVVZ3/1DeE6o6sAS+NNGpt6CtdILF3T3iFpJKLfqqOHeZo5f/aBXjZNphC2eFfIMM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We no longer need the rtc compat handling to be in common code, now that
all drivers are either moved to the rtc-class framework, or (rarely)
exist in drivers/char for architectures without compat mode (m68k,
alpha and ia64, respectively).

I checked the list of ioctl commands in drivers, and the ones that are
not already handled are all compatible, again with the one exception of
m68k driver, which implements RTC_PLL_GET and RTC_PLL_SET, but has no
compat mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-dev.c | 50 +++++++++++++++++++++++++++++++++++++++
 fs/compat_ioctl.c     | 54 -------------------------------------------
 2 files changed, 50 insertions(+), 54 deletions(-)

diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index 43d962a9c210..50b03e175263 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/sched/signal.h>
@@ -405,6 +406,52 @@ static long rtc_dev_ioctl(struct file *file,
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+#define RTC_IRQP_READ32		_IOR('p', 0x0b, compat_ulong_t)
+#define RTC_IRQP_SET32		_IOW('p', 0x0c, compat_ulong_t)
+#define RTC_EPOCH_READ32	_IOR('p', 0x0d, compat_ulong_t)
+#define RTC_EPOCH_SET32		_IOW('p', 0x0e, compat_ulong_t)
+
+static long rtc_dev_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+{
+	unsigned long __user *valp;
+	compat_ulong_t __user *argp = compat_ptr(arg);
+	unsigned long val;
+	int ret;
+
+	switch (cmd) {
+	/* pointer to 'long' needs translation. */
+	case RTC_IRQP_READ32:
+	case RTC_EPOCH_READ32: {
+		valp = compat_alloc_user_space(sizeof(*valp));
+		if (valp == NULL)
+			return -EFAULT;
+		ret = rtc_dev_ioctl(file, (cmd == RTC_IRQP_READ32) ?
+					RTC_IRQP_READ : RTC_EPOCH_READ,
+					(unsigned long)valp);
+		if (ret)
+			return ret;
+		if (get_user(val, valp) || put_user(val, argp))
+			return -EFAULT;
+		return 0;
+	}
+
+	/* arguments are compatible, command number is not */
+	case RTC_IRQP_SET32:
+		return rtc_dev_ioctl(file, RTC_IRQP_SET, arg);
+	case RTC_EPOCH_SET32:
+		return rtc_dev_ioctl(file, RTC_EPOCH_SET, arg);
+	}
+
+	/*
+	 * all other rtc ioctls are compatible, or only
+	 * exist on architectures without compat mode
+	 */
+
+	return rtc_dev_ioctl(file, cmd, (unsigned long)argp);
+}
+#endif
+
 static int rtc_dev_fasync(int fd, struct file *file, int on)
 {
 	struct rtc_device *rtc = file->private_data;
@@ -439,6 +486,9 @@ static const struct file_operations rtc_dev_fops = {
 	.read		= rtc_dev_read,
 	.poll		= rtc_dev_poll,
 	.unlocked_ioctl	= rtc_dev_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= rtc_dev_compat_ioctl,
+#endif
 	.open		= rtc_dev_open,
 	.release	= rtc_dev_release,
 	.fasync		= rtc_dev_fasync,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a9b00942e87d..a5c86a2fa8e6 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -46,7 +46,6 @@
 #include <linux/raw.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
-#include <linux/rtc.h>
 #include <linux/pci.h>
 #include <linux/serial.h>
 #include <linux/if_tun.h>
@@ -623,37 +622,6 @@ static int serial_struct_ioctl(struct file *file,
         return err;
 }
 
-#define RTC_IRQP_READ32		_IOR('p', 0x0b, compat_ulong_t)
-#define RTC_IRQP_SET32		_IOW('p', 0x0c, compat_ulong_t)
-#define RTC_EPOCH_READ32	_IOR('p', 0x0d, compat_ulong_t)
-#define RTC_EPOCH_SET32		_IOW('p', 0x0e, compat_ulong_t)
-
-static int rtc_ioctl(struct file *file,
-		unsigned cmd, void __user *argp)
-{
-	unsigned long __user *valp = compat_alloc_user_space(sizeof(*valp));
-	int ret;
-
-	if (valp == NULL)
-		return -EFAULT;
-	switch (cmd) {
-	case RTC_IRQP_READ32:
-	case RTC_EPOCH_READ32:
-		ret = do_ioctl(file, (cmd == RTC_IRQP_READ32) ?
-					RTC_IRQP_READ : RTC_EPOCH_READ,
-					(unsigned long)valp);
-		if (ret)
-			return ret;
-		return convert_in_user(valp, (unsigned int __user *)argp);
-	case RTC_IRQP_SET32:
-		return do_ioctl(file, RTC_IRQP_SET, (unsigned long)argp);
-	case RTC_EPOCH_SET32:
-		return do_ioctl(file, RTC_EPOCH_SET, (unsigned long)argp);
-	}
-
-	return -ENOIOCTLCMD;
-}
-
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
 struct space_resv_32 {
@@ -806,21 +774,6 @@ COMPATIBLE_IOCTL(SCSI_IOCTL_GET_PCI)
 /* Big V (don't complain on serial console) */
 IGNORE_IOCTL(VT_OPENQRY)
 IGNORE_IOCTL(VT_GETMODE)
-/* Little p (/dev/rtc, /dev/envctrl, etc.) */
-COMPATIBLE_IOCTL(RTC_AIE_ON)
-COMPATIBLE_IOCTL(RTC_AIE_OFF)
-COMPATIBLE_IOCTL(RTC_UIE_ON)
-COMPATIBLE_IOCTL(RTC_UIE_OFF)
-COMPATIBLE_IOCTL(RTC_PIE_ON)
-COMPATIBLE_IOCTL(RTC_PIE_OFF)
-COMPATIBLE_IOCTL(RTC_WIE_ON)
-COMPATIBLE_IOCTL(RTC_WIE_OFF)
-COMPATIBLE_IOCTL(RTC_ALM_SET)
-COMPATIBLE_IOCTL(RTC_ALM_READ)
-COMPATIBLE_IOCTL(RTC_RD_TIME)
-COMPATIBLE_IOCTL(RTC_SET_TIME)
-COMPATIBLE_IOCTL(RTC_WKALM_SET)
-COMPATIBLE_IOCTL(RTC_WKALM_RD)
 /*
  * These two are only for the sbus rtc driver, but
  * hwclock tries them on every rtc device first when
@@ -1297,13 +1250,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	case TIOCGSERIAL:
 	case TIOCSSERIAL:
 		return serial_struct_ioctl(file, cmd, argp);
-	/* Not implemented in the native kernel */
-	case RTC_IRQP_READ32:
-	case RTC_IRQP_SET32:
-	case RTC_EPOCH_READ32:
-	case RTC_EPOCH_SET32:
-		return rtc_ioctl(file, cmd, argp);
-
 	/* dvb */
 	case VIDEO_GET_EVENT:
 		return do_video_get_event(file, cmd, argp);
-- 
2.18.0

