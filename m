Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932178AbeCLNp5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:45:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeCLNpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:45:55 -0400
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
Subject: [PATCH 1/8] hw_breakpoint: Pass bp_type directly as find_slot_idx argument
Date: Mon, 12 Mar 2018 14:45:41 +0100
Message-Id: <20180312134548.31532-2-jolsa@kernel.org>
In-Reply-To: <20180312134548.31532-1-jolsa@kernel.org>
References: <20180312134548.31532-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing bp_type directly as find_slot_idx argument,
so we don't need to have whole event to get the
breakpoint slot type. It will be used in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/hw_breakpoint.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 3f8cb1e14588..395ca07965af 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -85,9 +85,9 @@ __weak int hw_breakpoint_weight(struct perf_event *bp)
 	return 1;
 }
 
-static inline enum bp_type_idx find_slot_idx(struct perf_event *bp)
+static inline enum bp_type_idx find_slot_idx(u64 bp_type)
 {
-	if (bp->attr.bp_type & HW_BREAKPOINT_RW)
+	if (bp_type & HW_BREAKPOINT_RW)
 		return TYPE_DATA;
 
 	return TYPE_INST;
@@ -122,7 +122,7 @@ static int task_bp_pinned(int cpu, struct perf_event *bp, enum bp_type_idx type)
 
 	list_for_each_entry(iter, &bp_task_head, hw.bp_list) {
 		if (iter->hw.target == tsk &&
-		    find_slot_idx(iter) == type &&
+		    find_slot_idx(iter->attr.bp_type) == type &&
 		    (iter->cpu < 0 || cpu == iter->cpu))
 			count += hw_breakpoint_weight(iter);
 	}
@@ -292,7 +292,7 @@ static int __reserve_bp_slot(struct perf_event *bp)
 	    bp->attr.bp_type == HW_BREAKPOINT_INVALID)
 		return -EINVAL;
 
-	type = find_slot_idx(bp);
+	type = find_slot_idx(bp->attr.bp_type);
 	weight = hw_breakpoint_weight(bp);
 
 	fetch_bp_busy_slots(&slots, bp, type);
@@ -329,7 +329,7 @@ static void __release_bp_slot(struct perf_event *bp)
 	enum bp_type_idx type;
 	int weight;
 
-	type = find_slot_idx(bp);
+	type = find_slot_idx(bp->attr.bp_type);
 	weight = hw_breakpoint_weight(bp);
 	toggle_bp_slot(bp, false, type, weight);
 }
-- 
2.13.6
