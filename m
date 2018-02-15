Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225uc18AgIsfT5oStIFyrkGXw91/Y2t8o2231w4pRDtcO07bljWSp+c/DCZDr3079COCILUF
ARC-Seal: i=1; a=rsa-sha256; t=1518708660; cv=none;
        d=google.com; s=arc-20160816;
        b=Qesb5SwgjsdR6DnQ2m6XYGwabe7B4Q3Q7jpcmkLDwgihisPYQEBbDOtZ1R1RmKGUrl
         KdaUrnbhHZHohLBvNpzJYeSMY8AjSoxOndSiWjo+Y87hHbY4pqShnb3ir3C8pBx+7p5w
         Gnlou9Dwh4+G/bUgxYm4VHKxQi9UPWssWsyOCGFDfxQkPiBewJNtHLxVfPN57jpDeb9j
         Y//pHsi3u4vZyZSuf745sgnD8380nA6C4V416KVHOQDE5l5ARf+lMmfB5w9UpdwYQ/VW
         b9asGus2o6fDnwIfey/tN/dzfSaRWhHSR5mK2JQWdE67HlbwBl5N1mbq7NAJN1CMo6iU
         didA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3eeP1Ops5LrpmCoKO058X4y68RIaQeMEnAMq8noQM5M=;
        b=ytYp2Ad1p2zyt8TC+vCmsHzjqbinsFB2afgPWmxg843PGrQ8IFvHwbE6uqlav7w5d5
         XyH55Weby76J7QTTR6uHjuPJrI7UZ2xIext94jNOAyaksqlHBFmDUsZq4cCteqsytdTn
         LBcs9Qw8DsjZlne8QUjEO+qO11XIfFAqAkoZKxRohqyBzcVkGG4Tt4s6JZuz5sFltq0h
         ZbBGB/LldDe28Xeg6WIIYilFRHGevAUJOF8u2bJQizd6lrfNSuqiBHGxeCEBIQk+GIAs
         1LB7UFBi4ttQc6fCZr9snpKO8InOLniCZt0cXamgzp5kIluSG4cyYPE6j1puZXLpHgBM
         j+TA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 033/195] [Variant 3/Meltdown] arm64: mm: Map entry trampoline into trampoline and kernel page tables
Date: Thu, 15 Feb 2018 16:15:24 +0100
Message-Id: <20180215151707.412444260@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481452544681902?=
X-GMAIL-MSGID: =?utf-8?q?1592481452544681902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 51a0048beb44 upstream.

The exception entry trampoline needs to be mapped at the same virtual
address in both the trampoline page table (which maps nothing else)
and also the kernel page table, so that we can swizzle TTBR1_EL1 on
exceptions from and return to EL0.

This patch maps the trampoline at a fixed virtual address in the fixmap
area of the kernel virtual address space, which allows the kernel proper
to be randomized with respect to the trampoline when KASLR is enabled.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/fixmap.h  |    4 ++++
 arch/arm64/include/asm/pgtable.h |    1 +
 arch/arm64/kernel/asm-offsets.c  |    6 +++++-
 arch/arm64/mm/mmu.c              |   23 +++++++++++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -58,6 +58,10 @@ enum fixed_addresses {
 	FIX_APEI_GHES_NMI,
 #endif /* CONFIG_ACPI_APEI_GHES */
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	FIX_ENTRY_TRAMP_TEXT,
+#define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
+#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 	__end_of_permanent_fixed_addresses,
 
 	/*
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -684,6 +684,7 @@ static inline void pmdp_set_wrprotect(st
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
+extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
 
 /*
  * Encode and decode a swap entry:
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -24,6 +24,7 @@
 #include <linux/kvm_host.h>
 #include <linux/suspend.h>
 #include <asm/cpufeature.h>
+#include <asm/fixmap.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/smp_plat.h>
@@ -148,11 +149,14 @@ int main(void)
   DEFINE(ARM_SMCCC_RES_X2_OFFS,		offsetof(struct arm_smccc_res, a2));
   DEFINE(ARM_SMCCC_QUIRK_ID_OFFS,	offsetof(struct arm_smccc_quirk, id));
   DEFINE(ARM_SMCCC_QUIRK_STATE_OFFS,	offsetof(struct arm_smccc_quirk, state));
-
   BLANK();
   DEFINE(HIBERN_PBE_ORIG,	offsetof(struct pbe, orig_address));
   DEFINE(HIBERN_PBE_ADDR,	offsetof(struct pbe, address));
   DEFINE(HIBERN_PBE_NEXT,	offsetof(struct pbe, next));
   DEFINE(ARM64_FTR_SYSVAL,	offsetof(struct arm64_ftr_reg, sys_val));
+  BLANK();
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+  DEFINE(TRAMP_VALIAS,		TRAMP_VALIAS);
+#endif
   return 0;
 }
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -525,6 +525,29 @@ static int __init parse_rodata(char *arg
 }
 early_param("rodata", parse_rodata);
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+static int __init map_entry_trampoline(void)
+{
+	extern char __entry_tramp_text_start[];
+
+	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
+	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
+
+	/* The trampoline is always mapped and can therefore be global */
+	pgprot_val(prot) &= ~PTE_NG;
+
+	/* Map only the text into the trampoline page table */
+	memset(tramp_pg_dir, 0, PGD_SIZE);
+	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
+			     prot, pgd_pgtable_alloc, 0);
+
+	/* ...as well as the kernel page table */
+	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
+	return 0;
+}
+core_initcall(map_entry_trampoline);
+#endif
+
 /*
  * Create fine-grained mappings for the kernel.
  */
