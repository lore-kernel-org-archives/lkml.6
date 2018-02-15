Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225syaFb+23wVpfskRvxHdSCCLwu4LN9EYX+Hk8+FCY3lZJ3AukWCgBCMUxdpIrEG6fKB4Wn
ARC-Seal: i=1; a=rsa-sha256; t=1518708701; cv=none;
        d=google.com; s=arc-20160816;
        b=p4TUWzElKAfvE1xNdxm7xmuqnHOgo4pQGnYP3DMRSmJaNTF4JfqpN3o1sD2oV4c1YJ
         eNHGQ4tq1boI/a8Bqo29bCiKkU7drtq1Svm/Rhl4/VbSEpjWOVXmyaFfBicUveU/5Bl6
         xEWkLySH8epogXvBoH5NgWaTip/0SH8ljQXw33pdPNexckG0ZFXe0dm26sQ+5KZHpsb4
         vzUPcBVOqh0Tdc7LHFcPPSVgGFtlhrsN6RhptsgPddDLOCrZUW8hi4YKB7xxAeOhUL59
         UIbWg44crnMaiVhJ0Ehxh4VG0Xy7XQm3LGViREb/sOMExyMckLDyGaav2vuYGu75nWqb
         F1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EqE95B9sgFdBmVdOrWgdyNFHWnkGV0houqH145pL8Ec=;
        b=QRdnXLTRpxRr037EymsF3gH0JWS8AJ6L2Eo7Wg4BrWM06bTWR9U9463/Sw3v/0hjyl
         zG3kb3LzzkOZ7TgDAIzlUK94Cso2G7XJXv/ps0i7Fr9VyQni93p5p9nUdqlt1a3VFUlO
         /CeUKnXwtvLiTza5BNl2ASjaMUVVke+kRyjyQybbJ0eMCZTjQKmchof0E+6KkcV5PjU0
         wcNwjdVorEhgQaFQhgTTPfTMQL0KzuxyCbC0QE14ZePHwH+tb86l0HEeMhU2txLFmt/r
         SlIK4LgbB5y0BVfW7Uz4GgEyD2aNeefdLaKPysOoLrDBFXnfZDy6PcSTnoQSMf9/oeGa
         594w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Timur Tabi <timur@codeaurora.org>
Subject: [PATCH 4.14 011/195] arm64: Add software workaround for Falkor erratum 1041
Date: Thu, 15 Feb 2018 16:15:02 +0100
Message-Id: <20180215151706.307474308@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481495113028061?=
X-GMAIL-MSGID: =?utf-8?q?1592481495113028061?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shanker Donthineni <shankerd@codeaurora.org>

commit 932b50c7c1c65e6f23002e075b97ee083c4a9e71 upstream.

The ARM architecture defines the memory locations that are permitted
to be accessed as the result of a speculative instruction fetch from
an exception level for which all stages of translation are disabled.
Specifically, the core is permitted to speculatively fetch from the
4KB region containing the current program counter 4K and next 4K.

When translation is changed from enabled to disabled for the running
exception level (SCTLR_ELn[M] changed from a value of 1 to 0), the
Falkor core may errantly speculatively access memory locations outside
of the 4KB region permitted by the architecture. The errant memory
access may lead to one of the following unexpected behaviors.

1) A System Error Interrupt (SEI) being raised by the Falkor core due
   to the errant memory access attempting to access a region of memory
   that is protected by a slave-side memory protection unit.
2) Unpredictable device behavior due to a speculative read from device
   memory. This behavior may only occur if the instruction cache is
   disabled prior to or coincident with translation being changed from
   enabled to disabled.

The conditions leading to this erratum will not occur when either of the
following occur:
 1) A higher exception level disables translation of a lower exception level
   (e.g. EL2 changing SCTLR_EL1[M] from a value of 1 to 0).
 2) An exception level disabling its stage-1 translation if its stage-2
    translation is enabled (e.g. EL1 changing SCTLR_EL1[M] from a value of 1
    to 0 when HCR_EL2[VM] has a value of 1).

To avoid the errant behavior, software must execute an ISB immediately
prior to executing the MSR that will change SCTLR_ELn[M] from 1 to 0.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Timur Tabi <timur@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/arm64/silicon-errata.txt |    1 +
 arch/arm64/Kconfig                     |   10 ++++++++++
 arch/arm64/include/asm/assembler.h     |   10 ++++++++++
 arch/arm64/kernel/cpu-reset.S          |    1 +
 arch/arm64/kernel/efi-entry.S          |    2 ++
 arch/arm64/kernel/head.S               |    1 +
 arch/arm64/kernel/relocate_kernel.S    |    1 +
 arch/arm64/kvm/hyp-init.S              |    1 +
 8 files changed, 27 insertions(+)

--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -74,3 +74,4 @@ stable kernels.
 | Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
 | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
+| Qualcomm Tech. | Falkor v{1,2}   | E1041           | QCOM_FALKOR_ERRATUM_1041    |
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -539,6 +539,16 @@ config QCOM_QDF2400_ERRATUM_0065
 
 	  If unsure, say Y.
 
+config QCOM_FALKOR_ERRATUM_E1041
+	bool "Falkor E1041: Speculative instruction fetches might cause errant memory access"
+	default y
+	help
+	  Falkor CPU may speculatively fetch instructions from an improper
+	  memory location when MMU translation is changed from SCTLR_ELn[M]=1
+	  to SCTLR_ELn[M]=0. Prefix an ISB instruction to fix the problem.
+
+	  If unsure, say Y.
+
 endmenu
 
 
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -499,4 +499,14 @@ alternative_else_nop_endif
 #endif
 	.endm
 
+/**
+ * Errata workaround prior to disable MMU. Insert an ISB immediately prior
+ * to executing the MSR that will change SCTLR_ELn[M] from a value of 1 to 0.
+ */
+	.macro pre_disable_mmu_workaround
+#ifdef CONFIG_QCOM_FALKOR_ERRATUM_E1041
+	isb
+#endif
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -37,6 +37,7 @@ ENTRY(__cpu_soft_restart)
 	mrs	x12, sctlr_el1
 	ldr	x13, =SCTLR_ELx_FLAGS
 	bic	x12, x12, x13
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x12
 	isb
 
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -96,6 +96,7 @@ ENTRY(entry)
 	mrs	x0, sctlr_el2
 	bic	x0, x0, #1 << 0	// clear SCTLR.M
 	bic	x0, x0, #1 << 2	// clear SCTLR.C
+	pre_disable_mmu_workaround
 	msr	sctlr_el2, x0
 	isb
 	b	2f
@@ -103,6 +104,7 @@ ENTRY(entry)
 	mrs	x0, sctlr_el1
 	bic	x0, x0, #1 << 0	// clear SCTLR.M
 	bic	x0, x0, #1 << 2	// clear SCTLR.C
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
 	isb
 2:
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -732,6 +732,7 @@ __primary_switch:
 	 * to take into account by discarding the current kernel mapping and
 	 * creating a new one.
 	 */
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x20			// disable the MMU
 	isb
 	bl	__create_page_tables		// recreate kernel mapping
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -45,6 +45,7 @@ ENTRY(arm64_relocate_new_kernel)
 	mrs	x0, sctlr_el2
 	ldr	x1, =SCTLR_ELx_FLAGS
 	bic	x0, x0, x1
+	pre_disable_mmu_workaround
 	msr	sctlr_el2, x0
 	isb
 1:
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -151,6 +151,7 @@ reset:
 	mrs	x5, sctlr_el2
 	ldr	x6, =SCTLR_ELx_FLAGS
 	bic	x5, x5, x6		// Clear SCTL_M and etc
+	pre_disable_mmu_workaround
 	msr	sctlr_el2, x5
 	isb
 
