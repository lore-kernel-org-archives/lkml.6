Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeFAOeK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752690AbeFAOdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:33:06 -0400
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
Subject: [PATCH 09/12] xtensa: Implement hw_breakpoint_arch_parse()
Date: Fri,  1 Jun 2018 16:32:02 +0200
Message-Id: <1527863526-32677-10-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527863526-32677-1-git-send-email-frederic@kernel.org>
References: <1527863526-32677-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
that clumsily mixes up architecture validation and commit

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
 arch/xtensa/include/asm/hw_breakpoint.h |  6 +++++-
 arch/xtensa/kernel/hw_breakpoint.c      | 33 ++++++++++++---------------------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/include/asm/hw_breakpoint.h
index 2525bf6..f347c21 100644
--- a/arch/xtensa/include/asm/hw_breakpoint.h
+++ b/arch/xtensa/include/asm/hw_breakpoint.h
@@ -30,13 +30,17 @@ struct arch_hw_breakpoint {
 	u16 type;
 };
 
+struct perf_event_attr;
 struct perf_event;
 struct pt_regs;
 struct task_struct;
 
 int hw_breakpoint_slots(int type);
 int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-int arch_validate_hwbkpt_settings(struct perf_event *bp);
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data);
 
diff --git a/arch/xtensa/kernel/hw_breakpoint.c b/arch/xtensa/kernel/hw_breakpoint.c
index 6e34c38..c2e387c 100644
--- a/arch/xtensa/kernel/hw_breakpoint.c
+++ b/arch/xtensa/kernel/hw_breakpoint.c
@@ -47,50 +47,41 @@ int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 /*
  * Construct an arch_hw_breakpoint from a perf_event.
  */
-static int arch_build_bp_info(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_X:
-		info->type = XTENSA_BREAKPOINT_EXECUTE;
+		hw->type = XTENSA_BREAKPOINT_EXECUTE;
 		break;
 	case HW_BREAKPOINT_R:
-		info->type = XTENSA_BREAKPOINT_LOAD;
+		hw->type = XTENSA_BREAKPOINT_LOAD;
 		break;
 	case HW_BREAKPOINT_W:
-		info->type = XTENSA_BREAKPOINT_STORE;
+		hw->type = XTENSA_BREAKPOINT_STORE;
 		break;
 	case HW_BREAKPOINT_RW:
-		info->type = XTENSA_BREAKPOINT_LOAD | XTENSA_BREAKPOINT_STORE;
+		hw->type = XTENSA_BREAKPOINT_LOAD | XTENSA_BREAKPOINT_STORE;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* Len */
-	info->len = bp->attr.bp_len;
-	if (info->len < 1 || info->len > 64 || !is_power_of_2(info->len))
+	hw->len = attr->bp_len;
+	if (hw->len < 1 || hw->len > 64 || !is_power_of_2(hw->len))
 		return -EINVAL;
 
 	/* Address */
-	info->address = bp->attr.bp_addr;
-	if (info->address & (info->len - 1))
+	hw->address = attr->bp_addr;
+	if (hw->address & (hw->len - 1))
 		return -EINVAL;
 
 	return 0;
 }
 
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
-{
-	int ret;
-
-	/* Build the arch_hw_breakpoint. */
-	ret = arch_build_bp_info(bp);
-	return ret;
-}
-
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data)
 {
-- 
2.7.4
