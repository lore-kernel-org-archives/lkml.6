Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932303AbeCLNqD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:46:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932242AbeCLNqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:46:01 -0400
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
Subject: [PATCH 3/8] hw_breakpoint: Add modify_bp_slot function
Date: Mon, 12 Mar 2018 14:45:43 +0100
Message-Id: <20180312134548.31532-4-jolsa@kernel.org>
In-Reply-To: <20180312134548.31532-1-jolsa@kernel.org>
References: <20180312134548.31532-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding modify_bp_slot function to keep slot numbers
correct when changing the breakpoint type.

Using existing __release_bp_slot/__reserve_bp_slot
call sequence to update the slot counts.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/hw_breakpoint.c | 46 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 9b31fbcc3305..776948beb4ac 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -44,6 +44,7 @@
 #include <linux/list.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
+#include <linux/bug.h>
 
 #include <linux/hw_breakpoint.h>
 /*
@@ -344,6 +345,38 @@ void release_bp_slot(struct perf_event *bp)
 	mutex_unlock(&nr_bp_mutex);
 }
 
+static int __modify_bp_slot(struct perf_event *bp, u64 old_type)
+{
+	int err;
+
+	__release_bp_slot(bp, old_type);
+
+	err = __reserve_bp_slot(bp, bp->attr.bp_type);
+	if (err) {
+		/*
+		 * Reserve the old_type slot back in case
+		 * there's no space for the new type.
+		 *
+		 * This must succeed, because we just released
+		 * the old_type slot in the __release_bp_slot
+		 * call above. If not, something is broken.
+		 */
+		WARN_ON(__reserve_bp_slot(bp, old_type));
+	}
+
+	return err;
+}
+
+static int modify_bp_slot(struct perf_event *bp, u64 old_type)
+{
+	int ret;
+
+	mutex_lock(&nr_bp_mutex);
+	ret = __modify_bp_slot(bp, old_type);
+	mutex_unlock(&nr_bp_mutex);
+	return ret;
+}
+
 /*
  * Allow the kernel debugger to reserve breakpoint slots without
  * taking a lock using the dbg_* variant of for the reserve and
@@ -435,6 +468,7 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 	u64 old_addr = bp->attr.bp_addr;
 	u64 old_len = bp->attr.bp_len;
 	int old_type = bp->attr.bp_type;
+	bool modify = attr->bp_type != old_type;
 	int err = 0;
 
 	/*
@@ -452,12 +486,9 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 	bp->attr.bp_type = attr->bp_type;
 	bp->attr.bp_len = attr->bp_len;
 
-	if (attr->disabled)
-		goto end;
-
 	err = validate_hw_breakpoint(bp);
-	if (!err)
-		perf_event_enable(bp);
+	if (!err && modify)
+		err = modify_bp_slot(bp, old_type);
 
 	if (err) {
 		bp->attr.bp_addr = old_addr;
@@ -469,9 +500,10 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 		return err;
 	}
 
-end:
-	bp->attr.disabled = attr->disabled;
+	if (!attr->disabled)
+		perf_event_enable(bp);
 
+	bp->attr.disabled = attr->disabled;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
-- 
2.13.6
