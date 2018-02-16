Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbeBPTjy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:39:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753378AbeBPTSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:18:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC14217C9
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
Subject: [PATCH 07/41] perf report: Ask for ordered events for --tasks option
Date: Fri, 16 Feb 2018 16:17:12 -0300
Message-Id: <20180216191746.11095-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
index 4ad5dc649716..8ef71669e7a0 100644
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
-- 
2.14.3
