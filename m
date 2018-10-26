Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E906ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26D220870
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26D220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeJ0GTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:19:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:25644 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbeJ0GTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:19:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 14:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,429,1534834800"; 
   d="scan'208";a="91559246"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Oct 2018 14:40:20 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH V2 1/2] x86/efi: Unmap EFI boot services code/data regions from efi_pgd
Date:   Fri, 26 Oct 2018 14:38:44 -0700
Message-Id: <20181026213845.28166-2-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026213845.28166-1-sai.praneeth.prakhya@intel.com>
References: <20181026213845.28166-1-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally, after kernel assumes control of the platform, firmware shouldn't
access EFI boot services code/data regions. But, it's noticed that this is
not so true in many x86 platforms. Hence, during boot, kernel reserves EFI
boot services code/data regions [1] and maps [2] them to efi_pgd so that
call to set_virtual_address_map() doesn't fail. After returning from
set_virtual_address_map(), kernel frees the reserved regions [3] but they
still remain mapped.

This means that any code that's running in efi_pgd address space (e.g: any
EFI runtime service) would still be able to access EFI boot services
code/data regions but the contents of these regions would have long been
over written by someone else as they are freed by efi_free_boot_services().
So, it's important to unmap these regions. After unmapping EFI boot
services code/data regions, any illegal access by buggy firmware to these
regions would result in page fault which will be handled by efi specific
fault handler.

Unmapping EFI boot services code/data regions will result in clearing
PAGE_PRESENT bit and it shouldn't bother L1TF cases because it's already
handled by protnone_mask() at arch/x86/include/asm/pgtable-invert.h.

[1] Please see efi_reserve_boot_services()
[2] Please see efi_map_region() -> __map_region()
[3] Please see efi_free_boot_services()

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/pgtable_types.h |  2 ++
 arch/x86/mm/pageattr.c               | 26 ++++++++++++++++++++++++++
 arch/x86/platform/efi/quirks.c       | 25 +++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b64acb08a62b..cda04ecf5432 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -566,6 +566,8 @@ extern pmd_t *lookup_pmd_address(unsigned long address);
 extern phys_addr_t slow_virt_to_phys(void *__address);
 extern int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 				   unsigned numpages, unsigned long page_flags);
+extern int kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
+				     unsigned long numpages);
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_DEFS_H */
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 51a5a69ecac9..248f16181bed 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2147,6 +2147,32 @@ int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 	return retval;
 }
 
+int kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
+			      unsigned long numpages)
+{
+	int retval;
+
+	/*
+	 * The typical sequence for unmapping is to find a pte through
+	 * lookup_address_in_pgd() (ideally, it should never return NULL because
+	 * the address is already mapped) and change it's protections.
+	 * As pfn is the *target* of a mapping, it's not useful while unmapping.
+	 */
+	struct cpa_data cpa = {
+		.vaddr		= &address,
+		.pgd		= pgd,
+		.numpages	= numpages,
+		.mask_set	= __pgprot(0),
+		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
+		.flags		= 0,
+	};
+
+	retval = __change_page_attr_set_clr(&cpa, 0);
+	__flush_tlb_all();
+
+	return retval;
+}
+
 /*
  * The testcases use internal knowledge of the implementation that shouldn't
  * be exposed to the rest of the kernel. Include these directly here.
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 669babcaf245..fb1c44b11235 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -370,6 +370,24 @@ void __init efi_reserve_boot_services(void)
 	}
 }
 
+/*
+ * Apart from having VA mappings for EFI boot services code/data regions,
+ * (duplicate) 1:1 mappings were also created as a quirk for buggy firmware. So,
+ * unmap both 1:1 and VA mappings.
+ */
+static void __init efi_unmap_pages(efi_memory_desc_t *md)
+{
+	pgd_t *pgd = efi_mm.pgd;
+	u64 pa = md->phys_addr;
+	u64 va = md->virt_addr;
+
+	if (kernel_unmap_pages_in_pgd(pgd, pa, md->num_pages))
+		pr_err("Failed to unmap 1:1 mapping for 0x%llx\n", pa);
+
+	if (kernel_unmap_pages_in_pgd(pgd, va, md->num_pages))
+		pr_err("Failed to unmap VA mapping for 0x%llx\n", va);
+}
+
 void __init efi_free_boot_services(void)
 {
 	phys_addr_t new_phys, new_size;
@@ -394,6 +412,13 @@ void __init efi_free_boot_services(void)
 			continue;
 		}
 
+		/*
+		 * Before calling set_virtual_address_map(), EFI boot services
+		 * code/data regions were mapped as a quirk for buggy firmware.
+		 * Unmap them from efi_pgd before freeing them up.
+		 */
+		efi_unmap_pages(md);
+
 		/*
 		 * Nasty quirk: if all sub-1MB memory is used for boot
 		 * services, we can get here without having allocated the
-- 
2.19.1

