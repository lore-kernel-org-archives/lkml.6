Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934108AbeCGPu7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:50:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933890AbeCGPu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:50:57 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 15/19] perf c2c report: Add cacheline address count column
Date: Wed,  7 Mar 2018 16:50:16 +0100
Message-Id: <20180307155020.32613-16-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the 'PA cnt' column grouped under data cacheline address.

It shows how many times the physical addresses changed for the
hist entry. It does not show the number of different physical
addresses for entry, because we don't store those. We only track
the number of times we got different address than we currently
hold, which is not expensive and gives similar info.

  $ perf c2c report --stdio

  #        ----------- Cacheline ----------    Total      Tot  ----- LLC Load Hitm -----
  # Index             Address  Node  PA cnt  records     Hitm    Total      Lcl      Rmt
  # .....  ..................  ....  ......  .......  .......  .......  .......  .......
  #
        0  0xffff9ad56dca0a80     0       9       10    7.69%        2        2        0
        1  0xffff9ad56dce0a80     0       9        9    7.69%        2        2        0
        2  0xffff9ad37659ad80     0       1        2    3.85%        1        1        0

  ...

  #        ----- HITM -----  -- Store Refs --  --------- Data address ---------
  #   Num      Rmt      Lcl   L1 Hit  L1 Miss              Offset  Node  PA cnt      Pid
  # .....  .......  .......  .......  .......  ..................  ....  ......  .......
  #
    -------------------------------------------------------------
        0        0        2        3        0  0xffff9ad56dca0a80
    -------------------------------------------------------------
             0.00%    0.00%   33.33%    0.00%                 0x0     0       1     2510
             0.00%    0.00%   33.33%    0.00%                 0x4     0       1     2476
             0.00%    0.00%   33.33%    0.00%                0x20     0       1        0
             0.00%  100.00%    0.00%    0.00%                0x38     0       1        0

Link: http://lkml.kernel.org/n/tip-j8d4zhimuz1qh3obbaucc8eq@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-c2c.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3790a7e0c51d..5a0f5067dfe9 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -507,6 +507,17 @@ dcacheline_node_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, c2c_he->nodestr);
 }
 
+static int
+dcacheline_node_count(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		      struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	return scnprintf(hpp->buf, hpp->size, "%*lu", width, c2c_he->paddr_cnt);
+}
+
 static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			struct hist_entry *he)
 {
@@ -1252,7 +1263,7 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	}
 
 static struct c2c_dimension dim_dcacheline = {
-	.header		= HEADER_SPAN("--- Cacheline ----", "Address", 1),
+	.header		= HEADER_SPAN("--- Cacheline ----", "Address", 2),
 	.name		= "dcacheline",
 	.cmp		= dcacheline_cmp,
 	.entry		= dcacheline_entry,
@@ -1267,10 +1278,18 @@ static struct c2c_dimension dim_dcacheline_node = {
 	.width		= 4,
 };
 
-static struct c2c_header header_offset_tui = HEADER_SPAN("-----", "Off", 1);
+static struct c2c_dimension dim_dcacheline_count = {
+	.header		= HEADER_LOW("PA cnt"),
+	.name		= "dcacheline_count",
+	.cmp		= empty_cmp,
+	.entry		= dcacheline_node_count,
+	.width		= 6,
+};
+
+static struct c2c_header header_offset_tui = HEADER_SPAN("-----", "Off", 2);
 
 static struct c2c_dimension dim_offset = {
-	.header		= HEADER_SPAN("--- Data address -", "Offset", 1),
+	.header		= HEADER_SPAN("--- Data address -", "Offset", 2),
 	.name		= "offset",
 	.cmp		= offset_cmp,
 	.entry		= offset_entry,
@@ -1605,6 +1624,7 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
 static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline,
 	&dim_dcacheline_node,
+	&dim_dcacheline_count,
 	&dim_offset,
 	&dim_offset_node,
 	&dim_iaddr,
@@ -2498,7 +2518,8 @@ static int ui_quirks(void)
 
 	/* Fix the zero line for dcacheline column. */
 	buf = fill_line("Cacheline", dim_dcacheline.width +
-				     dim_dcacheline_node.width + 2);
+				     dim_dcacheline_node.width +
+				     dim_dcacheline_count.width + 4);
 	if (!buf)
 		return -ENOMEM;
 
@@ -2506,7 +2527,8 @@ static int ui_quirks(void)
 
 	/* Fix the zero line for offset column. */
 	buf = fill_line(nodestr, dim_offset.width +
-			      dim_offset_node.width + 2);
+			         dim_offset_node.width +
+				 dim_dcacheline_count.width + 4);
 	if (!buf)
 		return -ENOMEM;
 
@@ -2628,7 +2650,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		"percent_lcl_hitm,"
 		"percent_stores_l1hit,"
 		"percent_stores_l1miss,"
-		"offset,offset_node,",
+		"offset,offset_node,dcacheline_count,",
 		add_pid   ? "pid," : "",
 		add_tid   ? "tid," : "",
 		add_iaddr ? "iaddr," : "",
@@ -2791,6 +2813,7 @@ static int perf_c2c__report(int argc, const char **argv)
 			"cl_idx,"
 			"dcacheline,"
 			"dcacheline_node,"
+			"dcacheline_count,"
 			"tot_recs,"
 			"percent_hitm,"
 			"tot_hitm,lcl_hitm,rmt_hitm,"
-- 
2.13.6
