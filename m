Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeCMGTj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:19:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49295 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeCMGTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:19:38 -0400
Date: Mon, 12 Mar 2018 23:18:59 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-cbd9d9f114f9e5931ba199f4450667656b892f32@git.kernel.org>
Cc: will.deacon@arm.com, jolsa@redhat.com, hbathini@linux.vnet.ibm.com,
        sukadev@linux.vnet.ibm.com, jolsa@kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, mpe@ellerman.id.au, namhyung@kernel.org,
        acme@redhat.com, mingo@kernel.org, onestero@redhat.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        kan.liang@intel.com, tglx@linutronix.de, peterz@infradead.org,
        dsahern@gmail.com, chabbi.milind@gmail.com,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com
Reply-To: fweisbec@gmail.com, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        chabbi.milind@gmail.com, tglx@linutronix.de, peterz@infradead.org,
        kan.liang@intel.com, alexander.shishkin@linux.intel.com,
        yao.jin@linux.intel.com, onestero@redhat.com, mingo@kernel.org,
        acme@redhat.com, mpe@ellerman.id.au, namhyung@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, jolsa@kernel.org,
        sukadev@linux.vnet.ibm.com, hbathini@linux.vnet.ibm.com,
        will.deacon@arm.com, jolsa@redhat.com
In-Reply-To: <20180312134548.31532-2-jolsa@kernel.org>
References: <20180312134548.31532-2-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] hw_breakpoint: Pass bp_type directly as
 find_slot_idx() argument
Git-Commit-ID: cbd9d9f114f9e5931ba199f4450667656b892f32
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

Commit-ID:  cbd9d9f114f9e5931ba199f4450667656b892f32
Gitweb:     https://git.kernel.org/tip/cbd9d9f114f9e5931ba199f4450667656b892f32
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 12 Mar 2018 14:45:41 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 06:56:07 +0100

hw_breakpoint: Pass bp_type directly as find_slot_idx() argument

Pass bp_type directly as a find_slot_idx() argument,
so we don't need to have whole event to get the
breakpoint slot type. It will be used in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Milind Chabbi <chabbi.milind@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oleg Nesterov <onestero@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20180312134548.31532-2-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
