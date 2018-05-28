Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162904AbeE1Kk7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162887AbeE1Kkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:40:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        kernel test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 293/329] perf/x86/intel: Properly save/restore the PMU state in the NMI handler
Date: Mon, 28 May 2018 12:03:42 +0200
Message-Id: <20180528100305.963028203@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 82d71ed0277efc45360828af8c4e4d40e1b45352 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2066,16 +2066,23 @@ static int intel_pmu_handle_irq(struct p
 	int bit, loops;
 	u64 status;
 	int handled;
+	int pmu_enabled;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	/*
+	 * Save the PMU state.
+	 * It needs to be restored when leaving the handler.
+	 */
+	pmu_enabled = cpuc->enabled;
+	/*
 	 * No known reason to not always do late ACK,
 	 * but just in case do it opt-in.
 	 */
 	if (!x86_pmu.late_ack)
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	intel_bts_disable_local();
+	cpuc->enabled = 0;
 	__intel_pmu_disable_all();
 	handled = intel_pmu_drain_bts_buffer();
 	handled += intel_bts_interrupt();
@@ -2173,7 +2180,8 @@ again:
 
 done:
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
-	if (cpuc->enabled)
+	cpuc->enabled = pmu_enabled;
+	if (pmu_enabled)
 		__intel_pmu_enable_all(0, true);
 	intel_bts_enable_local();
 
