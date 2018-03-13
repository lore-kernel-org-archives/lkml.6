Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeCMMFx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933137AbeCMMFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:05:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4E42176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Joe Mario <jmario@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/31] perf c2c report: Add span header over cacheline data
Date: Tue, 13 Mar 2018 09:04:45 -0300
Message-Id: <20180313120508.29327-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Forcing the NUMA node output to be grouped with the "Cacheline" column
in both "Shared Data Cache Line Table" and "Shared Cache Line
Distribution Pareto" tables.

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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180309101442.9224-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 63 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 45c047fdd7ac..a6336e4e2850 100644
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
@@ -2453,14 +2453,64 @@ static void perf_c2c_display(struct perf_session *session)
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
+	for (i = 0; i < j - 1; i++)
+		buf[i] = '-';
+
+	buf[i++] = ' ';
+
+	strcpy(buf + i, orig);
+
+	i += olen;
+
+	buf[i++] = ' ';
+
+	for (; i < len; i++)
+		buf[i] = '-';
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
@@ -2760,7 +2810,10 @@ static int perf_c2c__report(int argc, const char **argv)
 
 	ui_progress__finish();
 
-	ui_quirks();
+	if (ui_quirks()) {
+		pr_err("failed to setup UI\n");
+		goto out_mem2node;
+	}
 
 	perf_c2c_display(session);
 
-- 
2.14.3
