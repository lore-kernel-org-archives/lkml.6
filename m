Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+wqDHfiHPIWEpNLGkWKFirqZnnwL+eqf98yoxhlltiYyUAizUnFiNqRFExtE0yGDigFMkQ
ARC-Seal: i=1; a=rsa-sha256; t=1523021698; cv=none;
        d=google.com; s=arc-20160816;
        b=DbfzKdPDPXD43P2RQ8f5ZEcULjl5Z2aKWcKaRrXk+YyzAf71g3q2VRs8XmgHbmuS54
         /rYLN5f+h0oEvr/UJ2Bmv0RXCTBXER/cL048NSfQZcrqNgcJuF6ZDNs+FiCCX90+QAD5
         6eKsO79FYiXTmVrOkUUzMprQk3Ml2MkxDUXf7g9lttcYMSQ6HNkY6SwW+E5gGUDde2Jm
         2OaNHEbspMGEjkW8vU1xjEg04A1MAdNj3+SGuGQ3Y9EuM+xtlTLBLFq0CpPpfrQLxJwO
         1grZldHhUNmW/b4sT6jlRBMr584VRuwFZ8BrkKN+VMnm32BQaxN/j2avEYFMhBIlhffN
         G3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+79lN+QtO3s5nak+3TAlcEb+nHykm9AxbCe/hNzrrcU=;
        b=iXiwjxwk2vk/TD9XUAi87QTlS87uYVW/BG4FOwSgg+DKksMHQcpc5u/prwZG1MhyeH
         2cT667+YNRj0PyrPaHkw66Rr/VHd7eictY8cMEd9Xn9XEkKrPN8zCnZ5NTIClAkNVV8Z
         ik3Cz2KKAwEyckP0Wfmayv7mxv6x+CmQZQ/KrIXcmxB71yGMoj2n+N+lx4tqtxnG4xIo
         LpE3XzCrmRxQJ5WH6LwQA6BlGPZFvIeBc9I5zY4Acg4KMPdr78yzmJhYKqgFFa/3RfIR
         MqO1iVq5g/DIcL3+1vo84uMANGAlF9x33Ad/38ph8/CKJBqFygSZr5Bw/dzoDblK30Se
         9YGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Alex Shi <alex.shi@linaro.org>,
	Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.9 058/102] arm64: mm: Map entry trampoline into trampoline and kernel page tables
Date: Fri,  6 Apr 2018 15:23:39 +0200
Message-Id: <20180406084339.761446888@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004000553757821?=
X-GMAIL-MSGID: =?utf-8?q?1597004000553757821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 51a0048beb44 upstream.

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
Signed-off-by: Alex Shi <alex.shi@linaro.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/fixmap.h  |    5 +++++
 arch/arm64/include/asm/pgtable.h |    1 +
 arch/arm64/kernel/asm-offsets.c  |    6 +++++-
 arch/arm64/mm/mmu.c              |   23 +++++++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -51,6 +51,11 @@ enum fixed_addresses {
 
 	FIX_EARLYCON_MEM_BASE,
 	FIX_TEXT_POKE0,
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	FIX_ENTRY_TRAMP_TEXT,
+#define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
+#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 	__end_of_permanent_fixed_addresses,
 
 	/*
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -692,6 +692,7 @@ static inline void pmdp_set_wrprotect(st
 
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
@@ -144,11 +145,14 @@ int main(void)
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
@@ -419,6 +419,29 @@ static void __init map_kernel_segment(pg
 	vm_area_add_early(vma);
 }
 
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
