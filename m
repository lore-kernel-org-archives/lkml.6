Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeC0HsZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:48:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55811 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeC0HsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:48:23 -0400
Date: Tue, 27 Mar 2018 00:47:59 -0700
From: tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-71eb9ee9596d8df3d5723c3cfc18774c6235e8b1@git.kernel.org>
Cc: hpa@zytor.com, torvalds@linux-foundation.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, mingo@kernel.org,
        vincent.weaver@maine.edu, tglx@linutronix.de, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org
Reply-To: eranian@google.com, mingo@kernel.org, tglx@linutronix.de,
        vincent.weaver@maine.edu, jolsa@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        torvalds@linux-foundation.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <1521788507-10231-1-git-send-email-eranian@google.com>
References: <1521788507-10231-1-git-send-email-eranian@google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Fix linear IP of PEBS real_ip on
 Haswell and later CPUs
Git-Commit-ID: 71eb9ee9596d8df3d5723c3cfc18774c6235e8b1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  71eb9ee9596d8df3d5723c3cfc18774c6235e8b1
Gitweb:     https://git.kernel.org/tip/71eb9ee9596d8df3d5723c3cfc18774c6235e8b1
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Fri, 23 Mar 2018 00:01:47 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 27 Mar 2018 08:27:27 +0200

perf/x86/intel: Fix linear IP of PEBS real_ip on Haswell and later CPUs

this patch fix a bug in how the pebs->real_ip is handled in the PEBS
handler. real_ip only exists in Haswell and later processor. It is
actually the eventing IP, i.e., where the event occurred. As opposed
to the pebs->ip which is the PEBS interrupt IP which is always off
by one.

The problem is that the real_ip just like the IP needs to be fixed up
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
kernel entry point. Here PEBS, eventing IP (real_ip) captured a user level
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
of times the IP has to be set.

Signed-off-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: kan.liang@intel.com
Link: http://lkml.kernel.org/r/1521788507-10231-1-git-send-email-eranian@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/ds.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

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
