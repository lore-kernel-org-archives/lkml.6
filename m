Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224MkTQeNl+y3dXhmIiAmDqlYyvF1zfBcJ3vzDTgkf66V5KVbyMFMea6MjjTI21qz+Efrgyc
ARC-Seal: i=1; a=rsa-sha256; t=1518709156; cv=none;
        d=google.com; s=arc-20160816;
        b=lJcHt+GV/ElwdO3vndmvHaqo6xbZBa30y4MBsKEniY129hpyDBhrI+mQGRzbkS7jRJ
         OWACqMK4FIu3AfRjslzPMiKtV7wE1nEWGSnzg4CdvoPV9eNkeqTRBygtBsdFRgTvj3/Q
         OdWR2Undtm0dkNljFWmkHjxDBOqV20vmxkyM8plz26aX904wjX28kK4W7KUGdQjHbh72
         Mcejpq7omtyoiIRlCqXduR4p/5JvX9b5il0w0gV6Mm9ARmtGzPRPP/5zEi1S8V1BjJqx
         AaxC6/g88z7NhWoILqmpsoqs1ornCZb+J1WuzdUPEr55m+OSYKR0amv1MCDdJD/mLUDE
         o1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RIwyDXiV0cLso8daOKujI4C5zHV+1aDzto+lwaWKTYA=;
        b=SGWKH6UsXLZfR7rwcux4LK/LZy40KQkobBRGn8uW+pYbECcHvC2Wwh6xAFEmXatz15
         rRWnvLOGAQaDHasiUJ00Ijlze4zYFSW32z0Z75H3u89rZBTrJOddzTZxBr0+lwjmZgvT
         Cg2VwmykxHnlyaKvQZai5/r0a1/ZMwMLiwyKSe0vr5eLPNk44QXz6BZ17IH1RYepdxPc
         LALi4VHNsjFh6Q1T4TErl7rNL5YmDdPie87KIHJ/EQcqAQ/1rPlk++ykDNpR6PAthM4z
         Ez2Vx0mqkgu5vexDrzAMZ3j7OZ2DPWvIXuQ5dKR32EcJmRpO92/qnC09Savek8yPWcBR
         J2LQ==
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
Subject: [PATCH 4.15 017/202] [Variant 3/Meltdown] arm64: mm: Move ASID from TTBR0 to TTBR1
Date: Thu, 15 Feb 2018 16:15:17 +0100
Message-Id: <20180215151713.758586695@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481426646741341?=
X-GMAIL-MSGID: =?utf-8?q?1592481971891756526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -224,7 +227,7 @@ ENTRY(__cpu_setup)
 	 * both user and kernel.
 	 */
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
-			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0
+			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0 | TCR_A1
 	tcr_set_idmap_t0sz	x10, x9
 
 	/*
