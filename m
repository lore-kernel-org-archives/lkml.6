Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeCaKk4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 06:40:56 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38900 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeCaKky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 06:40:54 -0400
X-Google-Smtp-Source: AIpwx49CitmjUprYBkBEQLO/1bK/36v/ufXkxBoN0ZE8wDB9POZERY5DCuN3Tr1qrygBCN/7s7a0Xw==
Date: Sat, 31 Mar 2018 12:40:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20180331104050.s4lgdw5vozlqgbap@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: f67b15037a7a50c57f72e69a6d59941ad90a0f0f perf/hwbp: Simplify the perf-hwbp code, fix documentation

Two fixlets.

 Thanks,

	Ingo

------------------>
Linus Torvalds (1):
      perf/hwbp: Simplify the perf-hwbp code, fix documentation

Stephane Eranian (1):
      perf/x86/intel: Fix linear IP of PEBS real_ip on Haswell and later CPUs


 arch/x86/events/intel/ds.c    | 25 +++++++++++++++++--------
 kernel/events/hw_breakpoint.c | 30 +++++++-----------------------
 2 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index d8015235ba76..5e526c54247e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1153,6 +1153,7 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	if (pebs == NULL)
 		return;
 
+	regs->flags &= ~PERF_EFLAGS_EXACT;
 	sample_type = event->attr.sample_type;
 	dsrc = sample_type & PERF_SAMPLE_DATA_SRC;
 
@@ -1197,7 +1198,6 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	 */
 	*regs = *iregs;
 	regs->flags = pebs->flags;
-	set_linear_ip(regs, pebs->ip);
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		regs->ax = pebs->ax;
@@ -1233,13 +1233,22 @@ static void setup_pebs_sample_data(struct perf_event *event,
 #endif
 	}
 
-	if (event->attr.precise_ip > 1 && x86_pmu.intel_cap.pebs_format >= 2) {
-		regs->ip = pebs->real_ip;
-		regs->flags |= PERF_EFLAGS_EXACT;
-	} else if (event->attr.precise_ip > 1 && intel_pmu_pebs_fixup_ip(regs))
-		regs->flags |= PERF_EFLAGS_EXACT;
-	else
-		regs->flags &= ~PERF_EFLAGS_EXACT;
+	if (event->attr.precise_ip > 1) {
+		/* Haswell and later have the eventing IP, so use it: */
+		if (x86_pmu.intel_cap.pebs_format >= 2) {
+			set_linear_ip(regs, pebs->real_ip);
+			regs->flags |= PERF_EFLAGS_EXACT;
+		} else {
+			/* Otherwise use PEBS off-by-1 IP: */
+			set_linear_ip(regs, pebs->ip);
+
+			/* ... and try to fix it up using the LBR entries: */
+			if (intel_pmu_pebs_fixup_ip(regs))
+				regs->flags |= PERF_EFLAGS_EXACT;
+		}
+	} else
+		set_linear_ip(regs, pebs->ip);
+
 
 	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR)) &&
 	    x86_pmu.intel_cap.pebs_format >= 1)
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 3f8cb1e14588..253ae2da13c3 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -427,16 +427,9 @@ EXPORT_SYMBOL_GPL(register_user_hw_breakpoint);
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
@@ -451,27 +444,18 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
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
