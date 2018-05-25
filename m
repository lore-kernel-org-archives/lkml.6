Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965996AbeEYJuT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:50:19 -0400
Received: from foss.arm.com ([217.140.101.70]:57480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965485AbeEYJuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:15 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 08/26] arm64: daifflags: Use irqflags functions for daifflags
Date: Fri, 25 May 2018 10:49:14 +0100
Message-Id: <1527241772-48007-9-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the work done in daifflags save/restore is already provided
by irqflags functions. Daifflags should always be a superset of irqflags
(it handles irq status + status of other flags). Modifying behaviour of
irqflags should alter the behaviour of daifflags.

Use irqflags_save/restore functions for the corresponding daifflags
operation.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/daifflags.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

Note:
A latter patch changes the behaviour of arch_local_flags but the daif
flag still need to follow the semantics of arch_local_flags.

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 22e4c83..8d91f22 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -36,11 +36,8 @@ static inline unsigned long local_daif_save(void)
 {
 	unsigned long flags;

-	asm volatile(
-		"mrs	%0, daif		// local_daif_save\n"
-		: "=r" (flags)
-		:
-		: "memory");
+	flags = arch_local_save_flags();
+
 	local_daif_mask();

 	return flags;
@@ -60,11 +57,9 @@ static inline void local_daif_restore(unsigned long flags)
 {
 	if (!arch_irqs_disabled_flags(flags))
 		trace_hardirqs_on();
-	asm volatile(
-		"msr	daif, %0		// local_daif_restore"
-		:
-		: "r" (flags)
-		: "memory");
+
+	arch_local_irq_restore(flags);
+
 	if (arch_irqs_disabled_flags(flags))
 		trace_hardirqs_off();
 }
--
1.9.1
