Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCWHCB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:02:01 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43779 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCWHCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:02:00 -0400
X-Google-Smtp-Source: AG47ELvTAYUbIvqhnjyKznei6MZutcslRJMwdws0rKbxFWkuRf/0Qt21xHMISCTuw7JDgBtIuYzkEA==
From: Stephane Eranian <eranian@google.com>
To: linux-kernel@vger.kernel.org
Cc: acme@redhat.com, peterz@infradead.org, mingo@elte.hu,
        ak@linux.intel.com, kan.liang@intel.com, jolsa@redhat.com
Subject: [PATCH] perf/x86/intel: fix linear IP of PEBS real_ip
Date: Fri, 23 Mar 2018 00:01:47 -0700
Message-Id: <1521788507-10231-1-git-send-email-eranian@google.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch fix a bug in how the pebs->real_ip is handled in the PEBS
handler. real_ip only exists in Haswell and later processor. It is
actually the eventing ip, i.e., where the event occurred. As opposed
to the pebs->ip which is the PEBS interrupt IP which is always off
by one.

The problem is that the real_ip just like the pi needs to be fixed up
because PEBS does not record all the machine state registers, and
in particular the code segement (cs). This is why we have the set_linear_ip()
function. The problem was that set_linear_ip() was only used on the pebs->ip
and not the pebs->real_ip.

We have profiles which ran into invalid callstacks because of this.
Here is an example:

.....  0: ffffffffffffff80 recent entry, marker kernel v
.....  1: 000000000040044d <= user address in kernel space!
.....  2: fffffffffffffe00 marker enter user v
.....  3: 000000000040044d
.....  4: 00000000004004b6 oldest entry

Debugging output in get_perf_callchain():
[  857.769909] CALLCHAIN: CPU8 ip=40044d regs->cs=10 user_mode(regs)=0

The problem is that the kernel entry in 1: points to a user level
address. How can that be?

The reason is that with PEBS sampling the instruction that caused the event
to occur and the instruction where the CPU was when the interrupt was posted
may be far apart. And sometime during that time window, the privilege level may
change. This happens, for instance, when the PEBS sample is taken close to a
kernel entry point. Here PEBS, eventing ip (real_ip) captured a user level
instruction. But by the time the PMU interrupt fired, the processor had already
entered kernel space. This is why the debug output shows a user address with
user_mode() false.

The problem comes from PEBS not recording the code segment (cs) register.
The register is used in x86_64 to determine if executing in kernel vs user
space. This is okay because the kernel has a software workaround called
set_linear_ip(). But the issue in setup_pebs_sample_data() is that
set_linear_ip() is never called on the real_ip value when it is available
(Haswell and later) and precise_ip > 1.

This patch fixes this problem and eliminates the callchain discrepancy.

The patch restructures the code around set_linear_ip() to minimize the number
of times the ip has to be set.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/ds.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 209bf7c16443..5b6ce006b88f 100644
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
+		/* Haswell and later have the eventing IP, so use it */
+		if (x86_pmu.intel_cap.pebs_format >= 2) {
+			set_linear_ip(regs, pebs->real_ip);
+			regs->flags |= PERF_EFLAGS_EXACT;
+		} else {
+			/* otherwise use PEBS off-by-1 IP */
+			set_linear_ip(regs, pebs->ip);
+
+			/* and try to fix it up */
+			if (intel_pmu_pebs_fixup_ip(regs))
+				regs->flags |= PERF_EFLAGS_EXACT;
+		}
+	} else
+		set_linear_ip(regs, pebs->ip);
+
 
 	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR)) &&
 	    x86_pmu.intel_cap.pebs_format >= 1)
-- 
2.7.4
