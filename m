Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE77C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5ED721CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ED721CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932221AbeGCBvZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:51:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:5207 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753264AbeGCBvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:51:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 18:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,301,1526367600"; 
   d="scan'208";a="212956403"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2018 18:51:10 -0700
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
Subject: [PATCH 1/6] efi: Introduce efi_memmap_free() to free memory allocated by efi_memmap_alloc()
Date:   Mon,  2 Jul 2018 18:50:49 -0700
Message-Id: <1530582654-25662-2-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

efi_memmap_alloc() allocates memory depending on whether mm_init() has
already been invoked or not. Apart from memblock_alloc() memory and
alloc_pages() memory, efi memory map could also have a third variant of
memory allocation and that is memblock_reserved. This happens only for
the memory map passed to kernel by firmware and thus can happen only
once during boot process.

In order to identify these three different types of allocations and thus
to call the appropriate free() variant, introduce an enum named
efi_memmap_type and also introduce a efi memmap API named
efi_memmap_free() to free memory allocated by efi_memmap_alloc().

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
 drivers/firmware/efi/memmap.c | 28 ++++++++++++++++++++++++++++
 include/linux/efi.h           |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 5fc70520e04c..0686e063c644 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -12,6 +12,7 @@
 #include <asm/early_ioremap.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
+#include <linux/bootmem.h>
 
 static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
 {
@@ -50,6 +51,33 @@ phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
 }
 
 /**
+ * efi_memmap_free - Free memory allocated by efi_memmap_alloc()
+ * @mem: Physical address allocated by efi_memmap_alloc().
+ * @num_entries: Number of entries in the allocated map.
+ * @alloc_type: What type of allocation did efi_memmap_alloc() perform?
+ *
+ * Use this function to free memory allocated by efi_memmap_alloc().
+ * efi_memmap_alloc() allocates memory depending on whether mm_init()
+ * has already been invoked or not. It uses either memblock or "normal"
+ * page allocation, similarly, we free it in two different ways. Also
+ * note that there is a third type of memory used by memmap which is
+ * memblock_reserved() and is passed by EFI stub to kernel.
+ */
+void __init efi_memmap_free(phys_addr_t mem, unsigned int num_entries,
+			    enum efi_memmap_type alloc_type)
+{
+	unsigned long size = num_entries * efi.memmap.desc_size;
+	unsigned int order = get_order(size);
+
+	if (alloc_type == BUDDY_ALLOCATOR)
+		__free_pages(pfn_to_page(PHYS_PFN(mem)), order);
+	else if (alloc_type == MEMBLOCK)
+		memblock_free(mem, size);
+	else
+		free_bootmem(mem, size);
+}
+
+/**
  * __efi_memmap_init - Common code for mapping the EFI memory map
  * @data: EFI memory map data
  * @late: Use early or late mapping function?
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 56add823f190..455875c01ed1 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -765,6 +765,12 @@ struct efi_memory_map_data {
 	unsigned long desc_size;
 };
 
+enum efi_memmap_type {
+	EFI_STUB,
+	MEMBLOCK,
+	BUDDY_ALLOCATOR,
+};
+
 struct efi_memory_map {
 	phys_addr_t phys_map;
 	void *map;
@@ -1016,6 +1022,8 @@ extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 					 struct range *range);
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
 				     void *buf, struct efi_mem_range *mem);
+extern void __init efi_memmap_free(phys_addr_t mem, unsigned int num_entries,
+				   enum efi_memmap_type alloc_type);
 
 extern int efi_config_init(efi_config_table_type_t *arch_tables);
 #ifdef CONFIG_EFI_ESRT
-- 
2.7.4

