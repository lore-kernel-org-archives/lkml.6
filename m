Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966213AbeEYJyB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:54:01 -0400
Received: from foss.arm.com ([217.140.101.70]:57564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966119AbeEYJue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:34 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 16/26] arm64: daifflags: Include PMR in daifflags restore operations
Date: Fri, 25 May 2018 10:49:22 +0100
Message-Id: <1527241772-48007-17-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addition of PMR should not bypass the semantics of daifflags.

When DA_F are set, I bit is also set as no interrupts (even of higher
priority) is allowed.

When DA_F are cleared, I bit is cleared and interrupt enabling/disabling
goes through ICC_PMR_EL1.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/daifflags.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 8d91f22..3ae8139 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -18,8 +18,17 @@
 
 #include <linux/irqflags.h>
 
-#define DAIF_PROCCTX		0
-#define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
+#include <asm/arch_gicv3.h>
+
+#define DAIF_PROCCTX							\
+	(gic_prio_masking_enabled() ?					\
+		MAKE_ARCH_FLAGS(0, ICC_PMR_EL1_UNMASKED) :		\
+		0)
+
+#define DAIF_PROCCTX_NOIRQ						\
+	(gic_prio_masking_enabled() ?					\
+		MAKE_ARCH_FLAGS(0, ICC_PMR_EL1_MASKED) :		\
+		PSR_I_BIT)
 
 /* mask/save/unmask/restore all exceptions, including interrupts. */
 static inline void local_daif_mask(void)
@@ -51,6 +60,10 @@ static inline void local_daif_unmask(void)
 		:
 		:
 		: "memory");
+
+	/* Unmask IRQs in PMR if needed */
+	if (gic_prio_masking_enabled())
+		arch_local_irq_enable();
 }
 
 static inline void local_daif_restore(unsigned long flags)
-- 
1.9.1
