Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeEFTVe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 15:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbeEFTUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 15:20:35 -0400
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
Subject: [PATCH 5/9] xtensa: Split breakpoint validation into "check" and "commit"
Date: Sun,  6 May 2018 21:19:51 +0200
Message-Id: <1525634395-23380-6-git-send-email-frederic@kernel.org>
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
 arch/xtensa/kernel/hw_breakpoint.c | 60 ++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/kernel/hw_breakpoint.c b/arch/xtensa/kernel/hw_breakpoint.c
index b35656a..aae055d 100644
--- a/arch/xtensa/kernel/hw_breakpoint.c
+++ b/arch/xtensa/kernel/hw_breakpoint.c
@@ -45,15 +45,38 @@ int arch_check_bp_in_kernelspace(struct perf_event *bp)
 	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
 }
 
-/*
- * Construct an arch_hw_breakpoint from a perf_event.
- */
-static int arch_build_bp_info(struct perf_event *bp)
+static int hw_breakpoint_arch_check(struct perf_event *bp,
+				    const struct perf_event_attr *attr)
+{
+	/* Type */
+	switch (attr->bp_type) {
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
+	if (attr->bp_len < 1 || attr->bp_len > 64 || !is_power_of_2(attr->bp_len))
+		return -EINVAL;
+
+	/* Address */
+	if (attr->bp_addr & (attr->bp_len - 1))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void hw_breakpoint_arch_commit(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct perf_event_attr *attr = &bp->attr;
 
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_X:
 		info->type = XTENSA_BREAKPOINT_EXECUTE;
 		break;
@@ -67,29 +90,30 @@ static int arch_build_bp_info(struct perf_event *bp)
 		info->type = XTENSA_BREAKPOINT_LOAD | XTENSA_BREAKPOINT_STORE;
 		break;
 	default:
-		return -EINVAL;
+		WARN_ON_ONCE(1);
 	}
 
 	/* Len */
-	info->len = bp->attr.bp_len;
-	if (info->len < 1 || info->len > 64 || !is_power_of_2(info->len))
-		return -EINVAL;
+	info->len = attr->bp_len;
 
 	/* Address */
-	info->address = bp->attr.bp_addr;
-	if (info->address & (info->len - 1))
-		return -EINVAL;
-
-	return 0;
+	info->address = attr->bp_addr;
 }
 
+/*
+ * Validate the arch-specific HW Breakpoint register settings
+ */
 int arch_validate_hwbkpt_settings(struct perf_event *bp)
 {
-	int ret;
+	int err;
 
-	/* Build the arch_hw_breakpoint. */
-	ret = arch_build_bp_info(bp);
-	return ret;
+	err = hw_breakpoint_arch_check(bp, &bp->attr);
+	if (err)
+		return err;
+
+	hw_breakpoint_arch_commit(bp);
+
+	return 0;
 }
 
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
-- 
2.7.4
