Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeEQHE4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:04:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:58279 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeEQHEw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:04:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="224944269"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 1/2] perf annotate: Record the max/min cycles
Date: Thu, 17 May 2018 22:58:37 +0800
Message-Id: <1526569118-14217-2-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526569118-14217-1-git-send-email-yao.jin@linux.intel.com>
References: <1526569118-14217-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf has a feature to account cycles for LBRs

For example, on skylake,
perf record -b ...
perf report or perf annotate

And then browsing the annotate browser gives average cycle counts
for program blocks.

For some analysis it would be useful if we could know not only
the average cycles but also the max and min cycles.

This patch records the max and min cycles.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/annotate.c | 14 +++++++++++++-
 tools/perf/util/annotate.h |  4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 536ee14..934a172 100644
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
index f28a9e4..d50363d 100644
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
2.7.4
