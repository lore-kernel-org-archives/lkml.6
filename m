Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbeEFTVA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 15:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751825AbeEFTUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 15:20:55 -0400
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
Subject: [PATCH 9/9] perf/breakpoint: Only commit breakpoint to arch upon slot reservation success
Date: Sun,  6 May 2018 21:19:55 +0200
Message-Id: <1525634395-23380-10-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525634395-23380-1-git-send-email-frederic@kernel.org>
References: <1525634395-23380-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When slot reservation fails on breakpoint modification, we restore the
breakpoint previous state but only halfway as the architecture structure
isn't cleaned up. It should be harmless as the breakpoint has to be
deactivated at this point. But it's a terrible misdesign.

Now that we have split the attribute check and commit code, we can avoid
commiting a breakpoint to the architecture until its slot reservation
has been accepted and completed.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
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
 kernel/events/hw_breakpoint.c | 77 ++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6896ceeb..f5fbc76 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -400,14 +400,14 @@ int dbg_release_bp_slot(struct perf_event *bp)
 	return 0;
 }
 
-static int validate_hw_breakpoint(struct perf_event *bp)
+static int hw_breakpoint_check(struct perf_event *bp,
+			       const struct perf_event_attr *attr)
 {
 	int err;
 
-	err = hw_breakpoint_arch_check(bp, &bp->attr);
+	err = hw_breakpoint_arch_check(bp, attr);
 	if (err)
 		return err;
-	hw_breakpoint_arch_commit(bp);
 
 	if (arch_check_bp_in_kernelspace(bp)) {
 		if (bp->attr.exclude_kernel)
@@ -425,19 +425,21 @@ static int validate_hw_breakpoint(struct perf_event *bp)
 
 int register_perf_hw_breakpoint(struct perf_event *bp)
 {
-	int ret;
+	int err;
 
-	ret = reserve_bp_slot(bp);
-	if (ret)
-		return ret;
+	err = reserve_bp_slot(bp);
+	if (err)
+		return err;
 
-	ret = validate_hw_breakpoint(bp);
-
-	/* if hw_breakpoint_arch_check() fails then release bp slot */
-	if (ret)
+	err = hw_breakpoint_check(bp, &bp->attr);
+	if (err) {
 		release_bp_slot(bp);
+		return err;
+	}
 
-	return ret;
+	hw_breakpoint_arch_commit(bp);
+
+	return 0;
 }
 
 /**
@@ -457,35 +459,44 @@ register_user_hw_breakpoint(struct perf_event_attr *attr,
 }
 EXPORT_SYMBOL_GPL(register_user_hw_breakpoint);
 
+static void hw_breakpoint_copy_attr(struct perf_event_attr *to,
+				    struct perf_event_attr *from)
+{
+	to->bp_addr = from->bp_addr;
+	to->bp_type = from->bp_type;
+	to->bp_len  = from->bp_len;
+	to->disabled = from->disabled;
+}
+
 int
 modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
 			        bool check)
 {
-	u64 old_addr = bp->attr.bp_addr;
-	u64 old_len  = bp->attr.bp_len;
-	int old_type = bp->attr.bp_type;
-	bool modify  = attr->bp_type != old_type;
-	int err = 0;
+	int err;
 
-	bp->attr.bp_addr = attr->bp_addr;
-	bp->attr.bp_type = attr->bp_type;
-	bp->attr.bp_len  = attr->bp_len;
-
-	if (check && memcmp(&bp->attr, attr, sizeof(*attr)))
-		return -EINVAL;
-
-	err = validate_hw_breakpoint(bp);
-	if (!err && modify)
-		err = modify_bp_slot(bp, old_type);
-
-	if (err) {
-		bp->attr.bp_addr = old_addr;
-		bp->attr.bp_type = old_type;
-		bp->attr.bp_len  = old_len;
+	err = hw_breakpoint_check(bp, attr);
+	if (err)
 		return err;
+
+	if (check) {
+		struct perf_event_attr old_attr;
+
+		old_attr = bp->attr;
+		hw_breakpoint_copy_attr(&old_attr, attr);
+
+		if (memcmp(&old_attr, attr, sizeof(*attr)))
+			return -EINVAL;
 	}
 
-	bp->attr.disabled = attr->disabled;
+	if (bp->attr.bp_type != attr->bp_type) {
+		err = modify_bp_slot(bp, bp->attr.bp_type);
+		if (err)
+			return err;
+	}
+
+	hw_breakpoint_copy_attr(&bp->attr, attr);
+	hw_breakpoint_arch_commit(bp);
+
 	return 0;
 }
 
-- 
2.7.4
