Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2264EGXUA5C1EQk2I5UFxLWxKuzKFWRuLEcGthVsi9R7qp+ocYWgMLhKL5pU+IL53C5xnSIb
ARC-Seal: i=1; a=rsa-sha256; t=1518708638; cv=none;
        d=google.com; s=arc-20160816;
        b=DQlkW3ufRcHTMe4psKSbqOR+PU4PBiR6WdsuOFElIE2rst+Npegrglrbbnp4gDFy79
         j5tt46hJ3Q38Gbsuh3Psk1t6raxkFE7wkQSbW5i70eRDf/Fsp72B4N2t7HVAFIPE8Ali
         kBnn1deuBAwKKm0jDcot1Vj4hHnbi/xG7GJN8en5R9lFDSa9PgfXM5GF5m1LkqmZqAYX
         kVbqn0UECFrxIqc27/BTKh/sWAxw2vh7bAuYi2WZugqpEex1KMfjdLctUkHeCwTa6b0g
         3qRN4rESwdtznI8W0G1s8kmbR6Dviff2AhFlQ7y6cje4dwo88sHzpakqq8VRI6paeqKU
         KwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XgJuODz3Uq+B+k3WR3ANUwBfdms0/6m9F9NFFmalHpA=;
        b=Ayovnoox0odZ3jPZFR6qJPnxo6W9Znoh0hnu5FORvgMG0HP1G+2zcZ2DfR1rE6FkcM
         E7YXcPHsY1BT14GYISYhmj/0IcPqEbP70+qFOysyVeYixkga6SaV1B3Lg8dVKjbmkmXN
         AMfi8EJhSC0K9L2lgi0ArSx/vg0hW5C8SgSendPD82LfVe//s/oVEIJ9O2SqghBvNOe2
         NPtHJw7+MPgmq0KMsenBST+H3C0pNFVV7xVaXGCffnXZBygmYxnqyXSSGTQ5ef6Zmi5a
         6SsHArm5Hx06KwfRJyPyMXRjTvA3luP0wTjqASnYq3cAc9f+9Ziq6HKWh/4bv6bON2GZ
         ZLKA==
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
Subject: [PATCH 4.14 026/195] [Variant 3/Meltdown] arm64: mm: Remove pre_ttbr0_update_workaround for Falkor erratum #E1003
Date: Thu, 15 Feb 2018 16:15:17 +0100
Message-Id: <20180215151707.062766548@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481429424167022?=
X-GMAIL-MSGID: =?utf-8?q?1592481429424167022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 85d13c001497 upstream.

The pre_ttbr0_update_workaround hook is called prior to context-switching
TTBR0 because Falkor erratum E1003 can cause TLB allocation with the wrong
ASID if both the ASID and the base address of the TTBR are updated at
the same time.

With the ASID sitting safely in TTBR1, we no longer update things
atomically, so we can remove the pre_ttbr0_update_workaround macro as
it's no longer required. The erratum infrastructure and documentation
is left around for #E1003, as it will be required by the entry
trampoline code in a future patch.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h   |   22 ----------------------
 arch/arm64/include/asm/mmu_context.h |    2 --
 arch/arm64/mm/context.c              |   11 -----------
 arch/arm64/mm/proc.S                 |    1 -
 4 files changed, 36 deletions(-)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -25,7 +25,6 @@
 
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
-#include <asm/mmu_context.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
@@ -465,27 +464,6 @@ alternative_endif
 	.endm
 
 /*
- * Errata workaround prior to TTBR0_EL1 update
- *
- * 	val:	TTBR value with new BADDR, preserved
- * 	tmp0:	temporary register, clobbered
- * 	tmp1:	other temporary register, clobbered
- */
-	.macro	pre_ttbr0_update_workaround, val, tmp0, tmp1
-#ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
-alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003
-	mrs	\tmp0, ttbr0_el1
-	mov	\tmp1, #FALKOR_RESERVED_ASID
-	bfi	\tmp0, \tmp1, #48, #16		// reserved ASID + old BADDR
-	msr	ttbr0_el1, \tmp0
-	isb
-	bfi	\tmp0, \val, #0, #48		// reserved ASID + new BADDR
-	msr	ttbr0_el1, \tmp0
-	isb
-alternative_else_nop_endif
-#endif
-	.endm
-
 /*
  * Errata workaround post TTBR0_EL1 update.
  */
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -19,8 +19,6 @@
 #ifndef __ASM_MMU_CONTEXT_H
 #define __ASM_MMU_CONTEXT_H
 
-#define FALKOR_RESERVED_ASID	1
-
 #ifndef __ASSEMBLY__
 
 #include <linux/compiler.h>
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -79,13 +79,6 @@ void verify_cpu_asid_bits(void)
 	}
 }
 
-static void set_reserved_asid_bits(void)
-{
-	if (IS_ENABLED(CONFIG_QCOM_FALKOR_ERRATUM_1003) &&
-	    cpus_have_const_cap(ARM64_WORKAROUND_QCOM_FALKOR_E1003))
-		__set_bit(FALKOR_RESERVED_ASID, asid_map);
-}
-
 static void flush_context(unsigned int cpu)
 {
 	int i;
@@ -94,8 +87,6 @@ static void flush_context(unsigned int c
 	/* Update the list of reserved ASIDs and the ASID bitmap. */
 	bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
 
-	set_reserved_asid_bits();
-
 	/*
 	 * Ensure the generation bump is observed before we xchg the
 	 * active_asids.
@@ -250,8 +241,6 @@ static int asids_init(void)
 		panic("Failed to allocate bitmap for %lu ASIDs\n",
 		      NUM_USER_ASIDS);
 
-	set_reserved_asid_bits();
-
 	pr_info("ASID allocator initialised with %lu entries\n", NUM_USER_ASIDS);
 	return 0;
 }
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -138,7 +138,6 @@ ENDPROC(cpu_do_resume)
  *	- pgd_phys - physical address of new TTB
  */
 ENTRY(cpu_do_switch_mm)
-	pre_ttbr0_update_workaround x0, x2, x3
 	mrs	x2, ttbr1_el1
 	mmid	x1, x1				// get mm->context.id
 	bfi	x2, x1, #48, #16		// set the ASID
