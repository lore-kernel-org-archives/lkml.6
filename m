Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeEBR7G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:59:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49221 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeEBR7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:59:03 -0400
Date: Wed, 2 May 2018 10:58:52 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-es3zz9r0q2qlssg4wh1w1d8p@git.kernel.org>
Cc: adrian.hunter@intel.com, jolsa@kernel.org, namhyung@kernel.org,
        dsahern@gmail.com, wangnan0@huawei.com, hpa@zytor.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: wangnan0@huawei.com, hpa@zytor.com, dsahern@gmail.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Set PROT_EXEC for executable
 PERF_RECORD_MMAP records
Git-Commit-ID: 0f476f2bbc1b46f76f9383dfe647858a888549aa
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

Commit-ID:  0f476f2bbc1b46f76f9383dfe647858a888549aa
Gitweb:     https://git.kernel.org/tip/0f476f2bbc1b46f76f9383dfe647858a888549aa
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Apr 2018 11:30:50 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:19 -0300

perf machine: Set PROT_EXEC for executable PERF_RECORD_MMAP records

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
 
