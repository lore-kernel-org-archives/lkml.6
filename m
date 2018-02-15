Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227QwOUlraC0slzkKItEJMdJfqgx4mP3Z9h8UwmnPmldA2otMelufzQNmzXPT9qfVE8jinP6
ARC-Seal: i=1; a=rsa-sha256; t=1518709180; cv=none;
        d=google.com; s=arc-20160816;
        b=TQj/PVOgDnH799+pV5ytEizdaCO6N6KWDF3kt10aFTENEFb5dae8z9+gnA3K2vSLr2
         c9Jim3N+DcHYx/KOlrvjQblnVi9JnY8G2m0qBuwGobYU/BlvudgDzwFvi+BLZN87pUwc
         wzZejv7uGTVoxMRX5f8LMVPp+ByBFWsfk2ZZ576t3xS0/FGqFEp7F23N4eXQzDqT8mHW
         OYtGkjDqCcvxMcZDAjqcUH8ekxs4B5USuMmDMNc1txr35NjSRXnJbJNCMHEoBrz/3XtJ
         O0E6SAS83Ls8VoWvnru3gfijc+dE6IpgiP9E8bIAVnusy/4QVecQXKoau+sgRL2T2OUE
         uCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yU49BNzZcd+u3XSWgQTMbkIzcmejEsJ1aPa9YFNPfCI=;
        b=uAF5UpiChNSWB3YxBAs5WMXuOTEj+emP+X+dIkT/i1Yd4Q50zb70WREyXyGWoiaUV3
         DqV6zSdTQ7oRvPwx11Gc+NwidSH29ebOdvJbRMZGwSy/8XLmL77fixPr9qScqNOfuBgY
         y+xhgL7mX0S9NThyNxahs9ZtS2JzeYR1nnnun8SbEp7zzVz9lec6c/KibuIZUTMMcnH2
         uY68ZxdKdcf1kQVh9jQ96KCqQnLDJTFEgS0WRE+xW7oZBvNsBQK1zUK2VA/kQmD01Wh3
         wxEVp+pm2bE2OV5f0qiRWOAy3rqOmUk76gtPqmpGccwqAoqq1mCataPL4rt3fMg0aHxy
         Tv1Q==
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
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 025/202] [Variant 3/Meltdown] arm64: mm: Map entry trampoline into trampoline and kernel page tables
Date: Thu, 15 Feb 2018 16:15:25 +0100
Message-Id: <20180215151714.240866463@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481452544681902?=
X-GMAIL-MSGID: =?utf-8?q?1592481997879759437?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -683,6 +683,7 @@ static inline void pmdp_set_wrprotect(st
 
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
