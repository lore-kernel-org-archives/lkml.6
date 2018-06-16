Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB989C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 01:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969F9204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 01:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969F9204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756451AbeFPBJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 21:09:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:62578 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756240AbeFPBJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 21:09:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 18:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="237893143"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.145])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2018 18:09:38 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] x86/efi: Free allocated memory if remap fails
Date:   Fri, 15 Jun 2018 18:09:24 -0700
Message-Id: <1529111365-32295-1-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

efi_memmap_alloc(), as the name suggests, allocates memory for a new efi
memory map. It's referenced from couple of places, namely,
efi_arch_mem_reserve() and efi_free_boot_services(). These callers,
after allocating memory, remap it for further use. As usual, a routine
check is performed to confirm successful remap. If the remap fails,
ideally, the allocated memory should be freed but presently we just
return without freeing it up. Hence, fix this bug by introducing
efi_memmap_free() which frees memory allocated by efi_memmap_alloc().

As efi_memmap_alloc() allocates memory depending on whether mm_init()
has already been invoked or not, similarly efi_memmap_free() frees
memory accordingly.

efi_fake_memmap() also references efi_memmap_alloc() but it frees
memory correctly using memblock_free(), but replace it with
efi_memmap_free() to maintain consistency, as in, allocate memory with
efi_memmap_alloc() and free memory with efi_memmap_free().

It's a fact that memremap() and early_memremap() might never fail and
this code might never get a chance to run but to maintain good kernel
programming semantics, we might need this patch.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

I found this bug when working on a different patch set which uses
efi_memmap_alloc() and then noticed that I never freed the allocated
memory. I found it weird, in the sense that, memory is allocated but is
not freed (upon returning from an error). So, wasn't sure if that should
be treated as a bug or should I just leave it as is because everything
works fine even without this patch. Since the effort for the patch is
very minimal, I just went ahead and posted one, so that I could know
your thoughts on it.

Note: Patch based on Linus's mainline tree V4.17

 arch/x86/platform/efi/quirks.c  | 10 ++++++----
 drivers/firmware/efi/fake_mem.c |  2 +-
 drivers/firmware/efi/memmap.c   | 27 +++++++++++++++++++++++++++
 include/linux/efi.h             |  1 +
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 36c1f8b9f7e0..f223093f2df7 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -285,6 +285,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	new = early_memremap(new_phys, new_size);
 	if (!new) {
 		pr_err("Failed to map new boot services memmap\n");
+		efi_memmap_free(new_phys, num_entries);
 		return;
 	}
 
@@ -429,7 +430,7 @@ void __init efi_free_boot_services(void)
 	new = memremap(new_phys, new_size, MEMREMAP_WB);
 	if (!new) {
 		pr_err("Failed to map new EFI memmap\n");
-		return;
+		goto free_mem;
 	}
 
 	/*
@@ -450,10 +451,11 @@ void __init efi_free_boot_services(void)
 
 	memunmap(new);
 
-	if (efi_memmap_install(new_phys, num_entries)) {
+	if (efi_memmap_install(new_phys, num_entries))
 		pr_err("Could not install new EFI memmap\n");
-		return;
-	}
+
+free_mem:
+	efi_memmap_free(new_phys, num_entries);
 }
 
 /*
diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index 6c7d60c239b5..63edcedee25b 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -79,7 +79,7 @@ void __init efi_fake_memmap(void)
 	new_memmap = early_memremap(new_memmap_phy,
 				    efi.memmap.desc_size * new_nr_map);
 	if (!new_memmap) {
-		memblock_free(new_memmap_phy, efi.memmap.desc_size * new_nr_map);
+		efi_memmap_free(new_memmap_phy, new_nr_map);
 		return;
 	}
 
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 5fc70520e04c..27d28cb4652d 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -50,6 +50,33 @@ phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
 }
 
 /**
+ * efi_memmap_free - Free memory allocated by efi_memmap_alloc()
+ * @mem: Physical address allocated by efi_memmap_alloc()
+ * @num_entries: Number of entries in the allocated map.
+ *
+ * efi_memmap_alloc() allocates memory depending on whether mm_init()
+ * has already been invoked or not. It uses either memblock or "normal"
+ * page allocation. Use this function to free the memory allocated by
+ * efi_memmap_alloc(). Since the allocation is done in two different
+ * ways, similarly, we free it in two different ways.
+ *
+ */
+void __init efi_memmap_free(phys_addr_t mem, unsigned int num_entries)
+{
+	unsigned long size = num_entries * efi.memmap.desc_size;
+	unsigned int order = get_order(size);
+	phys_addr_t end = mem + size - 1;
+
+	if (slab_is_available()) {
+		__free_pages(pfn_to_page(PHYS_PFN(mem)), order);
+		return;
+	}
+
+	if (memblock_free(mem, size))
+		pr_err("Failed to free mem from %pa to %pa\n", &mem, &end);
+}
+
+/**
  * __efi_memmap_init - Common code for mapping the EFI memory map
  * @data: EFI memory map data
  * @late: Use early or late mapping function?
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 3016d8c456bc..f5d1cf44b320 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1016,6 +1016,7 @@ extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 					 struct range *range);
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
 				     void *buf, struct efi_mem_range *mem);
+void __init efi_memmap_free(phys_addr_t mem, unsigned int num_entries);
 
 extern int efi_config_init(efi_config_table_type_t *arch_tables);
 #ifdef CONFIG_EFI_ESRT
-- 
2.7.4

