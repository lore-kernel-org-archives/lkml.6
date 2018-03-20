Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeCTGU3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:20:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50753 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTGU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:20:27 -0400
Date: Mon, 19 Mar 2018 23:19:56 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d0802b1ee2c8b95e960f46fa14fe0fee562cb79a@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        namhyung@kernel.org, jmario@redhat.com, dsahern@gmail.com,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        peterz@infradead.org
Reply-To: dsahern@gmail.com, jmario@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, jolsa@kernel.org, peterz@infradead.org
In-Reply-To: <20180309101442.9224-9-jolsa@kernel.org>
References: <20180309101442.9224-9-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf c2c report: Add span header over cacheline
 data
Git-Commit-ID: d0802b1ee2c8b95e960f46fa14fe0fee562cb79a
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

Commit-ID:  d0802b1ee2c8b95e960f46fa14fe0fee562cb79a
Gitweb:     https://git.kernel.org/tip/d0802b1ee2c8b95e960f46fa14fe0fee562cb79a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 9 Mar 2018 11:14:41 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:53:30 -0300

perf c2c report: Add span header over cacheline data

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
 
