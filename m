Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30039C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF335222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S9a+FpHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404602AbfBMRqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:46:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404576AbfBMRqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xvt6WU53rbr8sNdP0Yb1NGTBLO4wbx68oDDxR14icuI=; b=S9a+FpHz9N7pHPMLFcQrjIrVde
        2FSeyLwLkJxfNzZOyzDImwRp8/FeSFdTaCC4uWFz2EhvuPdsxDfnLPBBsUB1oVKhZsWUfvReA0hU6
        LlgoGq1VPbK11Sm/6h/uNQYtWK0yQmfSWxJgO5JRr8o6nshpRcrygSLUptwIxd8QyIn//z6RwO0jg
        ki0yErJygvCwZVIgZwc6kdA3PCjYqf1oUFOZK9h0XgKcHI0YaLXRjnVkG2H9PnK6V0gB+aiGwDAqX
        U8T/OyCycuiG1IabDteq9CsVkZdw97Ntn/VMTw+fowZHqF2QN35VcHI2G8wmvdKox5GosMv5A3LSG
        N8TqdOpQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtycG-0006nL-7m; Wed, 13 Feb 2019 17:46:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] initramfs: move the legacy keepinitrd parameter to core code
Date:   Wed, 13 Feb 2019 18:46:19 +0100
Message-Id: <20190213174621.29297-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to handle the freeing disable in arch code when we already
have a core hook (and a different name for the option) for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig             |  7 +++++++
 arch/arm/Kconfig         |  1 +
 arch/arm/mm/init.c       | 25 ++++++-------------------
 arch/arm64/Kconfig       |  1 +
 arch/arm64/mm/init.c     | 17 ++---------------
 arch/unicore32/Kconfig   |  1 +
 arch/unicore32/mm/init.c | 14 +-------------
 init/initramfs.c         |  9 +++++++++
 8 files changed, 28 insertions(+), 47 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de48f79..d2bf5db0805f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -245,6 +245,13 @@ config ARCH_HAS_FORTIFY_SOURCE
 	  An architecture should select this when it can successfully
 	  build and run with CONFIG_FORTIFY_SOURCE.
 
+#
+# Select if the arch provides a historic keepinit alias for the retain_initrd
+# command line option
+#
+config ARCH_HAS_KEEPINITRD
+	bool
+
 # Select if arch has all set_memory_ro/rw/x/nx() functions in asm/cacheflush.h
 config ARCH_HAS_SET_MEMORY
 	bool
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..4c99a29a8ec7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -8,6 +8,7 @@ config ARM
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
+	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 478ea8b7db87..d0ccbfab94db 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -752,27 +752,14 @@ void free_initmem(void)
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-
-static int keep_initrd;
-
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (!keep_initrd) {
-		if (start == initrd_start)
-			start = round_down(start, PAGE_SIZE);
-		if (end == initrd_end)
-			end = round_up(end, PAGE_SIZE);
+	if (start == initrd_start)
+		start = round_down(start, PAGE_SIZE);
+	if (end == initrd_end)
+		end = round_up(end, PAGE_SIZE);
 
-		poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
-		free_reserved_area((void *)start, (void *)end, -1, "initrd");
-	}
+	poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
+	free_reserved_area((void *)start, (void *)end, -1, "initrd");
 }
-
-static int __init keepinitrd_setup(char *__unused)
-{
-	keep_initrd = 1;
-	return 1;
-}
-
-__setup("keepinitrd", keepinitrd_setup);
 #endif
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..74c89b628afd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -19,6 +19,7 @@ config ARM64
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
+	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7205a9085b4d..019c790d8d56 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -622,24 +622,11 @@ void free_initmem(void)
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-
-static int keep_initrd __initdata;
-
 void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (!keep_initrd) {
-		free_reserved_area((void *)start, (void *)end, 0, "initrd");
-		memblock_free(__virt_to_phys(start), end - start);
-	}
-}
-
-static int __init keepinitrd_setup(char *__unused)
-{
-	keep_initrd = 1;
-	return 1;
+	free_reserved_area((void *)start, (void *)end, 0, "initrd");
+	memblock_free(__virt_to_phys(start), end - start);
 }
-
-__setup("keepinitrd", keepinitrd_setup);
 #endif
 
 /*
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index c3a41bfe161b..b924c11e3ff9 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -2,6 +2,7 @@
 config UNICORE32
 	def_bool y
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_KEEPINITRD
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select HAVE_GENERIC_DMA_COHERENT
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index 85ef2c624090..e3f4f791e10a 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -318,20 +318,8 @@ void free_initmem(void)
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-
-static int keep_initrd;
-
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (!keep_initrd)
-		free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-
-static int __init keepinitrd_setup(char *__unused)
-{
-	keep_initrd = 1;
-	return 1;
+	free_reserved_area((void *)start, (void *)end, -1, "initrd");
 }
-
-__setup("keepinitrd", keepinitrd_setup);
 #endif
diff --git a/init/initramfs.c b/init/initramfs.c
index c55e08f72fad..cf8bf014873f 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -513,6 +513,15 @@ static int __init retain_initrd_param(char *str)
 }
 __setup("retain_initrd", retain_initrd_param);
 
+#ifdef CONFIG_ARCH_HAS_KEEPINITRD
+static int __init keepinitrd_setup(char *__unused)
+{
+	do_retain_initrd = 1;
+	return 1;
+}
+__setup("keepinitrd", keepinitrd_setup);
+#endif
+
 extern char __initramfs_start[];
 extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
-- 
2.20.1

