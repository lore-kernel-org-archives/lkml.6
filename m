Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AABC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BC1219EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BC1219EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeHIGys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 02:54:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:22077 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbeHIGys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 02:54:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 21:31:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,213,1531810800"; 
   d="scan'208";a="61024031"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by fmsmga007.fm.intel.com with ESMTP; 08 Aug 2018 21:31:57 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ricardo.ner@intel.com, matt@codeblueprint.co.uk,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH V1 2/6] x86/efi: Remove __init attribute from memory mapping functions
Date:   Wed,  8 Aug 2018 21:31:13 -0700
Message-Id: <1533789077-16156-3-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533789077-16156-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1533789077-16156-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Buggy firmware could illegally access EFI_BOOT_SERVICES_CODE/DATA
regions even after the kernel has assumed control of the platform. When
"CONFIG_EFI_WARN_ON_ILLEGAL_ACCESSES" is enabled, the efi page fault
handler will detect/fixup these illegal accesses. The below modified
functions are used by the page fault handler to fixup illegal accesses
to EFI_BOOT_SERVICES_CODE/DATA regions. As the page fault handler is
present during/after kernel boot it doesn't have an __init attribute,
but the below functions have it and thus during kernel build, "WARNING:
modpost: Found * section mismatch(es)" build warning is observed. To fix
it, remove __init attribute for all these functions.

In order to not keep these functions needlessly when
"CONFIG_EFI_WARN_ON_ILLEGAL_ACCESSES" is not selected, add a new
__efi_init_fixup attribute whose value changes based on whether the
config option is selected or not.

Suggested-by: Matt Fleming <matt@codeblueprint.co.uk>
Based-on-code-from: Ricardo Neri <ricardo.neri@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Al Stone <astone@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/efi.h     | 11 ++++++-----
 arch/x86/platform/efi/efi.c    |  4 ++--
 arch/x86/platform/efi/efi_32.c |  2 +-
 arch/x86/platform/efi/efi_64.c |  9 +++++----
 drivers/firmware/efi/efi.c     |  6 +++---
 include/linux/efi.h            | 16 ++++++++++++++--
 6 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cec5fae23eb3..9b70743400f3 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -103,8 +103,9 @@ struct efi_scratch {
 	preempt_enable();						\
 })
 
-extern void __iomem *__init efi_ioremap(unsigned long addr, unsigned long size,
-					u32 type, u64 attribute);
+extern void __iomem *__efi_init_fixup efi_ioremap(unsigned long addr,
+					      unsigned long size, u32 type,
+					      u64 attribute);
 
 #ifdef CONFIG_KASAN
 /*
@@ -126,13 +127,13 @@ extern int __init efi_memblock_x86_reserve_range(void);
 extern pgd_t * __init efi_call_phys_prolog(void);
 extern void __init efi_call_phys_epilog(pgd_t *save_pgd);
 extern void __init efi_print_memmap(void);
-extern void __init efi_memory_uc(u64 addr, unsigned long size);
-extern void __init efi_map_region(efi_memory_desc_t *md);
+extern void __efi_init_fixup efi_memory_uc(u64 addr, unsigned long size);
+extern void __efi_init_fixup efi_map_region(efi_memory_desc_t *md);
 extern void __init efi_map_region_fixed(efi_memory_desc_t *md);
 extern void efi_sync_low_kernel_mappings(void);
 extern int __init efi_alloc_page_tables(void);
 extern int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages);
-extern void __init old_map_region(efi_memory_desc_t *md);
+extern void __efi_init_fixup old_map_region(efi_memory_desc_t *md);
 extern void __init runtime_code_page_mkexec(void);
 extern void __init efi_runtime_update_mappings(void);
 extern void __init efi_dump_pagetable(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 9061babfbc83..439c2c40bf03 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -572,7 +572,7 @@ void __init runtime_code_page_mkexec(void)
 	}
 }
 
-void __init efi_memory_uc(u64 addr, unsigned long size)
+void __efi_init_fixup efi_memory_uc(u64 addr, unsigned long size)
 {
 	unsigned long page_shift = 1UL << EFI_PAGE_SHIFT;
 	u64 npages;
@@ -582,7 +582,7 @@ void __init efi_memory_uc(u64 addr, unsigned long size)
 	set_memory_uc(addr, npages);
 }
 
-void __init old_map_region(efi_memory_desc_t *md)
+void __efi_init_fixup old_map_region(efi_memory_desc_t *md)
 {
 	u64 start_pfn, end_pfn, end;
 	unsigned long size;
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 324b93328b37..8f31452bd204 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -58,7 +58,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	return 0;
 }
 
-void __init efi_map_region(efi_memory_desc_t *md)
+void __efi_init_fixup efi_map_region(efi_memory_desc_t *md)
 {
 	old_map_region(md);
 }
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 448267f1c073..a04298312fdd 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -408,7 +408,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	return 0;
 }
 
-static void __init __map_region(efi_memory_desc_t *md, u64 va)
+static void __efi_init_fixup __map_region(efi_memory_desc_t *md, u64 va)
 {
 	unsigned long flags = _PAGE_RW;
 	unsigned long pfn;
@@ -426,7 +426,7 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 			   md->phys_addr, va);
 }
 
-void __init efi_map_region(efi_memory_desc_t *md)
+void __efi_init_fixup efi_map_region(efi_memory_desc_t *md)
 {
 	unsigned long size = md->num_pages << PAGE_SHIFT;
 	u64 pa = md->phys_addr;
@@ -488,8 +488,9 @@ void __init efi_map_region_fixed(efi_memory_desc_t *md)
 	__map_region(md, md->virt_addr);
 }
 
-void __iomem *__init efi_ioremap(unsigned long phys_addr, unsigned long size,
-				 u32 type, u64 attribute)
+void __iomem *__efi_init_fixup efi_ioremap(unsigned long phys_addr,
+				       unsigned long size, u32 type,
+				       u64 attribute)
 {
 	unsigned long last_map_pfn;
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d8a33a781a57..7bc3fac7bfe0 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -768,7 +768,7 @@ int __init efi_get_fdt_params(struct efi_fdt_params *params)
 }
 #endif /* CONFIG_EFI_PARAMS_FROM_FDT */
 
-static __initdata char memory_type_name[][20] = {
+static __efi_initdata_fixup char memory_type_name[][20] = {
 	"Reserved",
 	"Loader Code",
 	"Loader Data",
@@ -786,8 +786,8 @@ static __initdata char memory_type_name[][20] = {
 	"Persistent Memory",
 };
 
-char * __init efi_md_typeattr_format(char *buf, size_t size,
-				     const efi_memory_desc_t *md)
+char * __efi_init_fixup efi_md_typeattr_format(char *buf, size_t size,
+					       const efi_memory_desc_t *md)
 {
 	char *pos;
 	int type_len;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 855992b15269..169b5837c72c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1107,11 +1107,23 @@ extern int efi_memattr_apply_permissions(struct mm_struct *mm,
 	for_each_efi_memory_desc_in_map(&efi.memmap, md)
 
 /*
+ * __efi_init_fixup - if CONFIG_EFI_WARN_ON_ILLEGAL_ACCESSES is enabled,
+ *		  remove __init modifier.
+ */
+#ifdef CONFIG_EFI_WARN_ON_ILLEGAL_ACCESSES
+#define __efi_init_fixup
+#define __efi_initdata_fixup
+#else
+#define __efi_init_fixup __init
+#define __efi_initdata_fixup __initdata
+#endif
+
+/*
  * Format an EFI memory descriptor's type and attributes to a user-provided
  * character buffer, as per snprintf(), and return the buffer.
  */
-char * __init efi_md_typeattr_format(char *buf, size_t size,
-				     const efi_memory_desc_t *md);
+char * __efi_init_fixup efi_md_typeattr_format(char *buf, size_t size,
+					       const efi_memory_desc_t *md);
 
 /**
  * efi_range_is_wc - check the WC bit on an address range
-- 
2.7.4

