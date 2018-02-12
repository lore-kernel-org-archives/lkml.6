Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935669AbeBLNkz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:40:55 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38548 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933254AbeBLNkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:40:53 -0500
X-Google-Smtp-Source: AH8x225LN9SzMHv5vEfdqqzufNohOWod5tYwFF4zGmn8zoMU6G+v/YC4E1n/rHCeOVz6XMdcqe1DKA==
From: Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, alessio.balsini@arm.com,
        juri.lelli@redhat.com
Subject: [RFC PATCH 0/3] SCHED_DEADLINE cgroups support
Date: Mon, 12 Feb 2018 14:40:27 +0100
Message-Id: <20180212134030.12846-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A long time ago there was a patch [1] (written by Dario) adding DEADLINE
bandwidth management control for task groups. That was then removed from
the set of patches that made to mainline because outside of the bare
minimum of features to possibly start playing with SCHED_DEADLINE, and
because quite some discussion points remained open.

Fast forward to present day and more features have been added, DEADLINE
usage is however still reserved to root only. Several things are still
missing before we can comfortably relax privilegies, bandwidth
management for group of tasks being one of the most important (together
with a better/safer PI mechanism I'd say).

Another (different) attempt to add cgroup support was proposed last year
[2]. The set was implementing hierachical scheduling support (RT
entities running inside DEADLINE servers). Complexity (and maybe not
enough documentation? :) made discussion around that proposal difficult
to happen.

Even though hierachical scheduling is still what we want in the end,
this set tries to start getting there by adding cgroup based bandwidth
management for SCHED_DEADLINE. The following design choices have been
made (also detailed in changelog/doc):

 - implementation _is not_ hierarchical: only single/plain DEADLINE
   entities can be handled, and they get scheduled at root rq level

 - DEADLINE_GROUP_SCHED requires RT_GROUP_SCHED (because of the points
   below)

 - DEADLINE and RT share bandwidth; therefore, DEADLINE tasks will eat
   RT bandwidth, as they do today at root level; support for RT_RUNTIME_
   SHARE is however missing, an RT task might be able to exceed its group
   bandwidth constrain if such feature is enabled (more thinking required)

 - and therefore cpu.rt_runtime_us and cpu.rt_period_us are still
   controlling a group bandwidth; however, two additional (read only)
   knobs are added

     # cpu.dl_bw : maximum bandwidth available for the group on each CPU
                   (rt_runtime_us/rt_period_us)
     # cpu.dl_total_bw : current total (across CPUs) amount of bandwidth
                         allocated by the group (sum of tasks bandwidth)

 - father/children/siblings rules are the same as for RT

Adding this kind of support should be useful to be able to let normal
users use DEADLINE, as the sys admin (with root privilegies) could
reserve a fraction of the total available bandwidth to users and let
them allocate what needed inside such space.

I'm more than sure that there are problems lurking in this set (e.g.,
too much ifdeffery) and many discussion points are still open, but I
wanted to share what I have early and see what people thinks about it
(possibly understaning how to move forward).

First patch might actually be a standalone cleanup change.

The set (based on tip/sched/core as of today) is available at:

https://github.com/jlelli/linux.git upstream/deadline/cgroup-rfc-v1

Comments and feedback are the purpose of this RFC. Thanks in advance!

Best,

- Juri

[1] https://lkml.org/lkml/2010/2/28/119
[2] https://lwn.net/Articles/718645/

Juri Lelli (3):
  sched/deadline: merge dl_bw into dl_bandwidth
  sched/deadline: add task groups bandwidth management support
  Documentation/scheduler/sched-deadline: add info about cgroup support

 Documentation/scheduler/sched-deadline.txt |  36 +++--
 init/Kconfig                               |  12 ++
 kernel/sched/autogroup.c                   |   7 +
 kernel/sched/core.c                        |  56 ++++++-
 kernel/sched/deadline.c                    | 241 +++++++++++++++++++++++------
 kernel/sched/debug.c                       |   6 +-
 kernel/sched/rt.c                          |  52 ++++++-
 kernel/sched/sched.h                       |  68 ++++----
 kernel/sched/topology.c                    |   2 +-
 9 files changed, 381 insertions(+), 99 deletions(-)

-- 
2.14.3
