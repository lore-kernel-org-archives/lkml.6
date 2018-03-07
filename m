Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934073AbeCGPvZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:51:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934075AbeCGPuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:50:55 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 14/19] perf c2c report: Add span header over cacheline data
Date: Wed,  7 Mar 2018 16:50:15 +0100
Message-Id: <20180307155020.32613-15-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forcing the NUMA node output to be grouped with the Cacheline
column in both Shared Data Cache Line Table and Shared Cache
Line Distribution Pareto.

Before:
  #                                    Total      Tot  ----- LLC Load Hitm -----
  # Index           Cacheline  Node  records     Hitm    Total      Lcl      Rmt
  # .....  ..................  ....  .......  .......  .......  .......  .......
  #
        0      0x7f0830100000     0       84   10.53%        8        8        0
        1  0xffff922a93154200     0        3    2.63%        2        2        0
        2  0xffff922a93154500     0        4    2.63%        2        2        0

After:
  #        ------- Cacheline ------    Total      Tot  ----- LLC Load Hitm -----
  # Index             Address  Node  records     Hitm    Total      Lcl      Rmt
  # .....  ..................  ....  .......  .......  .......  .......  .......
  #
        0      0x7f0830100000     0       84   10.53%        8        8        0
        1  0xffff922a93154200     0        3    2.63%        2        2        0
        2  0xffff922a93154500     0        4    2.63%        2        2        0

Before:
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

After:
  #        ----- HITM -----  -- Store Refs --  ----- Data address -----
  #   Num      Rmt      Lcl   L1 Hit  L1 Miss              Offset  Node      Pid
  # .....  .......  .......  .......  .......  ..................  ....  .......
  #
    -------------------------------------------------------------
        0        0        8       32        2      0x7f0830100000
    -------------------------------------------------------------
             0.00%   75.00%   21.88%    0.00%                0x18     0     1791
             0.00%   12.50%   37.50%    0.00%                0x18     0     1791
             0.00%    0.00%   34.38%    0.00%                0x18     0     1791

Link: http://lkml.kernel.org/n/tip-j8d4zhimuz1qh3obbaucc8eq@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-c2c.c | 65 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 45c047fdd7ac..3790a7e0c51d 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1252,7 +1252,7 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	}
 
 static struct c2c_dimension dim_dcacheline = {
-	.header		= HEADER_LOW("Cacheline"),
+	.header		= HEADER_SPAN("--- Cacheline ----", "Address", 1),
 	.name		= "dcacheline",
 	.cmp		= dcacheline_cmp,
 	.entry		= dcacheline_entry,
@@ -1267,10 +1267,10 @@ static struct c2c_dimension dim_dcacheline_node = {
 	.width		= 4,
 };
 
-static struct c2c_header header_offset_tui = HEADER_LOW("Off");
+static struct c2c_header header_offset_tui = HEADER_SPAN("-----", "Off", 1);
 
 static struct c2c_dimension dim_offset = {
-	.header		= HEADER_BOTH("Data address", "Offset"),
+	.header		= HEADER_SPAN("--- Data address -", "Offset", 1),
 	.name		= "offset",
 	.cmp		= offset_cmp,
 	.entry		= offset_entry,
@@ -2453,14 +2453,66 @@ static void perf_c2c_display(struct perf_session *session)
 }
 #endif /* HAVE_SLANG_SUPPORT */
 
-static void ui_quirks(void)
+static char *fill_line(const char *orig, int len)
 {
+	int i, j, olen = strlen(orig);
+	char *buf;
+
+	buf = zalloc(len + 1);
+	if (!buf)
+		return NULL;
+
+	j = len / 2 - olen / 2;
+
+	for (i = 0; i < j - 1; i++) {
+		buf[i] = '-';
+	}
+
+	buf[i++] = ' ';
+
+	strcpy(buf + i, orig);
+
+	i += olen;
+
+	buf[i++] = ' ';
+
+	for (; i < len; i++) {
+		buf[i] = '-';
+	}
+
+	return buf;
+}
+
+static int ui_quirks(void)
+{
+	const char *nodestr = "Data address";
+	char *buf;
+
 	if (!c2c.use_stdio) {
 		dim_offset.width  = 5;
 		dim_offset.header = header_offset_tui;
+		nodestr = "CL";
 	}
 
 	dim_percent_hitm.header = percent_hitm_header[c2c.display];
+
+	/* Fix the zero line for dcacheline column. */
+	buf = fill_line("Cacheline", dim_dcacheline.width +
+				     dim_dcacheline_node.width + 2);
+	if (!buf)
+		return -ENOMEM;
+
+	dim_dcacheline.header.line[0].text = buf;
+
+	/* Fix the zero line for offset column. */
+	buf = fill_line(nodestr, dim_offset.width +
+			      dim_offset_node.width + 2);
+	if (!buf)
+		return -ENOMEM;
+
+	dim_offset.header.line[0].text = buf;
+
+	return 0;
 }
 
 #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
@@ -2760,7 +2812,10 @@ static int perf_c2c__report(int argc, const char **argv)
 
 	ui_progress__finish();
 
-	ui_quirks();
+	if (ui_quirks()) {
+		pr_err("failed to setup UI\n");
+		goto out_mem2node;
+	}
 
 	perf_c2c_display(session);
 
-- 
2.13.6
