Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeA3LXD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:23:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45117 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeA3LXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:23:02 -0500
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
        William Grant <william.grant@canonical.com>
From: William Grant <william.grant@canonical.com>
Subject: [PATCH] x86: Fix overlap of i386 CPU_ENTRY_AREA with FIX_BTMAP
Message-ID: <7041d181-a019-e8b9-4e4e-48215f841e2c@canonical.com>
Date: Tue, 30 Jan 2018 22:22:55 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 92a0f81d8957 ("x86/cpu_entry_area: Move it out of the
fixmap"), i386's CPU_ENTRY_AREA has been mapped to the memory area just
below FIXADDR_START. But already immediately before FIXADDR_START is the
FIX_BTMAP area, which means that early_ioremap can collide with the
entry area.

It's especially bad on PAE where FIX_BTMAP_BEGIN gets aligned to exactly
match CPU_ENTRY_AREA_BASE, so the first early_ioremap slot clobbers the
IDT and causes interrupts during early boot to reset the system.

The overlap wasn't a problem before the CPU entry area was introduced,
as the fixmap has classically been preceded by the pkmap or vmalloc
areas, neither of which is used until early_ioremap is out of the
picture.

Relocate CPU_ENTRY_AREA to below FIX_BTMAP, not just below the permanent
fixmap area.

Signed-off-by: William Grant <william.grant@canonical.com>
---
This fixes a triple fault during early boot of 4.15 with PAE on x86 when
an Intel IOMMU is present. The ACPI table retrieval inside pci_iommu_alloc()
called early_ioremap and unmapped the IDT, and so the exception inside
test_wp_bit triple faulted.

2MiB of i386 kernel address space is wasted in the FIX_BTMAP area that
isn't used after boot, but I couldn't see a better place to put
CPU_ENTRY_AREA. We can't stick it just before the pkmap, since pkmap
doesn't exist when highmem is disabled. We could potentially shift fixmap
down from the top of the address space, but that's already variable due to
reserve_top_address. The only other option would be to shuffle it in
between lowmem and vmalloc, which looks messy due to their variable sizes.

 arch/x86/include/asm/fixmap.h           | 6 ++++--
 arch/x86/include/asm/pgtable_32_types.h | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 64c4a30e0d39..987020a28534 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -137,8 +137,10 @@ enum fixed_addresses {
 
 extern void reserve_top_address(unsigned long reserve);
 
-#define FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXADDR_SIZE        (__end_of_permanent_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START       (FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXADDR_ALL_SIZE    (__end_of_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_ALL_START   (FIXADDR_TOP - FIXADDR_ALL_SIZE)
 
 extern int fixmaps_set;
 
diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index ce245b0cdfca..01973e9fd269 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -44,8 +44,9 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
  */
 #define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 40)
 
-#define CPU_ENTRY_AREA_BASE				\
-	((FIXADDR_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1)) & PMD_MASK)
+#define CPU_ENTRY_AREA_BASE						\
+	((FIXADDR_ALL_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1))   \
+	 & PMD_MASK)
 
 #define PKMAP_BASE		\
 	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
-- 
2.15.1
