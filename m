Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbeEBPZ3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752226AbeEBPWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:22:02 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 39/52] perf machine: Set PROT_EXEC for executable PERF_RECORD_MMAP records
Date: Wed,  2 May 2018 12:19:29 -0300
Message-Id: <20180502151942.20542-40-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The kernel doesn't fill the map 'prot' field for PERF_RECORD_MMAP
records, and we will use that info to replace checking for
MAP__VARIABLE, so store that when processing the
PERF_RECORD_MISC_MMAP_DATA perf_event_attr.header.misc bit.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-es3zz9r0q2qlssg4wh1w1d8p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3422ef67ec21..53bc2fb88be4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -24,6 +24,7 @@
 
 #include "sane_ctype.h"
 #include <symbol/kallsyms.h>
+#include <linux/mman.h>
 
 static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
 
@@ -1457,6 +1458,7 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 	struct thread *thread;
 	struct map *map;
 	enum map_type type;
+	u32 prot = 0;
 	int ret = 0;
 
 	if (dump_trace)
@@ -1477,12 +1479,14 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 
 	if (event->header.misc & PERF_RECORD_MISC_MMAP_DATA)
 		type = MAP__VARIABLE;
-	else
+	else {
 		type = MAP__FUNCTION;
+		prot = PROT_EXEC;
+	}
 
 	map = map__new(machine, event->mmap.start,
 			event->mmap.len, event->mmap.pgoff,
-			0, 0, 0, 0, 0, 0,
+			0, 0, 0, 0, prot, 0,
 			event->mmap.filename,
 			type, thread);
 
-- 
2.14.3
