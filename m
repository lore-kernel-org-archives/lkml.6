Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeEFTUn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 15:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751825AbeEFTUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 15:20:40 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 6/9] arm64: Split breakpoint validation into "check" and "commit"
Date: Sun,  6 May 2018 21:19:52 +0200
Message-Id: <1525634395-23380-7-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525634395-23380-1-git-send-email-frederic@kernel.org>
References: <1525634395-23380-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The breakpoint code mixes up attribute check and commit into a single
code entity. Therefore the validation may return an error due to
incorrect atributes while still leaving halfway modified architecture
breakpoint struct.

Prepare fox fixing this misdesign and separate both logics.

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
---
 arch/arm64/kernel/hw_breakpoint.c | 183 +++++++++++++++++++++++++-------------
 1 file changed, 122 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 74bb56f..fa02995 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -419,15 +419,114 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 	return 0;
 }
 
+static int hw_breakpoint_arch_check(struct perf_event *bp,
+				    const struct perf_event_attr *attr)
+{
+	u64 addr = attr->bp_addr, len = attr->bp_len;
+	u32 type = attr->bp_type;
+
+	/* Type */
+	switch (type) {
+	case HW_BREAKPOINT_X:
+	case HW_BREAKPOINT_R:
+	case HW_BREAKPOINT_W:
+	case HW_BREAKPOINT_RW:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Len */
+	switch (len) {
+	case HW_BREAKPOINT_LEN_1:
+	case HW_BREAKPOINT_LEN_2:
+	case HW_BREAKPOINT_LEN_3:
+	case HW_BREAKPOINT_LEN_4:
+	case HW_BREAKPOINT_LEN_5:
+	case HW_BREAKPOINT_LEN_6:
+	case HW_BREAKPOINT_LEN_7:
+	case HW_BREAKPOINT_LEN_8:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * On AArch64, we only permit breakpoints of length 4, whereas
+	 * AArch32 also requires breakpoints of length 2 for Thumb.
+	 * Watchpoints can be of length 1, 2, 4 or 8 bytes.
+	 */
+	if (type == HW_BREAKPOINT_X) {
+		if (is_compat_bp(bp)) {
+			if (len != HW_BREAKPOINT_LEN_2 &&
+			    len != HW_BREAKPOINT_LEN_4)
+				return -EINVAL;
+		} else if (len != HW_BREAKPOINT_LEN_4) {
+			/*
+			 * FIXME: Some tools (I'm looking at you perf) assume
+			 *	  that breakpoints should be sizeof(long). This
+			 *	  is nonsense. For now, we fix up the parameter
+			 *	  but we should probably return -EINVAL instead.
+			 */
+			len = HW_BREAKPOINT_LEN_4;
+		}
+	}
+
+	/*
+	 * Check address alignment.
+	 * We don't do any clever alignment correction for watchpoints
+	 * because using 64-bit unaligned addresses is deprecated for
+	 * AArch64.
+	 *
+	 * AArch32 tasks expect some simple alignment fixups, so emulate
+	 * that here.
+	 */
+	if (is_compat_bp(bp)) {
+		u64 alignment_mask, offset;
+
+		if (len == HW_BREAKPOINT_LEN_8)
+			alignment_mask = 0x7;
+		else
+			alignment_mask = 0x3;
+		offset = addr & alignment_mask;
+		switch (offset) {
+		case 0:
+			/* Aligned */
+			break;
+		case 1:
+			/* Allow single byte watchpoint. */
+			if (len == HW_BREAKPOINT_LEN_1)
+				break;
+		case 2:
+			/* Allow halfword watchpoints and breakpoints. */
+			if (len == HW_BREAKPOINT_LEN_2)
+				break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * Disallow per-task kernel breakpoints since these would
+	 * complicate the stepping code.
+	 */
+	if (arch_check_bp_in_kernelspace(bp) && bp->hw.target)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * Construct an arch_hw_breakpoint from a perf_event.
  */
-static int arch_build_bp_info(struct perf_event *bp)
+static void hw_breakpoint_arch_commit(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct perf_event_attr *attr = &bp->attr;
+	u64 alignment_mask, offset;
 
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_X:
 		info->ctrl.type = ARM_BREAKPOINT_EXECUTE;
 		break;
@@ -441,11 +540,11 @@ static int arch_build_bp_info(struct perf_event *bp)
 		info->ctrl.type = ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
 		break;
 	default:
-		return -EINVAL;
+		WARN_ON_ONCE(1);
 	}
 
 	/* Len */
-	switch (bp->attr.bp_len) {
+	switch (attr->bp_len) {
 	case HW_BREAKPOINT_LEN_1:
 		info->ctrl.len = ARM_BREAKPOINT_LEN_1;
 		break;
@@ -471,7 +570,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 		info->ctrl.len = ARM_BREAKPOINT_LEN_8;
 		break;
 	default:
-		return -EINVAL;
+		WARN_ON_ONCE(1);
 	}
 
 	/*
@@ -480,11 +579,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * Watchpoints can be of length 1, 2, 4 or 8 bytes.
 	 */
 	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
-		if (is_compat_bp(bp)) {
-			if (info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
-			    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
-				return -EINVAL;
-		} else if (info->ctrl.len != ARM_BREAKPOINT_LEN_4) {
+		if (!is_compat_bp(bp) && info->ctrl.len != ARM_BREAKPOINT_LEN_4) {
 			/*
 			 * FIXME: Some tools (I'm looking at you perf) assume
 			 *	  that breakpoints should be sizeof(long). This
@@ -496,7 +591,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 	}
 
 	/* Address */
-	info->address = bp->attr.bp_addr;
+	info->address = attr->bp_addr;
 
 	/*
 	 * Privilege
@@ -509,72 +604,38 @@ static int arch_build_bp_info(struct perf_event *bp)
 		info->ctrl.privilege = AARCH64_BREAKPOINT_EL0;
 
 	/* Enabled? */
-	info->ctrl.enabled = !bp->attr.disabled;
+	info->ctrl.enabled = !attr->disabled;
 
-	return 0;
-}
-
-/*
- * Validate the arch-specific HW Breakpoint register settings.
- */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
-{
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	int ret;
-	u64 alignment_mask, offset;
-
-	/* Build the arch_hw_breakpoint. */
-	ret = arch_build_bp_info(bp);
-	if (ret)
-		return ret;
-
-	/*
-	 * Check address alignment.
-	 * We don't do any clever alignment correction for watchpoints
-	 * because using 64-bit unaligned addresses is deprecated for
-	 * AArch64.
-	 *
-	 * AArch32 tasks expect some simple alignment fixups, so emulate
-	 * that here.
-	 */
 	if (is_compat_bp(bp)) {
 		if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
 			alignment_mask = 0x7;
 		else
 			alignment_mask = 0x3;
-		offset = info->address & alignment_mask;
-		switch (offset) {
-		case 0:
-			/* Aligned */
-			break;
-		case 1:
-			/* Allow single byte watchpoint. */
-			if (info->ctrl.len == ARM_BREAKPOINT_LEN_1)
-				break;
-		case 2:
-			/* Allow halfword watchpoints and breakpoints. */
-			if (info->ctrl.len == ARM_BREAKPOINT_LEN_2)
-				break;
-		default:
-			return -EINVAL;
-		}
 	} else {
 		if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE)
 			alignment_mask = 0x3;
 		else
 			alignment_mask = 0x7;
-		offset = info->address & alignment_mask;
 	}
 
+	offset = info->address & alignment_mask;
+
 	info->address &= ~alignment_mask;
 	info->ctrl.len <<= offset;
+}
 
-	/*
-	 * Disallow per-task kernel breakpoints since these would
-	 * complicate the stepping code.
-	 */
-	if (info->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
-		return -EINVAL;
+/*
+ * Validate the arch-specific HW Breakpoint register settings
+ */
+int arch_validate_hwbkpt_settings(struct perf_event *bp)
+{
+	int err;
+
+	err = hw_breakpoint_arch_check(bp, &bp->attr);
+	if (err)
+		return err;
+
+	hw_breakpoint_arch_commit(bp);
 
 	return 0;
 }
-- 
2.7.4
