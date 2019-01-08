Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0E1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1A721019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfAHPpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:45:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfAHPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:45:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08FhaaD3567122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:43:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08Fha6d3567119;
        Tue, 8 Jan 2019 07:43:36 -0800
Date:   Tue, 8 Jan 2019 07:43:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-a3366db06bb656cef2e03f30f780d93059bcc594@git.kernel.org>
Cc:     yao.jin@linux.intel.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        hpa@zytor.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        tglx@linutronix.de, acme@redhat.com, peterz@infradead.org
Reply-To: acme@redhat.com, peterz@infradead.org, yao.jin@linux.intel.com,
          ak@linux.intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          kan.liang@linux.intel.com, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <1546582230-17507-1-git-send-email-yao.jin@linux.intel.com>
References: <1546582230-17507-1-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Fix wrong iteration count in
 --branch-history
Git-Commit-ID: a3366db06bb656cef2e03f30f780d93059bcc594
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a3366db06bb656cef2e03f30f780d93059bcc594
Gitweb:     https://git.kernel.org/tip/a3366db06bb656cef2e03f30f780d93059bcc594
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 4 Jan 2019 14:10:30 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 4 Jan 2019 12:54:49 -0300

perf report: Fix wrong iteration count in --branch-history

By calculating the removed loops, we can get the iteration count.

But the iteration count could be reported incorrectly, reporting
impossibly high counts.

That's because previous code uses the number of removed LBR entries for
the iteration count. That's not good. Fix this by increasing the
iteration count when a loop is detected.

When matching the chain, the iteration count would be added up, finally we need
to compute the average value when printing out.

For example,

  $ perf report --branch-history --stdio --no-children

Before:

  ---f2 +0
     |
     |--33.62%--f1 +9 (cycles:1)
     |          f1 +0
     |          main +22 (cycles:1)
     |          main +17
     |          main +38 (cycles:1)
     |          main +27
     |          f1 +26 (cycles:1)
     |          f1 +24
     |          f2 +27 (cycles:7)
     |          f2 +0
     |          f1 +19 (cycles:1)
     |          f1 +14
     |          f2 +27 (cycles:11)
     |          f2 +0
     |          f1 +9 (cycles:1 iter:2968 avg_cycles:3)
     |          f1 +0
     |          main +22 (cycles:1 iter:2968 avg_cycles:3)
     |          main +17
     |          main +38 (cycles:1 iter:2968 avg_cycles:3)

2968 is an impossible high iteration count and avg_cycles is too small.

After:

  ---f2 +0
     |
     |--33.62%--f1 +9 (cycles:1)
     |          f1 +0
     |          main +22 (cycles:1)
     |          main +17
     |          main +38 (cycles:1)
     |          main +27
     |          f1 +26 (cycles:1)
     |          f1 +24
     |          f2 +27 (cycles:7)
     |          f2 +0
     |          f1 +19 (cycles:1)
     |          f1 +14
     |          f2 +27 (cycles:11)
     |          f2 +0
     |          f1 +9 (cycles:1 iter:1 avg_cycles:23)
     |          f1 +0
     |          main +22 (cycles:1 iter:1 avg_cycles:23)
     |          main +17
     |          main +38 (cycles:1 iter:1 avg_cycles:23)

avg_cycles:23 is the average cycles of this iteration.

Fixes: c4ee06251d42 ("perf report: Calculate the average cycles of iterations")

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1546582230-17507-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c | 32 ++++++++++++++++++++------------
 tools/perf/util/callchain.h |  1 +
 tools/perf/util/machine.c   |  2 +-
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 32ef7bdca1cf..dc2212e12184 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -766,6 +766,7 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			cnode->cycles_count += node->branch_flags.cycles;
 			cnode->iter_count += node->nr_loop_iter;
 			cnode->iter_cycles += node->iter_cycles;
+			cnode->from_count++;
 		}
 	}
 
@@ -1345,10 +1346,10 @@ static int branch_to_str(char *bf, int bfsize,
 static int branch_from_str(char *bf, int bfsize,
 			   u64 branch_count,
 			   u64 cycles_count, u64 iter_count,
-			   u64 iter_cycles)
+			   u64 iter_cycles, u64 from_count)
 {
 	int printed = 0, i = 0;
-	u64 cycles;
+	u64 cycles, v = 0;
 
 	cycles = cycles_count / branch_count;
 	if (cycles) {
@@ -1357,14 +1358,16 @@ static int branch_from_str(char *bf, int bfsize,
 				bf + printed, bfsize - printed);
 	}
 
-	if (iter_count) {
-		printed += count_pri64_printf(i++, "iter",
-				iter_count,
-				bf + printed, bfsize - printed);
+	if (iter_count && from_count) {
+		v = iter_count / from_count;
+		if (v) {
+			printed += count_pri64_printf(i++, "iter",
+					v, bf + printed, bfsize - printed);
 
-		printed += count_pri64_printf(i++, "avg_cycles",
-				iter_cycles / iter_count,
-				bf + printed, bfsize - printed);
+			printed += count_pri64_printf(i++, "avg_cycles",
+					iter_cycles / iter_count,
+					bf + printed, bfsize - printed);
+		}
 	}
 
 	if (i)
@@ -1377,6 +1380,7 @@ static int counts_str_build(char *bf, int bfsize,
 			     u64 branch_count, u64 predicted_count,
 			     u64 abort_count, u64 cycles_count,
 			     u64 iter_count, u64 iter_cycles,
+			     u64 from_count,
 			     struct branch_type_stat *brtype_stat)
 {
 	int printed;
@@ -1389,7 +1393,8 @@ static int counts_str_build(char *bf, int bfsize,
 				predicted_count, abort_count, brtype_stat);
 	} else {
 		printed = branch_from_str(bf, bfsize, branch_count,
-				cycles_count, iter_count, iter_cycles);
+				cycles_count, iter_count, iter_cycles,
+				from_count);
 	}
 
 	if (!printed)
@@ -1402,13 +1407,14 @@ static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 				   u64 branch_count, u64 predicted_count,
 				   u64 abort_count, u64 cycles_count,
 				   u64 iter_count, u64 iter_cycles,
+				   u64 from_count,
 				   struct branch_type_stat *brtype_stat)
 {
 	char str[256];
 
 	counts_str_build(str, sizeof(str), branch_count,
 			 predicted_count, abort_count, cycles_count,
-			 iter_count, iter_cycles, brtype_stat);
+			 iter_count, iter_cycles, from_count, brtype_stat);
 
 	if (fp)
 		return fprintf(fp, "%s", str);
@@ -1422,6 +1428,7 @@ int callchain_list_counts__printf_value(struct callchain_list *clist,
 	u64 branch_count, predicted_count;
 	u64 abort_count, cycles_count;
 	u64 iter_count, iter_cycles;
+	u64 from_count;
 
 	branch_count = clist->branch_count;
 	predicted_count = clist->predicted_count;
@@ -1429,11 +1436,12 @@ int callchain_list_counts__printf_value(struct callchain_list *clist,
 	cycles_count = clist->cycles_count;
 	iter_count = clist->iter_count;
 	iter_cycles = clist->iter_cycles;
+	from_count = clist->from_count;
 
 	return callchain_counts_printf(fp, bf, bfsize, branch_count,
 				       predicted_count, abort_count,
 				       cycles_count, iter_count, iter_cycles,
-				       &clist->brtype_stat);
+				       from_count, &clist->brtype_stat);
 }
 
 static void free_callchain_node(struct callchain_node *node)
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 154560b1eb65..99d38ac019b8 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -118,6 +118,7 @@ struct callchain_list {
 		bool		has_children;
 	};
 	u64			branch_count;
+	u64			from_count;
 	u64			predicted_count;
 	u64			abort_count;
 	u64			cycles_count;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6fcb3bce0442..143f7057d581 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2005,7 +2005,7 @@ static void save_iterations(struct iterations *iter,
 {
 	int i;
 
-	iter->nr_loop_iter = nr;
+	iter->nr_loop_iter++;
 	iter->cycles = 0;
 
 	for (i = 0; i < nr; i++)
