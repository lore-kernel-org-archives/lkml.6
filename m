Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeESLqd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:46:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeESLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:46:29 -0400
Date: Sat, 19 May 2018 04:46:08 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-48659ebf37e5d9d23bda6dbf032bdbe9708929f1@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, ak@linux.intel.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        kan.liang@linux.intel.com, yao.jin@linux.intel.com, acme@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, yao.jin@linux.intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, ak@linux.intel.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <1526569118-14217-2-git-send-email-yao.jin@linux.intel.com>
References: <1526569118-14217-2-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Record the min/max cycles
Git-Commit-ID: 48659ebf37e5d9d23bda6dbf032bdbe9708929f1
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

Commit-ID:  48659ebf37e5d9d23bda6dbf032bdbe9708929f1
Gitweb:     https://git.kernel.org/tip/48659ebf37e5d9d23bda6dbf032bdbe9708929f1
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Thu, 17 May 2018 22:58:37 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 18 May 2018 16:31:41 -0300

perf annotate: Record the min/max cycles

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
