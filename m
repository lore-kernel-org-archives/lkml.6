Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbeCTG1W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:27:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43163 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeCTG1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:27:19 -0400
Date: Mon, 19 Mar 2018 23:27:12 -0700
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-39ce7fb31530c6d4648919e03e16c5e9286a5940@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, hpa@zytor.com, acme@redhat.com
In-Reply-To: <20180307152430.7e5h7e657b7bgd7q@gmail.com>
References: <20180307152430.7e5h7e657b7bgd7q@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Show zero counters as well in 'perf
 report --stat'
Git-Commit-ID: 39ce7fb31530c6d4648919e03e16c5e9286a5940
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

Commit-ID:  39ce7fb31530c6d4648919e03e16c5e9286a5940
Gitweb:     https://git.kernel.org/tip/39ce7fb31530c6d4648919e03e16c5e9286a5940
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Wed, 7 Mar 2018 16:24:30 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:55:36 -0300

perf report: Show zero counters as well in 'perf report --stat'

When recently using 'perf report --stat' it was not clear to me from the
output whether a particular statistics field (LOST_SAMPLES) was not
present, or just zero:

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

I had to check the output several times to ascertain that I'm not
misreading the output, that the field didn't change and that I didn't
misremember the name. In fact I had to look into the perf source to make
sure that zero fields are indeed not shown.

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
Acked-by: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180307152430.7e5h7e657b7bgd7q@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/stdio/hist.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 25dd1e0ecc58..6832fcb2e6ff 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -840,15 +840,11 @@ size_t events_stats__fprintf(struct events_stats *stats, FILE *fp)
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
