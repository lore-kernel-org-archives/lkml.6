Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932386AbeEHV1z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:27:55 -0400
Received: from a8-126.smtp-out.amazonses.com ([54.240.8.126]:56886 "EHLO
        a8-126.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756018AbeEHV1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:27:49 -0400
From: Jeremy Cline <jeremy@jcline.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 6/8] perf scripts python: Add Python 3 support to sched-migration.py
Date: Tue, 8 May 2018 21:27:47 +0000
Message-ID: <0100016341a737a5-44ec436f-3440-4cac-a03f-ddfa589bf308-000000@email.amazonses.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525811971.git.jeremy@jcline.org>
References: <cover.1525811971.git.jeremy@jcline.org>
X-SES-Outgoing: 2018.05.08-54.240.8.126
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in the sched-migration.py script.
This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 tools/perf/scripts/python/sched-migration.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/sched-migration.py b/tools/perf/scripts/python/sched-migration.py
index de66cb3b72c9..3473e7f66081 100644
--- a/tools/perf/scripts/python/sched-migration.py
+++ b/tools/perf/scripts/python/sched-migration.py
@@ -9,13 +9,17 @@
 # This software is distributed under the terms of the GNU General
 # Public License ("GPL") version 2 as published by the Free Software
 # Foundation.
-
+from __future__ import print_function
 
 import os
 import sys
 
 from collections import defaultdict
-from UserList import UserList
+try:
+    from UserList import UserList
+except ImportError:
+    # Python 3: UserList moved to the collections package
+    from collections import UserList
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -300,7 +304,7 @@ class TimeSliceList(UserList):
 		if i == -1:
 			return
 
-		for i in xrange(i, len(self.data)):
+		for i in range(i, len(self.data)):
 			timeslice = self.data[i]
 			if timeslice.start > end:
 				return
@@ -336,8 +340,8 @@ class SchedEventProxy:
 		on_cpu_task = self.current_tsk[headers.cpu]
 
 		if on_cpu_task != -1 and on_cpu_task != prev_pid:
-			print "Sched switch event rejected ts: %s cpu: %d prev: %s(%d) next: %s(%d)" % \
-				(headers.ts_format(), headers.cpu, prev_comm, prev_pid, next_comm, next_pid)
+			print("Sched switch event rejected ts: %s cpu: %d prev: %s(%d) next: %s(%d)" % \
+				headers.ts_format(), headers.cpu, prev_comm, prev_pid, next_comm, next_pid)
 
 		threads[prev_pid] = prev_comm
 		threads[next_pid] = next_comm
-- 
2.17.0
