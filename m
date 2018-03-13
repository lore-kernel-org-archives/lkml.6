Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeCMGV4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:21:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeCMGVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:21:53 -0400
Date: Mon, 12 Mar 2018 23:20:19 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-18ff57b220610a699947f20b156a8245ca7eee98@git.kernel.org>
Cc: hpa@zytor.com, yao.jin@linux.intel.com, sukadev@linux.vnet.ibm.com,
        mingo@kernel.org, tglx@linutronix.de, chabbi.milind@gmail.com,
        mpe@ellerman.id.au, dsahern@gmail.com, kan.liang@intel.com,
        fweisbec@gmail.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jolsa@kernel.org, onestero@redhat.com,
        acme@redhat.com, hbathini@linux.vnet.ibm.com, peterz@infradead.org,
        will.deacon@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Reply-To: mpe@ellerman.id.au, fweisbec@gmail.com, dsahern@gmail.com,
        kan.liang@intel.com, jolsa@redhat.com, jolsa@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hbathini@linux.vnet.ibm.com, peterz@infradead.org, onestero@redhat.com,
        acme@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will.deacon@arm.com, sukadev@linux.vnet.ibm.com,
        yao.jin@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, chabbi.milind@gmail.com
In-Reply-To: <20180312134548.31532-5-jolsa@kernel.org>
References: <20180312134548.31532-5-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] hw_breakpoint: Factor out
 __modify_user_hw_breakpoint() function
Git-Commit-ID: 18ff57b220610a699947f20b156a8245ca7eee98
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

Commit-ID:  18ff57b220610a699947f20b156a8245ca7eee98
Gitweb:     https://git.kernel.org/tip/18ff57b220610a699947f20b156a8245ca7eee98
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 12 Mar 2018 14:45:44 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 06:56:08 +0100

hw_breakpoint: Factor out __modify_user_hw_breakpoint() function

Moving out all the functionality without the events
disabling/enabling calls, because we want to call another
disabling/enabling functions in following change.

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
Link: http://lkml.kernel.org/r/20180312134548.31532-5-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
