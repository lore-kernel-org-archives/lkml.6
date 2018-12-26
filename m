Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49791C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EC52148E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeLZAov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 19:44:51 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57368 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeLZAoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 19:44:02 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id CA04629527; Tue, 25 Dec 2018 19:43:56 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 18/25] powerpc: Implement nvram sync ioctl
Date:   Wed, 26 Dec 2018 11:37:59 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the powerpc-specific sync() method to struct nvram_ops and implement
the corresponding ioctl in the nvram module. This allows the nvram module
to replace the generic_nvram module.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
On PPC32, the IOC_NVRAM_SYNC ioctl call always returns 0, even for those
platforms that don't implement ppc_md.nvram_sync. This patch retains
that quirk. It might be better to return -EINVAL (which is what PPC64 does).
---
 arch/powerpc/include/asm/nvram.h |  3 ---
 arch/powerpc/kernel/setup_32.c   |  6 ++---
 drivers/char/generic_nvram.c     |  2 +-
 drivers/char/nvram.c             | 38 ++++++++++++++++++++++++++++++++
 include/linux/nvram.h            |  4 ++++
 5 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
index 56a388da9c4f..629a5cdcc865 100644
--- a/arch/powerpc/include/asm/nvram.h
+++ b/arch/powerpc/include/asm/nvram.h
@@ -78,9 +78,6 @@ extern int	pmac_get_partition(int partition);
 extern u8	pmac_xpram_read(int xpaddr);
 extern void	pmac_xpram_write(int xpaddr, u8 data);
 
-/* Synchronize NVRAM */
-extern void	nvram_sync(void);
-
 /* Initialize NVRAM OS partition */
 extern int __init nvram_init_os_partition(struct nvram_os_partition *part);
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index ee91bba0805d..e0d045677472 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -152,7 +152,6 @@ __setup("l3cr=", ppc_setup_l3cr);
 
 #ifdef CONFIG_GENERIC_NVRAM
 
-/* Generic nvram hooks used by drivers/char/gen_nvram.c */
 unsigned char nvram_read_byte(int addr)
 {
 	if (ppc_md.nvram_read_val)
@@ -175,15 +174,16 @@ static ssize_t ppc_nvram_get_size(void)
 	return -ENODEV;
 }
 
-void nvram_sync(void)
+static long ppc_nvram_sync(void)
 {
 	if (ppc_md.nvram_sync)
 		ppc_md.nvram_sync();
+	return 0;
 }
-EXPORT_SYMBOL(nvram_sync);
 
 const struct nvram_ops arch_nvram_ops = {
 	.get_size       = ppc_nvram_get_size,
+	.sync           = ppc_nvram_sync,
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 
diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
index a7dfde734897..f32d5663de95 100644
--- a/drivers/char/generic_nvram.c
+++ b/drivers/char/generic_nvram.c
@@ -96,7 +96,7 @@ static int nvram_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 #endif /* CONFIG_PPC_PMAC */
 	case IOC_NVRAM_SYNC:
-		nvram_sync();
+		arch_nvram_ops.sync();
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index b77c27d68762..466e1fb02052 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -48,6 +48,10 @@
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
 
+#ifdef CONFIG_PPC
+#include <asm/nvram.h>
+#include <asm/machdep.h>
+#endif
 
 static DEFINE_MUTEX(nvram_mutex);
 static DEFINE_SPINLOCK(nvram_state_lock);
@@ -331,6 +335,37 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 	long ret = -ENOTTY;
 
 	switch (cmd) {
+#ifdef CONFIG_PPC
+	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
+		pr_warn("nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
+		/* fall through */
+	case IOC_NVRAM_GET_OFFSET:
+		ret = -EINVAL;
+#ifdef CONFIG_PPC_PMAC
+		if (machine_is(powermac)) {
+			int part, offset;
+
+			if (copy_from_user(&part, (void __user *)arg,
+					   sizeof(part)) != 0)
+				return -EFAULT;
+			if (part < pmac_nvram_OF || part > pmac_nvram_NR)
+				return -EINVAL;
+			offset = pmac_get_partition(part);
+			if (copy_to_user((void __user *)arg,
+					 &offset, sizeof(offset)) != 0)
+				return -EFAULT;
+			ret = 0;
+		}
+#endif
+		break;
+	case IOC_NVRAM_SYNC:
+		if (arch_nvram_ops.sync != NULL) {
+			mutex_lock(&nvram_mutex);
+			ret = arch_nvram_ops.sync();
+			mutex_unlock(&nvram_mutex);
+		}
+		break;
+#else /* !CONFIG_PPC */
 	case NVRAM_INIT:
 		/* initialize NVRAM contents and checksum */
 		if (!capable(CAP_SYS_ADMIN))
@@ -354,6 +389,7 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 			mutex_unlock(&nvram_mutex);
 		}
 		break;
+#endif /* CONFIG_PPC */
 	}
 	return ret;
 }
@@ -369,12 +405,14 @@ static int nvram_misc_open(struct inode *inode, struct file *file)
 		return -EBUSY;
 	}
 
+#ifndef CONFIG_PPC
 	/* Prevent multiple writers if the set_checksum ioctl is implemented. */
 	if ((arch_nvram_ops.set_checksum != NULL) &&
 	    (file->f_mode & FMODE_WRITE) && (nvram_open_mode & NVRAM_WRITE)) {
 		spin_unlock(&nvram_state_lock);
 		return -EBUSY;
 	}
+#endif
 
 	if (file->f_flags & O_EXCL)
 		nvram_open_mode |= NVRAM_EXCL;
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index b7bfaec60a43..24a57675dba1 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -18,8 +18,12 @@ struct nvram_ops {
 	unsigned char   (*read_byte)(int);
 	void            (*write_byte)(unsigned char, int);
 	ssize_t         (*get_size)(void);
+#ifdef CONFIG_PPC
+	long            (*sync)(void);
+#else
 	long            (*set_checksum)(void);
 	long            (*initialize)(void);
+#endif
 };
 
 extern const struct nvram_ops arch_nvram_ops;
-- 
2.19.2

