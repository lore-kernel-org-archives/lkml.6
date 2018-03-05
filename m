Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeCEOa7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751400AbeCEOa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:30:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2AF206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/28] perf python: Switch to new perf_mmap__read_event() interface
Date: Mon,  5 Mar 2018 11:29:21 -0300
Message-Id: <20180305142932.16921-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf python binding still use the legacy interface.

No functional change.

Committer notes:

Tested before and after with:

  [root@jouet perf]# export PYTHONPATH=/tmp/build/perf/python
  [root@jouet perf]# tools/perf/python/twatch.py
  cpu: 0, pid: 1183, tid: 6293 { type: exit, pid: 1183, ppid: 1183, tid: 6293, ptid: 6293, time: 17886646588257}
  cpu: 2, pid: 13820, tid: 13820 { type: fork, pid: 13820, ppid: 13820, tid: 6306, ptid: 13820, time: 17886869099529}
  cpu: 1, pid: 13820, tid: 6306 { type: comm, pid: 13820, tid: 6306, comm: TaskSchedulerFo }
  ^CTraceback (most recent call last):
    File "tools/perf/python/twatch.py", line 68, in <module>
      main()
    File "tools/perf/python/twatch.py", line 40, in main
      evlist.poll(timeout = -1)
  KeyboardInterrupt
  [root@jouet perf]#

No problems found.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-3-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2918cac7a142..35fb5ef7d290 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -983,13 +983,19 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 	union perf_event *event;
 	int sample_id_all = 1, cpu;
 	static char *kwlist[] = { "cpu", "sample_id_all", NULL };
+	struct perf_mmap *md;
+	u64 end, start;
 	int err;
 
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|i", kwlist,
 					 &cpu, &sample_id_all))
 		return NULL;
 
-	event = perf_evlist__mmap_read(evlist, cpu);
+	md = &evlist->mmap[cpu];
+	if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		goto end;
+
+	event = perf_mmap__read_event(md, false, &start, end);
 	if (event != NULL) {
 		PyObject *pyevent = pyrf_event__new(event);
 		struct pyrf_event *pevent = (struct pyrf_event *)pyevent;
@@ -1007,14 +1013,14 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		err = perf_evsel__parse_sample(evsel, event, &pevent->sample);
 
 		/* Consume the even only after we parsed it out. */
-		perf_evlist__mmap_consume(evlist, cpu);
+		perf_mmap__consume(md, false);
 
 		if (err)
 			return PyErr_Format(PyExc_OSError,
 					    "perf: can't parse sample, err=%d", err);
 		return pyevent;
 	}
-
+end:
 	Py_INCREF(Py_None);
 	return Py_None;
 }
-- 
2.14.3
