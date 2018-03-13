Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933042AbeCML4s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:56:48 -0400
Received: from foss.arm.com ([217.140.101.70]:36342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932963AbeCMLvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:51:47 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, dave.martin@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        ckadabi@codeaurora.org, robin.murphy@arm.com, shankerd@codeaurora.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 02/22] arm64: capabilities: Move errata work around check on boot CPU
Date: Tue, 13 Mar 2018 11:51:00 +0000
Message-Id: <20180313115120.17256-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313115120.17256-1-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We trigger CPU errata work around check on the boot CPU from
smp_prepare_boot_cpu() to make sure that we run the checks only
after the CPU feature infrastructure is initialised. While this
is correct, we can also do this from init_cpu_features() which
initilises the infrastructure, and is called only on the
Boot CPU. This helps to consolidate the CPU capability handling
to cpufeature.c. No functional changes.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 6 ++++++
 arch/arm64/kernel/smp.c        | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b8821234bc68..14c8348d488a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -548,6 +548,12 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
 		sve_init_vq_map();
 	}
+
+	/*
+	 * Run the errata work around checks on the boot CPU, once we have
+	 * initialised the cpu feature infrastructure.
+	 */
+	update_cpu_errata_workarounds();
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3b8ad7be9c33..5cef11450183 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -448,12 +448,6 @@ void __init smp_prepare_boot_cpu(void)
 	jump_label_init();
 	cpuinfo_store_boot_cpu();
 	save_boot_cpu_run_el();
-	/*
-	 * Run the errata work around checks on the boot CPU, once we have
-	 * initialised the cpu feature infrastructure from
-	 * cpuinfo_store_boot_cpu() above.
-	 */
-	update_cpu_errata_workarounds();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
-- 
2.14.3
