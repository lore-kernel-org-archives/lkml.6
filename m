Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F83C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8878208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8878208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeKLGyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:54:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeKLGyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:54:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9BDD3013038;
        Sun, 11 Nov 2018 21:04:31 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-16.brq.redhat.com [10.40.204.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E4B65C1B4;
        Sun, 11 Nov 2018 21:04:27 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCHv2 0/3] perf: Add cputime events/metrics
Date:   Sun, 11 Nov 2018 22:04:23 +0100
Message-Id: <20181111210426.28712-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 11 Nov 2018 21:04:32 +0000 (UTC)
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

This patchset adds 'cputime' perf software PMU, that provides
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


v2 changes:
  - all of the support patches are already in
  - new way of 'fixing' of idle counts when tick is disabled (patch 2)


Examples:
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

thanks,
jirka


[1] https://marc.info/?l=linux-kernel&m=152397251027433&w=2
---
Jiri Olsa (3):
      perf/cputime: Add cputime pmu
      perf/cputime: Fix idle time on NO_HZ config
      perf stat: Add cputime metric support

 include/linux/perf_event.h             |   2 ++
 include/linux/tick.h                   |   1 +
 kernel/events/Makefile                 |   2 +-
 kernel/events/core.c                   |   1 +
 kernel/events/cputime.c                | 221 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/time/tick-sched.c               |  11 ++++++
 tools/perf/Documentation/perf-stat.txt |  65 +++++++++++++++++++++++++++++++++
 tools/perf/builtin-stat.c              |  47 ++++++++++++++++++++++++
 tools/perf/util/stat-shadow.c          |  72 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.c                 |  10 ++++++
 tools/perf/util/stat.h                 |  10 ++++++
 11 files changed, 441 insertions(+), 1 deletion(-)
 create mode 100644 kernel/events/cputime.c
