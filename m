Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeCTGU5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:20:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51947 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbeCTGUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:20:51 -0400
Date: Mon, 19 Mar 2018 23:19:25 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-7f834c2e84bbcf94a1ed65a2ae648129e1901370@git.kernel.org>
Cc: namhyung@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org, hpa@zytor.com,
        acme@redhat.com, dsahern@gmail.com, jmario@redhat.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        dsahern@gmail.com, hpa@zytor.com, acme@redhat.com, jmario@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20180309101442.9224-8-jolsa@kernel.org>
References: <20180309101442.9224-8-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf c2c report: Display node for cacheline address
Git-Commit-ID: 7f834c2e84bbcf94a1ed65a2ae648129e1901370
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

Commit-ID:  7f834c2e84bbcf94a1ed65a2ae648129e1901370
Gitweb:     https://git.kernel.org/tip/7f834c2e84bbcf94a1ed65a2ae648129e1901370
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 9 Mar 2018 11:14:40 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:53:23 -0300

perf c2c report: Display node for cacheline address

Adding the NUMA node info for the data cacheline. Adding the new column
to both "Shared Data Cache Line Table" and "Shared Cache Line
Distribution Pareto".

Note the new 'Node' column next to the 'Cacheline'.

  $ perf c2c report --stdio
  =================================================
             Shared Data Cache Line Table
  =================================================
  #
  #                                    Total      Tot  ----- LLC Load Hitm -----
  # Index           Cacheline  Node  records     Hitm    Total      Lcl      Rmt
  # .....  ..................  ....  .......  .......  .......  .......  .......
  #
        0      0x7f0830100000     0       84   10.53%        8        8        0
        1  0xffff922a93154200     0        3    2.63%        2        2        0
        2  0xffff922a93154500     0        4    2.63%        2        2        0
  ...

Note the new 'Node' column next to the 'Offset'.

  =================================================
        Shared Cache Line Distribution Pareto
  =================================================
  #
  #        ----- HITM -----  -- Store Refs --        Data address
  #   Num      Rmt      Lcl   L1 Hit  L1 Miss              Offset  Node      Pid
  # .....  .......  .......  .......  .......  ..................  ....  .......
  #
    -------------------------------------------------------------
        0        0        8       32        2      0x7f0830100000
    -------------------------------------------------------------
             0.00%   75.00%   21.88%    0.00%                0x18     0     1791
             0.00%   12.50%   37.50%    0.00%                0x18     0     1791
             0.00%    0.00%   34.38%    0.00%                0x18     0     1791

Using the mem2node object to get the NUMA node data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180309101442.9224-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 119 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 821112e8ba97..45c047fdd7ac 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -32,6 +32,7 @@
 #include "evsel.h"
 #include "ui/browsers/hists.h"
 #include "thread.h"
+#include "mem2node.h"
 
 struct c2c_hists {
 	struct hists		hists;
@@ -49,6 +50,7 @@ struct c2c_hist_entry {
 	struct c2c_hists	*hists;
 	struct c2c_stats	 stats;
 	unsigned long		*cpuset;
+	unsigned long		*nodeset;
 	struct c2c_stats	*node_stats;
 	unsigned int		 cacheline_idx;
 
@@ -59,6 +61,11 @@ struct c2c_hist_entry {
 	 * because of its callchain dynamic entry
 	 */
 	struct hist_entry	he;
+
+	unsigned long		 paddr;
+	unsigned long		 paddr_cnt;
+	bool			 paddr_zero;
+	char			*nodestr;
 };
 
 static char const *coalesce_default = "pid,iaddr";
@@ -66,6 +73,7 @@ static char const *coalesce_default = "pid,iaddr";
 struct perf_c2c {
 	struct perf_tool	tool;
 	struct c2c_hists	hists;
+	struct mem2node		mem2node;
 
 	unsigned long		**nodes;
 	int			 nodes_cnt;
@@ -123,6 +131,10 @@ static void *c2c_he_zalloc(size_t size)
 	if (!c2c_he->cpuset)
 		return NULL;
 
+	c2c_he->nodeset = bitmap_alloc(c2c.nodes_cnt);
+	if (!c2c_he->nodeset)
+		return NULL;
+
 	c2c_he->node_stats = zalloc(c2c.nodes_cnt * sizeof(*c2c_he->node_stats));
 	if (!c2c_he->node_stats)
 		return NULL;
@@ -145,6 +157,8 @@ static void c2c_he_free(void *he)
 	}
 
 	free(c2c_he->cpuset);
+	free(c2c_he->nodeset);
+	free(c2c_he->nodestr);
 	free(c2c_he->node_stats);
 	free(c2c_he);
 }
@@ -194,6 +208,28 @@ static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
 	set_bit(sample->cpu, c2c_he->cpuset);
 }
 
+static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
+			     struct perf_sample *sample)
+{
+	int node;
+
+	if (!sample->phys_addr) {
+		c2c_he->paddr_zero = true;
+		return;
+	}
+
+	node = mem2node__node(&c2c.mem2node, sample->phys_addr);
+	if (WARN_ONCE(node < 0, "WARNING: failed to find node\n"))
+		return;
+
+	set_bit(node, c2c_he->nodeset);
+
+	if (c2c_he->paddr != sample->phys_addr) {
+		c2c_he->paddr_cnt++;
+		c2c_he->paddr = sample->phys_addr;
+	}
+}
+
 static void compute_stats(struct c2c_hist_entry *c2c_he,
 			  struct c2c_stats *stats,
 			  u64 weight)
@@ -257,6 +293,7 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 	c2c_add_stats(&c2c_hists->stats, &stats);
 
 	c2c_he__set_cpu(c2c_he, sample);
+	c2c_he__set_node(c2c_he, sample);
 
 	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 	ret = hist_entry__append_callchain(he, sample);
@@ -293,6 +330,7 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 		compute_stats(c2c_he, &stats, sample->weight);
 
 		c2c_he__set_cpu(c2c_he, sample);
+		c2c_he__set_node(c2c_he, sample);
 
 		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 		ret = hist_entry__append_callchain(he, sample);
@@ -455,6 +493,20 @@ static int dcacheline_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
 }
 
+static int
+dcacheline_node_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		      struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	if (WARN_ON_ONCE(!c2c_he->nodestr))
+		return 0;
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, c2c_he->nodestr);
+}
+
 static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			struct hist_entry *he)
 {
@@ -1207,6 +1259,14 @@ static struct c2c_dimension dim_dcacheline = {
 	.width		= 18,
 };
 
+static struct c2c_dimension dim_dcacheline_node = {
+	.header		= HEADER_LOW("Node"),
+	.name		= "dcacheline_node",
+	.cmp		= empty_cmp,
+	.entry		= dcacheline_node_entry,
+	.width		= 4,
+};
+
 static struct c2c_header header_offset_tui = HEADER_LOW("Off");
 
 static struct c2c_dimension dim_offset = {
@@ -1217,6 +1277,14 @@ static struct c2c_dimension dim_offset = {
 	.width		= 18,
 };
 
+static struct c2c_dimension dim_offset_node = {
+	.header		= HEADER_LOW("Node"),
+	.name		= "offset_node",
+	.cmp		= empty_cmp,
+	.entry		= dcacheline_node_entry,
+	.width		= 4,
+};
+
 static struct c2c_dimension dim_iaddr = {
 	.header		= HEADER_LOW("Code address"),
 	.name		= "iaddr",
@@ -1536,7 +1604,9 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
 
 static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline,
+	&dim_dcacheline_node,
 	&dim_offset,
+	&dim_offset_node,
 	&dim_iaddr,
 	&dim_tot_hitm,
 	&dim_lcl_hitm,
@@ -1839,12 +1909,44 @@ static inline int valid_hitm_or_store(struct hist_entry *he)
 	return has_hitm || c2c_he->stats.store;
 }
 
+static void set_node_width(struct c2c_hist_entry *c2c_he, int len)
+{
+	struct c2c_dimension *dim;
+
+	dim = &c2c.hists == c2c_he->hists ?
+	      &dim_dcacheline_node : &dim_offset_node;
+
+	if (len > dim->width)
+		dim->width = len;
+}
+
+static int set_nodestr(struct c2c_hist_entry *c2c_he)
+{
+	char buf[30];
+	int len;
+
+	if (c2c_he->nodestr)
+		return 0;
+
+	if (bitmap_weight(c2c_he->nodeset, c2c.nodes_cnt)) {
+		len = bitmap_scnprintf(c2c_he->nodeset, c2c.nodes_cnt,
+				      buf, sizeof(buf));
+	} else {
+		len = scnprintf(buf, sizeof(buf), "N/A");
+	}
+
+	set_node_width(c2c_he, len);
+	c2c_he->nodestr = strdup(buf);
+	return c2c_he->nodestr ? 0 : -ENOMEM;
+}
+
 static void calc_width(struct c2c_hist_entry *c2c_he)
 {
 	struct c2c_hists *c2c_hists;
 
 	c2c_hists = container_of(c2c_he->he.hists, struct c2c_hists, hists);
 	hists__calc_col_len(&c2c_hists->hists, &c2c_he->he);
+	set_nodestr(c2c_he);
 }
 
 static int filter_cb(struct hist_entry *he)
@@ -2474,7 +2576,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		"percent_lcl_hitm,"
 		"percent_stores_l1hit,"
 		"percent_stores_l1miss,"
-		"offset,",
+		"offset,offset_node,",
 		add_pid   ? "pid," : "",
 		add_tid   ? "tid," : "",
 		add_iaddr ? "iaddr," : "",
@@ -2603,17 +2705,21 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out;
 	}
 
-	err = setup_callchain(session->evlist);
+	err = mem2node__init(&c2c.mem2node, &session->header.env);
 	if (err)
 		goto out_session;
 
+	err = setup_callchain(session->evlist);
+	if (err)
+		goto out_mem2node;
+
 	if (symbol__init(&session->header.env) < 0)
-		goto out_session;
+		goto out_mem2node;
 
 	/* No pipe support at the moment. */
 	if (perf_data__is_pipe(session->data)) {
 		pr_debug("No pipe support at the moment.\n");
-		goto out_session;
+		goto out_mem2node;
 	}
 
 	if (c2c.use_stdio)
@@ -2626,12 +2732,13 @@ static int perf_c2c__report(int argc, const char **argv)
 	err = perf_session__process_events(session);
 	if (err) {
 		pr_err("failed to process sample\n");
-		goto out_session;
+		goto out_mem2node;
 	}
 
 	c2c_hists__reinit(&c2c.hists,
 			"cl_idx,"
 			"dcacheline,"
+			"dcacheline_node,"
 			"tot_recs,"
 			"percent_hitm,"
 			"tot_hitm,lcl_hitm,rmt_hitm,"
@@ -2657,6 +2764,8 @@ static int perf_c2c__report(int argc, const char **argv)
 
 	perf_c2c_display(session);
 
+out_mem2node:
+	mem2node__exit(&c2c.mem2node);
 out_session:
 	perf_session__delete(session);
 out:
