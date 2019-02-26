Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7B7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2202054F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfBZSnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:43:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52260 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728920AbfBZSnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:43:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E07D80D;
        Tue, 26 Feb 2019 10:43:50 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26D433F738;
        Tue, 26 Feb 2019 10:43:49 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     james.morse@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>
Subject: [PATCH v5] arm64: Add workaround for Fujitsu A64FX erratum 010001
Date:   Tue, 26 Feb 2019 18:43:41 +0000
Message-Id: <20190226184341.26083-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Lei <zhang.lei@jp.fujitsu.com>

On the Fujitsu-A64FX cores ver(1.0, 1.1), memory access may cause
an undefined fault (Data abort, DFSC=0b111111). This fault occurs under
a specific hardware condition when a load/store instruction performs an
address translation. Any load/store instruction, except non-fault access
including Armv8 and SVE might cause this undefined fault.

The TCR_ELx.NFD1 bit is used by the kernel when CONFIG_RANDOMIZE_BASE
is enabled to mitigate timing attacks against KASLR where the kernel
address space could be probed using the FFR and suppressed fault on
SVE loads.

Since this erratum causes spurious exceptions, which may corrupt
the exception registers, we clear the TCR_ELx.NFDx=1 bits when
booting on an affected CPU.

Signed-off-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
[Generated MIDR value/mask for __cpu_setup(), removed spurious-fault handler
 and always disabled the NFDx bits on affected CPUs]
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: zhang.lei <zhang.lei@jp.fujitsu.com>

---
(and since posted inline: removed the stray ; on
 MIDR_FUJITSU_ERRATUM_010001_MASK)

Changes since [v4]
 * Generated MIDR value/mask for __cpu_setup(),
 * removed spurious-fault handler,
 * always disabled the NFDx bits on affected CPUs

Changes since [v3]
 * Add description of the patch.
 * Add dependency to Kconfig.
  - Set default value of FUJITSU_ERRATUM_010001 depends on RANDOMIZE_BASE.

Changes since [v2]
 * Change TCR_ELx.NFD1.
  - Set TCR_ELx.NFD1 to 0 when entry kernel.
  - Set TCR_ELx.NFD1 to 1 when exit kernel.

Changes since [v1]
 * Use the errata framework to work around for Fujitsu A64FX erratum 010001.


 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 19 +++++++++++++++++++
 arch/arm64/include/asm/assembler.h     | 20 ++++++++++++++++++++
 arch/arm64/include/asm/cputype.h       |  9 +++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/mm/proc.S                   |  1 +
 6 files changed, 51 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 1f09d043d086..26d64e9f3a35 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -80,3 +80,4 @@ stable kernels.
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
 | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
 | Qualcomm Tech. | Falkor v{1,2}   | E1041           | QCOM_FALKOR_ERRATUM_1041    |
+| Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..b0b7f1c4e816 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -643,6 +643,25 @@ config QCOM_FALKOR_ERRATUM_E1041
 
 	  If unsure, say Y.
 
+config FUJITSU_ERRATUM_010001
+	bool "Fujitsu-A64FX erratum E#010001: Undefined fault may occur wrongly"
+	default y
+	help
+	  This option adds workaround for Fujitsu-A64FX erratum E#010001.
+	  On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1), memory
+	  accesses may cause undefined fault (Data abort, DFSC=0b111111).
+	  This fault occurs under a specific hardware condition when a
+	  load/store instruction performs an address translation using:
+	  case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
+	  case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
+	  case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
+	  case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
+
+	  The workaround is to ensure these bits are clear in TCR_ELx.
+	  The workaround only affect the Fujitsu-A64FX.
+
+	  If unsure, say Y.
+
 endmenu
 
 
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 4feb6119c3c9..128d0fbfcb24 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -27,6 +27,7 @@
 
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
+#include <asm/cputype.h>
 #include <asm/debug-monitors.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
@@ -604,6 +605,25 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 #endif
 	.endm
 
+/*
+ * tcr_clear_errata_bits - Clear TCR bits that trigger an errata on this CPU.
+ */
+	.macro	tcr_clear_errata_bits, tcr, tmp1, tmp2
+#ifdef CONFIG_FUJITSU_ERRATUM_010001
+	mrs	\tmp1, midr_el1
+
+	mov_q	\tmp2, MIDR_FUJITSU_ERRATUM_010001_MASK
+	and	\tmp1, \tmp1, \tmp2
+	mov_q	\tmp2, MIDR_FUJITSU_ERRATUM_010001
+	cmp	\tmp1, \tmp2
+	b.ne	10f
+
+	mov_q	\tmp2, TCR_CLEAR_FUJITSU_ERRATUM_010001
+	bic	\tcr, \tcr, \tmp2
+10:
+#endif /* CONFIG_FUJITSU_ERRATUM_010001 */
+	.endm
+
 /**
  * Errata workaround prior to disable MMU. Insert an ISB immediately prior
  * to executing the MSR that will change SCTLR_ELn[M] from a value of 1 to 0.
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 951ed1a4e5c9..c6c6b4de0688 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -76,6 +76,7 @@
 #define ARM_CPU_IMP_BRCM		0x42
 #define ARM_CPU_IMP_QCOM		0x51
 #define ARM_CPU_IMP_NVIDIA		0x4E
+#define ARM_CPU_IMP_FUJITSU		0x46
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -104,6 +105,8 @@
 #define NVIDIA_CPU_PART_DENVER		0x003
 #define NVIDIA_CPU_PART_CARMEL		0x004
 
+#define FUJITSU_CPU_PART_A64FX		0x001
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -122,6 +125,12 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
+#define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
+
+/* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
+#define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
+#define MIDR_FUJITSU_ERRATUM_010001_MASK	(~MIDR_VARIANT(1))
+#define TCR_CLEAR_FUJITSU_ERRATUM_010001	(TCR_NFD1 | TCR_NFD0)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index e9b0a7d75184..a69259cc1f16 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -302,6 +302,7 @@
 #define TCR_TBI1		(UL(1) << 38)
 #define TCR_HA			(UL(1) << 39)
 #define TCR_HD			(UL(1) << 40)
+#define TCR_NFD0		(UL(1) << 53)
 #define TCR_NFD1		(UL(1) << 54)
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 73886a5f1f30..750e9f0500db 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -456,6 +456,7 @@ ENTRY(__cpu_setup)
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
+	tcr_clear_errata_bits x10, x9, x5
 
 #ifdef CONFIG_ARM64_USER_VA_BITS_52
 	ldr_l		x9, vabits_user
-- 
2.20.1

