Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeENJwA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:52:00 -0400
Received: from foss.arm.com ([217.140.101.70]:38240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752411AbeENJrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:47:35 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: [PATCH 05/18] arm64: kill change_cpacr()
Date: Mon, 14 May 2018 10:46:27 +0100
Message-Id: <20180514094640.27569-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514094640.27569-1-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 87a35364e750..088940387a4d 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -172,23 +172,14 @@ static void *sve_pffr(struct task_struct *task)
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
