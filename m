Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8DAC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E5121479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E5121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeLFTSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:18:50 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:39550 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeLFTSm (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 6 Dec 2018 14:18:42 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 06 Dec 2018 12:18:33 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 7/7] perf sched: Use cached rbtrees
Date:   Thu,  6 Dec 2018 11:18:19 -0800
Message-Id: <20181206191819.30182-8-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181206191819.30182-1-dave@stgolabs.net>
References: <20181206191819.30182-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the cost of an extra pointer, we can avoid the O(logN) cost
of finding the first element in the tree (smallest node), which
is something heavily required for perf-sched.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/builtin-sched.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cbf39dab19c1..d687d8fbc1cd 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -213,7 +213,7 @@ struct perf_sched {
 	u64		 all_runtime;
 	u64		 all_count;
 	u64		 cpu_last_switched[MAX_CPUS];
-	struct rb_root	 atom_root, sorted_atom_root, merged_atom_root;
+	struct rb_root_cached atom_root, sorted_atom_root, merged_atom_root;
 	struct list_head sort_list, cmp_pid;
 	bool force;
 	bool skip_merge;
@@ -271,7 +271,7 @@ struct evsel_runtime {
 struct idle_thread_runtime {
 	struct thread_runtime	tr;
 	struct thread		*last_thread;
-	struct rb_root		sorted_root;
+	struct rb_root_cached	sorted_root;
 	struct callchain_root	callchain;
 	struct callchain_cursor	cursor;
 };
@@ -950,10 +950,10 @@ thread_lat_cmp(struct list_head *list, struct work_atoms *l, struct work_atoms *
 }
 
 static struct work_atoms *
-thread_atoms_search(struct rb_root *root, struct thread *thread,
+thread_atoms_search(struct rb_root_cached *root, struct thread *thread,
 			 struct list_head *sort_list)
 {
-	struct rb_node *node = root->rb_node;
+	struct rb_node *node = root->rb_root.rb_node;
 	struct work_atoms key = { .thread = thread };
 
 	while (node) {
@@ -976,10 +976,11 @@ thread_atoms_search(struct rb_root *root, struct thread *thread,
 }
 
 static void
-__thread_latency_insert(struct rb_root *root, struct work_atoms *data,
+__thread_latency_insert(struct rb_root_cached *root, struct work_atoms *data,
 			 struct list_head *sort_list)
 {
-	struct rb_node **new = &(root->rb_node), *parent = NULL;
+	struct rb_node **new = &(root->rb_root.rb_node), *parent = NULL;
+	bool leftmost = true;
 
 	while (*new) {
 		struct work_atoms *this;
@@ -992,12 +993,14 @@ __thread_latency_insert(struct rb_root *root, struct work_atoms *data,
 
 		if (cmp > 0)
 			new = &((*new)->rb_left);
-		else
+		else {
 			new = &((*new)->rb_right);
+			leftmost = false;
+		}
 	}
 
 	rb_link_node(&data->node, parent, new);
-	rb_insert_color(&data->node, root);
+	rb_insert_color_cached(&data->node, root, leftmost);
 }
 
 static int thread_atoms_insert(struct perf_sched *sched, struct thread *thread)
@@ -1447,15 +1450,15 @@ static int sort_dimension__add(const char *tok, struct list_head *list)
 static void perf_sched__sort_lat(struct perf_sched *sched)
 {
 	struct rb_node *node;
-	struct rb_root *root = &sched->atom_root;
+	struct rb_root_cached *root = &sched->atom_root;
 again:
 	for (;;) {
 		struct work_atoms *data;
-		node = rb_first(root);
+		node = rb_first_cached(root);
 		if (!node)
 			break;
 
-		rb_erase(node, root);
+		rb_erase_cached(node, root);
 		data = rb_entry(node, struct work_atoms, node);
 		__thread_latency_insert(&sched->sorted_atom_root, data, &sched->sort_list);
 	}
@@ -2762,12 +2765,12 @@ static size_t callchain__fprintf_folded(FILE *fp, struct callchain_node *node)
 	return ret;
 }
 
-static size_t timehist_print_idlehist_callchain(struct rb_root *root)
+static size_t timehist_print_idlehist_callchain(struct rb_root_cached *root)
 {
 	size_t ret = 0;
 	FILE *fp = stdout;
 	struct callchain_node *chain;
-	struct rb_node *rb_node = rb_first(root);
+	struct rb_node *rb_node = rb_first_cached(root);
 
 	printf("  %16s  %8s  %s\n", "Idle time (msec)", "Count", "Callchains");
 	printf("  %.16s  %.8s  %.50s\n", graph_dotted_line, graph_dotted_line,
@@ -2868,7 +2871,7 @@ static void timehist_print_summary(struct perf_sched *sched,
 			if (itr == NULL)
 				continue;
 
-			callchain_param.sort(&itr->sorted_root, &itr->callchain,
+			callchain_param.sort(&itr->sorted_root.rb_root, &itr->callchain,
 					     0, &callchain_param);
 
 			printf("  CPU %2d:", i);
@@ -3074,11 +3077,12 @@ static void print_bad_events(struct perf_sched *sched)
 	}
 }
 
-static void __merge_work_atoms(struct rb_root *root, struct work_atoms *data)
+static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *data)
 {
-	struct rb_node **new = &(root->rb_node), *parent = NULL;
+	struct rb_node **new = &(root->rb_root.rb_node), *parent = NULL;
 	struct work_atoms *this;
 	const char *comm = thread__comm_str(data->thread), *this_comm;
+	bool leftmost = true;
 
 	while (*new) {
 		int cmp;
@@ -3092,6 +3096,7 @@ static void __merge_work_atoms(struct rb_root *root, struct work_atoms *data)
 			new = &((*new)->rb_left);
 		} else if (cmp < 0) {
 			new = &((*new)->rb_right);
+			leftmost = false;
 		} else {
 			this->num_merged++;
 			this->total_runtime += data->total_runtime;
@@ -3109,7 +3114,7 @@ static void __merge_work_atoms(struct rb_root *root, struct work_atoms *data)
 
 	data->num_merged++;
 	rb_link_node(&data->node, parent, new);
-	rb_insert_color(&data->node, root);
+	rb_insert_color_cached(&data->node, root, leftmost);
 }
 
 static void perf_sched__merge_lat(struct perf_sched *sched)
@@ -3120,8 +3125,8 @@ static void perf_sched__merge_lat(struct perf_sched *sched)
 	if (sched->skip_merge)
 		return;
 
-	while ((node = rb_first(&sched->atom_root))) {
-		rb_erase(node, &sched->atom_root);
+	while ((node = rb_first_cached(&sched->atom_root))) {
+		rb_erase_cached(node, &sched->atom_root);
 		data = rb_entry(node, struct work_atoms, node);
 		__merge_work_atoms(&sched->merged_atom_root, data);
 	}
@@ -3143,7 +3148,7 @@ static int perf_sched__lat(struct perf_sched *sched)
 	printf("  Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |\n");
 	printf(" -----------------------------------------------------------------------------------------------------------------\n");
 
-	next = rb_first(&sched->sorted_atom_root);
+	next = rb_first_cached(&sched->sorted_atom_root);
 
 	while (next) {
 		struct work_atoms *work_list;
-- 
2.16.4

