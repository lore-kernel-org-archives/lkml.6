Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23D2206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfAHOJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:09:47 -0500
Received: from foss.arm.com ([217.140.101.70]:52300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbfAHOIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:08:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B0831AED;
        Tue,  8 Jan 2019 06:08:30 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E6353F70D;
        Tue,  8 Jan 2019 06:08:28 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Christoffer Dall <Christoffer.Dall@arm.com>
Subject: [PATCH v8 14/26] arm64: alternative: Allow alternative status checking per cpufeature
Date:   Tue,  8 Jan 2019 14:07:32 +0000
Message-Id: <1546956464-48825-15-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the application of alternatives at different points
during the boot process, provide the possibility to check whether
alternatives for a feature of interest was already applied instead of
having a global boolean for all alternatives.

Make VHE enablement code check for the VHE feature instead of considering
all alternatives.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Christoffer Dall <Christoffer.Dall@arm.com>
---
 arch/arm64/include/asm/alternative.h |  3 +--
 arch/arm64/kernel/alternative.c      | 21 +++++++++++++++++----
 arch/arm64/kernel/cpufeature.c       |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 4b650ec..9806a23 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -14,8 +14,6 @@
 #include <linux/stddef.h>
 #include <linux/stringify.h>
 
-extern int alternatives_applied;
-
 struct alt_instr {
 	s32 orig_offset;	/* offset to original instruction */
 	s32 alt_offset;		/* offset to replacement instruction */
@@ -28,6 +26,7 @@ typedef void (*alternative_cb_t)(struct alt_instr *alt,
 				 __le32 *origptr, __le32 *updptr, int nr_inst);
 
 void __init apply_alternatives_all(void);
+bool alternative_is_applied(u16 cpufeature);
 
 #ifdef CONFIG_MODULES
 void apply_alternatives_module(void *start, size_t length);
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index b5d6039..c947d22 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -32,13 +32,23 @@
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
 
-int alternatives_applied;
+static int all_alternatives_applied;
+
+static DECLARE_BITMAP(applied_alternatives, ARM64_NCAPS);
 
 struct alt_region {
 	struct alt_instr *begin;
 	struct alt_instr *end;
 };
 
+bool alternative_is_applied(u16 cpufeature)
+{
+	if (WARN_ON(cpufeature >= ARM64_NCAPS))
+		return false;
+
+	return test_bit(cpufeature, applied_alternatives);
+}
+
 /*
  * Check if the target PC is within an alternative block.
  */
@@ -192,6 +202,9 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 		dsb(ish);
 		__flush_icache_all();
 		isb();
+
+		/* We applied all that was available */
+		bitmap_copy(applied_alternatives, cpu_hwcaps, ARM64_NCAPS);
 	}
 }
 
@@ -208,14 +221,14 @@ static int __apply_alternatives_multi_stop(void *unused)
 
 	/* We always have a CPU 0 at this point (__init) */
 	if (smp_processor_id()) {
-		while (!READ_ONCE(alternatives_applied))
+		while (!READ_ONCE(all_alternatives_applied))
 			cpu_relax();
 		isb();
 	} else {
-		BUG_ON(alternatives_applied);
+		BUG_ON(all_alternatives_applied);
 		__apply_alternatives(&region, false);
 		/* Barriers provided by the cache flushing */
-		WRITE_ONCE(alternatives_applied, 1);
+		WRITE_ONCE(all_alternatives_applied, 1);
 	}
 
 	return 0;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c426302..84fa5be 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1113,7 +1113,7 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 	 * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
 	 * do anything here.
 	 */
-	if (!alternatives_applied)
+	if (!alternative_is_applied(ARM64_HAS_VIRT_HOST_EXTN))
 		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
 }
 #endif
-- 
1.9.1

