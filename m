Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeCIJIo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:08:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37979 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeCIJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:08:42 -0500
Date: Fri, 9 Mar 2018 01:08:18 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-82d71ed0277efc45360828af8c4e4d40e1b45352@git.kernel.org>
Cc: kan.liang@linux.intel.com, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, acme@redhat.com,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        vincent.weaver@maine.edu, fengguang.wu@intel.com, eranian@google.com
Reply-To: fengguang.wu@intel.com, vincent.weaver@maine.edu, eranian@google.com,
        mingo@kernel.org, hpa@zytor.com, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, acme@redhat.com, kan.liang@linux.intel.com,
        peterz@infradead.org, torvalds@linux-foundation.org
In-Reply-To: <6f44ee84-56f8-79f1-559b-08e371eaeb78@linux.intel.com>
References: <6f44ee84-56f8-79f1-559b-08e371eaeb78@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Properly save/restore the PMU state
 in the NMI handler
Git-Commit-ID: 82d71ed0277efc45360828af8c4e4d40e1b45352
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

Commit-ID:  82d71ed0277efc45360828af8c4e4d40e1b45352
Gitweb:     https://git.kernel.org/tip/82d71ed0277efc45360828af8c4e4d40e1b45352
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 20 Feb 2018 02:11:50 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:22:18 +0100

perf/x86/intel: Properly save/restore the PMU state in the NMI handler

The PMU is disabled in intel_pmu_handle_irq(), but cpuc->enabled is not updated
accordingly.

This is fine in current usage because no-one checks it - but fix it
for future code: for example, the drain_pebs() will be modified to
fix an auto-reload bug.

Properly save/restore the old PMU state.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: kernel test robot <fengguang.wu@intel.com>
Link: http://lkml.kernel.org/r/6f44ee84-56f8-79f1-559b-08e371eaeb78@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6b6c1717787d..1ba7ca7b675d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2201,9 +2201,15 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	int bit, loops;
 	u64 status;
 	int handled;
+	int pmu_enabled;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	/*
+	 * Save the PMU state.
+	 * It needs to be restored when leaving the handler.
+	 */
+	pmu_enabled = cpuc->enabled;
 	/*
 	 * No known reason to not always do late ACK,
 	 * but just in case do it opt-in.
@@ -2211,6 +2217,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	if (!x86_pmu.late_ack)
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	intel_bts_disable_local();
+	cpuc->enabled = 0;
 	__intel_pmu_disable_all();
 	handled = intel_pmu_drain_bts_buffer();
 	handled += intel_bts_interrupt();
@@ -2320,7 +2327,8 @@ again:
 
 done:
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
-	if (cpuc->enabled)
+	cpuc->enabled = pmu_enabled;
+	if (pmu_enabled)
 		__intel_pmu_enable_all(0, true);
 	intel_bts_enable_local();
 
