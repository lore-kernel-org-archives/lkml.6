Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeCEOaA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:30:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752208AbeCEO3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:29:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9BD21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        weiping zhang <zhangweiping@didichuxing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/28] perf cgroup: Simplify arguments when tracking multiple events
Date: Mon,  5 Mar 2018 11:29:07 -0300
Message-Id: <20180305142932.16921-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: weiping zhang <zhangweiping@didichuxing.com>

When using -G with one cgroup and -e with multiple events, only the
first event gets the correct cgroup setting, all events from the second
onwards will track system-wide events.

If the user wants to track multiple events for a specific cgroup, the
user must give parameters like the following:

  $ perf stat -e e1 -e e2 -e e3 -G test,test,test

This patch simplify this case, just type one cgroup:

  $ perf stat -e e1 -e e2 -e e3 -G test

  $ mkdir -p /sys/fs/cgroup/perf_event/empty_cgroup
  $ perf stat -e cycles -e cache-misses -a -I 1000 -G empty_cgroup

Before:

     1.001007226   <not counted>      cycles	   empty_cgroup
     1.001007226           7,506      cache-misses

After:

     1.000834097   <not counted>      cycles	   empty_cgroup
     1.000834097   <not counted>      cache-misses empty_cgroup

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180129154805.GA6284@localhost.didichuxing.com
[ Improved the doc text a bit, providing an example for cgroup + system wide counting ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  6 +++++-
 tools/perf/Documentation/perf-stat.txt   |  6 +++++-
 tools/perf/util/cgroup.c                 | 17 ++++++++++++++++-
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 3eea6de35a38..76bc2181d214 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -308,7 +308,11 @@ can be provided. Each cgroup is applied to the corresponding event, i.e., first
 to first event, second cgroup to second event and so on. It is possible to provide
 an empty cgroup (monitor all the time) using, e.g., -G foo,,bar. Cgroups must have
 corresponding events, i.e., they always refer to events defined earlier on the command
-line.
+line. If the user wants to track multiple events for a specific cgroup, the user can
+use '-e e1 -e e2 -G foo,foo' or just use '-e e1 -e e2 -G foo'.
+
+If wanting to monitor, say, 'cycles' for a cgroup and also for system wide, this
+command line can be used: 'perf stat -e cycles -G cgroup_name -a -e cycles'.
 
 -b::
 --branch-any::
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 2bbe79a50d3c..2b38e222016a 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -118,7 +118,11 @@ can be provided. Each cgroup is applied to the corresponding event, i.e., first
 to first event, second cgroup to second event and so on. It is possible to provide
 an empty cgroup (monitor all the time) using, e.g., -G foo,,bar. Cgroups must have
 corresponding events, i.e., they always refer to events defined earlier on the command
-line.
+line. If the user wants to track multiple events for a specific cgroup, the user can
+use '-e e1 -e e2 -G foo,foo' or just use '-e e1 -e e2 -G foo'.
+
+If wanting to monitor, say, 'cycles' for a cgroup and also for system wide, this
+command line can be used: 'perf stat -e cycles -G cgroup_name -a -e cycles'.
 
 -o file::
 --output file::
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 984f69144f87..5dd9b5ea314d 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -157,9 +157,11 @@ int parse_cgroups(const struct option *opt __maybe_unused, const char *str,
 		  int unset __maybe_unused)
 {
 	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
+	struct perf_evsel *counter;
+	struct cgroup_sel *cgrp = NULL;
 	const char *p, *e, *eos = str + strlen(str);
 	char *s;
-	int ret;
+	int ret, i;
 
 	if (list_empty(&evlist->entries)) {
 		fprintf(stderr, "must define events before cgroups\n");
@@ -188,5 +190,18 @@ int parse_cgroups(const struct option *opt __maybe_unused, const char *str,
 			break;
 		str = p+1;
 	}
+	/* for the case one cgroup combine to multiple events */
+	i = 0;
+	if (nr_cgroups == 1) {
+		evlist__for_each_entry(evlist, counter) {
+			if (i == 0)
+				cgrp = counter->cgrp;
+			else {
+				counter->cgrp = cgrp;
+				refcount_inc(&cgrp->refcnt);
+			}
+			i++;
+		}
+	}
 	return 0;
 }
-- 
2.14.3
