Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeCFGsN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:48:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37669 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbeCFGsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:48:11 -0500
Date: Mon, 5 Mar 2018 22:47:59 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-35b7cdc6379ea8300161f0f80fe8aad083a1c5d0@git.kernel.org>
Cc: kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, wangnan0@huawei.com, tglx@linutronix.de,
        namhyung@kernel.org, mingo@kernel.org, acme@redhat.com, hpa@zytor.com,
        ak@linux.intel.com
Reply-To: acme@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        namhyung@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, wangnan0@huawei.com,
        kan.liang@linux.intel.com
In-Reply-To: <1519945751-37786-3-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-3-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf python: Switch to new perf_mmap__read_event()
 interface
Git-Commit-ID: 35b7cdc6379ea8300161f0f80fe8aad083a1c5d0
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

Commit-ID:  35b7cdc6379ea8300161f0f80fe8aad083a1c5d0
Gitweb:     https://git.kernel.org/tip/35b7cdc6379ea8300161f0f80fe8aad083a1c5d0
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:00 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:47:07 -0300

perf python: Switch to new perf_mmap__read_event() interface

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
