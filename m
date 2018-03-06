Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeCFGwS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:52:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752800AbeCFGwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:52:16 -0500
Date: Mon, 5 Mar 2018 22:52:02 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-ee4024ff858211316c4824b16bea446f08765ae8@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, namhyung@kernel.org,
        mingo@kernel.org, kan.liang@linux.intel.com, wangnan0@huawei.com
Reply-To: tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com, hpa@zytor.com,
        namhyung@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, kan.liang@linux.intel.com, wangnan0@huawei.com
In-Reply-To: <1519945751-37786-12-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-12-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Switch to new perf_mmap__read_event()
 interface for switch-tracking
Git-Commit-ID: ee4024ff858211316c4824b16bea446f08765ae8
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

Commit-ID:  ee4024ff858211316c4824b16bea446f08765ae8
Gitweb:     https://git.kernel.org/tip/ee4024ff858211316c4824b16bea446f08765ae8
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:09 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:50:50 -0300

perf test: Switch to new perf_mmap__read_event() interface for switch-tracking

The perf test 'switch-tracking' still use the legacy interface.

No functional change.

Committer testing:

  # perf test switch
  32: Track with sched_switch                               : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-12-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/switch-tracking.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 33e00295a972..10c4dcdc2324 100644
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
+		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 			cnt += 1;
 			ret = add_event(evlist, &events, event);
-			perf_evlist__mmap_consume(evlist, i);
+			 perf_mmap__consume(md, false);
 			if (ret < 0)
 				goto out_free_nodes;
 		}
+		perf_mmap__read_done(md);
 	}
 
 	events_array = calloc(cnt, sizeof(struct event_node));
