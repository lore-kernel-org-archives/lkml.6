Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5829FECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2392082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2392082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeKEF2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 00:28:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:8965 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725745AbeKEF2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 00:28:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 12:12:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,465,1534834800"; 
   d="scan'208";a="97569952"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga003.jf.intel.com with ESMTP; 04 Nov 2018 12:12:01 -0800
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
Subject: [PATCH V3 1/3] x86/mm/pageattr: Introduce helper function to unmap EFI boot services
Date:   Sun,  4 Nov 2018 12:10:17 -0800
Message-Id: <20181104201019.26142-2-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104201019.26142-1-sai.praneeth.prakhya@intel.com>
References: <20181104201019.26142-1-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally, after kernel assumes control of the platform, firmware
shouldn't access EFI boot services code/data regions. But, it's noticed
that this is not so true in many x86 platforms. Hence, during boot,
kernel reserves EFI boot services code/data regions [1] and maps [2]
them to efi_pgd so that call to set_virtual_address_map() doesn't fail.
After returning from set_virtual_address_map(), kernel frees the
reserved regions [3] but they still remain mapped. Hence, introduce
kernel_unmap_pages_in_pgd() which will later be used to unmap EFI boot
services code/data regions.

While at it modify kernel_map_pages_in_pgd() by
1. Adding __init modifier because it's always used *only* during boot.
2. Add a warning if it's used after SMP is initialized because it uses
   __flush_tlb_all() which flushes mappings only on current CPU.

Unmapping EFI boot services code/data regions will result in clearing
PAGE_PRESENT bit and it shouldn't bother L1TF cases because it's already
handled by protnone_mask() at arch/x86/include/asm/pgtable-invert.h.

[1] efi_reserve_boot_services()
[2] efi_map_region() -> __map_region() -> kernel_map_pages_in_pgd()
[3] efi_free_boot_services()

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
 arch/x86/include/asm/pgtable_types.h |  8 ++++++--
 arch/x86/mm/pageattr.c               | 40 ++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b64acb08a62b..79aa79bb2cfa 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -564,8 +564,12 @@ extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 				    unsigned int *level);
 extern pmd_t *lookup_pmd_address(unsigned long address);
 extern phys_addr_t slow_virt_to_phys(void *__address);
-extern int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
-				   unsigned numpages, unsigned long page_flags);
+extern int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn,
+					  unsigned long address,
+					  unsigned numpages,
+					  unsigned long page_flags);
+extern int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
+					    unsigned long numpages);
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_DEFS_H */
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 51a5a69ecac9..1b1d5a68c4b2 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2111,8 +2111,8 @@ bool kernel_page_present(struct page *page)
 
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
-int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
-			    unsigned numpages, unsigned long page_flags)
+int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
+				   unsigned numpages, unsigned long page_flags)
 {
 	int retval = -EINVAL;
 
@@ -2126,6 +2126,8 @@ int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.flags = 0,
 	};
 
+	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
+
 	if (!(__supported_pte_mask & _PAGE_NX))
 		goto out;
 
@@ -2148,6 +2150,40 @@ int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 }
 
 /*
+ * __flush_tlb_all() flushes mappings only on current CPU and hence this
+ * function shouldn't be used in an SMP environment. Presently, it's used only
+ * during boot (way before smp_init()) by EFI subsystem and hence is ok.
+ */
+int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
+				     unsigned long numpages)
+{
+	int retval;
+
+	/*
+	 * The typical sequence for unmapping is to find a pte through
+	 * lookup_address_in_pgd() (ideally, it should never return NULL because
+	 * the address is already mapped) and change it's protections. As pfn is
+	 * the *target* of a mapping, it's not useful while unmapping.
+	 */
+	struct cpa_data cpa = {
+		.vaddr		= &address,
+		.pfn		= 0,
+		.pgd		= pgd,
+		.numpages	= numpages,
+		.mask_set	= __pgprot(0),
+		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
+		.flags		= 0,
+	};
+
+	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
+
+	retval = __change_page_attr_set_clr(&cpa, 0);
+	__flush_tlb_all();
+
+	return retval;
+}
+
+/*
  * The testcases use internal knowledge of the implementation that shouldn't
  * be exposed to the rest of the kernel. Include these directly here.
  */
-- 
2.7.4

