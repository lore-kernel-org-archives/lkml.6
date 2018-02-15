Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2271I7tP//za2nR5SX1Rl8tzBvXH79NdTp+8JvBSzyVTT885DujUiRFNXoiTKGrD8gmuHdej
ARC-Seal: i=1; a=rsa-sha256; t=1518708635; cv=none;
        d=google.com; s=arc-20160816;
        b=dfEGCNQryRt5w4jj38R16PCozs7XfoTpkLigORB1ZMrxNcHfV2ziUH7b5IiTtLQ1e1
         OWlhRFBoAmfIDrBjYYb7Zj9sUMYe75rrcHSzdDfMwiQU6aye2YNBfUwjN2WoOXeuHBBX
         DrMBzw24z3LfQLvHt64A6da/wYCLq7yajepQJjDVSxdIRDkjnLYJCs5AiCWdWIMeeetE
         xeYw6thNTt8Ds7mqXCoopmbXMfwq0cP7hjZgmbXbuYcF0AIkQH3+L1i7lWi8+E218UJl
         +Gj2IiK8ODK9H7KmGhPX9ktPRJC9YScyZswmAzRcIVw/2+BEmQKeOGPGnWHruoFxiMGB
         +s0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HQAT7k1QPjCJd0R0ycH6sxsFLrPeB1iE5p/y2hyjjBE=;
        b=cC7L0Luw9VmOtH+7VxqSGToPHoyw6/iQBL4CO4sNxQKsMnC/BuvdXdv1gSnno0yW2w
         ZeK3HuGhr7Qm4ePBcrnm19jbrxRdqGKEN4Z11FM7/OTR7BEJQxMkQR+jqJn+mE8SnIzC
         8EpkxE2x21Mpflg66TgIW8OFQ11boHZ2WdQyLYiss9mTEm5sGYUmGujOqe0kiBCjvo8j
         rvMLXyRFosfENyNcvoUftgXaHF8p/AC99yp8YpPggUtCGNuG/Pqy9xI+mBAMDkI8WePc
         2JqMzB72PG0lQ4iq2tVFZ76jH8LS+Y63qSTIr8cbsWYBXAVNBZaEA+alnIP+om6lZhQQ
         NNOg==
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
Subject: [PATCH 4.14 025/195] [Variant 3/Meltdown] arm64: mm: Move ASID from TTBR0 to TTBR1
Date: Thu, 15 Feb 2018 16:15:16 +0100
Message-Id: <20180215151707.003894362@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481426646741341?=
X-GMAIL-MSGID: =?utf-8?q?1592481426646741341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 7655abb95386 upstream.

In preparation for mapping kernelspace and userspace with different
ASIDs, move the ASID to TTBR1 and update switch_mm to context-switch
TTBR0 via an invalid mapping (the zero page).

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/mmu_context.h   |    7 +++++++
 arch/arm64/include/asm/pgtable-hwdef.h |    1 +
 arch/arm64/include/asm/proc-fns.h      |    6 ------
 arch/arm64/mm/proc.S                   |    9 ++++++---
 4 files changed, 14 insertions(+), 9 deletions(-)

--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -57,6 +57,13 @@ static inline void cpu_set_reserved_ttbr
 	isb();
 }
 
+static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
+{
+	BUG_ON(pgd == swapper_pg_dir);
+	cpu_set_reserved_ttbr0();
+	cpu_do_switch_mm(virt_to_phys(pgd),mm);
+}
+
 /*
  * TCR.T0SZ value to use when the ID map is active. Usually equals
  * TCR_T0SZ(VA_BITS), unless system RAM is positioned very high in
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -272,6 +272,7 @@
 #define TCR_TG1_4K		(UL(2) << TCR_TG1_SHIFT)
 #define TCR_TG1_64K		(UL(3) << TCR_TG1_SHIFT)
 
+#define TCR_A1			(UL(1) << 22)
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
 #define TCR_HA			(UL(1) << 39)
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -35,12 +35,6 @@ extern u64 cpu_do_resume(phys_addr_t ptr
 
 #include <asm/memory.h>
 
-#define cpu_switch_mm(pgd,mm)				\
-do {							\
-	BUG_ON(pgd == swapper_pg_dir);			\
-	cpu_do_switch_mm(virt_to_phys(pgd),mm);		\
-} while (0)
-
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* __ASM_PROCFNS_H */
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -139,9 +139,12 @@ ENDPROC(cpu_do_resume)
  */
 ENTRY(cpu_do_switch_mm)
 	pre_ttbr0_update_workaround x0, x2, x3
+	mrs	x2, ttbr1_el1
 	mmid	x1, x1				// get mm->context.id
-	bfi	x0, x1, #48, #16		// set the ASID
-	msr	ttbr0_el1, x0			// set TTBR0
+	bfi	x2, x1, #48, #16		// set the ASID
+	msr	ttbr1_el1, x2			// in TTBR1 (since TCR.A1 is set)
+	isb
+	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
 	post_ttbr0_update_workaround
 	ret
@@ -225,7 +228,7 @@ ENTRY(__cpu_setup)
 	 * both user and kernel.
 	 */
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
-			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0
+			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0 | TCR_A1
 	tcr_set_idmap_t0sz	x10, x9
 
 	/*
