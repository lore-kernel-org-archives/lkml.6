Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753690AbeCXUHd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753040AbeCXUFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:05:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AA02172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Petr Machata <petrm@mellanox.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 40/44] perf python: Reference Py_None before returning it
Date: Sat, 24 Mar 2018 17:02:07 -0300
Message-Id: <20180324200211.21326-41-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

Python None objects are handled just like all the other objects with
respect to their reference counting. Before returning Py_None, its
reference count thus needs to be bumped.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Machata <petrm@mellanox.com>
Link: http://lkml.kernel.org/r/b1e565ecccf68064d8d54f37db5d028dda8fa522.1521675563.git.petrm@mellanox.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b956868fd445..863b61478edd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1004,8 +1004,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 			return PyErr_NoMemory();
 
 		evsel = perf_evlist__event2evsel(evlist, event);
-		if (!evsel)
+		if (!evsel) {
+			Py_INCREF(Py_None);
 			return Py_None;
+		}
 
 		pevent->evsel = evsel;
 
-- 
2.14.3
