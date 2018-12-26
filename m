Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FB3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D282148E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeLZAoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 19:44:05 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57332 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeLZAoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 19:44:00 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 002362951B; Tue, 25 Dec 2018 19:43:55 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <b8154e56502650a08734355831399406676834e2.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 07/25] char/nvram: Allow the set_checksum and initialize
 ioctls to be omitted
Date:   Wed, 26 Dec 2018 11:37:59 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers/char/nvram module has previously only supported RTC "CMOS"
NVRAM, for which it provides appropriate checksum ioctls. Make these
ioctls optional so the module can be re-used with other kinds of NVRAM.

The ops struct methods that implement the ioctls now return error
codes so that a multi-platform kernel binary can do the right thing when
running on hardware without suitable NVRAM.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/char/nvram.c  | 70 ++++++++++++++++++++++++-------------------
 include/linux/nvram.h |  2 ++
 2 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 00897daa0643..33ef3b02d365 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -153,16 +153,25 @@ static void __nvram_set_checksum(void)
 	__nvram_write_byte(sum & 0xff, PC_CKS_LOC + 1);
 }
 
-#if 0
-void nvram_set_checksum(void)
+static long nvram_set_checksum(void)
 {
-	unsigned long flags;
+	spin_lock_irq(&rtc_lock);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+}
 
-	spin_lock_irqsave(&rtc_lock, flags);
+static long nvram_initialize(void)
+{
+	ssize_t i;
+
+	spin_lock_irq(&rtc_lock);
+	for (i = 0; i < NVRAM_BYTES; ++i)
+		__nvram_write_byte(0, i);
 	__nvram_set_checksum();
-	spin_unlock_irqrestore(&rtc_lock, flags);
+	spin_unlock_irq(&rtc_lock);
+	return 0;
 }
-#endif  /*  0  */
 
 static ssize_t nvram_get_size(void)
 {
@@ -173,6 +182,8 @@ const struct nvram_ops arch_nvram_ops = {
 	.read_byte      = nvram_read_byte,
 	.write_byte     = nvram_write_byte,
 	.get_size       = nvram_get_size,
+	.set_checksum   = nvram_set_checksum,
+	.initialize     = nvram_initialize,
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 #endif /* CONFIG_X86 */
@@ -258,51 +269,50 @@ static ssize_t nvram_misc_write(struct file *file, const char __user *buf,
 static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
-	int i;
+	long ret = -ENOTTY;
 
 	switch (cmd) {
-
 	case NVRAM_INIT:
 		/* initialize NVRAM contents and checksum */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
-		mutex_lock(&nvram_mutex);
-		spin_lock_irq(&rtc_lock);
-
-		for (i = 0; i < NVRAM_BYTES; ++i)
-			__nvram_write_byte(0, i);
-		__nvram_set_checksum();
-
-		spin_unlock_irq(&rtc_lock);
-		mutex_unlock(&nvram_mutex);
-		return 0;
-
+		if (arch_nvram_ops.initialize != NULL) {
+			mutex_lock(&nvram_mutex);
+			ret = arch_nvram_ops.initialize();
+			mutex_unlock(&nvram_mutex);
+		}
+		break;
 	case NVRAM_SETCKS:
 		/* just set checksum, contents unchanged (maybe useful after
 		 * checksum garbaged somehow...) */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
-		mutex_lock(&nvram_mutex);
-		spin_lock_irq(&rtc_lock);
-		__nvram_set_checksum();
-		spin_unlock_irq(&rtc_lock);
-		mutex_unlock(&nvram_mutex);
-		return 0;
-
-	default:
-		return -ENOTTY;
+		if (arch_nvram_ops.set_checksum != NULL) {
+			mutex_lock(&nvram_mutex);
+			ret = arch_nvram_ops.set_checksum();
+			mutex_unlock(&nvram_mutex);
+		}
+		break;
 	}
+	return ret;
 }
 
 static int nvram_misc_open(struct inode *inode, struct file *file)
 {
 	spin_lock(&nvram_state_lock);
 
+	/* Prevent multiple readers/writers if desired. */
 	if ((nvram_open_cnt && (file->f_flags & O_EXCL)) ||
-	    (nvram_open_mode & NVRAM_EXCL) ||
-	    ((file->f_mode & FMODE_WRITE) && (nvram_open_mode & NVRAM_WRITE))) {
+	    (nvram_open_mode & NVRAM_EXCL)) {
+		spin_unlock(&nvram_state_lock);
+		return -EBUSY;
+	}
+
+	/* Prevent multiple writers if the set_checksum ioctl is implemented. */
+	if ((arch_nvram_ops.set_checksum != NULL) &&
+	    (file->f_mode & FMODE_WRITE) && (nvram_open_mode & NVRAM_WRITE)) {
 		spin_unlock(&nvram_state_lock);
 		return -EBUSY;
 	}
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index d1bdee50d6a8..b7bfaec60a43 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -18,6 +18,8 @@ struct nvram_ops {
 	unsigned char   (*read_byte)(int);
 	void            (*write_byte)(unsigned char, int);
 	ssize_t         (*get_size)(void);
+	long            (*set_checksum)(void);
+	long            (*initialize)(void);
 };
 
 extern const struct nvram_ops arch_nvram_ops;
-- 
2.19.2

