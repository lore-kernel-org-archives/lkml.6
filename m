Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeESK5H (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 06:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752523AbeESK4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 06:56:02 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/18] perf annotate: Record the min/max cycles
Date: Sat, 19 May 2018 07:55:03 -0300
Message-Id: <20180519105507.16450-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Currently perf has a feature to account cycles for LBRs

For example, on skylake:

  perf record -b ...
  perf report or perf annotate

And then browsing the annotate browser gives average cycle counts for
program blocks.

For some analysis it would be useful if we could know not only the
average cycles but also the min and max cycles.

This patch records the min and max cycles.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1526569118-14217-2-git-send-email-yao.jin@linux.intel.com
[ Switch from max/min to min/max ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 14 +++++++++++++-
 tools/perf/util/annotate.h |  4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5d74a30fe00f..4fcfefea3bc2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -760,6 +760,15 @@ static int __symbol__account_cycles(struct annotation *notes,
 	ch[offset].num_aggr++;
 	ch[offset].cycles_aggr += cycles;
 
+	if (cycles > ch[offset].cycles_max)
+		ch[offset].cycles_max = cycles;
+
+	if (ch[offset].cycles_min) {
+		if (cycles && cycles < ch[offset].cycles_min)
+			ch[offset].cycles_min = cycles;
+	} else
+		ch[offset].cycles_min = cycles;
+
 	if (!have_start && ch[offset].have_start)
 		return 0;
 	if (ch[offset].num) {
@@ -953,8 +962,11 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 			if (ch->have_start)
 				annotation__count_and_fill(notes, ch->start, offset, ch);
 			al = notes->offsets[offset];
-			if (al && ch->num_aggr)
+			if (al && ch->num_aggr) {
 				al->cycles = ch->cycles_aggr / ch->num_aggr;
+				al->cycles_max = ch->cycles_max;
+				al->cycles_min = ch->cycles_min;
+			}
 			notes->have_cycles = true;
 		}
 	}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index f28a9e43421d..d50363d56f73 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -105,6 +105,8 @@ struct annotation_line {
 	int			 jump_sources;
 	float			 ipc;
 	u64			 cycles;
+	u64			 cycles_max;
+	u64			 cycles_min;
 	size_t			 privsize;
 	char			*path;
 	u32			 idx;
@@ -186,6 +188,8 @@ struct cyc_hist {
 	u64	start;
 	u64	cycles;
 	u64	cycles_aggr;
+	u64	cycles_max;
+	u64	cycles_min;
 	u32	num;
 	u32	num_aggr;
 	u8	have_start;
-- 
2.14.3
