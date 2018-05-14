Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrguX1fN8mQLjELs5nG8+lu7OoVml3t9G3f3hwV4Ynm0JScyDlbmcW2WKUtBm4xUJBPTVMr
ARC-Seal: i=1; a=rsa-sha256; t=1526280889; cv=none;
        d=google.com; s=arc-20160816;
        b=Ojks1HKtJH7D0MS0pG9gQX/oplyg8qXGFOBePU3WB6z55P/B3nu6h9j/pkUW+pOFwI
         lLI4K+Y2vmSf8c3RuLud3urpeGKIM3mKHKPJRy9FXZmcKaAvSpO61sWJrgrUy8w6L23F
         d0TVsXFf8Psm6/s/ASJX93IEEcGbf3bmvlAJvR7x95sD3LaPw3AYAq9eUdhbqO1LJjc5
         M92hBW0+znw3ZmBghA6kUKhwIEDQapXdPHYZ0+hekrW3ajAedbHFp2DaFUEX1lxUR+ac
         QBDaGD7Kau3PoZoa6gPmiqfByj0UCioshD61eGQC6yaz8NAyylNtEZG74ivwAdyK4bn1
         KwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=sLJRbBNsOVlqSQ2cC2hrva0fIJPrRqEdfXNgad/57N4=;
        b=a7+wUdQ5MukWQa4hjMc1GrI66/4yhxrdd80LvRirT/RY5mN45cpIGlZ1FhBRK855/3
         iSv4H4drgQ58c5XWSshXQZA6pT6mqWgQWHVYMs8MCIDctiQosgOWiQX2+D4hGjb2P9Bh
         WbQG8/wNKdER0P9dBSBakpk3KXoA/K1/lJ/go8o508ZcCdohl3dny4CYmm2mj9UMR+la
         M9/NznEd1FjBiYNCWy6nw88v9umHEqCq9QG9E5SxRhdrcZH0eKX8076jJlznD9HOafnb
         ApR+XNPfqfWlypS2R8Xoi2pjzqf7UT9mHJ1u+SYJKAsM/G51qsnHHf6Z75MR7RHus1yu
         Q5bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cd3UwxxL;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cd3UwxxL;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	ckadabi@codeaurora.org,
	Dave Martin <dave.martin@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.9 16/36] arm64: Add work around for Arm Cortex-A55 Erratum 1024718
Date: Mon, 14 May 2018 08:48:50 +0200
Message-Id: <20180514064805.527665634@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421510087874369?=
X-GMAIL-MSGID: =?utf-8?q?1600421510087874369?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream.

Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
from an erratum 1024718, which causes incorrect updates when DBM/AP
bits in a page table entry is modified without a break-before-make
sequence. The work around is to skip enabling the hardware DBM feature
on the affected cores. The hardware Access Flag management features
is not affected. There are some other cores suffering from this
errata, which could be added to the midr_list to trigger the work
around.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: ckadabi@codeaurora.org
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 Documentation/arm64/silicon-errata.txt |    1 
 arch/arm64/Kconfig                     |   14 +++++++++++
 arch/arm64/include/asm/assembler.h     |   40 +++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cputype.h       |    5 ++++
 arch/arm64/mm/proc.S                   |    5 ++++
 5 files changed, 65 insertions(+)

--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -54,6 +54,7 @@ stable kernels.
 | ARM            | Cortex-A57      | #852523         | N/A                         |
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220        |
 | ARM            | Cortex-A72      | #853709         | N/A                         |
+| ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -427,6 +427,20 @@ config ARM64_ERRATUM_843419
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_1024718
+	bool "Cortex-A55: 1024718: Update of DBM/AP bits without break before make might result in incorrect update"
+	default y
+	help
+	  This option adds work around for Arm Cortex-A55 Erratum 1024718.
+
+	  Affected Cortex-A55 cores (r0p0, r0p1, r1p0) could cause incorrect
+	  update of the hardware dirty bit when the DBM/AP bits are updated
+	  without a break-before-make. The work around is to disable the usage
+	  of hardware DBM locally on the affected cores. CPUs not affected by
+	  erratum will continue to use the feature.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -25,6 +25,7 @@
 
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
+#include <asm/cputype.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
@@ -435,4 +436,43 @@ alternative_endif
 	and	\phys, \pte, #(((1 << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
 	.endm
 
+/*
+ * Check the MIDR_EL1 of the current CPU for a given model and a range of
+ * variant/revision. See asm/cputype.h for the macros used below.
+ *
+ *	model:		MIDR_CPU_MODEL of CPU
+ *	rv_min:		Minimum of MIDR_CPU_VAR_REV()
+ *	rv_max:		Maximum of MIDR_CPU_VAR_REV()
+ *	res:		Result register.
+ *	tmp1, tmp2, tmp3: Temporary registers
+ *
+ * Corrupts: res, tmp1, tmp2, tmp3
+ * Returns:  0, if the CPU id doesn't match. Non-zero otherwise
+ */
+	.macro	cpu_midr_match model, rv_min, rv_max, res, tmp1, tmp2, tmp3
+	mrs		\res, midr_el1
+	mov_q		\tmp1, (MIDR_REVISION_MASK | MIDR_VARIANT_MASK)
+	mov_q		\tmp2, MIDR_CPU_MODEL_MASK
+	and		\tmp3, \res, \tmp2	// Extract model
+	and		\tmp1, \res, \tmp1	// rev & variant
+	mov_q		\tmp2, \model
+	cmp		\tmp3, \tmp2
+	cset		\res, eq
+	cbz		\res, .Ldone\@		// Model matches ?
+
+	.if (\rv_min != 0)			// Skip min check if rv_min == 0
+	mov_q		\tmp3, \rv_min
+	cmp		\tmp1, \tmp3
+	cset		\res, ge
+	.endif					// \rv_min != 0
+	/* Skip rv_max check if rv_min == rv_max && rv_min != 0 */
+	.if ((\rv_min != \rv_max) || \rv_min == 0)
+	mov_q		\tmp2, \rv_max
+	cmp		\tmp1, \tmp2
+	cset		\tmp2, le
+	and		\res, \res, \tmp2
+	.endif
+.Ldone\@:
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -56,6 +56,9 @@
 	(0xf			<< MIDR_ARCHITECTURE_SHIFT) | \
 	((partnum)		<< MIDR_PARTNUM_SHIFT))
 
+#define MIDR_CPU_VAR_REV(var, rev) \
+	(((var) << MIDR_VARIANT_SHIFT) | (rev))
+
 #define MIDR_CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
 			     MIDR_ARCHITECTURE_MASK)
 
@@ -74,6 +77,7 @@
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
+#define ARM_CPU_PART_CORTEX_A55		0xD05
 #define ARM_CPU_PART_CORTEX_A57		0xD07
 #define ARM_CPU_PART_CORTEX_A72		0xD08
 #define ARM_CPU_PART_CORTEX_A53		0xD03
@@ -89,6 +93,7 @@
 #define BRCM_CPU_PART_VULCAN		0x516
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
+#define MIDR_CORTEX_A55 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A55)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
 #define MIDR_CORTEX_A73 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A73)
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -425,6 +425,11 @@ ENTRY(__cpu_setup)
 	cbz	x9, 2f
 	cmp	x9, #2
 	b.lt	1f
+#ifdef CONFIG_ARM64_ERRATUM_1024718
+	/* Disable hardware DBM on Cortex-A55 r0p0, r0p1 & r1p0 */
+	cpu_midr_match MIDR_CORTEX_A55, MIDR_CPU_VAR_REV(0, 0), MIDR_CPU_VAR_REV(1, 0), x1, x2, x3, x4
+	cbnz	x1, 1f
+#endif
 	orr	x10, x10, #TCR_HD		// hardware Dirty flag update
 1:	orr	x10, x10, #TCR_HA		// hardware Access flag update
 2:
