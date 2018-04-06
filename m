Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49giBdpqO/CEILo6bqPwIpm8zy2H9hUd0wqiRwkK4Ozwvmmn0do9Uf5+Lw/nWjJa4gqytTc
ARC-Seal: i=1; a=rsa-sha256; t=1523021679; cv=none;
        d=google.com; s=arc-20160816;
        b=SjnW98qikdM3hjk5PaYXNDDwv8YCPtdRTv84faQlX3ersLku359/CzOozGAWbLqwj8
         E5NMhfavTZo6RHOJ24R8A+LHYTAPYgvGlXML1kaKaNClwMwISkFxrmp/J5zgsG+mQ2ej
         PmhWvF0PhMiGSKuBs3yImTcmAtNd8tHSQ6nTZivtg60ZKuLzuomRr6ESkiQlw0RBd1pk
         ri2PNS7+XoxL8sYEPZlDiuIhXCs5MokCHKCZ6ErMxhNOIrA1O6PgKKApQgkGlnsu4F9/
         1plkSopDQ2TefXAasrvFSdd3hBUTzAZGnTXxeoxuMU9zkTYL5xaYTZDLD1JNqXKUlbJ2
         589Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w9E5D5irbPQAGQRuGlut8ydCvsF3+aN1yoWQGIzbiEc=;
        b=WHUJv4V9gWHm/OX3Prp4KedtAhmdDooU3MzQ4ibVq5iVPg2iqHNArjkbXvuP5lOxKc
         mKtacehr/Hk8lTI24tQZK2zIrgmTGuf29Z0oMheJMexobM8y9urXAzt29FVyqkQb9dPY
         /AuFVYj8WoZCL921J5PRFbD6Phj3OtUnmIRLWZ9w1IbrtRW2dVkfDNGAuh+f+tA62kYD
         Jtagur6sEEUrQht7pEvgT9KezZ4Wu4SpXoMR7kcCGCDZOgSlWi3L/mBZjNxx256x26wM
         pkBpayMwcRIoECGZZ0b9c9UbgqHUC+W8+/WKG1ZH59pxi4C3ccS5JttLwfKUbMJe+SIf
         3Iow==
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
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 4.9 051/102] arm64: mm: Move ASID from TTBR0 to TTBR1
Date: Fri,  6 Apr 2018 15:23:32 +0200
Message-Id: <20180406084338.789334380@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003980613313447?=
X-GMAIL-MSGID: =?utf-8?q?1597003980613313447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 7655abb95386 upstream.

In preparation for mapping kernelspace and userspace with different
ASIDs, move the ASID to TTBR1 and update switch_mm to context-switch
TTBR0 via an invalid mapping (the zero page).

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/mmu_context.h   |    7 +++++++
 arch/arm64/include/asm/pgtable-hwdef.h |    1 +
 arch/arm64/include/asm/proc-fns.h      |    6 ------
 arch/arm64/mm/proc.S                   |    9 ++++++---
 4 files changed, 14 insertions(+), 9 deletions(-)

--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -50,6 +50,13 @@ static inline void cpu_set_reserved_ttbr
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
@@ -132,9 +132,12 @@ ENDPROC(cpu_do_resume)
  *	- pgd_phys - physical address of new TTB
  */
 ENTRY(cpu_do_switch_mm)
+	mrs	x2, ttbr1_el1
 	mmid	x1, x1				// get mm->context.id
-	bfi	x0, x1, #48, #16		// set the ASID
-	msr	ttbr0_el1, x0			// set TTBR0
+	bfi	x2, x1, #48, #16		// set the ASID
+	msr	ttbr1_el1, x2			// in TTBR1 (since TCR.A1 is set)
+	isb
+	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
 alternative_if ARM64_WORKAROUND_CAVIUM_27456
 	ic	iallu
@@ -222,7 +225,7 @@ ENTRY(__cpu_setup)
 	 * both user and kernel.
 	 */
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
-			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0
+			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0 | TCR_A1
 	tcr_set_idmap_t0sz	x10, x9
 
 	/*
