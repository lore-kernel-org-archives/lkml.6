Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163024AbeCAXNN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:13:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:30247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162889AbeCAXKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:10:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208165002"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 05/14] perf test: Apply new perf_mmap__read_event() interface for code reading
Date: Thu,  1 Mar 2018 18:09:02 -0500
Message-Id: <1519945751-37786-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 'object code reading' still use the legacy interface.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/code-reading.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index c7115d3..40bbec9 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -409,15 +409,22 @@ static int process_events(struct machine *machine, struct perf_evlist *evlist,
 			  struct state *state)
 {
 	union perf_event *event;
+	struct perf_mmap *md;
+	u64 end, start;
 	int i, ret;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+		md = &evlist->mmap[i];
+		if (perf_mmap__read_init(md, 0, &start, &end) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(md, 0, &start, end)) != NULL) {
 			ret = process_event(machine, evlist, event, state);
-			perf_evlist__mmap_consume(evlist, i);
+			perf_mmap__consume(md, 0);
 			if (ret < 0)
 				return ret;
 		}
+		perf_mmap__read_done(md);
 	}
 	return 0;
 }
-- 
2.4.11
