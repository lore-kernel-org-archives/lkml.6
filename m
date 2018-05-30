Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeE3L0t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:26:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33294 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751256AbeE3LYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:24:34 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Stephane Eranian" <eranian@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Frederic Weisbecker" <fweisbec@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Vince Weaver" <vincent.weaver@maine.edu>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.339323268@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 026/153] perf/hwbp: Simplify the perf-hwbp code, fix
 documentation
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit f67b15037a7a50c57f72e69a6d59941ad90a0f0f upstream.

Annoyingly, modify_user_hw_breakpoint() unnecessarily complicates the
modification of a breakpoint - simplify it and remove the pointless
local variables.

Also update the stale Docbook while at it.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/events/hw_breakpoint.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -443,16 +443,9 @@ EXPORT_SYMBOL_GPL(register_user_hw_break
  * modify_user_hw_breakpoint - modify a user-space hardware breakpoint
  * @bp: the breakpoint structure to modify
  * @attr: new breakpoint attributes
- * @triggered: callback to trigger when we hit the breakpoint
- * @tsk: pointer to 'task_struct' of the process to which the address belongs
  */
 int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr)
 {
-	u64 old_addr = bp->attr.bp_addr;
-	u64 old_len = bp->attr.bp_len;
-	int old_type = bp->attr.bp_type;
-	int err = 0;
-
 	/*
 	 * modify_user_hw_breakpoint can be invoked with IRQs disabled and hence it
 	 * will not be possible to raise IPIs that invoke __perf_event_disable.
@@ -467,27 +460,18 @@ int modify_user_hw_breakpoint(struct per
 	bp->attr.bp_addr = attr->bp_addr;
 	bp->attr.bp_type = attr->bp_type;
 	bp->attr.bp_len = attr->bp_len;
+	bp->attr.disabled = 1;
 
-	if (attr->disabled)
-		goto end;
-
-	err = validate_hw_breakpoint(bp);
-	if (!err)
-		perf_event_enable(bp);
+	if (!attr->disabled) {
+		int err = validate_hw_breakpoint(bp);
 
-	if (err) {
-		bp->attr.bp_addr = old_addr;
-		bp->attr.bp_type = old_type;
-		bp->attr.bp_len = old_len;
-		if (!bp->attr.disabled)
-			perf_event_enable(bp);
+		if (err)
+			return err;
 
-		return err;
+		perf_event_enable(bp);
+		bp->attr.disabled = 0;
 	}
 
-end:
-	bp->attr.disabled = attr->disabled;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
