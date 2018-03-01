Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163074AbeCAXN7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:13:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:30247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162811AbeCAXJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:09:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208164989"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 03/14] perf python: Apply new perf_mmap__read_event() interface
Date: Thu,  1 Mar 2018 18:09:00 -0500
Message-Id: <1519945751-37786-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf python still use the legacy interface.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/python.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2918cac..62aed42 100644
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
+	if (perf_mmap__read_init(md, 0, &start, &end) < 0)
+		goto end;
+
+	event = perf_mmap__read_event(md, 0, &start, end);
 	if (event != NULL) {
 		PyObject *pyevent = pyrf_event__new(event);
 		struct pyrf_event *pevent = (struct pyrf_event *)pyevent;
@@ -1007,14 +1013,14 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		err = perf_evsel__parse_sample(evsel, event, &pevent->sample);
 
 		/* Consume the even only after we parsed it out. */
-		perf_evlist__mmap_consume(evlist, cpu);
+		perf_mmap__consume(md, 0);
 
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
2.4.11
