Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCMGUC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:20:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37809 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbeCMGUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:20:01 -0400
Date: Mon, 12 Mar 2018 23:19:26 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-1ad9ff7dea4c42bee43f98b7d7ce8037ee22e133@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, chabbi.milind@gmail.com,
        mpe@ellerman.id.au, peterz@infradead.org, acme@redhat.com,
        namhyung@kernel.org, dsahern@gmail.com, yao.jin@linux.intel.com,
        mingo@kernel.org, jolsa@kernel.org, kan.liang@intel.com,
        sukadev@linux.vnet.ibm.com, onestero@redhat.com,
        hbathini@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will.deacon@arm.com, jolsa@redhat.com,
        fweisbec@gmail.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: jolsa@kernel.org, sukadev@linux.vnet.ibm.com, kan.liang@intel.com,
        hbathini@linux.vnet.ibm.com, onestero@redhat.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, jolsa@redhat.com, fweisbec@gmail.com,
        hpa@zytor.com, tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        chabbi.milind@gmail.com, mpe@ellerman.id.au, peterz@infradead.org,
        acme@redhat.com, namhyung@kernel.org, yao.jin@linux.intel.com,
        mingo@kernel.org, dsahern@gmail.com
In-Reply-To: <20180312134548.31532-3-jolsa@kernel.org>
References: <20180312134548.31532-3-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] hw_breakpoint: Pass bp_type argument to
 __reserve_bp_slot|__release_bp_slot()
Git-Commit-ID: 1ad9ff7dea4c42bee43f98b7d7ce8037ee22e133
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

Commit-ID:  1ad9ff7dea4c42bee43f98b7d7ce8037ee22e133
Gitweb:     https://git.kernel.org/tip/1ad9ff7dea4c42bee43f98b7d7ce8037ee22e133
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 12 Mar 2018 14:45:42 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 06:56:07 +0100

hw_breakpoint: Pass bp_type argument to __reserve_bp_slot|__release_bp_slot()

Passing bp_type argument to __reserve_bp_slot() and __release_bp_slot()
functions, so we can pass another bp_type than the one defined in
bp->attr.bp_type. This will be handy in following change that fixes
breakpoint slot counts during its modification.

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
Link: http://lkml.kernel.org/r/20180312134548.31532-3-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
