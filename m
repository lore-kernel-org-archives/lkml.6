Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968082AbeBOM27 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:28:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968029AbeBOM0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:26:50 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 8/9] perf tools: Do not create kernel maps in sample__resolve
Date: Thu, 15 Feb 2018 13:26:34 +0100
Message-Id: <20180215122635.24029-9-jolsa@kernel.org>
In-Reply-To: <20180215122635.24029-1-jolsa@kernel.org>
References: <20180215122635.24029-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need for kernel maps to be allocated at this
point - sample processing.

We search for kernel maps using the kernel map_groups in
machine::kmaps which is static. If vmlinux maps for any
reason still don't exist, the search correctly fails
because they are not in the map group.

Link: http://lkml.kernel.org/n/tip-f1swg55ooc3sihcvadgzkw1z@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.13.6
