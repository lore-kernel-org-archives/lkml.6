Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeBPTTO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753600AbeBPTTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDA3217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/41] perf tools: Do not create kernel maps in sample__resolve()
Date: Fri, 16 Feb 2018 16:17:23 -0300
Message-Id: <20180216191746.11095-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need for kernel maps to be allocated at this point - sample
processing.

We search for kernel maps using the kernel map_groups in machine::kmaps
which is static. If vmlinux maps for any reason still don't exist, the
search correctly fails because they are not in the map group.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180215122635.24029-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 4644e751a3e3..f0a6cbd033cc 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1588,17 +1588,6 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 		return -1;
 
 	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread->tid);
-	/*
-	 * Have we already created the kernel maps for this machine?
-	 *
-	 * This should have happened earlier, when we processed the kernel MMAP
-	 * events, but for older perf.data files there was no such thing, so do
-	 * it now.
-	 */
-	if (sample->cpumode == PERF_RECORD_MISC_KERNEL &&
-	    machine__kernel_map(machine) == NULL)
-		machine__create_kernel_maps(machine);
-
 	thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, sample->ip, al);
 	dump_printf(" ...... dso: %s\n",
 		    al->map ? al->map->dso->long_name :
-- 
2.14.3
