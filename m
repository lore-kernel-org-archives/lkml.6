Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeCORBs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:01:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeCORBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:01:46 -0400
Date: Thu, 15 Mar 2018 18:01:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de, alexey.budankov@linux.intel.com,
        Dmitry.Prohorov@intel.com, alexander.shishkin@linux.intel.com,
        acme@redhat.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jolsa@redhat.com, torvalds@linux-foundation.org,
        mingo@kernel.org, vincent.weaver@maine.edu, kan.liang@intel.com,
        eranian@google.com, davidcc@google.com, valery.cherepennikov@intel.com
Cc: linux-tip-commits@vger.kernel.org
Subject: [PATCH] perf: Fix sibling iteration
Message-ID: <20180315170129.GX4043@hirez.programming.kicks-ass.net>
References: <tip-8343aae66167df6708128a778e750d48dbe31302@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-8343aae66167df6708128a778e750d48dbe31302@git.kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: perf: Fix sibling iteration
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Mar 15 17:36:56 CET 2018

Mark noticed that the change to sibling_list changed some iteration
semantics; because previously we used group_list as list entry,
sibling events would always have an empty sibling_list.

But because we now use sibling_list for both list head and list entry,
siblings will report as having siblings.

Fix this with a custom for_each_sibling_event() iterator.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 8343aae66167 ("perf/core: Remove perf_event::group_entry")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -351,7 +351,7 @@ static int collect_events(struct perf_ev
 		evtype[n] = group->hw.event_base;
 		current_idx[n++] = PMC_NO_INDEX;
 	}
-	list_for_each_entry(pe, &group->sibling_list, sibling_list) {
+	for_each_sibling_event(pe, group) {
 		if (!is_software_event(pe) && pe->state != PERF_EVENT_STATE_OFF) {
 			if (n >= max_count)
 				return -1;
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -269,7 +269,7 @@ static bool mmdc_pmu_group_is_valid(stru
 			return false;
 	}
 
-	list_for_each_entry(sibling, &leader->sibling_list, sibling_list) {
+	for_each_sibling_event(sibling, leader) {
 		if (!mmdc_pmu_group_event_is_valid(sibling, pmu, &counter_mask))
 			return false;
 	}
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -293,7 +293,7 @@ static bool l2x0_pmu_group_is_valid(stru
 	else if (!is_software_event(leader))
 		return false;
 
-	list_for_each_entry(sibling, &leader->sibling_list, sibling_list) {
+	for_each_sibling_event(sibling, leader) {
 		if (sibling->pmu == pmu)
 			num_hw++;
 		else if (!is_software_event(sibling))
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -711,7 +711,7 @@ static int validate_group(struct perf_ev
 	if (mipsxx_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
 		return -EINVAL;
 
-	list_for_each_entry(sibling, &leader->sibling_list, sibling_list) {
+	for_each_sibling_event(sibling, leader) {
 		if (mipsxx_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
 			return -EINVAL;
 	}
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1426,7 +1426,7 @@ static int collect_events(struct perf_ev
 		flags[n] = group->hw.event_base;
 		events[n++] = group->hw.config;
 	}
-	list_for_each_entry(event, &group->sibling_list, sibling_list) {
+	for_each_sibling_event(event, group) {
 		if (event->pmu->task_ctx_nr == perf_hw_context &&
 		    event->state != PERF_EVENT_STATE_OFF) {
 			if (n >= max_count)
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -277,7 +277,7 @@ static int collect_events(struct perf_ev
 		ctrs[n] = group;
 		n++;
 	}
-	list_for_each_entry(event, &group->sibling_list, sibling_list) {
+	for_each_sibling_event(event, group) {
 		if (!is_software_event(event) &&
 		    event->state != PERF_EVENT_STATE_OFF) {
 			if (n >= max_count)
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1342,7 +1342,7 @@ static int collect_events(struct perf_ev
 		events[n] = group->hw.event_base;
 		current_idx[n++] = PIC_NO_INDEX;
 	}
-	list_for_each_entry(event, &group->sibling_list, sibling_list) {
+	for_each_sibling_event(event, group) {
 		if (!is_software_event(event) &&
 		    event->state != PERF_EVENT_STATE_OFF) {
 			if (n >= max_count)
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -990,7 +990,7 @@ static int collect_events(struct cpu_hw_
 	if (!dogrp)
 		return n;
 
-	list_for_each_entry(event, &leader->sibling_list, sibling_list) {
+	for_each_sibling_event(event, leader) {
 		if (!is_x86_event(event) ||
 		    event->state <= PERF_EVENT_STATE_OFF)
 			continue;
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -354,7 +354,7 @@ uncore_collect_events(struct intel_uncor
 	if (!dogrp)
 		return n;
 
-	list_for_each_entry(event, &leader->sibling_list, sibling_list) {
+	for_each_sibling_event(event, leader) {
 		if (!is_box_event(box, event) ||
 		    event->state <= PERF_EVENT_STATE_OFF)
 			continue;
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -1311,7 +1311,7 @@ validate_group(struct perf_event *event)
 	if (!validate_event(event->pmu, &fake_pmu, leader))
 		return -EINVAL;
 
-	list_for_each_entry(sibling, &leader->sibling_list, sibling_list) {
+	for_each_sibling_event(sibling, leader) {
 		if (!validate_event(event->pmu, &fake_pmu, sibling))
 			return -EINVAL;
 	}
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -846,11 +846,11 @@ static int arm_ccn_pmu_event_init(struct
 			!is_software_event(event->group_leader))
 		return -EINVAL;
 
-	list_for_each_entry(sibling, &event->group_leader->sibling_list,
-			sibling_list)
+	for_each_sibling_event(sibling, event->group_leader) {
 		if (sibling->pmu != event->pmu &&
 				!is_software_event(sibling))
 			return -EINVAL;
+	}
 
 	return 0;
 }
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -536,7 +536,7 @@ static bool dsu_pmu_validate_group(struc
 	memset(fake_hw.used_mask, 0, sizeof(fake_hw.used_mask));
 	if (!dsu_pmu_validate_event(event->pmu, &fake_hw, leader))
 		return false;
-	list_for_each_entry(sibling, &leader->sibling_list, sibling_list) {
+	for_each_sibling_event(sibling, leader) {
 		if (!dsu_pmu_validate_event(event->pmu, &fake_hw, sibling))
 			return false;
 	}
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -311,7 +311,7 @@ validate_group(struct perf_event *event)
 	if (!validate_event(event->pmu, &fake_pmu, leader))
 		return -EINVAL;
 
-	list_for_each_entry(sibling, &leader->sibling_list, sibling_list) {
+	for_each_sibling_event(sibling, leader) {
 		if (!validate_event(event->pmu, &fake_pmu, sibling))
 			return -EINVAL;
 	}
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -82,7 +82,7 @@ static bool hisi_validate_event_group(st
 			counters++;
 	}
 
-	list_for_each_entry(sibling, &event->group_leader->sibling_list, sibling_list) {
+	for_each_sibling_event(sibling, event->group_leader) {
 		if (is_software_event(sibling))
 			continue;
 		if (sibling->pmu != event->pmu)
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -534,8 +534,7 @@ static int l2_cache_event_init(struct pe
 		return -EINVAL;
 	}
 
-	list_for_each_entry(sibling, &event->group_leader->sibling_list,
-			    sibling_list)
+	for_each_sibling_event(sibling, event->group_leader) {
 		if (sibling->pmu != event->pmu &&
 		    !is_software_event(sibling)) {
 			dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
@@ -571,8 +570,7 @@ static int l2_cache_event_init(struct pe
 		return -EINVAL;
 	}
 
-	list_for_each_entry(sibling, &event->group_leader->sibling_list,
-			    sibling_list) {
+	for_each_sibling_event(sibling, event->group_leader) {
 		if ((sibling != event) &&
 		    !is_software_event(sibling) &&
 		    (L2_EVT_GROUP(sibling->attr.config) ==
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -468,7 +468,7 @@ static bool qcom_l3_cache__validate_even
 	counters = event_num_counters(event);
 	counters += event_num_counters(leader);
 
-	list_for_each_entry(sibling, &leader->sibling_list, sibling_list) {
+	for_each_sibling_event(sibling, leader) {
 		if (is_software_event(sibling))
 			continue;
 		if (sibling->pmu != event->pmu)
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -949,11 +949,11 @@ static int xgene_perf_event_init(struct
 			!is_software_event(event->group_leader))
 		return -EINVAL;
 
-	list_for_each_entry(sibling, &event->group_leader->sibling_list,
-			sibling_list)
+	for_each_sibling_event(sibling, event->group_leader) {
 		if (sibling->pmu != event->pmu &&
 				!is_software_event(sibling))
 			return -EINVAL;
+	}
 
 	return 0;
 }
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -536,6 +536,10 @@ struct pmu_event_list {
 	struct list_head	list;
 };
 
+#define for_each_sibling_event(sibling, event)			\
+	if ((event)->group_leader == (event))			\
+		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
+
 /**
  * struct perf_event - performance event kernel representation:
  */
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -643,7 +643,7 @@ static void perf_event_update_sibling_ti
 {
 	struct perf_event *sibling;
 
-	list_for_each_entry(sibling, &leader->sibling_list, sibling_list)
+	for_each_sibling_event(sibling, leader)
 		perf_event_update_time(sibling);
 }
 
@@ -1828,7 +1828,7 @@ static void perf_group_attach(struct per
 
 	perf_event__header_size(group_leader);
 
-	list_for_each_entry(pos, &group_leader->sibling_list, sibling_list)
+	for_each_sibling_event(pos, group_leader)
 		perf_event__header_size(pos);
 }
 
@@ -1928,7 +1928,7 @@ static void perf_group_detach(struct per
 out:
 	perf_event__header_size(event->group_leader);
 
-	list_for_each_entry(tmp, &event->group_leader->sibling_list, sibling_list)
+	for_each_sibling_event(tmp, event->group_leader)
 		perf_event__header_size(tmp);
 }
 
@@ -1951,13 +1951,13 @@ static inline int __pmu_filter_match(str
  */
 static inline int pmu_filter_match(struct perf_event *event)
 {
-	struct perf_event *child;
+	struct perf_event *sibling;
 
 	if (!__pmu_filter_match(event))
 		return 0;
 
-	list_for_each_entry(child, &event->sibling_list, sibling_list) {
-		if (!__pmu_filter_match(child))
+	for_each_sibling_event(sibling, event) {
+		if (!__pmu_filter_match(sibling))
 			return 0;
 	}
 
@@ -2031,7 +2031,7 @@ group_sched_out(struct perf_event *group
 	/*
 	 * Schedule out siblings (if any):
 	 */
-	list_for_each_entry(event, &group_event->sibling_list, sibling_list)
+	for_each_sibling_event(event, group_event)
 		event_sched_out(event, cpuctx, ctx);
 
 	perf_pmu_enable(ctx->pmu);
@@ -2310,7 +2310,7 @@ group_sched_in(struct perf_event *group_
 	/*
 	 * Schedule in siblings as one group (if any):
 	 */
-	list_for_each_entry(event, &group_event->sibling_list, sibling_list) {
+	for_each_sibling_event(event, group_event) {
 		if (event_sched_in(event, cpuctx, ctx)) {
 			partial_group = event;
 			goto group_error;
@@ -2326,7 +2326,7 @@ group_sched_in(struct perf_event *group_
 	 * partial group before returning:
 	 * The events up to the failed event are scheduled out normally.
 	 */
-	list_for_each_entry(event, &group_event->sibling_list, sibling_list) {
+	for_each_sibling_event(event, group_event) {
 		if (event == partial_group)
 			break;
 
@@ -3865,7 +3865,7 @@ static void __perf_event_read(void *info
 
 	pmu->read(event);
 
-	list_for_each_entry(sub, &event->sibling_list, sibling_list) {
+	for_each_sibling_event(sub, event) {
 		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
 			/*
 			 * Use sibling's PMU rather than @event's since
@@ -4713,7 +4713,7 @@ static int __perf_read_group_add(struct
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 
-	list_for_each_entry(sub, &leader->sibling_list, sibling_list) {
+	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
@@ -4907,7 +4907,7 @@ static void perf_event_for_each(struct p
 	event = event->group_leader;
 
 	perf_event_for_each_child(event, func);
-	list_for_each_entry(sibling, &event->sibling_list, sibling_list)
+	for_each_sibling_event(sibling, event)
 		perf_event_for_each_child(sibling, func);
 }
 
@@ -6079,7 +6079,7 @@ static void perf_output_read_group(struc
 
 	__output_copy(handle, values, n * sizeof(u64));
 
-	list_for_each_entry(sub, &leader->sibling_list, sibling_list) {
+	for_each_sibling_event(sub, leader) {
 		n = 0;
 
 		if ((sub != event) &&
@@ -10664,8 +10664,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		perf_remove_from_context(group_leader, 0);
 		put_ctx(gctx);
 
-		list_for_each_entry(sibling, &group_leader->sibling_list,
-				    sibling_list) {
+		for_each_sibling_event(sibling, group_leader) {
 			perf_remove_from_context(sibling, 0);
 			put_ctx(gctx);
 		}
@@ -10686,8 +10685,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * By installing siblings first we NO-OP because they're not
 		 * reachable through the group lists.
 		 */
-		list_for_each_entry(sibling, &group_leader->sibling_list,
-				    sibling_list) {
+		for_each_sibling_event(sibling, group_leader) {
 			perf_event__state_init(sibling);
 			perf_install_in_context(ctx, sibling, sibling->cpu);
 			get_ctx(ctx);
@@ -11326,7 +11324,7 @@ static int inherit_group(struct perf_eve
 	 * case inherit_event() will create individual events, similar to what
 	 * perf_group_detach() would do anyway.
 	 */
-	list_for_each_entry(sub, &parent_event->sibling_list, sibling_list) {
+	for_each_sibling_event(sub, parent_event) {
 		child_ctr = inherit_event(sub, parent, parent_ctx,
 					    child, leader, child_ctx);
 		if (IS_ERR(child_ctr))
