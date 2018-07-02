Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F01C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD3F25524
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD3F25524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030277AbeGBLEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:04:34 -0400
Received: from foss.arm.com ([217.140.101.70]:57468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934201AbeGBLEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:04:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 753FD1650;
        Mon,  2 Jul 2018 04:04:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 64BEA3F5BA;
        Mon,  2 Jul 2018 04:04:28 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, hch@infradead.org, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv4 03/19] arm64: kill config_sctlr_el1()
Date:   Mon,  2 Jul 2018 12:03:59 +0100
Message-Id: <20180702110415.10465-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180702110415.10465-1-mark.rutland@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have sysreg_clear_set(), we can consistently use this
instead of config_sctlr_el1().

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/sysreg.h      | 10 ----------
 arch/arm64/kernel/armv8_deprecated.c |  8 ++++----
 arch/arm64/kernel/cpu_errata.c       |  3 +--
 arch/arm64/kernel/traps.c            |  2 +-
 arch/arm64/mm/fault.c                |  2 +-
 5 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index fefc17dae8ee..e205ec8489e9 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -742,16 +742,6 @@ asm(
 		write_sysreg(__scs_new, sysreg);			\
 } while (0)
 
-static inline void config_sctlr_el1(u32 clear, u32 set)
-{
-	u32 val;
-
-	val = read_sysreg(sctlr_el1);
-	val &= ~clear;
-	val |= set;
-	write_sysreg(val, sctlr_el1);
-}
-
 #endif
 
 #endif	/* __ASM_SYSREG_H */
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index d4707abb2f16..d01c7fc0463c 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -511,9 +511,9 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
 static int cp15_barrier_set_hw_mode(bool enable)
 {
 	if (enable)
-		config_sctlr_el1(0, SCTLR_EL1_CP15BEN);
+		sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_CP15BEN);
 	else
-		config_sctlr_el1(SCTLR_EL1_CP15BEN, 0);
+		sysreg_clear_set(sctlr_el1, SCTLR_EL1_CP15BEN, 0);
 	return 0;
 }
 
@@ -548,9 +548,9 @@ static int setend_set_hw_mode(bool enable)
 		return -EINVAL;
 
 	if (enable)
-		config_sctlr_el1(SCTLR_EL1_SED, 0);
+		sysreg_clear_set(sctlr_el1, SCTLR_EL1_SED, 0);
 	else
-		config_sctlr_el1(0, SCTLR_EL1_SED);
+		sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_SED);
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 1d2b6d768efe..92128ea53102 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -76,8 +76,7 @@ has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
 static void
 cpu_enable_trap_ctr_access(const struct arm64_cpu_capabilities *__unused)
 {
-	/* Clear SCTLR_EL1.UCT */
-	config_sctlr_el1(SCTLR_EL1_UCT, 0);
+	sysreg_clear_set(sctlr_el1, SCTLR_EL1_UCT, 0);
 }
 
 atomic_t arm64_el2_vector_last_slot = ATOMIC_INIT(-1);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d399d459397b..c27292703bd1 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -411,7 +411,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 
 void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 {
-	config_sctlr_el1(SCTLR_EL1_UCI, 0);
+	sysreg_clear_set(sctlr_el1, SCTLR_EL1_UCI, 0);
 }
 
 #define __user_cache_maint(insn, address, res)			\
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b8eecc7b9531..ea591c9e5144 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -879,7 +879,7 @@ void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
 	 */
 	WARN_ON_ONCE(in_interrupt());
 
-	config_sctlr_el1(SCTLR_EL1_SPAN, 0);
+	sysreg_clear_set(sctlr_el1, SCTLR_EL1_SPAN, 0);
 	asm(SET_PSTATE_PAN(1));
 }
 #endif /* CONFIG_ARM64_PAN */
-- 
2.11.0

