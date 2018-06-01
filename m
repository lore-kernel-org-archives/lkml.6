Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeFAOc5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751555AbeFAOcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:32:50 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 06/12] arm64: Implement hw_breakpoint_arch_parse()
Date: Fri,  1 Jun 2018 16:31:59 +0200
Message-Id: <1527863526-32677-7-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527863526-32677-1-git-send-email-frederic@kernel.org>
References: <1527863526-32677-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
that clumsily mixes up architecture validation and commit.

Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
---
 arch/arm64/include/asm/hw_breakpoint.h |  6 ++-
 arch/arm64/kernel/hw_breakpoint.c      | 79 +++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 9f4a3d4..bf9c305 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -119,13 +119,17 @@ static inline void decode_ctrl_reg(u32 reg,
 
 struct task_struct;
 struct notifier_block;
+struct perf_event_attr;
 struct perf_event;
 struct pmu;
 
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 				  int *gen_len, int *gen_type, int *offset);
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_parse(struct perf_event *bp,
+				    const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 92c6973..6114660 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -421,53 +421,53 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 /*
  * Construct an arch_hw_breakpoint from a perf_event.
  */
-static int arch_build_bp_info(struct perf_event *bp)
+static int arch_build_bp_info(struct perf_event *bp,
+			      const struct perf_event_attr *attr,
+			      struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_X:
-		info->ctrl.type = ARM_BREAKPOINT_EXECUTE;
+		hw->ctrl.type = ARM_BREAKPOINT_EXECUTE;
 		break;
 	case HW_BREAKPOINT_R:
-		info->ctrl.type = ARM_BREAKPOINT_LOAD;
+		hw->ctrl.type = ARM_BREAKPOINT_LOAD;
 		break;
 	case HW_BREAKPOINT_W:
-		info->ctrl.type = ARM_BREAKPOINT_STORE;
+		hw->ctrl.type = ARM_BREAKPOINT_STORE;
 		break;
 	case HW_BREAKPOINT_RW:
-		info->ctrl.type = ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
+		hw->ctrl.type = ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* Len */
-	switch (bp->attr.bp_len) {
+	switch (attr->bp_len) {
 	case HW_BREAKPOINT_LEN_1:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_1;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_1;
 		break;
 	case HW_BREAKPOINT_LEN_2:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_2;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_2;
 		break;
 	case HW_BREAKPOINT_LEN_3:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_3;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_3;
 		break;
 	case HW_BREAKPOINT_LEN_4:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_4;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_4;
 		break;
 	case HW_BREAKPOINT_LEN_5:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_5;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_5;
 		break;
 	case HW_BREAKPOINT_LEN_6:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_6;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_6;
 		break;
 	case HW_BREAKPOINT_LEN_7:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_7;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_7;
 		break;
 	case HW_BREAKPOINT_LEN_8:
-		info->ctrl.len = ARM_BREAKPOINT_LEN_8;
+		hw->ctrl.len = ARM_BREAKPOINT_LEN_8;
 		break;
 	default:
 		return -EINVAL;
@@ -478,37 +478,37 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * AArch32 also requires breakpoints of length 2 for Thumb.
 	 * Watchpoints can be of length 1, 2, 4 or 8 bytes.
 	 */
-	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
+	if (hw->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
 		if (is_compat_bp(bp)) {
-			if (info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
-			    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
+			if (hw->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
+			    hw->ctrl.len != ARM_BREAKPOINT_LEN_4)
 				return -EINVAL;
-		} else if (info->ctrl.len != ARM_BREAKPOINT_LEN_4) {
+		} else if (hw->ctrl.len != ARM_BREAKPOINT_LEN_4) {
 			/*
 			 * FIXME: Some tools (I'm looking at you perf) assume
 			 *	  that breakpoints should be sizeof(long). This
 			 *	  is nonsense. For now, we fix up the parameter
 			 *	  but we should probably return -EINVAL instead.
 			 */
-			info->ctrl.len = ARM_BREAKPOINT_LEN_4;
+			hw->ctrl.len = ARM_BREAKPOINT_LEN_4;
 		}
 	}
 
 	/* Address */
-	info->address = bp->attr.bp_addr;
+	hw->address = attr->bp_addr;
 
 	/*
 	 * Privilege
 	 * Note that we disallow combined EL0/EL1 breakpoints because
 	 * that would complicate the stepping code.
 	 */
-	if (arch_check_bp_in_kernelspace(info))
-		info->ctrl.privilege = AARCH64_BREAKPOINT_EL1;
+	if (arch_check_bp_in_kernelspace(hw))
+		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL1;
 	else
-		info->ctrl.privilege = AARCH64_BREAKPOINT_EL0;
+		hw->ctrl.privilege = AARCH64_BREAKPOINT_EL0;
 
 	/* Enabled? */
-	info->ctrl.enabled = !bp->attr.disabled;
+	hw->ctrl.enabled = !attr->disabled;
 
 	return 0;
 }
@@ -516,14 +516,15 @@ static int arch_build_bp_info(struct perf_event *bp)
 /*
  * Validate the arch-specific HW Breakpoint register settings.
  */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	int ret;
 	u64 alignment_mask, offset;
 
 	/* Build the arch_hw_breakpoint. */
-	ret = arch_build_bp_info(bp);
+	ret = arch_build_bp_info(bp, attr, hw);
 	if (ret)
 		return ret;
 
@@ -537,42 +538,42 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * that here.
 	 */
 	if (is_compat_bp(bp)) {
-		if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
+		if (hw->ctrl.len == ARM_BREAKPOINT_LEN_8)
 			alignment_mask = 0x7;
 		else
 			alignment_mask = 0x3;
-		offset = info->address & alignment_mask;
+		offset = hw->address & alignment_mask;
 		switch (offset) {
 		case 0:
 			/* Aligned */
 			break;
 		case 1:
 			/* Allow single byte watchpoint. */
-			if (info->ctrl.len == ARM_BREAKPOINT_LEN_1)
+			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
 				break;
 		case 2:
 			/* Allow halfword watchpoints and breakpoints. */
-			if (info->ctrl.len == ARM_BREAKPOINT_LEN_2)
+			if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
 				break;
 		default:
 			return -EINVAL;
 		}
 	} else {
-		if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE)
+		if (hw->ctrl.type == ARM_BREAKPOINT_EXECUTE)
 			alignment_mask = 0x3;
 		else
 			alignment_mask = 0x7;
-		offset = info->address & alignment_mask;
+		offset = hw->address & alignment_mask;
 	}
 
-	info->address &= ~alignment_mask;
-	info->ctrl.len <<= offset;
+	hw->address &= ~alignment_mask;
+	hw->ctrl.len <<= offset;
 
 	/*
 	 * Disallow per-task kernel breakpoints since these would
 	 * complicate the stepping code.
 	 */
-	if (info->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
+	if (hw->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
 		return -EINVAL;
 
 	return 0;
-- 
2.7.4
