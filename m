Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226v3RaZNYRShTWdUtgzmW9R7GdvnVTtId0QTi558fiAsjY8vG12JFGowSio9/1GlVIFThZ0
ARC-Seal: i=1; a=rsa-sha256; t=1518709164; cv=none;
        d=google.com; s=arc-20160816;
        b=MNJBV0eRqW1tmWA2gihaH+McZis4350YDk93JaoNQuGPg2VPtFW61lgqOzw3A5NRcq
         ot7P6w0VtJYDlkVkLJirPsTarua55CLvIc38VYoBsrcB0assHiFtlqcoYiqdISZ1wQBD
         O5Z9VRaKcL9I7fJqUrlSCCFivNLL09bgNnLU4vZlatTrBN9YIRaWclHTzmbU4tH007OU
         +uhxxr+Vo/OtTmtmWBO7/KInyoFSOuxZSgUa/lTPkm/JXpnki4a1gIqm/G2HDJTr43ZW
         qOjLh4jVCJERfZrU011dzUO0rJ4S0uxbHDzQGUZmwdvwz5sGozApW2Lxs2rE8+C58aZX
         ZRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=24iI0cocbGieqvaVVVGMU947cPJJHSsGVRKP1aha8Y8=;
        b=pHOgKLA1xqs4U2mXJGz4gjk9p7N7rUxq4wHR65ZNvvlgNS0Xgb3PnOpKy9T932jJgo
         +H/lgWlJw7ogiVWk9aNiSC6VPtZY9BiKEN7cApPBPXHXXKIND9sGZhHfnKub3CkTAJ7b
         S1qcPA8QcZ6JlfQYynzh7Mt0YzpISCDqH8ZuawLMtRLP+8BuEltv1gQ0YZmhQT3mZAKp
         pE6wOzQ2RDQf4rEqjoxj1KJnl18RaPHtexGkDg5liP5YFzae19tMBIuCpXApDCNdwSAd
         Dy874G/5PeQDplwfski2o3xopCac1SsBHBYibva1fVnbi0BNKU2fbev5Dw1RHqYaUKFg
         xg/w==
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
Subject: [PATCH 4.15 020/202] [Variant 3/Meltdown] arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN
Date: Thu, 15 Feb 2018 16:15:20 +0100
Message-Id: <20180215151713.955175657@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481438392756670?=
X-GMAIL-MSGID: =?utf-8?q?1592481981160550608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 27a921e75711 upstream.

With the ASID now installed in TTBR1, we can re-enable ARM64_SW_TTBR0_PAN
by ensuring that we switch to a reserved ASID of zero when disabling
user access and restore the active user ASID on the uaccess enable path.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig                   |    1 -
 arch/arm64/include/asm/asm-uaccess.h |   25 +++++++++++++++++--------
 arch/arm64/include/asm/uaccess.h     |   21 +++++++++++++++++----
 arch/arm64/kernel/entry.S            |    4 ++--
 arch/arm64/lib/clear_user.S          |    2 +-
 arch/arm64/lib/copy_from_user.S      |    2 +-
 arch/arm64/lib/copy_in_user.S        |    2 +-
 arch/arm64/lib/copy_to_user.S        |    2 +-
 arch/arm64/mm/cache.S                |    2 +-
 arch/arm64/xen/hypercall.S           |    2 +-
 10 files changed, 42 insertions(+), 21 deletions(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -920,7 +920,6 @@ endif
 
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
-	depends on BROKEN       # Temporary while switch_mm is reworked
 	help
 	  Enabling this option prevents the kernel from accessing
 	  user-space memory directly by pointing TTBR0_EL1 to a reserved
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -16,11 +16,20 @@
 	add	\tmp1, \tmp1, #SWAPPER_DIR_SIZE	// reserved_ttbr0 at the end of swapper_pg_dir
 	msr	ttbr0_el1, \tmp1		// set reserved TTBR0_EL1
 	isb
+	sub	\tmp1, \tmp1, #SWAPPER_DIR_SIZE
+	bic	\tmp1, \tmp1, #(0xffff << 48)
+	msr	ttbr1_el1, \tmp1		// set reserved ASID
+	isb
 	.endm
 
-	.macro	__uaccess_ttbr0_enable, tmp1
+	.macro	__uaccess_ttbr0_enable, tmp1, tmp2
 	get_thread_info \tmp1
 	ldr	\tmp1, [\tmp1, #TSK_TI_TTBR0]	// load saved TTBR0_EL1
+	mrs	\tmp2, ttbr1_el1
+	extr    \tmp2, \tmp2, \tmp1, #48
+	ror     \tmp2, \tmp2, #16
+	msr	ttbr1_el1, \tmp2		// set the active ASID
+	isb
 	msr	ttbr0_el1, \tmp1		// set the non-PAN TTBR0_EL1
 	isb
 	.endm
@@ -31,18 +40,18 @@ alternative_if_not ARM64_HAS_PAN
 alternative_else_nop_endif
 	.endm
 
-	.macro	uaccess_ttbr0_enable, tmp1, tmp2
+	.macro	uaccess_ttbr0_enable, tmp1, tmp2, tmp3
 alternative_if_not ARM64_HAS_PAN
-	save_and_disable_irq \tmp2		// avoid preemption
-	__uaccess_ttbr0_enable \tmp1
-	restore_irq \tmp2
+	save_and_disable_irq \tmp3		// avoid preemption
+	__uaccess_ttbr0_enable \tmp1, \tmp2
+	restore_irq \tmp3
 alternative_else_nop_endif
 	.endm
 #else
 	.macro	uaccess_ttbr0_disable, tmp1
 	.endm
 
-	.macro	uaccess_ttbr0_enable, tmp1, tmp2
+	.macro	uaccess_ttbr0_enable, tmp1, tmp2, tmp3
 	.endm
 #endif
 
@@ -56,8 +65,8 @@ alternative_if ARM64_ALT_PAN_NOT_UAO
 alternative_else_nop_endif
 	.endm
 
-	.macro	uaccess_enable_not_uao, tmp1, tmp2
-	uaccess_ttbr0_enable \tmp1, \tmp2
+	.macro	uaccess_enable_not_uao, tmp1, tmp2, tmp3
+	uaccess_ttbr0_enable \tmp1, \tmp2, \tmp3
 alternative_if ARM64_ALT_PAN_NOT_UAO
 	SET_PSTATE_PAN(0)
 alternative_else_nop_endif
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -107,15 +107,19 @@ static inline void __uaccess_ttbr0_disab
 {
 	unsigned long ttbr;
 
+	ttbr = read_sysreg(ttbr1_el1);
 	/* reserved_ttbr0 placed at the end of swapper_pg_dir */
-	ttbr = read_sysreg(ttbr1_el1) + SWAPPER_DIR_SIZE;
-	write_sysreg(ttbr, ttbr0_el1);
+	write_sysreg(ttbr + SWAPPER_DIR_SIZE, ttbr0_el1);
+	isb();
+	/* Set reserved ASID */
+	ttbr &= ~(0xffffUL << 48);
+	write_sysreg(ttbr, ttbr1_el1);
 	isb();
 }
 
 static inline void __uaccess_ttbr0_enable(void)
 {
-	unsigned long flags;
+	unsigned long flags, ttbr0, ttbr1;
 
 	/*
 	 * Disable interrupts to avoid preemption between reading the 'ttbr0'
@@ -123,7 +127,16 @@ static inline void __uaccess_ttbr0_enabl
 	 * roll-over and an update of 'ttbr0'.
 	 */
 	local_irq_save(flags);
-	write_sysreg(current_thread_info()->ttbr0, ttbr0_el1);
+	ttbr0 = current_thread_info()->ttbr0;
+
+	/* Restore active ASID */
+	ttbr1 = read_sysreg(ttbr1_el1);
+	ttbr1 |= ttbr0 & (0xffffUL << 48);
+	write_sysreg(ttbr1, ttbr1_el1);
+	isb();
+
+	/* Restore user page table */
+	write_sysreg(ttbr0, ttbr0_el1);
 	isb();
 	local_irq_restore(flags);
 }
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -184,7 +184,7 @@ alternative_if ARM64_HAS_PAN
 alternative_else_nop_endif
 
 	.if	\el != 0
-	mrs	x21, ttbr0_el1
+	mrs	x21, ttbr1_el1
 	tst	x21, #0xffff << 48		// Check for the reserved ASID
 	orr	x23, x23, #PSR_PAN_BIT		// Set the emulated PAN in the saved SPSR
 	b.eq	1f				// TTBR0 access already disabled
@@ -248,7 +248,7 @@ alternative_else_nop_endif
 	tbnz	x22, #22, 1f			// Skip re-enabling TTBR0 access if the PSR_PAN_BIT is set
 	.endif
 
-	__uaccess_ttbr0_enable x0
+	__uaccess_ttbr0_enable x0, x1
 
 	.if	\el == 0
 	/*
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -30,7 +30,7 @@
  * Alignment fixed up by hardware.
  */
 ENTRY(__clear_user)
-	uaccess_enable_not_uao x2, x3
+	uaccess_enable_not_uao x2, x3, x4
 	mov	x2, x1			// save the size for fixup return
 	subs	x1, x1, #8
 	b.mi	2f
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -64,7 +64,7 @@
 
 end	.req	x5
 ENTRY(__arch_copy_from_user)
-	uaccess_enable_not_uao x3, x4
+	uaccess_enable_not_uao x3, x4, x5
 	add	end, x0, x2
 #include "copy_template.S"
 	uaccess_disable_not_uao x3
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -65,7 +65,7 @@
 
 end	.req	x5
 ENTRY(raw_copy_in_user)
-	uaccess_enable_not_uao x3, x4
+	uaccess_enable_not_uao x3, x4, x5
 	add	end, x0, x2
 #include "copy_template.S"
 	uaccess_disable_not_uao x3
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -63,7 +63,7 @@
 
 end	.req	x5
 ENTRY(__arch_copy_to_user)
-	uaccess_enable_not_uao x3, x4
+	uaccess_enable_not_uao x3, x4, x5
 	add	end, x0, x2
 #include "copy_template.S"
 	uaccess_disable_not_uao x3
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -49,7 +49,7 @@ ENTRY(flush_icache_range)
  *	- end     - virtual end address of region
  */
 ENTRY(__flush_cache_user_range)
-	uaccess_ttbr0_enable x2, x3
+	uaccess_ttbr0_enable x2, x3, x4
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	bic	x4, x0, x3
--- a/arch/arm64/xen/hypercall.S
+++ b/arch/arm64/xen/hypercall.S
@@ -101,7 +101,7 @@ ENTRY(privcmd_call)
 	 * need the explicit uaccess_enable/disable if the TTBR0 PAN emulation
 	 * is enabled (it implies that hardware UAO and PAN disabled).
 	 */
-	uaccess_ttbr0_enable x6, x7
+	uaccess_ttbr0_enable x6, x7, x8
 	hvc XEN_IMM
 
 	/*
