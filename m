Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7248C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7207320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7207320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeILURM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:17:12 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60713 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeILURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:17:12 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mq2za-1fVyyV40aQ-00n8nk; Wed, 12 Sep 2018 17:11:58 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/17] compat_ioctl: move rtc handling into rtc-dev.c
Date:   Wed, 12 Sep 2018 17:08:53 +0200
Message-Id: <20180912151134.436719-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912151134.436719-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
X-Provags-ID: V03:K1:/lDmWHltkb95roFyCi33jMAOL5Z83iacQMqJ17PWNKeiyo7FOBS
 Z3TAhJ9yX6UzLmqAMc3q8oDQPXFqhkjQawJCJUikgbE1PvTk21rfPLFSysvVNAm8Zrb3Pyc
 TOfACCM615podZrM7bc+udjNXiv3BYRAMex+nfGLJx1GjHxjN5M2JBt4WG2i94AoUGVh/h4
 znb0Xl3wBL/bWhg/whjLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ORT8gnPtTQg=:6R29ukBK1Fc/CoZT/ybUOs
 KnsYdseCyuxAKww7QmTr7JdD+G2nuvveadpsvjJoP6hOtCZ5rjTEhQ+2euNePrWAc2l0XOIwc
 ceqDxmyFlnYaPFDyxHqKE+WCfZVd1hm+mEIjMXNWoZC38GuAQnwXzENcBlT2Ou1TyZx/86sjJ
 DKXlSpuS1FN7R4XAFTWQWfmZmLLSvNKFUgb7ZVW+y8677jLSY7/kTa2aa4xYmKR4ap2U4nE81
 wlLM1n3wXnYhRUOU9y6z4/gbNwTHRRIO38TlF8yP2UXyVatIVQTJpAtgvRx/GfoagSQdBhTSh
 n/Ovaw6PKavcO0MdGyiM1sqCbICPDDRJC+fr/aduSf88jekdpEodB7E9gy+J/LIcfkCtUoGR/
 7YWyxsxbhae5RnMRvT/ejxNFYPQJgafJzWvupUKLbV6OCYUN0q8E85nzYp3Ea3Nka03Z+zMhb
 thPWs8Fkr8QoktkAHyc685xu4BhN2vw5lJEQ3KV/p/O0sg1Qo9RgY0m4wuPkfLbvt/WR7hthR
 Hh73i9dLPuZ7HcV4jlutwLr9hfa0iwfPbWEXBe7AJvPmylnOciHJx/PT/02ttSiJKmqrZKwrk
 SIFNH1EDKZED18aOh2csjCWcSm2gAfng9a7wdcTLUnPK/vnqFMDRy7ZYtxFDZGO8iLMmiiUz4
 P0222qO9L+eIN6pY/fYeKb2gptotuULxrVzgmXkRR4KIsKbA6qM2wLnSC9+9XalFp1cM=
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

Since the ioctl commands are either compatible or differ in both structure
and command code between 32-bit and 64-bit, we can merge the compat
handler into the native one and just implement the two common compat
commands (RTC_IRQP_READ, RTC_IRQP_SET) there.

The old conversion handler also deals with RTC_EPOCH_READ and
RTC_EPOCH_SET, which are not handled in rtc-dev.c but only in
a single device driver (rtc-vr41xx), so I'm adding the compat
version in the same place. I don't expect other drivers to need
those commands in the future.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: merge compat handler into ioctl function to avoid the
    compat_alloc_user_space() roundtrip, based on feedback
    from Al Viro.
---
 drivers/rtc/rtc-dev.c    | 13 +++++++++-
 drivers/rtc/rtc-vr41xx.c | 10 ++++++++
 fs/compat_ioctl.c        | 54 ----------------------------------------
 3 files changed, 22 insertions(+), 55 deletions(-)

diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index 43d962a9c210..ccd5b1795e20 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/sched/signal.h>
@@ -364,10 +365,19 @@ static long rtc_dev_ioctl(struct file *file,
 		mutex_unlock(&rtc->ops_lock);
 		return rtc_update_irq_enable(rtc, 0);
 
+#ifdef CONFIG_COMPAT
+#define RTC_IRQP_SET32		_IOW('p', 0x0c, compat_ulong_t)
+#define RTC_IRQP_READ32		_IOR('p', 0x0b, compat_ulong_t)
+	case RTC_IRQP_SET32:
+		err = rtc_irq_set_freq(rtc, arg);
+		break;
+	case RTC_IRQP_READ32:
+		err = put_user(rtc->irq_freq, (unsigned int __user *)uarg);
+		break;
+#endif
 	case RTC_IRQP_SET:
 		err = rtc_irq_set_freq(rtc, arg);
 		break;
-
 	case RTC_IRQP_READ:
 		err = put_user(rtc->irq_freq, (unsigned long __user *)uarg);
 		break;
@@ -439,6 +449,7 @@ static const struct file_operations rtc_dev_fops = {
 	.read		= rtc_dev_read,
 	.poll		= rtc_dev_poll,
 	.unlocked_ioctl	= rtc_dev_ioctl,
+	.compat_ioctl	= generic_compat_ioctl_ptrarg,
 	.open		= rtc_dev_open,
 	.release	= rtc_dev_release,
 	.fasync		= rtc_dev_fasync,
diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 70f013e692b0..1d90bde59d21 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/compat.h>
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -79,6 +80,10 @@ static void __iomem *rtc2_base;
 #define rtc2_read(offset)		readw(rtc2_base + (offset))
 #define rtc2_write(offset, value)	writew((value), rtc2_base + (offset))
 
+/* 32-bit compat for ioctls that nobody else uses */
+#define RTC_EPOCH_READ32	_IOR('p', 0x0d, compat_ulong_t)
+#define RTC_EPOCH_SET32		_IOW('p', 0x0e, compat_ulong_t)
+
 static unsigned long epoch = 1970;	/* Jan 1 1970 00:00:00 */
 
 static DEFINE_SPINLOCK(rtc_lock);
@@ -195,6 +200,11 @@ static int vr41xx_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long
 	switch (cmd) {
 	case RTC_EPOCH_READ:
 		return put_user(epoch, (unsigned long __user *)arg);
+#ifdef CONFIG_COMPAT
+	case RTC_EPOCH_READ32:
+		return put_user(epoch, (unsigned int __user *)arg);
+	case RTC_EPOCH_SET32:
+#endif
 	case RTC_EPOCH_SET:
 		/* Doesn't support before 1900 */
 		if (arg < 1900)
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 2d7c7e149083..312b52b4e974 100644
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
@@ -633,37 +632,6 @@ static int serial_struct_ioctl(struct file *file,
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
@@ -816,21 +784,6 @@ COMPATIBLE_IOCTL(SCSI_IOCTL_GET_PCI)
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
@@ -1307,13 +1260,6 @@ static long do_ioctl_trans(unsigned int cmd,
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

