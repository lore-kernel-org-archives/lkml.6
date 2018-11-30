Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1CFC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FFC2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FFC2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeK3VHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:07:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38137 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeK3VHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:07:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAU9w5o73261877
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Nov 2018 01:58:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAU9w5Sb3261874;
        Fri, 30 Nov 2018 01:58:05 -0800
Date:   Fri, 30 Nov 2018 01:58:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sai Praneeth Prakhya <tipbot@zytor.com>
Message-ID: <tip-7e0dabd3010d6041ee0a952c1146b2150a11f1be@git.kernel.org>
Cc:     matt@codeblueprint.co.uk, bhsharma@redhat.com,
        peterz@infradead.org, hdegoede@redhat.com, jonathanh@nvidia.com,
        sedat.dilek@gmail.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, zhuyifei1999@gmail.com, hpa@zytor.com,
        joe@perches.com, julien.thierry@arm.com,
        torvalds@linux-foundation.org, natechancellor@gmail.com,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        dave.hansen@intel.com, bp@alien8.de, luto@kernel.org,
        sai.praneeth.prakhya@intel.com, mingo@kernel.org,
        arend.vanspriel@broadcom.com, eric.snowberg@oracle.com
Reply-To: luto@kernel.org, marc.zyngier@arm.com, dave.hansen@intel.com,
          bp@alien8.de, ard.biesheuvel@linaro.org,
          torvalds@linux-foundation.org, natechancellor@gmail.com,
          eric.snowberg@oracle.com, arend.vanspriel@broadcom.com,
          mingo@kernel.org, sai.praneeth.prakhya@intel.com,
          jonathanh@nvidia.com, peterz@infradead.org, hdegoede@redhat.com,
          matt@codeblueprint.co.uk, bhsharma@redhat.com,
          julien.thierry@arm.com, joe@perches.com, sedat.dilek@gmail.com,
          hpa@zytor.com, tglx@linutronix.de, zhuyifei1999@gmail.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181129171230.18699-5-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-5-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] x86/mm/pageattr: Introduce helper function to unmap
 EFI boot services
Git-Commit-ID: 7e0dabd3010d6041ee0a952c1146b2150a11f1be
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7e0dabd3010d6041ee0a952c1146b2150a11f1be
Gitweb:     https://git.kernel.org/tip/7e0dabd3010d6041ee0a952c1146b2150a11f1be
Author:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
AuthorDate: Thu, 29 Nov 2018 18:12:23 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Nov 2018 09:10:30 +0100

x86/mm/pageattr: Introduce helper function to unmap EFI boot services

Ideally, after kernel assumes control of the platform, firmware
shouldn't access EFI boot services code/data regions. But, it's noticed
that this is not so true in many x86 platforms. Hence, during boot,
kernel reserves EFI boot services code/data regions [1] and maps [2]
them to efi_pgd so that call to set_virtual_address_map() doesn't fail.
After returning from set_virtual_address_map(), kernel frees the
reserved regions [3] but they still remain mapped. Hence, introduce
kernel_unmap_pages_in_pgd() which will later be used to unmap EFI boot
services code/data regions.

While at it modify kernel_map_pages_in_pgd() by:

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
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-5-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable_types.h |  8 ++++++--
 arch/x86/mm/pageattr.c               | 40 ++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 106b7d0e2dae..d6ff0bbdb394 100644
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
index db7a10082238..bac35001d896 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2338,8 +2338,8 @@ bool kernel_page_present(struct page *page)
 
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
-int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
-			    unsigned numpages, unsigned long page_flags)
+int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
+				   unsigned numpages, unsigned long page_flags)
 {
 	int retval = -EINVAL;
 
@@ -2353,6 +2353,8 @@ int kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.flags = 0,
 	};
 
+	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
+
 	if (!(__supported_pte_mask & _PAGE_NX))
 		goto out;
 
@@ -2374,6 +2376,40 @@ out:
 	return retval;
 }
 
+/*
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
 /*
  * The testcases use internal knowledge of the implementation that shouldn't
  * be exposed to the rest of the kernel. Include these directly here.
