Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeDEGaG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 02:30:06 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33281 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeDEGaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 02:30:00 -0400
X-Google-Smtp-Source: AIpwx48nczIKe8FLPFJYyRA4f8RuClboaVPKU4wXy9pI+ebDxvOFdwH6Tsy3kdMd8UtlLnGX76drug==
From: Stephane Eranian <eranian@google.com>
To: linux-kernel@vger.kernel.org
Cc: acme@redhat.com, peterz@infradead.org, mingo@elte.hu,
        ak@linux.intel.com, kan.liang@intel.com, jolsa@redhat.com
Subject: [PATCH v2] perf/x86/intel: move regs->flags EXACT bit init
Date: Wed,  4 Apr 2018 23:29:51 -0700
Message-Id: <1522909791-32498-1-git-send-email-eranian@google.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a redundant store on regs->flags introduced
by commit:

71eb9ee9596d ("perf/x86/intel: Fix linear IP of PEBS real_ip on Haswell and later CPUs")

We were clearing the PERF_EFLAGS_EXACT but it was overwritten by
regs->flags = pebs->flags later on.

The PERF_EFLAGS_EXACT is a software flag using bit 3 of regs->flags.
X86 marks this bit as Reserved. To make sure this bit is zero before
we do any IP processing, we clear it explicitly.

Patch also removes the following assignment:
	regs->flags = pebs->flags | (regs->flags & PERF_EFLAGS_VM);

Because there is no regs->flags to preserve anymore because
set_linear_ip() is not called until later.

In V2, we improve reability of the comments.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/ds.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index da6780122786..e4e97fc8eec3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1153,7 +1153,6 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	if (pebs == NULL)
 		return;
 
-	regs->flags &= ~PERF_EFLAGS_EXACT;
 	sample_type = event->attr.sample_type;
 	dsrc = sample_type & PERF_SAMPLE_DATA_SRC;
 
@@ -1197,7 +1196,13 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	 * and PMI.
 	 */
 	*regs = *iregs;
-	regs->flags = pebs->flags;
+
+	/*
+	 * Initialize regs_>flags from PEBS,
+	 * clear exact bit (which uses x86 EFLAGS Reserved bit 3),
+	 * i.e., do not rely on it being zero.
+	 */
+	regs->flags = pebs->flags & ~PERF_EFLAGS_EXACT;
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		regs->ax = pebs->ax;
@@ -1217,10 +1222,6 @@ static void setup_pebs_sample_data(struct perf_event *event,
 			regs->sp = pebs->sp;
 		}
 
-		/*
-		 * Preserve PERF_EFLAGS_VM from set_linear_ip().
-		 */
-		regs->flags = pebs->flags | (regs->flags & PERF_EFLAGS_VM);
 #ifndef CONFIG_X86_32
 		regs->r8 = pebs->r8;
 		regs->r9 = pebs->r9;
@@ -1234,20 +1235,33 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	}
 
 	if (event->attr.precise_ip > 1) {
-		/* Haswell and later have the eventing IP, so use it: */
+		/*
+		 * Haswell and later processors have eventing IP
+		 * which avoids the off-by-1 skid. Use it when
+		 * precise_ip >= 2
+		 */
 		if (x86_pmu.intel_cap.pebs_format >= 2) {
 			set_linear_ip(regs, pebs->real_ip);
 			regs->flags |= PERF_EFLAGS_EXACT;
 		} else {
-			/* Otherwise use PEBS off-by-1 IP: */
+			/* Otherwise, use PEBS off-by-1 IP */
 			set_linear_ip(regs, pebs->ip);
 
-			/* ... and try to fix it up using the LBR entries: */
+			/*
+			 * With precise_ip >= 2, try to fix up the off-by-1 IP
+			 * using the LBR. If successful, the fixup function
+			 * corrects regs->ip and calls set_linear_ip() on regs.
+			 */
 			if (intel_pmu_pebs_fixup_ip(regs))
 				regs->flags |= PERF_EFLAGS_EXACT;
 		}
-	} else
+	} else {
+		/*
+		 * when precise_ip == 1, return the PEBS off-by-1 IP,
+		 * no fixup attempted
+		 */
 		set_linear_ip(regs, pebs->ip);
+	}
 
 
 	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR)) &&
-- 
2.7.4
