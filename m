Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeFALZF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:25:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50294 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbeFALZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:25:00 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>
Subject: [PATCHv2 05/19] arm64: kill change_cpacr()
Date: Fri,  1 Jun 2018 12:24:27 +0100
Message-Id: <20180601112441.37810-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have sysreg_clear_set(), we can use this instead of
change_cpacr().

Note that the order of the set and clear arguments differs between
change_cpacr() and sysreg_clear_set(), so these are flipped as part of
the conversion. Also, sve_user_enable() redundantly clears
CPACR_EL1_ZEN_EL0EN before setting it; this is removed for clarity.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 3db8ed530e56..c135cff8f882 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -171,23 +171,14 @@ static void *sve_pffr(struct task_struct *task)
 		sve_ffr_offset(task->thread.sve_vl);
 }
 
-static void change_cpacr(u64 val, u64 mask)
-{
-	u64 cpacr = read_sysreg(CPACR_EL1);
-	u64 new = (cpacr & ~mask) | val;
-
-	if (new != cpacr)
-		write_sysreg(new, CPACR_EL1);
-}
-
 static void sve_user_disable(void)
 {
-	change_cpacr(0, CPACR_EL1_ZEN_EL0EN);
+	sysreg_clear_set(cpacr_el1, CPACR_EL1_ZEN_EL0EN, 0);
 }
 
 static void sve_user_enable(void)
 {
-	change_cpacr(CPACR_EL1_ZEN_EL0EN, CPACR_EL1_ZEN_EL0EN);
+	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
 }
 
 /*
-- 
2.11.0
