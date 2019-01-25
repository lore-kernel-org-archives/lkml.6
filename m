Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3DCC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB5520844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458484;
	bh=VYywMZZkL1R2aUn3JEeA5v/WUj4zqVz0Pkx5wDNBFvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tCMyWrd8emQXzRK/ZBUn4x7k4iYPAHnEIda5jheNh117Z4J2NhL8QLYTh2AGf9x1k
	 cFfvik6y6A3F6Hp9iapn5kg+ut0BEB7V7aht/9cF2KM3lN5HG1tv2n4hyb7O0Fsmfp
	 oDqPP9/7qP5aCnKGzeWxe3R8L4AGCGmCjkTPPvFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfAYXVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:21:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729828AbfAYXTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:25 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738F6218D0;
        Fri, 25 Jan 2019 23:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458364;
        bh=VYywMZZkL1R2aUn3JEeA5v/WUj4zqVz0Pkx5wDNBFvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRy5kW0/bjFsmb1B4w4LvcyxfzLh75bIGKJGKEv93bsj/0RWHU9LisYN8u3k2HI2I
         WSni96IbRSvt1NMmkbQMPf/Y74L+4F4O1I00PJ0X1Mz4oEIH6kvgNHsbMdIrPsRYl3
         GdQPEuNShmp4ySdBEBruAjgorN91tofdI8/wMBiU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/29] perf sched: Use cached rbtrees
Date:   Sat, 26 Jan 2019 00:18:30 +0100
Message-Id: <20190125231843.2895-17-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

At the cost of an extra pointer, we can avoid the O(logN) cost of
finding the first element in the tree (smallest node), which is
something heavily required for perf-sched.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181206191819.30182-8-dave@stgolabs.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 45 +++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2e0f0c65964a..640558e9352e 100644
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
2.20.1

