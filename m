Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeCLNrO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:47:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932266AbeCLNqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:46:03 -0400
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
Subject: [PATCH 4/8] hw_breakpoint: Factor out __modify_user_hw_breakpoint function
Date: Mon, 12 Mar 2018 14:45:44 +0100
Message-Id: <20180312134548.31532-5-jolsa@kernel.org>
In-Reply-To: <20180312134548.31532-1-jolsa@kernel.org>
References: <20180312134548.31532-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving out the all the functionality without the events
disabling/enabling calls, because we want to call another
disabling/enabling functions in following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/hw_breakpoint.c | 46 +++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 776948beb4ac..a556aba223da 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -456,6 +456,33 @@ register_user_hw_breakpoint(struct perf_event_attr *attr,
 }
 EXPORT_SYMBOL_GPL(register_user_hw_breakpoint);
 
+static int __modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr)
+{
+	u64 old_addr = bp->attr.bp_addr;
+	u64 old_len  = bp->attr.bp_len;
+	int old_type = bp->attr.bp_type;
+	bool modify  = attr->bp_type != old_type;
+	int err = 0;
+
+	bp->attr.bp_addr = attr->bp_addr;
+	bp->attr.bp_type = attr->bp_type;
+	bp->attr.bp_len  = attr->bp_len;
+
+	err = validate_hw_breakpoint(bp);
+	if (!err && modify)
+		err = modify_bp_slot(bp, old_type);
+
+	if (err) {
+		bp->attr.bp_addr = old_addr;
+		bp->attr.bp_type = old_type;
+		bp->attr.bp_len  = old_len;
+		return err;
+	}
+
+	bp->attr.disabled = attr->disabled;
+	return 0;
+}
+
 /**
  * modify_user_hw_breakpoint - modify a user-space hardware breakpoint
  * @bp: the breakpoint structure to modify
@@ -465,11 +492,7 @@ EXPORT_SYMBOL_GPL(register_user_hw_breakpoint);
  */
 int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr)
 {
-	u64 old_addr = bp->attr.bp_addr;
-	u64 old_len = bp->attr.bp_len;
-	int old_type = bp->attr.bp_type;
-	bool modify = attr->bp_type != old_type;
-	int err = 0;
+	int err;
 
 	/*
 	 * modify_user_hw_breakpoint can be invoked with IRQs disabled and hence it
@@ -482,18 +505,9 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 	else
 		perf_event_disable(bp);
 
-	bp->attr.bp_addr = attr->bp_addr;
-	bp->attr.bp_type = attr->bp_type;
-	bp->attr.bp_len = attr->bp_len;
-
-	err = validate_hw_breakpoint(bp);
-	if (!err && modify)
-		err = modify_bp_slot(bp, old_type);
+	err = __modify_user_hw_breakpoint(bp, attr);
 
 	if (err) {
-		bp->attr.bp_addr = old_addr;
-		bp->attr.bp_type = old_type;
-		bp->attr.bp_len = old_len;
 		if (!bp->attr.disabled)
 			perf_event_enable(bp);
 
@@ -502,8 +516,6 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 
 	if (!attr->disabled)
 		perf_event_enable(bp);
-
-	bp->attr.disabled = attr->disabled;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
-- 
2.13.6
