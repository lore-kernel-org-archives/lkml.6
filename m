Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbeCLNqB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:46:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932197AbeCLNp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:45:58 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Oleg Nesterov <onestero@redhat.com>, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/8] hw_breakpoint: Pass bp_type argument to __reserve_bp_slot|__release_bp_slot
Date: Mon, 12 Mar 2018 14:45:42 +0100
Message-Id: <20180312134548.31532-3-jolsa@kernel.org>
In-Reply-To: <20180312134548.31532-1-jolsa@kernel.org>
References: <20180312134548.31532-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing bp_type argument to __reserve_bp_slot and __release_bp_slot
functions, so we can pass another bp_type than the one defined in
bp->attr.bp_type. This will be handy in following change that fixes
breakpoint slot counts during its modification.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/hw_breakpoint.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 395ca07965af..9b31fbcc3305 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -277,7 +277,7 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
  *       ((per_cpu(info->flexible, *) > 1) + max(per_cpu(info->cpu_pinned, *))
  *            + max(per_cpu(info->tsk_pinned, *))) < HBP_NUM
  */
-static int __reserve_bp_slot(struct perf_event *bp)
+static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 {
 	struct bp_busy_slots slots = {0};
 	enum bp_type_idx type;
@@ -288,11 +288,11 @@ static int __reserve_bp_slot(struct perf_event *bp)
 		return -ENOMEM;
 
 	/* Basic checks */
-	if (bp->attr.bp_type == HW_BREAKPOINT_EMPTY ||
-	    bp->attr.bp_type == HW_BREAKPOINT_INVALID)
+	if (bp_type == HW_BREAKPOINT_EMPTY ||
+	    bp_type == HW_BREAKPOINT_INVALID)
 		return -EINVAL;
 
-	type = find_slot_idx(bp->attr.bp_type);
+	type = find_slot_idx(bp_type);
 	weight = hw_breakpoint_weight(bp);
 
 	fetch_bp_busy_slots(&slots, bp, type);
@@ -317,19 +317,19 @@ int reserve_bp_slot(struct perf_event *bp)
 
 	mutex_lock(&nr_bp_mutex);
 
-	ret = __reserve_bp_slot(bp);
+	ret = __reserve_bp_slot(bp, bp->attr.bp_type);
 
 	mutex_unlock(&nr_bp_mutex);
 
 	return ret;
 }
 
-static void __release_bp_slot(struct perf_event *bp)
+static void __release_bp_slot(struct perf_event *bp, u64 bp_type)
 {
 	enum bp_type_idx type;
 	int weight;
 
-	type = find_slot_idx(bp->attr.bp_type);
+	type = find_slot_idx(bp_type);
 	weight = hw_breakpoint_weight(bp);
 	toggle_bp_slot(bp, false, type, weight);
 }
@@ -339,7 +339,7 @@ void release_bp_slot(struct perf_event *bp)
 	mutex_lock(&nr_bp_mutex);
 
 	arch_unregister_hw_breakpoint(bp);
-	__release_bp_slot(bp);
+	__release_bp_slot(bp, bp->attr.bp_type);
 
 	mutex_unlock(&nr_bp_mutex);
 }
@@ -354,7 +354,7 @@ int dbg_reserve_bp_slot(struct perf_event *bp)
 	if (mutex_is_locked(&nr_bp_mutex))
 		return -1;
 
-	return __reserve_bp_slot(bp);
+	return __reserve_bp_slot(bp, bp->attr.bp_type);
 }
 
 int dbg_release_bp_slot(struct perf_event *bp)
@@ -362,7 +362,7 @@ int dbg_release_bp_slot(struct perf_event *bp)
 	if (mutex_is_locked(&nr_bp_mutex))
 		return -1;
 
-	__release_bp_slot(bp);
+	__release_bp_slot(bp, bp->attr.bp_type);
 
 	return 0;
 }
-- 
2.13.6
