Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeBQLiU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:38:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeBQLiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:38:17 -0500
Date: Sat, 17 Feb 2018 03:27:56 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a73e24d240bc136619d382b1268f34d75c9d25ce@git.kernel.org>
Cc: namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, peterz@infradead.org, jolsa@kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, jolsa@kernel.org, dsahern@gmail.com,
        peterz@infradead.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com
In-Reply-To: <20180215122635.24029-9-jolsa@kernel.org>
References: <20180215122635.24029-9-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Do not create kernel maps in
 sample__resolve()
Git-Commit-ID: a73e24d240bc136619d382b1268f34d75c9d25ce
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

Commit-ID:  a73e24d240bc136619d382b1268f34d75c9d25ce
Gitweb:     https://git.kernel.org/tip/a73e24d240bc136619d382b1268f34d75c9d25ce
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 15 Feb 2018 13:26:34 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:25:59 -0300

perf tools: Do not create kernel maps in sample__resolve()

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
index 4644e75..f0a6cbd 100644
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
