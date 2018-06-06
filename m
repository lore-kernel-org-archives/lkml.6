Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id s0azK/xcGFvkJAAAmS7hNA
	; Wed, 06 Jun 2018 22:15:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A01B4608B8; Wed,  6 Jun 2018 22:15:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3C56B607F7;
	Wed,  6 Jun 2018 22:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C56B607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeFFWPU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:15:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751878AbeFFWPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:15:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 538BB805A531;
        Wed,  6 Jun 2018 22:15:18 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61A802026DEF;
        Wed,  6 Jun 2018 22:15:14 +0000 (UTC)
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [RFC 00/10] perf: Add cputime events/metrics
Date: Thu,  7 Jun 2018 00:15:03 +0200
Message-Id: <20180606221513.11302-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 06 Jun 2018 22:15:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 06 Jun 2018 22:15:18 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
so.. I failed to make work reliably the exclude_idle bit for
cpu-clock event using the idle's process sum_exec_runtime as
Peter outlined in his patch [1]. The time jumped up and down
and I couldn't make it stable.

But I noticed we actually have IDLE stats (and many more)
available for each CPU (enum cpu_usage_stat), we just can't
reach them by perf yet.

So this patchset adds 'cputime' perf software PMU, that provides
CPUTIME_* stats via events that mirrors their names:

  # perf list | grep cputime
    cputime/guest/                                     [Kernel PMU event]
    cputime/guest_nice/                                [Kernel PMU event]
    cputime/idle/                                      [Kernel PMU event]
    cputime/iowait/                                    [Kernel PMU event]
    cputime/irq/                                       [Kernel PMU event]
    cputime/nice/                                      [Kernel PMU event]
    cputime/softirq/                                   [Kernel PMU event]
    cputime/steal/                                     [Kernel PMU event]
    cputime/system/                                    [Kernel PMU event]
    cputime/user/                                      [Kernel PMU event]

I had some issues with IDLE counter being miscounted due to stopping
of the idle tick. I tried to solve it in this patch (it's part of the
patchset):
  perf/cputime: Don't stop idle tick if there's live cputime event

but I'm pretty sure it's wrong and there's better solution.


However most of the counts look ok so far and here's few
of my favorite commands I've been playing with:

  # perf stat --top -I 1000
  #           time       Idle     System       User        Irq    Softirq    IO wait
       1.001692690     100.0%       0.0%       0.0%       0.7%       0.2%       0.0%
       2.002994039      98.9%       0.0%       0.0%       0.9%       0.2%       0.0%
       3.004164038      98.5%       0.2%       0.2%       0.9%       0.2%       0.0%
       4.005312773      98.9%       0.0%       0.0%       0.9%       0.2%       0.0%


  # perf stat --top-full -I 1000
  #           time       Idle     System       User        Irq    Softirq    IO wait      Guest Guest nice       Nice      Steal
       1.001750803     100.0%       0.0%       0.0%       0.7%       0.2%       0.0%       0.0%       0.0%       0.0%       0.0%
       2.003159490      99.0%       0.0%       0.0%       0.9%       0.2%       0.0%       0.0%       0.0%       0.0%       0.0%
       3.004358366      99.0%       0.0%       0.0%       0.9%       0.2%       0.0%       0.0%       0.0%       0.0%       0.0%
       4.005592436      98.9%       0.0%       0.0%       0.9%       0.2%       0.0%       0.0%       0.0%       0.0%       0.0%


  # perf stat -e cpu-clock,cputime/system/,cputime/user/,cputime/idle/ -a sleep 10

   Performance counter stats for 'system wide':

       240070.828221      cpu-clock (msec)          #   23.999 CPUs utilized          
     208,910,979,120 ns   cputime/system/           #     87.0% System                
      20,589,603,359 ns   cputime/user/             #      8.6% User                  
       8,813,416,821 ns   cputime/idle/             #      3.7% Idle                  

        10.003261054 seconds time elapsed


  # perf stat -e cpu-clock,cputime/system/,cputime/user/ yes > /dev/null
  ^Cyes: Interrupt

   Performance counter stats for 'yes':

         3483.824364      cpu-clock (msec)          #    1.000 CPUs utilized          
       2,460,117,205 ns   cputime/system/           #     70.6% System                
       1,018,360,669 ns   cputime/user/             #     29.2% User                  

         3.484554149 seconds time elapsed

         1.018525000 seconds user
         2.460515000 seconds sys

  # perf stat --top -I 1000 --interval-clear
  # perf stat --top -I 1000 --interval-clear --per-core
  # perf stat --top -I 1000 --interval-clear --per-socket
  # perf stat --top -I 1000 --interval-clear -A

It's also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

My current plan is now to read those counters in perf top/record/report
to show (at least) the idle percentage for the current profile.

thoughts? ;-)

thanks,
jirka


[1] https://marc.info/?l=linux-kernel&m=152397251027433&w=2
---
Jiri Olsa (10):
      perf tools: Uniquify the event name if there's no other matched event
      perf tools: Fix error index for pmu event parser
      perf stat: Add --interval-clear option
      perf stat: Use only color_fprintf call in print_metric_only
      perf stat: Fix metric column display
      perf stat: Allow to specify specific metric column len
      perf stat: Add event parsing error handling to add_default_attributes
      perf/cputime: Add cputime pmu
      perf/cputime: Don't stop idle tick if there's live cputime event
      perf stat: Add cputime metric support

 include/linux/perf_event.h             |   3 ++
 kernel/events/Makefile                 |   2 +-
 kernel/events/core.c                   |   1 +
 kernel/events/cputime.c                | 211 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/time/tick-sched.c               |   4 +++
 tools/perf/Documentation/perf-stat.txt |  68 ++++++++++++++++++++++++++++++++++++
 tools/perf/builtin-stat.c              | 104 ++++++++++++++++++++++++++++++++++++++++++++-----------
 tools/perf/util/parse-events.y         |   5 +++
 tools/perf/util/stat-shadow.c          |  70 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.c                 |  10 ++++++
 tools/perf/util/stat.h                 |  10 ++++++
 11 files changed, 467 insertions(+), 21 deletions(-)
 create mode 100644 kernel/events/cputime.c
