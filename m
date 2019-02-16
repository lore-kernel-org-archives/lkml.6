Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEA9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F31D222E6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfBPOHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 09:07:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47461 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfBPOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 09:07:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1GE7Nr91676780
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 16 Feb 2019 06:07:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1GE7Mtl1676777;
        Sat, 16 Feb 2019 06:07:22 -0800
Date:   Sat, 16 Feb 2019 06:07:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-8a5b403d71affa098009cc3dff1b2c45113021ad@git.kernel.org>
Cc:     marc.zyngier@arm.com, tglx@linutronix.de, will.deacon@arm.com,
        rppt@linux.ibm.com, akpm@linux-foundation.org, hpa@zytor.com,
        ard.biesheuvel@linaro.org, torvalds@linux-foundation.org,
        mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, mingo@kernel.org,
          ard.biesheuvel@linaro.org, hpa@zytor.com, rppt@linux.ibm.com,
          akpm@linux-foundation.org, will.deacon@arm.com,
          tglx@linutronix.de, marc.zyngier@arm.com
In-Reply-To: <20190215123333.21209-2-ard.biesheuvel@linaro.org>
References: <20190215123333.21209-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] arm64, mm, efi: Account for GICv3 LPI tables in
 static memblock reserve table
Git-Commit-ID: 8a5b403d71affa098009cc3dff1b2c45113021ad
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8a5b403d71affa098009cc3dff1b2c45113021ad
Gitweb:     https://git.kernel.org/tip/8a5b403d71affa098009cc3dff1b2c45113021ad
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Fri, 15 Feb 2019 13:33:32 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 16 Feb 2019 15:02:03 +0100

arm64, mm, efi: Account for GICv3 LPI tables in static memblock reserve table

In the irqchip and EFI code, we have what basically amounts to a quirk
to work around a peculiarity in the GICv3 architecture, which permits
the system memory address of LPI tables to be programmable only once
after a CPU reset. This means kexec kernels must use the same memory
as the first kernel, and thus ensure that this memory has not been
given out for other purposes by the time the ITS init code runs, which
is not very early for secondary CPUs.

On systems with many CPUs, these reservations could overflow the
memblock reservation table, and this was addressed in commit:

  eff896288872 ("efi/arm: Defer persistent reservations until after paging_init()")

However, this turns out to have made things worse, since the allocation
of page tables and heap space for the resized memblock reservation table
itself may overwrite the regions we are attempting to reserve, which may
cause all kinds of corruption, also considering that the ITS will still
be poking bits into that memory in response to incoming MSIs.

So instead, let's grow the static memblock reservation table on such
systems so it can accommodate these reservations at an earlier time.
This will permit us to revert the above commit in a subsequent patch.

[ mingo: Minor cleanups. ]

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190215123333.21209-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm64/include/asm/memory.h | 11 +++++++++++
 include/linux/memblock.h        |  3 ---
 mm/memblock.c                   | 11 +++++++++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index e1ec947e7c0c..0c656850eeea 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -332,6 +332,17 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_addr_valid(kaddr)		\
 	(_virt_addr_is_linear(kaddr) && _virt_addr_valid(kaddr))
 
+/*
+ * Given that the GIC architecture permits ITS implementations that can only be
+ * configured with a LPI table address once, GICv3 systems with many CPUs may
+ * end up reserving a lot of different regions after a kexec for their LPI
+ * tables (one per CPU), as we are forced to reuse the same memory after kexec
+ * (and thus reserve it persistently with EFI beforehand)
+ */
+#if defined(CONFIG_EFI) && defined(CONFIG_ARM_GIC_V3_ITS)
+# define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + NR_CPUS + 1)
+#endif
+
 #include <asm-generic/memory_model.h>
 
 #endif
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 64c41cf45590..859b55b66db2 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -29,9 +29,6 @@ extern unsigned long max_pfn;
  */
 extern unsigned long long max_possible_pfn;
 
-#define INIT_MEMBLOCK_REGIONS	128
-#define INIT_PHYSMEM_REGIONS	4
-
 /**
  * enum memblock_flags - definition of memory region attributes
  * @MEMBLOCK_NONE: no special request
diff --git a/mm/memblock.c b/mm/memblock.c
index 022d4cbb3618..ea31045ba704 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -26,6 +26,13 @@
 
 #include "internal.h"
 
+#define INIT_MEMBLOCK_REGIONS			128
+#define INIT_PHYSMEM_REGIONS			4
+
+#ifndef INIT_MEMBLOCK_RESERVED_REGIONS
+# define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
+#endif
+
 /**
  * DOC: memblock overview
  *
@@ -92,7 +99,7 @@ unsigned long max_pfn;
 unsigned long long max_possible_pfn;
 
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
-static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
+static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS] __initdata_memblock;
 #endif
@@ -105,7 +112,7 @@ struct memblock memblock __initdata_memblock = {
 
 	.reserved.regions	= memblock_reserved_init_regions,
 	.reserved.cnt		= 1,	/* empty dummy entry */
-	.reserved.max		= INIT_MEMBLOCK_REGIONS,
+	.reserved.max		= INIT_MEMBLOCK_RESERVED_REGIONS,
 	.reserved.name		= "reserved",
 
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
