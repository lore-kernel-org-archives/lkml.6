Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbeEFTUa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 15:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbeEFTUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 15:20:25 -0400
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
Subject: [PATCH 3/9] sh: Split breakpoint validation into "check" and "commit"
Date: Sun,  6 May 2018 21:19:49 +0200
Message-Id: <1525634395-23380-4-git-send-email-frederic@kernel.org>
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
 arch/sh/kernel/hw_breakpoint.c | 89 ++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index 286c3ab..c89152f 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -174,14 +174,53 @@ int arch_bp_generic_fields(int sh_len, int sh_type,
 	return 0;
 }
 
-static int arch_build_bp_info(struct perf_event *bp)
+static int hw_breakpoint_arch_check(struct perf_event *bp,
+				    const struct perf_event_attr *attr)
+{
+	unsigned int align;
+
+	/* Check type */
+	switch (attr->bp_type) {
+	case HW_BREAKPOINT_W:
+	case HW_BREAKPOINT_R:
+	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check len */
+	switch (attr->bp_len) {
+	case HW_BREAKPOINT_LEN_1:
+	case HW_BREAKPOINT_LEN_2:
+	case HW_BREAKPOINT_LEN_4:
+	case HW_BREAKPOINT_LEN_8:
+		break;
+	default:
+		return -EINVAL;
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
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct perf_event_attr *attr = &bp->attr;
 
-	info->address = bp->attr.bp_addr;
+	info->address = attr->bp_addr;
 
 	/* Len */
-	switch (bp->attr.bp_len) {
+	switch (attr->bp_len) {
 	case HW_BREAKPOINT_LEN_1:
 		info->len = SH_BREAKPOINT_LEN_1;
 		break;
@@ -195,11 +234,11 @@ static int arch_build_bp_info(struct perf_event *bp)
 		info->len = SH_BREAKPOINT_LEN_8;
 		break;
 	default:
-		return -EINVAL;
+		WARN_ON_ONCE(1);
 	}
 
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_R:
 		info->type = SH_BREAKPOINT_READ;
 		break;
@@ -210,10 +249,8 @@ static int arch_build_bp_info(struct perf_event *bp)
 		info->type = SH_BREAKPOINT_RW;
 		break;
 	default:
-		return -EINVAL;
+		WARN_ON_ONCE(1);
 	}
-
-	return 0;
 }
 
 /*
@@ -221,39 +258,13 @@ static int arch_build_bp_info(struct perf_event *bp)
  */
 int arch_validate_hwbkpt_settings(struct perf_event *bp)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned int align;
-	int ret;
+	int err;
 
-	ret = arch_build_bp_info(bp);
-	if (ret)
-		return ret;
+	err = hw_breakpoint_arch_check(bp, &bp->attr);
+	if (err)
+		return err;
 
-	ret = -EINVAL;
-
-	switch (info->len) {
-	case SH_BREAKPOINT_LEN_1:
-		align = 0;
-		break;
-	case SH_BREAKPOINT_LEN_2:
-		align = 1;
-		break;
-	case SH_BREAKPOINT_LEN_4:
-		align = 3;
-		break;
-	case SH_BREAKPOINT_LEN_8:
-		align = 7;
-		break;
-	default:
-		return ret;
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
