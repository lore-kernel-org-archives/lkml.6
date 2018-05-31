Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755158AbeEaMaZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:30:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36061 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754197AbeEaMaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:30:23 -0400
Date: Thu, 31 May 2018 05:30:03 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-2da331465f44f9618abe8837d1a68405d550b66e@git.kernel.org>
Cc: kan.liang@intel.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kan.liang@intel.com
In-Reply-To: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
References: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Introduce customized
 event_read() for client IMC uncore
Git-Commit-ID: 2da331465f44f9618abe8837d1a68405d550b66e
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

Commit-ID:  2da331465f44f9618abe8837d1a68405d550b66e
Gitweb:     https://git.kernel.org/tip/2da331465f44f9618abe8837d1a68405d550b66e
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 3 May 2018 11:25:06 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 31 May 2018 12:36:27 +0200

perf/x86/intel/uncore: Introduce customized event_read() for client IMC uncore

There are two free-running counters for client IMC uncore. The
customized event_init() function hard codes their index to
'UNCORE_PMC_IDX_FIXED' and 'UNCORE_PMC_IDX_FIXED + 1'.
To support the index 'UNCORE_PMC_IDX_FIXED + 1', the generic
uncore_perf_event_update is obscurely hacked.
The code quality issue will bring problems when a new counter index is
introduced into the generic code, for example, a new index for
free-running counter.

Introducing a customized event_read() function for client IMC uncore.
The customized function is copied from previous generic
uncore_pmu_event_read().
The index 'UNCORE_PMC_IDX_FIXED + 1' will be isolated for client IMC
uncore only.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: http://lkml.kernel.org/r/1525371913-10597-1-git-send-email-kan.liang@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_snb.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index aee5e8496be4..df535215d18b 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -450,6 +450,35 @@ static void snb_uncore_imc_event_start(struct perf_event *event, int flags)
 		uncore_pmu_start_hrtimer(box);
 }
 
+static void snb_uncore_imc_event_read(struct perf_event *event)
+{
+	struct intel_uncore_box *box = uncore_event_to_box(event);
+	u64 prev_count, new_count, delta;
+	int shift;
+
+	/*
+	 * There are two free running counters in IMC.
+	 * The index for the second one is hardcoded to
+	 * UNCORE_PMC_IDX_FIXED + 1.
+	 */
+	if (event->hw.idx >= UNCORE_PMC_IDX_FIXED)
+		shift = 64 - uncore_fixed_ctr_bits(box);
+	else
+		shift = 64 - uncore_perf_ctr_bits(box);
+
+	/* the hrtimer might modify the previous event value */
+again:
+	prev_count = local64_read(&event->hw.prev_count);
+	new_count = uncore_read_counter(box, event);
+	if (local64_xchg(&event->hw.prev_count, new_count) != prev_count)
+		goto again;
+
+	delta = (new_count << shift) - (prev_count << shift);
+	delta >>= shift;
+
+	local64_add(delta, &event->count);
+}
+
 static void snb_uncore_imc_event_stop(struct perf_event *event, int flags)
 {
 	struct intel_uncore_box *box = uncore_event_to_box(event);
@@ -472,7 +501,7 @@ static void snb_uncore_imc_event_stop(struct perf_event *event, int flags)
 		 * Drain the remaining delta count out of a event
 		 * that we are disabling:
 		 */
-		uncore_perf_event_update(box, event);
+		snb_uncore_imc_event_read(event);
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 }
@@ -534,7 +563,7 @@ static struct pmu snb_uncore_imc_pmu = {
 	.del		= snb_uncore_imc_event_del,
 	.start		= snb_uncore_imc_event_start,
 	.stop		= snb_uncore_imc_event_stop,
-	.read		= uncore_pmu_event_read,
+	.read		= snb_uncore_imc_event_read,
 };
 
 static struct intel_uncore_ops snb_uncore_imc_ops = {
