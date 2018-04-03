Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754901AbeDCGVC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 02:21:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34602 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752460AbeDCGUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 02:20:55 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, thomas.petazzoni@bootlin.com,
        mylene.josserand@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/13] ARM: move cputype definitions into another file
Date: Tue,  3 Apr 2018 08:18:24 +0200
Message-Id: <20180403061836.3926-2-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180403061836.3926-1-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To add the support for SMP on sun8i-a83t, we will use some
definitions in an assembly file so move definitions into
another file to separate C functions and macro defintions.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/include/asm/cputype.h     | 94 +-----------------------------------
 arch/arm/include/asm/cputype_def.h | 98 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm/include/asm/cputype_def.h

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb546425da8a..4cb26e840a58 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -4,99 +4,7 @@
 
 #include <linux/stringify.h>
 #include <linux/kernel.h>
-
-#define CPUID_ID	0
-#define CPUID_CACHETYPE	1
-#define CPUID_TCM	2
-#define CPUID_TLBTYPE	3
-#define CPUID_MPUIR	4
-#define CPUID_MPIDR	5
-#define CPUID_REVIDR	6
-
-#ifdef CONFIG_CPU_V7M
-#define CPUID_EXT_PFR0	0x40
-#define CPUID_EXT_PFR1	0x44
-#define CPUID_EXT_DFR0	0x48
-#define CPUID_EXT_AFR0	0x4c
-#define CPUID_EXT_MMFR0	0x50
-#define CPUID_EXT_MMFR1	0x54
-#define CPUID_EXT_MMFR2	0x58
-#define CPUID_EXT_MMFR3	0x5c
-#define CPUID_EXT_ISAR0	0x60
-#define CPUID_EXT_ISAR1	0x64
-#define CPUID_EXT_ISAR2	0x68
-#define CPUID_EXT_ISAR3	0x6c
-#define CPUID_EXT_ISAR4	0x70
-#define CPUID_EXT_ISAR5	0x74
-#else
-#define CPUID_EXT_PFR0	"c1, 0"
-#define CPUID_EXT_PFR1	"c1, 1"
-#define CPUID_EXT_DFR0	"c1, 2"
-#define CPUID_EXT_AFR0	"c1, 3"
-#define CPUID_EXT_MMFR0	"c1, 4"
-#define CPUID_EXT_MMFR1	"c1, 5"
-#define CPUID_EXT_MMFR2	"c1, 6"
-#define CPUID_EXT_MMFR3	"c1, 7"
-#define CPUID_EXT_ISAR0	"c2, 0"
-#define CPUID_EXT_ISAR1	"c2, 1"
-#define CPUID_EXT_ISAR2	"c2, 2"
-#define CPUID_EXT_ISAR3	"c2, 3"
-#define CPUID_EXT_ISAR4	"c2, 4"
-#define CPUID_EXT_ISAR5	"c2, 5"
-#endif
-
-#define MPIDR_SMP_BITMASK (0x3 << 30)
-#define MPIDR_SMP_VALUE (0x2 << 30)
-
-#define MPIDR_MT_BITMASK (0x1 << 24)
-
-#define MPIDR_HWID_BITMASK 0xFFFFFF
-
-#define MPIDR_INVALID (~MPIDR_HWID_BITMASK)
-
-#define MPIDR_LEVEL_BITS 8
-#define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
-#define MPIDR_LEVEL_SHIFT(level) (MPIDR_LEVEL_BITS * level)
-
-#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
-	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
-
-#define ARM_CPU_IMP_ARM			0x41
-#define ARM_CPU_IMP_DEC			0x44
-#define ARM_CPU_IMP_INTEL		0x69
-
-/* ARM implemented processors */
-#define ARM_CPU_PART_ARM1136		0x4100b360
-#define ARM_CPU_PART_ARM1156		0x4100b560
-#define ARM_CPU_PART_ARM1176		0x4100b760
-#define ARM_CPU_PART_ARM11MPCORE	0x4100b020
-#define ARM_CPU_PART_CORTEX_A8		0x4100c080
-#define ARM_CPU_PART_CORTEX_A9		0x4100c090
-#define ARM_CPU_PART_CORTEX_A5		0x4100c050
-#define ARM_CPU_PART_CORTEX_A7		0x4100c070
-#define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
-#define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
-#define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
-#define ARM_CPU_PART_MASK		0xff00fff0
-
-/* DEC implemented cores */
-#define ARM_CPU_PART_SA1100		0x4400a110
-
-/* Intel implemented cores */
-#define ARM_CPU_PART_SA1110		0x6900b110
-#define ARM_CPU_REV_SA1110_A0		0
-#define ARM_CPU_REV_SA1110_B0		4
-#define ARM_CPU_REV_SA1110_B1		5
-#define ARM_CPU_REV_SA1110_B2		6
-#define ARM_CPU_REV_SA1110_B4		8
-
-#define ARM_CPU_XSCALE_ARCH_MASK	0xe000
-#define ARM_CPU_XSCALE_ARCH_V1		0x2000
-#define ARM_CPU_XSCALE_ARCH_V2		0x4000
-#define ARM_CPU_XSCALE_ARCH_V3		0x6000
-
-/* Qualcomm implemented cores */
-#define ARM_CPU_PART_SCORPION		0x510002d0
+#include <asm/cputype_def.h>
 
 extern unsigned int processor_id;
 
diff --git a/arch/arm/include/asm/cputype_def.h b/arch/arm/include/asm/cputype_def.h
new file mode 100644
index 000000000000..3a62ea13dc35
--- /dev/null
+++ b/arch/arm/include/asm/cputype_def.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ARM_CPUTYPEDEF_H
+#define __ASM_ARM_CPUTYPEDEF_H
+
+#define CPUID_ID	0
+#define CPUID_CACHETYPE	1
+#define CPUID_TCM	2
+#define CPUID_TLBTYPE	3
+#define CPUID_MPUIR	4
+#define CPUID_MPIDR	5
+#define CPUID_REVIDR	6
+
+#ifdef CONFIG_CPU_V7M
+#define CPUID_EXT_PFR0	0x40
+#define CPUID_EXT_PFR1	0x44
+#define CPUID_EXT_DFR0	0x48
+#define CPUID_EXT_AFR0	0x4c
+#define CPUID_EXT_MMFR0	0x50
+#define CPUID_EXT_MMFR1	0x54
+#define CPUID_EXT_MMFR2	0x58
+#define CPUID_EXT_MMFR3	0x5c
+#define CPUID_EXT_ISAR0	0x60
+#define CPUID_EXT_ISAR1	0x64
+#define CPUID_EXT_ISAR2	0x68
+#define CPUID_EXT_ISAR3	0x6c
+#define CPUID_EXT_ISAR4	0x70
+#define CPUID_EXT_ISAR5	0x74
+#else
+#define CPUID_EXT_PFR0	"c1, 0"
+#define CPUID_EXT_PFR1	"c1, 1"
+#define CPUID_EXT_DFR0	"c1, 2"
+#define CPUID_EXT_AFR0	"c1, 3"
+#define CPUID_EXT_MMFR0	"c1, 4"
+#define CPUID_EXT_MMFR1	"c1, 5"
+#define CPUID_EXT_MMFR2	"c1, 6"
+#define CPUID_EXT_MMFR3	"c1, 7"
+#define CPUID_EXT_ISAR0	"c2, 0"
+#define CPUID_EXT_ISAR1	"c2, 1"
+#define CPUID_EXT_ISAR2	"c2, 2"
+#define CPUID_EXT_ISAR3	"c2, 3"
+#define CPUID_EXT_ISAR4	"c2, 4"
+#define CPUID_EXT_ISAR5	"c2, 5"
+#endif
+
+#define MPIDR_SMP_BITMASK (0x3 << 30)
+#define MPIDR_SMP_VALUE (0x2 << 30)
+
+#define MPIDR_MT_BITMASK (0x1 << 24)
+
+#define MPIDR_HWID_BITMASK 0xFFFFFF
+
+#define MPIDR_INVALID (~MPIDR_HWID_BITMASK)
+
+#define MPIDR_LEVEL_BITS 8
+#define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
+#define MPIDR_LEVEL_SHIFT(level) (MPIDR_LEVEL_BITS * level)
+
+#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
+	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
+
+#define ARM_CPU_IMP_ARM			0x41
+#define ARM_CPU_IMP_DEC			0x44
+#define ARM_CPU_IMP_INTEL		0x69
+
+/* ARM implemented processors */
+#define ARM_CPU_PART_ARM1136		0x4100b360
+#define ARM_CPU_PART_ARM1156		0x4100b560
+#define ARM_CPU_PART_ARM1176		0x4100b760
+#define ARM_CPU_PART_ARM11MPCORE	0x4100b020
+#define ARM_CPU_PART_CORTEX_A8		0x4100c080
+#define ARM_CPU_PART_CORTEX_A9		0x4100c090
+#define ARM_CPU_PART_CORTEX_A5		0x4100c050
+#define ARM_CPU_PART_CORTEX_A7		0x4100c070
+#define ARM_CPU_PART_CORTEX_A12		0x4100c0d0
+#define ARM_CPU_PART_CORTEX_A17		0x4100c0e0
+#define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
+#define ARM_CPU_PART_MASK		0xff00fff0
+
+/* DEC implemented cores */
+#define ARM_CPU_PART_SA1100		0x4400a110
+
+/* Intel implemented cores */
+#define ARM_CPU_PART_SA1110		0x6900b110
+#define ARM_CPU_REV_SA1110_A0		0
+#define ARM_CPU_REV_SA1110_B0		4
+#define ARM_CPU_REV_SA1110_B1		5
+#define ARM_CPU_REV_SA1110_B2		6
+#define ARM_CPU_REV_SA1110_B4		8
+
+#define ARM_CPU_XSCALE_ARCH_MASK	0xe000
+#define ARM_CPU_XSCALE_ARCH_V1		0x2000
+#define ARM_CPU_XSCALE_ARCH_V2		0x4000
+#define ARM_CPU_XSCALE_ARCH_V3		0x6000
+
+/* Qualcomm implemented cores */
+#define ARM_CPU_PART_SCORPION		0x510002d0
+
+#endif
-- 
2.11.0
