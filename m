Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeEFTUU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 15:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751807AbeEFTUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 15:20:14 -0400
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
Subject: [PATCH 1/9] x86/breakpoint: Split validation into "check" and "commit"
Date: Sun,  6 May 2018 21:19:47 +0200
Message-Id: <1525634395-23380-2-git-send-email-frederic@kernel.org>
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

Original-patch-by: Andy Lutomirski <luto@kernel.org>
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
 arch/x86/kernel/hw_breakpoint.c | 137 +++++++++++++++++++++-------------------
 1 file changed, 72 insertions(+), 65 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 8771766..6960800 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -233,20 +233,15 @@ int arch_bp_generic_fields(int x86_len, int x86_type,
 	return 0;
 }
 
-
-static int arch_build_bp_info(struct perf_event *bp)
+static int hw_breakpoint_arch_check(struct perf_event *bp,
+				    const struct perf_event_attr *attr)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	unsigned int align;
 
-	info->address = bp->attr.bp_addr;
-
-	/* Type */
-	switch (bp->attr.bp_type) {
+	/* Check type */
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_W:
-		info->type = X86_BREAKPOINT_WRITE;
-		break;
 	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:
-		info->type = X86_BREAKPOINT_RW;
 		break;
 	case HW_BREAKPOINT_X:
 		/*
@@ -254,33 +249,84 @@ static int arch_build_bp_info(struct perf_event *bp)
 		 * acceptable for kprobes.  On non-kprobes kernels, we don't
 		 * allow kernel breakpoints at all.
 		 */
-		if (bp->attr.bp_addr >= TASK_SIZE_MAX) {
+		if (attr->bp_addr >= TASK_SIZE_MAX) {
 #ifdef CONFIG_KPROBES
-			if (within_kprobe_blacklist(bp->attr.bp_addr))
+			if (within_kprobe_blacklist(attr->bp_addr))
 				return -EINVAL;
 #else
 			return -EINVAL;
 #endif
 		}
 
+		if (attr->bp_len == sizeof(long))
+			return 0;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check len */
+	switch (attr->bp_len) {
+	case HW_BREAKPOINT_LEN_1:
+	case HW_BREAKPOINT_LEN_2:
+	case HW_BREAKPOINT_LEN_4:
+		break;
+#ifdef CONFIG_X86_64
+	case HW_BREAKPOINT_LEN_8:
+		break;
+	default:
+		/* AMD range breakpoint */
+		if (!is_power_of_2(attr->bp_len))
+			return -EINVAL;
+
+		if (!boot_cpu_has(X86_FEATURE_BPEXT))
+			return -EOPNOTSUPP;
+#endif
+	}
+
+	align = attr->bp_len - 1;
+
+	/*
+	 * Check that the low-order bits of the address are appropriate
+	 * for the alignment implied by len.
+	 */
+	if (attr->bp_addr & align)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void hw_breakpoint_arch_commit(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct perf_event_attr *attr = &bp->attr;
+
+	info->address = attr->bp_addr;
+
+	/* Set type */
+	switch (attr->bp_type) {
+	case HW_BREAKPOINT_W:
+		info->type = X86_BREAKPOINT_WRITE;
+		break;
+	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:
+		info->type = X86_BREAKPOINT_RW;
+		break;
+	case HW_BREAKPOINT_X:
 		info->type = X86_BREAKPOINT_EXECUTE;
 		/*
 		 * x86 inst breakpoints need to have a specific undefined len.
 		 * But we still need to check userspace is not trying to setup
 		 * an unsupported length, to get a range breakpoint for example.
 		 */
-		if (bp->attr.bp_len == sizeof(long)) {
-			info->len = X86_BREAKPOINT_LEN_X;
-			return 0;
-		}
+		info->len = X86_BREAKPOINT_LEN_X;
+		return;
 	default:
-		return -EINVAL;
+		WARN_ON_ONCE(1);
 	}
 
-	/* Len */
+	/* Set len */
 	info->mask = 0;
 
-	switch (bp->attr.bp_len) {
+	switch (attr->bp_len) {
 	case HW_BREAKPOINT_LEN_1:
 		info->len = X86_BREAKPOINT_LEN_1;
 		break;
@@ -296,15 +342,6 @@ static int arch_build_bp_info(struct perf_event *bp)
 		break;
 #endif
 	default:
-		/* AMD range breakpoint */
-		if (!is_power_of_2(bp->attr.bp_len))
-			return -EINVAL;
-		if (bp->attr.bp_addr & (bp->attr.bp_len - 1))
-			return -EINVAL;
-
-		if (!boot_cpu_has(X86_FEATURE_BPEXT))
-			return -EOPNOTSUPP;
-
 		/*
 		 * It's impossible to use a range breakpoint to fake out
 		 * user vs kernel detection because bp_len - 1 can't
@@ -312,54 +349,24 @@ static int arch_build_bp_info(struct perf_event *bp)
 		 * breakpoints, then we'll have to check for kprobe-blacklisted
 		 * addresses anywhere in the range.
 		 */
-		info->mask = bp->attr.bp_len - 1;
+		info->mask = attr->bp_len - 1;
 		info->len = X86_BREAKPOINT_LEN_1;
 	}
-
-	return 0;
 }
 
+
 /*
  * Validate the arch-specific HW Breakpoint register settings
  */
 int arch_validate_hwbkpt_settings(struct perf_event *bp)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned int align;
-	int ret;
+	int err;
 
+	err = hw_breakpoint_arch_check(bp, &bp->attr);
+	if (err)
+		return err;
 
-	ret = arch_build_bp_info(bp);
-	if (ret)
-		return ret;
-
-	switch (info->len) {
-	case X86_BREAKPOINT_LEN_1:
-		align = 0;
-		if (info->mask)
-			align = info->mask;
-		break;
-	case X86_BREAKPOINT_LEN_2:
-		align = 1;
-		break;
-	case X86_BREAKPOINT_LEN_4:
-		align = 3;
-		break;
-#ifdef CONFIG_X86_64
-	case X86_BREAKPOINT_LEN_8:
-		align = 7;
-		break;
-#endif
-	default:
-		WARN_ON_ONCE(1);
-	}
-
-	/*
-	 * Check that the low-order bits of the address are appropriate
-	 * for the alignment implied by len.
-	 */
-	if (info->address & align)
-		return -EINVAL;
+	hw_breakpoint_arch_commit(bp);
 
 	return 0;
 }
-- 
2.7.4
