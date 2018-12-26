Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0945BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69452148E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeLZApd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 19:45:33 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57348 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLZAoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 19:44:01 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id B984C29526; Tue, 25 Dec 2018 19:43:56 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <185de04191ba2e0a5cafb12760ff65b1dbfad24e.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 17/25] powerpc: Implement arch_nvram_ops.get_size() and
 remove old nvram_* exports
Date:   Wed, 26 Dec 2018 11:37:59 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement arch_nvram_ops for PPC32 and make use of it in the generic_nvram
misc device module so that the nvram_* function exports can be removed.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
 arch/powerpc/include/asm/nvram.h |  3 ---
 arch/powerpc/kernel/setup_32.c   | 10 +++++++---
 drivers/char/generic_nvram.c     | 24 ++++++++++++------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
index 1443b40f44b9..56a388da9c4f 100644
--- a/arch/powerpc/include/asm/nvram.h
+++ b/arch/powerpc/include/asm/nvram.h
@@ -98,7 +98,4 @@ extern int nvram_write_os_partition(struct nvram_os_partition *part,
 				    unsigned int err_type,
 				    unsigned int error_log_cnt);
 
-/* Determine NVRAM size */
-extern ssize_t nvram_get_size(void);
-
 #endif /* _ASM_POWERPC_NVRAM_H */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 04c0315cfe46..ee91bba0805d 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -168,13 +168,12 @@ void nvram_write_byte(unsigned char val, int addr)
 }
 EXPORT_SYMBOL(nvram_write_byte);
 
-ssize_t nvram_get_size(void)
+static ssize_t ppc_nvram_get_size(void)
 {
 	if (ppc_md.nvram_size)
 		return ppc_md.nvram_size();
-	return -1;
+	return -ENODEV;
 }
-EXPORT_SYMBOL(nvram_get_size);
 
 void nvram_sync(void)
 {
@@ -183,6 +182,11 @@ void nvram_sync(void)
 }
 EXPORT_SYMBOL(nvram_sync);
 
+const struct nvram_ops arch_nvram_ops = {
+	.get_size       = ppc_nvram_get_size,
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+
 #endif /* CONFIG_NVRAM */
 
 static int __init ppc_init(void)
diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
index 0381af638fe3..a7dfde734897 100644
--- a/drivers/char/generic_nvram.c
+++ b/drivers/char/generic_nvram.c
@@ -28,8 +28,6 @@
 #include <asm/machdep.h>
 #endif
 
-#define NVRAM_SIZE	8192
-
 static DEFINE_MUTEX(nvram_mutex);
 static ssize_t nvram_len;
 
@@ -134,20 +132,22 @@ static struct miscdevice nvram_dev = {
 
 int __init nvram_init(void)
 {
-	int ret = 0;
+	int ret;
 
-	printk(KERN_INFO "Generic non-volatile memory driver v%s\n",
-		NVRAM_VERSION);
-	ret = misc_register(&nvram_dev);
-	if (ret != 0)
-		goto out;
+	if (arch_nvram_ops.get_size == NULL)
+		return -ENODEV;
 
-	nvram_len = nvram_get_size();
+	nvram_len = arch_nvram_ops.get_size();
 	if (nvram_len < 0)
-		nvram_len = NVRAM_SIZE;
+		return nvram_len;
 
-out:
-	return ret;
+	ret = misc_register(&nvram_dev);
+	if (ret)
+		return ret;
+
+	pr_info("Generic non-volatile memory driver v%s\n", NVRAM_VERSION);
+
+	return 0;
 }
 
 void __exit nvram_cleanup(void)
-- 
2.19.2

