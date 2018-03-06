Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbeCFGta (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:49:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52117 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeCFGt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:49:29 -0500
Date: Mon, 5 Mar 2018 22:49:19 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-693d32aebf857ef1d1803b08ef1b631990ae3747@git.kernel.org>
Cc: jolsa@redhat.com, wangnan0@huawei.com, kan.liang@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, acme@redhat.com, hpa@zytor.com, ak@linux.intel.com
Reply-To: tglx@linutronix.de, jolsa@redhat.com, kan.liang@linux.intel.com,
        wangnan0@huawei.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, ak@linux.intel.com, acme@redhat.com, hpa@zytor.com
In-Reply-To: <1519945751-37786-6-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-6-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Switch to new perf_mmap__read_event()
 interface for "keep tracking" test
Git-Commit-ID: 693d32aebf857ef1d1803b08ef1b631990ae3747
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

Commit-ID:  693d32aebf857ef1d1803b08ef1b631990ae3747
Gitweb:     https://git.kernel.org/tip/693d32aebf857ef1d1803b08ef1b631990ae3747
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:03 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:49:01 -0300

perf test: Switch to new perf_mmap__read_event() interface for "keep tracking" test

The perf test 'keep tracking' still use the legacy interface.

No functional change.

Committer testing:

  # perf test tracking
  25: Use a dummy software event to keep tracking           : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-6-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/keep-tracking.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index c46530918938..4590d8fb91ab 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -27,18 +27,24 @@
 static int find_comm(struct perf_evlist *evlist, const char *comm)
 {
 	union perf_event *event;
+	struct perf_mmap *md;
+	u64 end, start;
 	int i, found;
 
 	found = 0;
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+		md = &evlist->mmap[i];
+		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			continue;
+		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 			if (event->header.type == PERF_RECORD_COMM &&
 			    (pid_t)event->comm.pid == getpid() &&
 			    (pid_t)event->comm.tid == getpid() &&
 			    strcmp(event->comm.comm, comm) == 0)
 				found += 1;
-			perf_evlist__mmap_consume(evlist, i);
+			perf_mmap__consume(md, false);
 		}
+		perf_mmap__read_done(md);
 	}
 	return found;
 }
