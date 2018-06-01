Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeFAL3x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:29:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50276 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbeFALYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:24:55 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>
Subject: [PATCHv2 02/19] arm64: move SCTLR_EL{1,2} assertions to <asm/sysreg.h>
Date: Fri,  1 Jun 2018 12:24:24 +0100
Message-Id: <20180601112441.37810-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we assert that the SCTLR_EL{1,2}_{SET,CLEAR} bits are
self-consistent with an assertion in config_sctlr_el1(). This is a bit
unusual, since config_sctlr_el1() doesn't make use of these definitions,
and is far away from the definitions themselves.

We can use the CPP #error directive to have equivalent assertions in
<asm/sysreg.h>, next to the definitions of the set/clear bits, which is
a bit clearer and simpler.

The preprocessor handles literals differently than regular C, e.g. ~0 is
equivalent to ~(intmax_t)0 rather than ~(int)0. Therefore, instead of ~0
we use 0xffffffff, which is unambiguous.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6171178075dc..bd1d1194a5e7 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -452,9 +452,9 @@
 			 SCTLR_ELx_SA     | SCTLR_ELx_I    | SCTLR_ELx_WXN | \
 			 ENDIAN_CLEAR_EL2 | SCTLR_EL2_RES0)
 
-/* Check all the bits are accounted for */
-#define SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != ~0)
-
+#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffff
+#error "Inconsistent SCTLR_EL2 set/clear bits"
+#endif
 
 /* SCTLR_EL1 specific flags. */
 #define SCTLR_EL1_UCI		(1 << 26)
@@ -492,8 +492,9 @@
 			 SCTLR_EL1_UMA | SCTLR_ELx_WXN     | ENDIAN_CLEAR_EL1 |\
 			 SCTLR_EL1_RES0)
 
-/* Check all the bits are accounted for */
-#define SCTLR_EL1_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != ~0)
+#if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffff
+#error "Inconsistent SCTLR_EL1 set/clear bits"
+#endif
 
 /* id_aa64isar0 */
 #define ID_AA64ISAR0_TS_SHIFT		52
@@ -732,9 +733,6 @@ static inline void config_sctlr_el1(u32 clear, u32 set)
 {
 	u32 val;
 
-	SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS;
-	SCTLR_EL1_BUILD_BUG_ON_MISSING_BITS;
-
 	val = read_sysreg(sctlr_el1);
 	val &= ~clear;
 	val |= set;
-- 
2.11.0
