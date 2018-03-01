Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163028AbeCAXLL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:11:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:30247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162942AbeCAXKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:10:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208165071"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 12/14] perf test: Apply new perf_mmap__read_event() interface for switch-tracking
Date: Thu,  1 Mar 2018 18:09:09 -0500
Message-Id: <1519945751-37786-12-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 'switch-tracking' still use the legacy interface.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/switch-tracking.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 33e0029..b01277c 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -258,16 +258,23 @@ static int process_events(struct perf_evlist *evlist,
 	unsigned pos, cnt = 0;
 	LIST_HEAD(events);
 	struct event_node *events_array, *node;
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
 			cnt += 1;
 			ret = add_event(evlist, &events, event);
-			perf_evlist__mmap_consume(evlist, i);
+			 perf_mmap__consume(md, 0);
 			if (ret < 0)
 				goto out_free_nodes;
 		}
+		perf_mmap__read_done(md);
 	}
 
 	events_array = calloc(cnt, sizeof(struct event_node));
-- 
2.4.11
