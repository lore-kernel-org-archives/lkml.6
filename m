Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeCMGUX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:20:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50157 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbeCMGUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:20:22 -0400
Date: Mon, 12 Mar 2018 23:19:53 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ea6a9d530c1779b9bd30944b803820c462f01eac@git.kernel.org>
Cc: will.deacon@arm.com, chabbi.milind@gmail.com, fweisbec@gmail.com,
        yao.jin@linux.intel.com, jolsa@kernel.org, onestero@redhat.com,
        tglx@linutronix.de, kan.liang@intel.com, namhyung@kernel.org,
        dsahern@gmail.com, mpe@ellerman.id.au, hbathini@linux.vnet.ibm.com,
        jolsa@redhat.com, sukadev@linux.vnet.ibm.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        torvalds@linux-foundation.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org
Reply-To: kan.liang@intel.com, mpe@ellerman.id.au, dsahern@gmail.com,
        namhyung@kernel.org, jolsa@kernel.org, onestero@redhat.com,
        tglx@linutronix.de, yao.jin@linux.intel.com, fweisbec@gmail.com,
        will.deacon@arm.com, chabbi.milind@gmail.com,
        hbathini@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
        mingo@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, torvalds@linux-foundation.org
In-Reply-To: <20180312134548.31532-4-jolsa@kernel.org>
References: <20180312134548.31532-4-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] hw_breakpoint: Add modify_bp_slot() function
Git-Commit-ID: ea6a9d530c1779b9bd30944b803820c462f01eac
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

Commit-ID:  ea6a9d530c1779b9bd30944b803820c462f01eac
Gitweb:     https://git.kernel.org/tip/ea6a9d530c1779b9bd30944b803820c462f01eac
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 12 Mar 2018 14:45:43 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 06:56:07 +0100

hw_breakpoint: Add modify_bp_slot() function

Add the modify_bp_slot() function to keep slot numbers
correct when changing the breakpoint type.

Using existing __release_bp_slot()/__reserve_bp_slot()
call sequence to update the slot counts.

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
Link: http://lkml.kernel.org/r/20180312134548.31532-4-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
