Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeCTLGM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:06:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57737 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbeCTLFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:32 -0400
Date: Tue, 20 Mar 2018 04:04:49 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-5927145efd5de71976e62e2822511b13014d7e56@git.kernel.org>
Cc: mingo@kernel.org, torvalds@linux-foundation.org,
        thomas.lendacky@amd.com, dwmw2@infradead.org, mulix@mulix.org,
        konrad.wilk@oracle.com, jdmason@kudzu.us, hpa@zytor.com,
        tglx@linutronix.de, peterz@infradead.org, hch@lst.de, joro@8bytes.org,
        linux-kernel@vger.kernel.org
Reply-To: mulix@mulix.org, thomas.lendacky@amd.com, dwmw2@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, hch@lst.de,
        konrad.wilk@oracle.com, jdmason@kudzu.us, tglx@linutronix.de,
        hpa@zytor.com
In-Reply-To: <20180319103826.12853-2-hch@lst.de>
References: <20180319103826.12853-2-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/cpu: Remove the CONFIG_X86_PPRO_FENCE=y quirk
Git-Commit-ID: 5927145efd5de71976e62e2822511b13014d7e56
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5927145efd5de71976e62e2822511b13014d7e56
Gitweb:     https://git.kernel.org/tip/5927145efd5de71976e62e2822511b13014d7e56
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 19 Mar 2018 11:38:13 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 10:01:05 +0100

x86/cpu: Remove the CONFIG_X86_PPRO_FENCE=y quirk

There were only a few Pentium Pro multiprocessors systems where this
errata applied. They are more than 20 years old now, and we've slowly
dropped places which put the workarounds in and discouraged anyone
from enabling the workaround.

Get rid of it for good.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: iommu@lists.linux-foundation.org
Link: http://lkml.kernel.org/r/20180319103826.12853-2-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig.cpu                        | 13 -------------
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |  2 --
 arch/x86/include/asm/barrier.h              | 30 -----------------------------
 arch/x86/include/asm/io.h                   | 15 ---------------
 arch/x86/kernel/pci-nommu.c                 | 19 ------------------
 arch/x86/um/asm/barrier.h                   |  4 ----
 6 files changed, 83 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 65a9a4716e34..f0c5ef578153 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -315,19 +315,6 @@ config X86_L1_CACHE_SHIFT
 	default "4" if MELAN || M486 || MGEODEGX1
 	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 
-config X86_PPRO_FENCE
-	bool "PentiumPro memory ordering errata workaround"
-	depends on M686 || M586MMX || M586TSC || M586 || M486 || MGEODEGX1
-	---help---
-	  Old PentiumPro multiprocessor systems had errata that could cause
-	  memory operations to violate the x86 ordering standard in rare cases.
-	  Enabling this option will attempt to work around some (but not all)
-	  occurrences of this problem, at the cost of much heavier spinlock and
-	  memory barrier operations.
-
-	  If unsure, say n here. Even distro kernels should think twice before
-	  enabling this: there are few systems, and an unlikely bug.
-
 config X86_F00F_BUG
 	def_bool y
 	depends on M586MMX || M586TSC || M586 || M486
diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 7780bbfb06ef..9242b28418d5 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -5,8 +5,6 @@
 #undef CONFIG_OPTIMIZE_INLINING
 #endif
 
-#undef CONFIG_X86_PPRO_FENCE
-
 #ifdef CONFIG_X86_64
 
 /*
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index e1259f043ae9..042b5e892ed1 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -52,11 +52,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 #define barrier_nospec() alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC, \
 					   "lfence", X86_FEATURE_LFENCE_RDTSC)
 
-#ifdef CONFIG_X86_PPRO_FENCE
-#define dma_rmb()	rmb()
-#else
 #define dma_rmb()	barrier()
-#endif
 #define dma_wmb()	barrier()
 
 #ifdef CONFIG_X86_32
@@ -68,30 +64,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 #define __smp_wmb()	barrier()
 #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
 
-#if defined(CONFIG_X86_PPRO_FENCE)
-
-/*
- * For this option x86 doesn't have a strong TSO memory
- * model and we should fall back to full barriers.
- */
-
-#define __smp_store_release(p, v)					\
-do {									\
-	compiletime_assert_atomic_type(*p);				\
-	__smp_mb();							\
-	WRITE_ONCE(*p, v);						\
-} while (0)
-
-#define __smp_load_acquire(p)						\
-({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
-	compiletime_assert_atomic_type(*p);				\
-	__smp_mb();							\
-	___p1;								\
-})
-
-#else /* regular x86 TSO memory ordering */
-
 #define __smp_store_release(p, v)					\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
@@ -107,8 +79,6 @@ do {									\
 	___p1;								\
 })
 
-#endif
-
 /* Atomic operations are already serializing on x86 */
 #define __smp_mb__before_atomic()	barrier()
 #define __smp_mb__after_atomic()	barrier()
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 95e948627fd0..f6e5b9375d8c 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -232,21 +232,6 @@ extern void set_iounmap_nonlazy(void);
  */
 #define __ISA_IO_base ((char __iomem *)(PAGE_OFFSET))
 
-/*
- *	Cache management
- *
- *	This needed for two cases
- *	1. Out of order aware processors
- *	2. Accidentally out of order processors (PPro errata #51)
- */
-
-static inline void flush_write_buffers(void)
-{
-#if defined(CONFIG_X86_PPRO_FENCE)
-	asm volatile("lock; addl $0,0(%%esp)": : :"memory");
-#endif
-}
-
 #endif /* __KERNEL__ */
 
 extern void native_io_delay(void);
diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index 618285e475c6..ac7ea3a8242f 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -37,7 +37,6 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 	WARN_ON(size == 0);
 	if (!check_addr("map_single", dev, bus, size))
 		return NOMMU_MAPPING_ERROR;
-	flush_write_buffers();
 	return bus;
 }
 
@@ -72,25 +71,9 @@ static int nommu_map_sg(struct device *hwdev, struct scatterlist *sg,
 			return 0;
 		s->dma_length = s->length;
 	}
-	flush_write_buffers();
 	return nents;
 }
 
-static void nommu_sync_single_for_device(struct device *dev,
-			dma_addr_t addr, size_t size,
-			enum dma_data_direction dir)
-{
-	flush_write_buffers();
-}
-
-
-static void nommu_sync_sg_for_device(struct device *dev,
-			struct scatterlist *sg, int nelems,
-			enum dma_data_direction dir)
-{
-	flush_write_buffers();
-}
-
 static int nommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr == NOMMU_MAPPING_ERROR;
@@ -101,8 +84,6 @@ const struct dma_map_ops nommu_dma_ops = {
 	.free			= dma_generic_free_coherent,
 	.map_sg			= nommu_map_sg,
 	.map_page		= nommu_map_page,
-	.sync_single_for_device = nommu_sync_single_for_device,
-	.sync_sg_for_device	= nommu_sync_sg_for_device,
 	.is_phys		= 1,
 	.mapping_error		= nommu_mapping_error,
 	.dma_supported		= x86_dma_supported,
diff --git a/arch/x86/um/asm/barrier.h b/arch/x86/um/asm/barrier.h
index b7d73400ea29..f31e5d903161 100644
--- a/arch/x86/um/asm/barrier.h
+++ b/arch/x86/um/asm/barrier.h
@@ -30,11 +30,7 @@
 
 #endif /* CONFIG_X86_32 */
 
-#ifdef CONFIG_X86_PPRO_FENCE
-#define dma_rmb()	rmb()
-#else /* CONFIG_X86_PPRO_FENCE */
 #define dma_rmb()	barrier()
-#endif /* CONFIG_X86_PPRO_FENCE */
 #define dma_wmb()	barrier()
 
 #include <asm-generic/barrier.h>
