Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753480AbeDIQ41 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:56:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58476 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753089AbeDIQ4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:56:25 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: [PATCH 0/7] Add utilization clamping support
Date: Mon,  9 Apr 2018 17:56:08 +0100
Message-Id: <20180409165615.2326-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a respin of:

   https://lkml.org/lkml/2017/8/24/721

which finally removes the RFC tag since we properly addressed all the major
concerns from previous discussions, mainly at LPCs and OSPM conferences, and we
want to aim now at finalizing this series for mainline merge.

Comments and feedbacks are more than welcome!

The content of this series will be discussed also at the upcoming OSPM Summit:

   http://retis.sssup.it/ospm-summit/

A live stream and record of the event will be available for the benefit of
those interested which will not be able to join the summit.

.:: Main changes

The main change in this version is the introduction of a new userspace API, as
requested by Tejun. This makes now the CGroups based a "secondary" interface
for utilization clamping, which allows to use this feature also on systems
where the CGroups's CPU controller is not available or not in use.

The primary interface for utilization clamping is now also a per-task API,
which has been added by extending the existing sched_{set,get}attr syscalls.
Here we propose a simple yet effective extension of these syscalls based on a
couple of additional attributes.
A possible alternative implementation is also described, as a note in the
corresponding commit message, which will not require to change the syscall but
just to properly re-use existing attributes currently available only for
DEADLINE tasks. Since this would require a more complex implementation, we
decided to go for the simple option and open up for discussions on this
(hopefully last) point while we finalize the patchset.

Due to the new API, the series has also been re-organized into the following
described main sections.

Data Structures and Mechanisms
==============================

  [PATCH 1/7] sched/core: uclamp: add CPU clamp groups accounting
  [PATCH 2/7] sched/core: uclamp: map TASK clamp values into CPU clamp groups

Add the necessary data structures and mechanisms to translate task's
utilization clamping values into an effective and low-overhead fast path
(i.e. enqueue/dequeue time) tracking of the CPU's utilization clamping values.

Here we also introduce a new CONFIG_UCLAMP_TASK KConfig option, which allows to
completely remove utilization clamping code for systems not needing it.
Being mainly a mechanism to use in conjunction with schedutil, utilization
clamping depends also on CPU_FREQ_GOV_SCHEDUTIL being enabled.

We also add the possibility to define at compile time how many different clamp
values can be used. This is done because it makes sense from a practical usage
standpoint and has it also interesting size/overhead benefits.

Per task (primary) API
======================

  [PATCH 3/7] sched/core: uclamp: extend sched_setattr to support utilization clamping

Provides a simple yet effective user-space API to define per-task minimum and
maximum utilization clamp values. A simple implementation is proposed here,
while a possible alternative is described in the notes.

Per task group (secondary) API
==============================

  [PATCH 4/7] sched/core: uclamp: add utilization clamping to the CPU controller
  [PATCH 5/7] sched/core: uclamp: use TG clamps to restrict TASK clamps

Add the same task group based API presented in the previous posting, but this
time on top of the per-task one. The second patch is dedicated to the
aggregation between per-task and per-task_group clamp values.

Schedutil integration
=====================

  [PATCH 6/7] sched/cpufreq: uclamp: add utilization clamping for FAIR tasks
  [PATCH 7/7] sched/cpufreq: uclamp: add utilization clamping for RT tasks

Extend sugov_aggregate_util() and sugov_set_iowait_boost() to clamp the
utilization reported by cfs_rq and rt_rq in the selection of the OPP.

This patch set is based on today's tip/sched/core:

  commit b720342  ("sched/core: Update preempt_notifier_key to modern API")

but it depends on a couple of schedutil related refactoring patches which
I've posted separately on the list. For your convenience, a complete tree for
testing and evaluation is available here:

   git://linux-arm.org/linux-pb.git  lkml/utilclamp_v1
   http://www.linux-arm.org/git?p=linux-pb.git;a=shortlog;h=refs/heads/lkml/utilclamp_v1


.:: Newcomer's Short Abstract

The Linux scheduler is able to drive frequency selection, when the schedutil
cpufreq's governor is in use, based on task utilization aggregated at CPU
level. The CPU utilization is then used to select the frequency which better
fits the task's generated workload.  The current translation of utilization
values into a frequency selection is pretty simple: we just go to max for RT
tasks or to the minimum frequency which can accommodate the utilization of
DL+FAIR tasks.

While this simple mechanism is good enough for DL tasks, for RT and FAIR tasks
we can aim at some better frequency driving which can take into consideration
hints coming from user-space.

Utilization clamping is a mechanism which allows to "clamp" (i.e. filter) the
utilization generated by RT and FAIR tasks within a range defined from
user-space. The clamped utilization value can then be used to enforce a minimum
and/or maximum frequency depending on which tasks are currently active on a
CPU.

The main use-cases for utilization clamping are:

 - boosting: better interactive response for small tasks which
   are affecting the user experience. Consider for example the case of a
   small control thread for an external accelerator (e.g. GPU, DSP, other
   devices). In this case the scheduler does not have a complete view of
   what are the task bandwidth requirements and, if it's a small task,
   schedutil will keep selecting a lower frequency thus affecting the
   overall time required to complete the task activations.

 - clamping: increase energy efficiency for background tasks not directly
   affecting the user experience. Since running at a lower frequency is in
   general more energy efficient, when the completion time is not a main
   goal then clamping the maximum frequency to use for certain (maybe big)
   tasks can have positive effects, both on energy consumption and thermal
   stress.
   Moreover, this last support allows also to make RT tasks more energy
   friendly on mobile systems, where running them at the maximum
   frequency is not strictly required.

Cheers Patrick

Patrick Bellasi (7):
  sched/core: uclamp: add CPU clamp groups accounting
  sched/core: uclamp: map TASK clamp values into CPU clamp groups
  sched/core: uclamp: extend sched_setattr to support utilization
    clamping
  sched/core: uclamp: add utilization clamping to the CPU controller
  sched/core: uclamp: use TG clamps to restrict TASK clamps
  sched/cpufreq: uclamp: add utilization clamping for FAIR tasks
  sched/cpufreq: uclamp: add utilization clamping for RT tasks

 include/linux/sched.h            |  34 ++
 include/uapi/linux/sched.h       |   4 +-
 include/uapi/linux/sched/types.h |  65 ++-
 init/Kconfig                     |  64 +++
 kernel/sched/core.c              | 824 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |  46 ++-
 kernel/sched/sched.h             | 180 +++++++++
 7 files changed, 1192 insertions(+), 25 deletions(-)

-- 
2.15.1
