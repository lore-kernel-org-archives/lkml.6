Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837D2ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC5E2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC5E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeJVJxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 05:53:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:63581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeJVJxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 05:53:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2018 18:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,410,1534834800"; 
   d="scan'208";a="97296420"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga002.fm.intel.com with ESMTP; 21 Oct 2018 18:36:49 -0700
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
Subject: [PATCH 1/2] x86/efi: Unmap efi boot services code/data regions from efi_pgd
Date:   Sun, 21 Oct 2018 18:35:44 -0700
Message-Id: <1540172145-17134-2-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540172145-17134-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1540172145-17134-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally, after kernel assumes control of the platform firmware shouldn't
access EFI Boot Services Code/Data regions. But, it's noticed that this
is not so true in many x86 platforms. Hence, during boot, kernel
reserves efi boot services code/data regions [1] and maps [2] them to
efi_pgd so that call to set_virtual_address_map() doesn't fail. After
returning from set_virtual_address_map(), kernel frees the reserved
regions [3] but they still remain mapped.

This means that any code that's running in efi_pgd address space (e.g:
any efi runtime service) would still be able to access efi boot services
code/data regions but the contents of these regions would have long been
over written by someone else as they are freed by efi_free_boot_services().
So, it's important to unmap these regions. After unmapping boot services
code/data regions, any illegal access by buggy firmware to these regions
would result in page fault which will be handled by efi specific fault
handler.

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
 arch/x86/mm/pageattr.c               | 21 +++++++++++++++++++++
 arch/x86/platform/efi/quirks.c       | 26 ++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b64acb08a62b..796476f11151 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -566,6 +566,8 @@ extern pmd_t *lookup_pmd_address(unsigned long address);
 extern phys_addr_t slow_virt_to_phys(void *__address);
 extern int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 				   unsigned numpages, unsigned long page_flags);
+extern int kernel_unmap_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
+				     unsigned long numpages);
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_DEFS_H */
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 51a5a69ecac9..b88ed8e91790 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2147,6 +2147,27 @@ int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 	return retval;
 }
 
+int kernel_unmap_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
+			      unsigned long numpages)
+{
+	int retval;
+
+	struct cpa_data cpa = {
+		.vaddr = &address,
+		.pfn = pfn,
+		.pgd = pgd,
+		.numpages = numpages,
+		.mask_set = __pgprot(0),
+		.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW),
+		.flags = 0,
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
index 669babcaf245..5a1ee9392fcf 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -370,6 +370,25 @@ void __init efi_reserve_boot_services(void)
 	}
 }
 
+/*
+ * Apart from having VA mappings for efi boot services code/data regions,
+ * (duplicate) 1:1 mappings were also created as a catch for buggy firmware. So,
+ * unmap both 1:1 and VA mappings.
+ */
+static void __init efi_unmap_pages(efi_memory_desc_t *md)
+{
+	pgd_t *pgd = efi_mm.pgd;
+	u64 pfn = md->phys_addr >> PAGE_SHIFT;
+
+	if (kernel_unmap_pages_in_pgd(pgd, pfn, md->phys_addr, md->num_pages))
+		pr_err("Failed to unmap 1:1 mapping: PA 0x%llx -> VA 0x%llx!\n",
+		       md->phys_addr, md->virt_addr);
+
+	if (kernel_unmap_pages_in_pgd(pgd, pfn, md->virt_addr, md->num_pages))
+		pr_err("Failed to unmap VA mapping: PA 0x%llx -> VA 0x%llx!\n",
+		       md->phys_addr, md->virt_addr);
+}
+
 void __init efi_free_boot_services(void)
 {
 	phys_addr_t new_phys, new_size;
@@ -415,6 +434,13 @@ void __init efi_free_boot_services(void)
 		}
 
 		free_bootmem_late(start, size);
+
+		/*
+		 * Before calling set_virtual_address_map(), boot services
+		 * code/data regions were mapped as a catch for buggy firmware.
+		 * Unmap them from efi_pgd as they have already been freed.
+		 */
+		efi_unmap_pages(md);
 	}
 
 	if (!num_entries)
-- 
2.7.4

