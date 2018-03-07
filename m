Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeCGPYk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:24:40 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36262 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933545AbeCGPYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:24:34 -0500
X-Google-Smtp-Source: AG47ELtTUGMXm6hdGK1tciu3WzqrjlFI05AQzL32DT9+eGOoEi1bAhYjZWPQyoF/315Y1KqC98d4BA==
Date: Wed, 7 Mar 2018 16:24:30 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf report: Show zero counters as well in 'perf report
 --stat'
Message-ID: <20180307152430.7e5h7e657b7bgd7q@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When recently using 'perf report --stat' it was not clear to me from the output 
whether a particular statistics field (LOST_SAMPLES) was not present, or just 
zero:

  fomalhaut:~> perf report --stat

  Aggregated stats:
           TOTAL events:     495984
            MMAP events:         85
            COMM events:       3389
            EXIT events:       1605
        THROTTLE events:          2
      UNTHROTTLE events:          2
            FORK events:       3377
          SAMPLE events:     472629
           MMAP2 events:      14753
  FINISHED_ROUND events:        139
      THREAD_MAP events:          1
         CPU_MAP events:          1
       TIME_CONV events:          1

I had to check the output several times to ascertain that I'm not misreading the 
output, that the field didn't change and that I didn't misremember the name. In 
fact I had to look into the perf source to make sure that zero fields are indeed 
not shown.

With the patch applied:

  fomalhaut:~> perf report --stat

  Aggregated stats:
           TOTAL events:     495984
            MMAP events:         85
            LOST events:          0
            COMM events:       3389
            EXIT events:       1605
        THROTTLE events:          2
      UNTHROTTLE events:          2
            FORK events:       3377
            READ events:          0
          SAMPLE events:     472629
           MMAP2 events:      14753
             AUX events:          0
    ITRACE_START events:          0
    LOST_SAMPLES events:          0
          SWITCH events:          0
 SWITCH_CPU_WIDE events:          0
      NAMESPACES events:          0
            ATTR events:          0
      EVENT_TYPE events:          0
    TRACING_DATA events:          0
        BUILD_ID events:          0
  FINISHED_ROUND events:        139
        ID_INDEX events:          0
   AUXTRACE_INFO events:          0
        AUXTRACE events:          0
  AUXTRACE_ERROR events:          0
      THREAD_MAP events:          1
         CPU_MAP events:          1
     STAT_CONFIG events:          0
            STAT events:          0
      STAT_ROUND events:          0
    EVENT_UPDATE events:          0
       TIME_CONV events:          1
         FEATURE events:          0

It's pretty clear at a glance that LOST_SAMPLES is present but zero.

The original output can still be gotten via:

  fomalhaut:~> perf report --stat | grep -vw 0

  Aggregated stats:
           TOTAL events:     495984
            MMAP events:         85
            COMM events:       3389
            EXIT events:       1605
        THROTTLE events:          2
      UNTHROTTLE events:          2
            FORK events:       3377
          SAMPLE events:     472629
           MMAP2 events:      14753
  FINISHED_ROUND events:        139
      THREAD_MAP events:          1
         CPU_MAP events:          1
       TIME_CONV events:          1

So I don't think there's any real loss in functionality.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/perf/ui/stdio/hist.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: linux/tools/perf/ui/stdio/hist.c
===================================================================
--- linux.orig/tools/perf/ui/stdio/hist.c
+++ linux/tools/perf/ui/stdio/hist.c
@@ -840,15 +840,11 @@ size_t events_stats__fprintf(struct even
 	for (i = 0; i < PERF_RECORD_HEADER_MAX; ++i) {
 		const char *name;
 
-		if (stats->nr_events[i] == 0)
-			continue;
-
 		name = perf_event__name(i);
 		if (!strcmp(name, "UNKNOWN"))
 			continue;
 
-		ret += fprintf(fp, "%16s events: %10d\n", name,
-			       stats->nr_events[i]);
+		ret += fprintf(fp, "%16s events: %10d\n", name, stats->nr_events[i]);
 	}
 
 	return ret;
