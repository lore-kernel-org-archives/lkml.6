Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE9DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4525E21CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4525E21CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753829AbeGCBwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:52:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:5207 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753591AbeGCBvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:51:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 18:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,301,1526367600"; 
   d="scan'208";a="212956407"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2018 18:51:11 -0700
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
Subject: [PATCH 2/6] efi: Let the user of efi_memmap_alloc() know the type of allocation performed
Date:   Mon,  2 Jul 2018 18:50:50 -0700
Message-Id: <1530582654-25662-3-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

efi_memmap_alloc(), as the name suggests, allocates memory for a new efi
memory map and it does so depending on whether mm_init() has already
been invoked or not. As we have introduced efi_memmap_free() to free the
memory allocated by efi_memmap_alloc(), modify efi_memmap_alloc() to
include "efi_memmap_type", so that the caller of efi_memmap_alloc() will
know the type of allocation performed and later use the same to free the
memory should remap fail. Without "efi_memmap_type" there would be no
way for efi_memmap_free() to know the type of allocation performed by
efi_memmap_alloc().

Also, "efi_memmap_type" will make sure that efi_memmap_alloc() and
efi_memmap_free() are always binded properly i.e. a user could use
efi_memmap_alloc() before slab_is_available() and use efi_memmap_free()
on the same memory but after slab_is_available(). Without
"efi_memmap_type", efi_memmap_free() would be using wrong free variant.
With "efi_memmap_type", we make this relationship between
efi_memmap_alloc() and efi_memmap_free() explicit to the user.

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
 arch/x86/platform/efi/quirks.c  |  6 ++++--
 drivers/firmware/efi/fake_mem.c |  3 ++-
 drivers/firmware/efi/memmap.c   | 12 ++++++++++--
 include/linux/efi.h             |  3 ++-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 36c1f8b9f7e0..84e8d077adf6 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -248,6 +248,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	efi_memory_desc_t md;
 	int num_entries;
 	void *new;
+	enum efi_memmap_type alloc_type;
 
 	if (efi_mem_desc_lookup(addr, &md)) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
@@ -276,7 +277,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 
 	new_size = efi.memmap.desc_size * num_entries;
 
-	new_phys = efi_memmap_alloc(num_entries);
+	new_phys = efi_memmap_alloc(num_entries, &alloc_type);
 	if (!new_phys) {
 		pr_err("Could not allocate boot services memmap\n");
 		return;
@@ -375,6 +376,7 @@ void __init efi_free_boot_services(void)
 	efi_memory_desc_t *md;
 	int num_entries = 0;
 	void *new, *new_md;
+	enum efi_memmap_type alloc_type;
 
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
@@ -420,7 +422,7 @@ void __init efi_free_boot_services(void)
 		return;
 
 	new_size = efi.memmap.desc_size * num_entries;
-	new_phys = efi_memmap_alloc(num_entries);
+	new_phys = efi_memmap_alloc(num_entries, &alloc_type);
 	if (!new_phys) {
 		pr_err("Failed to allocate new EFI memmap\n");
 		return;
diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index 6c7d60c239b5..955e690b8325 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -57,6 +57,7 @@ void __init efi_fake_memmap(void)
 	phys_addr_t new_memmap_phy;
 	void *new_memmap;
 	int i;
+	enum efi_memmap_type alloc_type;
 
 	if (!nr_fake_mem)
 		return;
@@ -71,7 +72,7 @@ void __init efi_fake_memmap(void)
 	}
 
 	/* allocate memory for new EFI memmap */
-	new_memmap_phy = efi_memmap_alloc(new_nr_map);
+	new_memmap_phy = efi_memmap_alloc(new_nr_map, &alloc_type);
 	if (!new_memmap_phy)
 		return;
 
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 0686e063c644..69b81d355619 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -33,6 +33,7 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
 /**
  * efi_memmap_alloc - Allocate memory for the EFI memory map
  * @num_entries: Number of entries in the allocated map.
+ * @alloc_type: Type of allocation performed (memblock or normal)?
  *
  * Depending on whether mm_init() has already been invoked or not,
  * either memblock or "normal" page allocation is used.
@@ -40,13 +41,20 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
  * Returns the physical address of the allocated memory map on
  * success, zero on failure.
  */
-phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
+phys_addr_t __init efi_memmap_alloc(unsigned int num_entries,
+				    enum efi_memmap_type *alloc_type)
 {
 	unsigned long size = num_entries * efi.memmap.desc_size;
 
-	if (slab_is_available())
+	if (!alloc_type)
+		return 0;
+
+	if (slab_is_available()) {
+		*alloc_type = BUDDY_ALLOCATOR;
 		return __efi_memmap_alloc_late(size);
+	}
 
+	*alloc_type = MEMBLOCK;
 	return __efi_memmap_alloc_early(size);
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 455875c01ed1..53495e854d2a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1013,7 +1013,8 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
 #endif
 extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
-extern phys_addr_t __init efi_memmap_alloc(unsigned int num_entries);
+extern phys_addr_t __init efi_memmap_alloc(unsigned int num_entries,
+					   enum efi_memmap_type *alloc_type);
 extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
 extern void __init efi_memmap_unmap(void);
-- 
2.7.4

