Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F24C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314C320672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314C320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeLJP3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:29:06 -0500
Received: from foss.arm.com ([217.140.101.70]:56442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbeLJP3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:29:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A32F91596;
        Mon, 10 Dec 2018 07:29:05 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28AD93F6A8;
        Mon, 10 Dec 2018 07:29:04 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will.deacon@arm.com, catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, cyrilc@xilinx.com,
        james.morse@arm.com, anshuman.khandual@arm.com
Subject: [PATCH] arm64: Add memory hotplug support
Date:   Mon, 10 Dec 2018 15:29:01 +0000
Message-Id: <0a0c7d3b8fbe1b2b399eeb6889027031335d2af1.1544453739.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the basic support for hot-adding memory. Since memory hotplug
is fairly tightly coupled to sparsemem, we tweak pfn_valid() to also
cross-check the presence of a section in the manner of the generic
implementation, before falling back to memblock to check for no-map
regions within a present section as before. By having arch_add_memory(()
create the linear mapping first, this then makes everything work in the
way that __add_section() expects.

We expect hotplug to be ACPI-driven, so the swapper_pg_dir updates
should be safe from races by virtue of the global device hotplug lock.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Looks like I'm not going to have the whole pte_devmap story figured out
in time to land any ZONE_DEVICE support this cycle, but since this patch
also stands alone as a complete feature (and has ended up remarkably
simple and self-contained), I hope we might consider getting it merged
on its own merit.

Robin.

 arch/arm64/Kconfig   |  3 +++
 arch/arm64/mm/init.c |  8 ++++++++
 arch/arm64/mm/mmu.c  | 12 ++++++++++++
 arch/arm64/mm/numa.c | 10 ++++++++++
 4 files changed, 33 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d2b25f51bb3..7b855ae45747 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -261,6 +261,9 @@ config ZONE_DMA32
 config HAVE_GENERIC_GUP
 	def_bool y
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+
 config SMP
 	def_bool y
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 2983e0fc1786..82e0b08f2e31 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -291,6 +291,14 @@ int pfn_valid(unsigned long pfn)
 
 	if ((addr >> PAGE_SHIFT) != pfn)
 		return 0;
+
+#ifdef CONFIG_SPARSEMEM
+	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
+		return 0;
+
+	if (!valid_section(__nr_to_section(pfn_to_section_nr(pfn))))
+		return 0;
+#endif
 	return memblock_is_map_memory(addr);
 }
 EXPORT_SYMBOL(pfn_valid);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e1b2d58a311a..22379a74d289 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1044,3 +1044,15 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	pmd_free(NULL, table);
 	return 1;
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
+		    bool want_memblock)
+{
+	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
+			     size, PAGE_KERNEL, pgd_pgtable_alloc, 0);
+
+	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
+			   altmap, want_memblock);
+}
+#endif
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 27a31efd9e8e..ae34e3a1cef1 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -466,3 +466,13 @@ void __init arm64_numa_init(void)
 
 	numa_init(dummy_numa_init);
 }
+
+/*
+ * We hope that we will be hotplugging memory on nodes we already know about,
+ * such that acpi_get_node() succeeds and we never fall back to this...
+ */
+int memory_add_physaddr_to_nid(u64 addr)
+{
+	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
+	return 0;
+}
-- 
2.19.1.dirty

