Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbeBQLc5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:32:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57487 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbeBQLc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:32:56 -0500
Date: Sat, 17 Feb 2018 03:22:33 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-8614ada0be7d7be84b85c006d526a9c8f76484fa@git.kernel.org>
Cc: namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, namhyung@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, peterz@infradead.org,
        acme@redhat.com
In-Reply-To: <20180206181813.10943-2-jolsa@kernel.org>
References: <20180206181813.10943-2-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Ask for ordered events for --tasks
 option
Git-Commit-ID: 8614ada0be7d7be84b85c006d526a9c8f76484fa
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

Commit-ID:  8614ada0be7d7be84b85c006d526a9c8f76484fa
Gitweb:     https://git.kernel.org/tip/8614ada0be7d7be84b85c006d526a9c8f76484fa
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 6 Feb 2018 19:17:57 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 10:09:23 -0300

perf report: Ask for ordered events for --tasks option

If we have the time in, keep the events in time order.

Committer notes:

Trying to be more verbose, what actual effect this will have in this particular
case?

Before and after this patch shows the artifacts:

  --- /tmp/before 2018-02-06 15:40:29.536411625 -0300
  +++ /tmp/after  2018-02-06 15:40:51.963403599 -0300
  @@ -5,34 +5,34 @@
         2540     2540     1818 |   gnome-terminal-
         3489     3489     2540 |    bash
        32433    32433     3489 |     perf
  -     32434    32434    32433 |      perf
  +     32434    32434    32433 |      make
        32441    32441    32434 |       make
        32514    32514    32441 |        make
          511      511    32514 |         sh
  -       512      512      511 |          sh
  +       512      512      511 |          install
<SNIP>

We don't have 'perf' calling 'perf' calling 'make', etc, the second
'perf' actually is 'make', i.e.  there was reordering of the relevant
PERF_RECORD_COMM and PERF_RECORD_FORK records.

Ditto for sh/install later on.

Look for FORK and COMM meta events, for those tids:

  # perf report -D | egrep 'PERF_RECORD_(FORK|COMM)' | egrep '3243[34]'
  0 14774650990679 0x1a3cd8 [0x38]: PERF_RECORD_FORK(32433:32433):(3489:3489)
  1 14774652080381 0x1d6568 [0x30]: PERF_RECORD_COMM exec: perf:32433/32433
  1 14774742473340 0x1dbb48 [0x38]: PERF_RECORD_FORK(32434:32434):(32433:32433)
  0 14774752005779 0x1a4af8 [0x30]: PERF_RECORD_COMM exec: make:32434/32434
  0 14774753997960 0x1a5578 [0x38]: PERF_RECORD_FORK(32435:32435):(32434:32434)
  0 14774756070782 0x1a5618 [0x38]: PERF_RECORD_FORK(32438:32438):(32434:32434)
  0 14774757772939 0x1a5680 [0x38]: PERF_RECORD_FORK(32440:32440):(32434:32434)
  0 14774758230600 0x1a56e8 [0x38]: PERF_RECORD_FORK(32441:32441):(32434:32434)
  #

First column is the cpu, second is the timestamp.

So they are on different CPUs, thus ring buffers, and when we don't use
the ordered_events class, we end up mixing that up, use it to take
advantage of the PERF_RECORD_FINISHED_ROUND meta events to go on
ordering the events using the PERF_SAMPLE_TIME present in the
PERF_RECORD_{FORK,COMM,EXIT,SAMPLE,etc} records in the ring buffer.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180206181813.10943-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4ad5dc6..8ef7166 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -614,6 +614,7 @@ static int stats_print(struct report *rep)
 static void tasks_setup(struct report *rep)
 {
 	memset(&rep->tool, 0, sizeof(rep->tool));
+	rep->tool.ordered_events = true;
 	if (rep->mmaps_mode) {
 		rep->tool.mmap = perf_event__process_mmap;
 		rep->tool.mmap2 = perf_event__process_mmap2;
