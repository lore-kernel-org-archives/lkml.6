Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162880AbeCAXJ7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:09:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:30247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162810AbeCAXJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:09:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208164984"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 02/14] perf trace: Apply new perf_mmap__read_event() interface
Date: Thu,  1 Mar 2018 18:08:59 -0500
Message-Id: <1519945751-37786-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf trace still use the legacy interface.

Apply the new perf_mmap__read_event() interface for perf trace.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-trace.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e7f1b18..a46644f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2472,8 +2472,14 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
+		struct perf_mmap *md;
+		u64 end, start;
 
-		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+		md = &evlist->mmap[i];
+		if (perf_mmap__read_init(md, 0, &start, &end) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(md, 0, &start, end)) != NULL) {
 			struct perf_sample sample;
 
 			++trace->nr_events;
@@ -2486,7 +2492,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 			trace__handle_event(trace, event, &sample);
 next_event:
-			perf_evlist__mmap_consume(evlist, i);
+			perf_mmap__consume(md, 0);
 
 			if (interrupted)
 				goto out_disable;
@@ -2496,6 +2502,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 				draining = true;
 			}
 		}
+		perf_mmap__read_done(md);
 	}
 
 	if (trace->nr_events == before) {
-- 
2.4.11
