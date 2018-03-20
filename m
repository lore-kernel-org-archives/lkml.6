Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCTGV4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:21:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41035 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCTGUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:20:50 -0400
Date: Mon, 19 Mar 2018 23:20:26 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-03d9fcb701340de3446b4ff4ddb9f5407d1412f5@git.kernel.org>
Cc: acme@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        dsahern@gmail.com, jolsa@kernel.org, hpa@zytor.com, jmario@redhat.com
Reply-To: hpa@zytor.com, jmario@redhat.com, jolsa@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        peterz@infradead.org
In-Reply-To: <20180309101442.9224-10-jolsa@kernel.org>
References: <20180309101442.9224-10-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf c2c report: Add cacheline address count column
Git-Commit-ID: 03d9fcb701340de3446b4ff4ddb9f5407d1412f5
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

Commit-ID:  03d9fcb701340de3446b4ff4ddb9f5407d1412f5
Gitweb:     https://git.kernel.org/tip/03d9fcb701340de3446b4ff4ddb9f5407d1412f5
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 9 Mar 2018 11:14:42 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:53:38 -0300

perf c2c report: Add cacheline address count column

Adding the 'PA cnt' column grouped under data cacheline address.

It shows how many times the physical addresses changed for the hist
entry. It does not show the number of different physical addresses for
entry, because we don't store those. We only track the number of times
we got different address than we currently hold, which is not expensive
and gives similar info.

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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180309101442.9224-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a6336e4e2850..2126bfbcb385 100644
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
@@ -2496,7 +2516,8 @@ static int ui_quirks(void)
 
 	/* Fix the zero line for dcacheline column. */
 	buf = fill_line("Cacheline", dim_dcacheline.width +
-				     dim_dcacheline_node.width + 2);
+				     dim_dcacheline_node.width +
+				     dim_dcacheline_count.width + 4);
 	if (!buf)
 		return -ENOMEM;
 
@@ -2504,7 +2525,8 @@ static int ui_quirks(void)
 
 	/* Fix the zero line for offset column. */
 	buf = fill_line(nodestr, dim_offset.width +
-			      dim_offset_node.width + 2);
+			         dim_offset_node.width +
+				 dim_dcacheline_count.width + 4);
 	if (!buf)
 		return -ENOMEM;
 
@@ -2626,7 +2648,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		"percent_lcl_hitm,"
 		"percent_stores_l1hit,"
 		"percent_stores_l1miss,"
-		"offset,offset_node,",
+		"offset,offset_node,dcacheline_count,",
 		add_pid   ? "pid," : "",
 		add_tid   ? "tid," : "",
 		add_iaddr ? "iaddr," : "",
@@ -2789,6 +2811,7 @@ static int perf_c2c__report(int argc, const char **argv)
 			"cl_idx,"
 			"dcacheline,"
 			"dcacheline_node,"
+			"dcacheline_count,"
 			"tot_recs,"
 			"percent_hitm,"
 			"tot_hitm,lcl_hitm,rmt_hitm,"
