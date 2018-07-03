Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0258C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498AE21CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498AE21CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbeGCBwi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:52:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:5209 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753530AbeGCBvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:51:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 18:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,301,1526367600"; 
   d="scan'208";a="212956409"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2018 18:51:13 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Dave Young <dyoung@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Laszlo Ersek <lersek@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Nicolai Stange <nicstange@gmail.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 3/6] efi: Use efi.memmap.alloc_type instead of efi.memmap.late
Date:   Mon,  2 Jul 2018 18:50:51 -0700
Message-Id: <1530582654-25662-4-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Memory used by efi memory map could be one among the three different
types, namely a) memblock_reserved b) memblock_alloc'ed c) normal paged
memory. Presently, we use efi.memmap.late which is of type "bool" to
record the type of memory in use by efi memory map. As "bool" doesn't
suffice our needs, replace it with enum to represent one among the three
different available types of memory and hence also change all the
corresponding memmap API's to reflect the same.

Also, presently, we never freed memblock_reserved memory and hence never
recorded it's usage. Change efi_memmap_init_early() so that it could now
record the usage of memblock_reserved memory and can be freed when
appropriate. Also, change efi_memmap_install() and __efi_memmap_init()
so that at every point of time we could record the type of memory in use
by efi memory map and hence use "efi.memmap.alloc_type" to free the
existing memory before installing a new memory map.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Nicolai Stange <nicstange@gmail.com>
Cc: Naresh Bhat <naresh.bhat@linaro.org>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/efi.c     |  4 ++--
 arch/x86/platform/efi/quirks.c  |  4 ++--
 drivers/firmware/efi/arm-init.c |  2 +-
 drivers/firmware/efi/fake_mem.c |  2 +-
 drivers/firmware/efi/memmap.c   | 34 +++++++++++++++++++---------------
 include/linux/efi.h             |  8 +++++---
 6 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 9061babfbc83..cda54abf25a6 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -196,7 +196,7 @@ int __init efi_memblock_x86_reserve_range(void)
 	data.desc_size		= e->efi_memdesc_size;
 	data.desc_version	= e->efi_memdesc_version;
 
-	rv = efi_memmap_init_early(&data);
+	rv = efi_memmap_init_early(&data, EFI_STUB);
 	if (rv)
 		return rv;
 
@@ -272,7 +272,7 @@ static void __init efi_clean_memmap(void)
 		u64 size = efi.memmap.nr_map - n_removal;
 
 		pr_warn("Removing %d invalid memory map entries.\n", n_removal);
-		efi_memmap_install(efi.memmap.phys_map, size);
+		efi_memmap_install(efi.memmap.phys_map, size, EFI_STUB);
 	}
 }
 
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 84e8d077adf6..11fa6ac9f0c2 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -292,7 +292,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	efi_memmap_insert(&efi.memmap, new, &mr);
 	early_memunmap(new, new_size);
 
-	efi_memmap_install(new_phys, num_entries);
+	efi_memmap_install(new_phys, num_entries, alloc_type);
 }
 
 /*
@@ -452,7 +452,7 @@ void __init efi_free_boot_services(void)
 
 	memunmap(new);
 
-	if (efi_memmap_install(new_phys, num_entries)) {
+	if (efi_memmap_install(new_phys, num_entries, alloc_type)) {
 		pr_err("Could not install new EFI memmap\n");
 		return;
 	}
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index b5214c143fee..f0de8df6f396 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -239,7 +239,7 @@ void __init efi_init(void)
 	data.size = params.mmap_size;
 	data.phys_map = params.mmap;
 
-	if (efi_memmap_init_early(&data) < 0) {
+	if (efi_memmap_init_early(&data, EFI_STUB) < 0) {
 		/*
 		* If we are booting via UEFI, the UEFI memory map is the only
 		* description of memory we have, so there is little point in
diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index 955e690b8325..82dcfa1c340b 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -90,7 +90,7 @@ void __init efi_fake_memmap(void)
 	/* swap into new EFI memmap */
 	early_memunmap(new_memmap, efi.memmap.desc_size * new_nr_map);
 
-	efi_memmap_install(new_memmap_phy, new_nr_map);
+	efi_memmap_install(new_memmap_phy, new_nr_map, alloc_type);
 
 	/* print new EFI memmap */
 	efi_print_memmap();
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 69b81d355619..d4e3e114cf86 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -88,7 +88,7 @@ void __init efi_memmap_free(phys_addr_t mem, unsigned int num_entries,
 /**
  * __efi_memmap_init - Common code for mapping the EFI memory map
  * @data: EFI memory map data
- * @late: Use early or late mapping function?
+ * @alloc_type: Use early or late mapping function?
  *
  * This function takes care of figuring out which function to use to
  * map the EFI memory map in efi.memmap based on how far into the boot
@@ -101,8 +101,8 @@ void __init efi_memmap_free(phys_addr_t mem, unsigned int num_entries,
  *
  * Returns zero on success, a negative error code on failure.
  */
-static int __init
-__efi_memmap_init(struct efi_memory_map_data *data, bool late)
+static int __init __efi_memmap_init(struct efi_memory_map_data *data,
+				    enum efi_memmap_type alloc_type)
 {
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
@@ -112,7 +112,7 @@ __efi_memmap_init(struct efi_memory_map_data *data, bool late)
 
 	phys_map = data->phys_map;
 
-	if (late)
+	if (alloc_type == BUDDY_ALLOCATOR)
 		map.map = memremap(phys_map, data->size, MEMREMAP_WB);
 	else
 		map.map = early_memremap(phys_map, data->size);
@@ -128,7 +128,7 @@ __efi_memmap_init(struct efi_memory_map_data *data, bool late)
 
 	map.desc_version = data->desc_version;
 	map.desc_size = data->desc_size;
-	map.late = late;
+	map.alloc_type = alloc_type;
 
 	set_bit(EFI_MEMMAP, &efi.flags);
 
@@ -140,27 +140,29 @@ __efi_memmap_init(struct efi_memory_map_data *data, bool late)
 /**
  * efi_memmap_init_early - Map the EFI memory map data structure
  * @data: EFI memory map data
+ * @alloc_type: Type of allocated memory map (EFI_STUB or MEMBLOCK)?
  *
  * Use early_memremap() to map the passed in EFI memory map and assign
  * it to efi.memmap.
  */
-int __init efi_memmap_init_early(struct efi_memory_map_data *data)
+int __init efi_memmap_init_early(struct efi_memory_map_data *data,
+				 enum efi_memmap_type alloc_type)
 {
 	/* Cannot go backwards */
-	WARN_ON(efi.memmap.late);
+	WARN_ON(efi.memmap.alloc_type == BUDDY_ALLOCATOR);
 
-	return __efi_memmap_init(data, false);
+	return __efi_memmap_init(data, alloc_type);
 }
 
 void __init efi_memmap_unmap(void)
 {
-	if (!efi.memmap.late) {
+	if (efi.memmap.alloc_type == BUDDY_ALLOCATOR) {
+		memunmap(efi.memmap.map);
+	} else {
 		unsigned long size;
 
 		size = efi.memmap.desc_size * efi.memmap.nr_map;
 		early_memunmap(efi.memmap.map, size);
-	} else {
-		memunmap(efi.memmap.map);
 	}
 
 	efi.memmap.map = NULL;
@@ -201,7 +203,7 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 	WARN_ON(efi.memmap.map);
 
 	/* Were we already called? */
-	WARN_ON(efi.memmap.late);
+	WARN_ON(efi.memmap.alloc_type == BUDDY_ALLOCATOR);
 
 	/*
 	 * It makes no sense to allow callers to register different
@@ -211,13 +213,14 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 	data.desc_version = efi.memmap.desc_version;
 	data.desc_size = efi.memmap.desc_size;
 
-	return __efi_memmap_init(&data, true);
+	return __efi_memmap_init(&data, BUDDY_ALLOCATOR);
 }
 
 /**
  * efi_memmap_install - Install a new EFI memory map in efi.memmap
  * @addr: Physical address of the memory map
  * @nr_map: Number of entries in the memory map
+ * @alloc_type: Type of allocation performed to get @addr.
  *
  * Unlike efi_memmap_init_*(), this function does not allow the caller
  * to switch from early to late mappings. It simply uses the existing
@@ -225,7 +228,8 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
  *
  * Returns zero on success, a negative error code on failure.
  */
-int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
+int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map,
+			      enum efi_memmap_type alloc_type)
 {
 	struct efi_memory_map_data data;
 
@@ -236,7 +240,7 @@ int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
 	data.desc_version = efi.memmap.desc_version;
 	data.desc_size = efi.memmap.desc_size;
 
-	return __efi_memmap_init(&data, efi.memmap.late);
+	return __efi_memmap_init(&data, alloc_type);
 }
 
 /**
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 53495e854d2a..c9752c67d184 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -778,7 +778,7 @@ struct efi_memory_map {
 	int nr_map;
 	unsigned long desc_version;
 	unsigned long desc_size;
-	bool late;
+	enum efi_memmap_type alloc_type;
 };
 
 struct efi_mem_range {
@@ -1015,10 +1015,12 @@ extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
 extern phys_addr_t __init efi_memmap_alloc(unsigned int num_entries,
 					   enum efi_memmap_type *alloc_type);
-extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
+extern int __init efi_memmap_init_early(struct efi_memory_map_data *data,
+					enum efi_memmap_type alloc_type);
 extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
 extern void __init efi_memmap_unmap(void);
-extern int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map);
+extern int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map,
+				     enum efi_memmap_type alloc_type);
 extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 					 struct range *range);
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
-- 
2.7.4

