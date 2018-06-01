Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeFAOc2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbeFAOcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:32:24 -0400
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
Subject: [PATCH 01/12] perf/breakpoint: Split attribute parse and commit
Date: Fri,  1 Jun 2018 16:31:54 +0200
Message-Id: <1527863526-32677-2-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527863526-32677-1-git-send-email-frederic@kernel.org>
References: <1527863526-32677-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_validate_hwbkpt_settings() mixes up attribute check and commit into
a single code entity. Therefore the validation may return an error due to
incorrect atributes while still leaving halfway modified architecture
breakpoint data.

This is harmless when we deal with a new breakpoint but it becomes a
problem when we modify an existing breakpoint.

Split attribute parse and commit to fix that. The architecture is
passed a "struct arch_hw_breakpoint" to fill on top of the new attr
and the core takes care about copying the backend data once it's fully
validated. The architectures then need to implement the new API.

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
Cc: Joel Fernandes <joel.opensrc@gmail.com>
---
 kernel/events/hw_breakpoint.c | 57 +++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6e28d28..314e2a9 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -400,16 +400,35 @@ int dbg_release_bp_slot(struct perf_event *bp)
 	return 0;
 }
 
-static int validate_hw_breakpoint(struct perf_event *bp)
+#ifndef hw_breakpoint_arch_parse
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	int ret;
+	int err;
 
-	ret = arch_validate_hwbkpt_settings(bp);
-	if (ret)
-		return ret;
+	err = arch_validate_hwbkpt_settings(bp);
+	if (err)
+		return err;
+
+	*hw = bp->hw.info;
+
+	return 0;
+}
+#endif
+
+static int hw_breakpoint_parse(struct perf_event *bp,
+			       const struct perf_event_attr *attr,
+			       struct arch_hw_breakpoint *hw)
+{
+	int err;
+
+	err = hw_breakpoint_arch_parse(bp, attr, hw);
+	if (err)
+		return err;
 
 	if (arch_check_bp_in_kernelspace(bp)) {
-		if (bp->attr.exclude_kernel)
+		if (attr->exclude_kernel)
 			return -EINVAL;
 		/*
 		 * Don't let unprivileged users set a breakpoint in the trap
@@ -424,19 +443,22 @@ static int validate_hw_breakpoint(struct perf_event *bp)
 
 int register_perf_hw_breakpoint(struct perf_event *bp)
 {
-	int ret;
+	struct arch_hw_breakpoint hw;
+	int err;
 
-	ret = reserve_bp_slot(bp);
-	if (ret)
-		return ret;
+	err = reserve_bp_slot(bp);
+	if (err)
+		return err;
 
-	ret = validate_hw_breakpoint(bp);
-
-	/* if arch_validate_hwbkpt_settings() fails then release bp slot */
-	if (ret)
+	err = hw_breakpoint_parse(bp, &bp->attr, &hw);
+	if (err) {
 		release_bp_slot(bp);
+		return err;
+	}
 
-	return ret;
+	bp->hw.info = hw;
+
+	return 0;
 }
 
 /**
@@ -464,6 +486,7 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 	u64 old_len  = bp->attr.bp_len;
 	int old_type = bp->attr.bp_type;
 	bool modify  = attr->bp_type != old_type;
+	struct arch_hw_breakpoint hw;
 	int err = 0;
 
 	bp->attr.bp_addr = attr->bp_addr;
@@ -473,7 +496,7 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 	if (check && memcmp(&bp->attr, attr, sizeof(*attr)))
 		return -EINVAL;
 
-	err = validate_hw_breakpoint(bp);
+	err = hw_breakpoint_parse(bp, attr, &hw);
 	if (!err && modify)
 		err = modify_bp_slot(bp, old_type);
 
@@ -484,7 +507,9 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 		return err;
 	}
 
+	bp->hw.info = hw;
 	bp->attr.disabled = attr->disabled;
+
 	return 0;
 }
 
-- 
2.7.4
