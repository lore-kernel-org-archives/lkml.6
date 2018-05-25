Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965832AbeEYJ4x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:56:53 -0400
Received: from foss.arm.com ([217.140.101.70]:57422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965455AbeEYJuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:03 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Christoffer Dall <Christoffer.Dall@arm.com>
Subject: [PATCH v4 03/26] arm64: cpufeature: Use alternatives for VHE cpu_enable
Date: Fri, 25 May 2018 10:49:09 +0100
Message-Id: <1527241772-48007-4-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_enable callback for VHE feature requires all alternatives to have
been applied. This prevents applying VHE alternative separately from the
rest.

Use an alternative depending on VHE feature to know whether VHE
alternatives have already been applied.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Christoffer Dall <Christoffer.Dall@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a177104..a3a5585d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1013,6 +1013,8 @@ static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused
 
 static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 {
+	u64 tmp = 0;
+
 	/*
 	 * Copy register values that aren't redirected by hardware.
 	 *
@@ -1021,8 +1023,15 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 	 * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
 	 * do anything here.
 	 */
-	if (!alternatives_applied)
-		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
+	asm volatile(ALTERNATIVE(
+		"mrs	%0, tpidr_el1\n"
+		"msr	tpidr_el2, %0",
+		"nop\n"
+		"nop",
+		ARM64_HAS_VIRT_HOST_EXTN)
+		: "+r" (tmp)
+		:
+		: "memory");
 }
 #endif
 
-- 
1.9.1
