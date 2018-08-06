Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC92C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B9621A18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B9621A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbeHFSuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41692 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeHFSuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E20380D;
        Mon,  6 Aug 2018 09:40:24 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE0013F5D0;
        Mon,  6 Aug 2018 09:40:21 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 00/14] Add utilization clamping support
Date:   Mon,  6 Aug 2018 17:39:32 +0100
Message-Id: <20180806163946.28380-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a respin of:

   https://lore.kernel.org/lkml/20180716082906.6061-1-patrick.bellasi@arm.com

Which has been rebased on today's tip/sched/core:

   commit 1b6266ebe3da ("watchdog: Reduce message verbosity")

and addresses all the comments from Tejun and Suren, thanks for your feedback!

Further comments and feedbacks are more than welcome!

Cheers Patrick


Main changes
============

.:: Properly implemented the cgroup delegation model
----------------------------------------------------

 As Tejun pointed out in:

    https://lore.kernel.org/lkml/20180409222417.GK3126663@devbig577.frc2.facebook.com

 the cgroup delegation model requires that a parent group can always restrict
 the resources of a child group. To properly support this behavior we need to
 add a concept of "effective" clamp values beside the one of "requested" clamp
 values.

 This means that a child group can always ask for certain clamp values but the
 effective clamps it get depends on the parent group configuration. More
 specifically, the effective clamps for a group are defined as the most
 restrictive value (i.e. the minimum) between a task group clamp value and the
 effective value of its parent task group.

 This new feature is introduced by this new patch in this series:

    [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps


.:: Added support for system defaults
-------------------------------------

 The introduction of the previous patch implies that the root task group must be
 configured with a default min utilization clamping which corresponds to the
 maximum value, i.e. root_task_group::uclamp[UTIL_MIN].value = 100%.
 Otherwise, subgroups will always have an effective 0% minimum clamp.

 To fix this misbehavior, as well as to overcome the (cgroup imposed) limitation
 of non configurable attributes of the root task group, in this new patch:

    [PATCH v3 12/14] sched/core: uclamp: add system default clamps

 we add sysfs support for system wide defaults.

 This should satisfy another comment by Tejun and it also provides a convenient
 system wide configuration API, which is available independently from cgroup.


.:: Improved syscall API semantics
----------------------------------

 As pointed out and suggested by Suren, the __sched_setscheduler() syscall
 semantics has been improved to support:
 - single attribute configuration
   by using a new set of dedicated sched_attr::sched_flags we can now specify
   which clamp values we want to configure
 - atomic setting or failure in case of two attributes being configured at the
   same time.

 These changes affect mainly:

    [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to support utilization clamping
    [PATCH v3 02/14] sched/core: uclamp: map TASK's clamp values into CPU's clamp groups


.:: Other notes
---------------

The rest of the series is similar to v2 and split into these sections:

- Patches [01-04]: Per task (primary) API
- Patches [05-06]: Schedutil integration
- Patches [08-13]: Per task group (secondary) API
- Patches [07,14]: Additional improvements


Newcomer's Short Abstract (Updated)
===================================

The Linux scheduler is able to drive frequency selection, when the schedutil
cpufreq's governor is in use, based on task utilization aggregated at CPU
level. The CPU utilization is then used to select the frequency which best
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
   are affecting the user experience.
   Consider for example the case of a small control thread for an external
   accelerator (e.g. GPU, DSP, other devices). In this case, from its
   utilization the scheduler does not have a complete view of what are the task
   requirements and, if it's a small utilization task, schedutil will keep
   selecting a more energy efficient CPU, with smaller capacity and lower
   frequency, thus affecting the overall time required to complete the task
   activations.

 - capping: increase energy efficiency for background tasks not directly
   affecting the user experience.
   Since running on a lower capacity CPU at a lower frequency is in general
   more energy efficient, when the completion time is not a main goal, then
   capping the utilization considered for certain (maybe big) tasks can have
   positive effects, both on energy consumption and thermal stress.
   Moreover, this last support allows also to make RT tasks more energy
   friendly on mobile systems, where running them on high capacity CPUs and at
   the maximum frequency is not strictly required.

From these two use-cases, it's worth to notice that frequency selection
biasing, introduced by patches 5 and 6 of this series, is just one possible
usage of utilization clamping. Another compelling extension of utilization
clamping is in helping the scheduler on tasks placement decisions.

Utilization is a task specific property which is used by the scheduler to know
how much CPU bandwidth a task requires (under certain conditions).
Thus, the utilization clamp values defined either per-task or via the CPU
controller, can be used to represent tasks to the scheduler as being bigger
(or smaller) than what they really are.

Utilization clamping thus ultimately enable interesting additional
optimizations, especially on asymmetric capacity systems like Arm
big.LITTLE and DynamIQ CPUs, where:

 - boosting: small tasks are preferably scheduled on higher-capacity CPUs
   where, despite being less energy efficient, they can complete faster

 - capping: big/background tasks are preferably scheduled on low-capacity CPUs
   where, being more energy efficient, they can still run but save power and
   thermal headroom for more important tasks.

This additional usage of the utilization clamping is not presented in this
series but it's an integral part of the Energy Aware Scheduler (EAS) feature
set. A similar solution (SchedTune) is already used on Android kernels, which
targets the biasing of both 'frequency selection' and 'task placement'.
This series provides the foundation bits to add similar features in mainline
and its first simple client with the schedutil integration.


Detailed Changelog
==================

Changes in v3:
 Message-ID: <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
 - removed UCLAMP_NONE not used by this patch
 - remove not necessary checks in uclamp_group_find()
 - add WARN on unlikely un-referenced decrement in uclamp_group_put()
 - add WARN on unlikely un-referenced decrement in uclamp_cpu_put_id()
 - make __setscheduler_uclamp() able to set just one clamp value
 - make __setscheduler_uclamp() failing if both clamps are required but
   there is no clamp groups available for one of them
 - remove uclamp_group_find() from uclamp_group_get() which now takes a
   group_id as a parameter
 - add explicit calls to uclamp_group_find()
   which is now not more part of uclamp_group_get()
 - fixed a not required override
 - fixed some typos in comments and changelog
 Message-ID: <CAJuCfpGaKvxKcO=RLcmveHRB9qbMrvFs2yFVrk=k-v_m7JkxwQ@mail.gmail.com>
 - few typos fixed
 Message-ID: <20180409222417.GK3126663@devbig577.frc2.facebook.com>
 - use "." notation for attributes naming
   i.e. s/util_{min,max}/util.{min,max}/
 - added new patches: 09 and 12
 Other changes:
 - rebased on tip/sched/core

Changes in v2:
 Message-ID: <20180413093822.GM4129@hirez.programming.kicks-ass.net>
 - refactored struct rq::uclamp_cpu to be more cache efficient
   no more holes, re-arranged vectors to match cache lines with expected
   data locality
 Message-ID: <20180413094615.GT4043@hirez.programming.kicks-ass.net>
 - use *rq as parameter whenever already available
 - add scheduling class's uclamp_enabled marker
 - get rid of the "confusing" single callback uclamp_task_update()
   and use uclamp_cpu_{get,put}() directly from {en,de}queue_task()
 - fix/remove "bad" comments
 Message-ID: <20180413113337.GU14248@e110439-lin>
 - remove inline from init_uclamp, flag it __init
 Message-ID: <20180413111900.GF4082@hirez.programming.kicks-ass.net>
 - get rid of the group_id back annotation
   which is not requires at this stage where we have only per-task
   clamping support. It will be introduce later when cgroup support is
   added.
 Message-ID: <20180409222417.GK3126663@devbig577.frc2.facebook.com>
 - make attributes available only on non-root nodes
   a system wide API seems of not immediate interest and thus it's not
   supported anymore
 - remove implicit parent-child constraints and dependencies
 Message-ID: <20180410200514.GA793541@devbig577.frc2.facebook.com>
 - add some cgroup-v2 documentation for the new attributes
 - (hopefully) better explain intended use-cases
   the changelog above has been extended to better justify the naming
   proposed by the new attributes
 Other changes:
 - improved documentation to make more explicit some concepts
 - set UCLAMP_GROUPS_COUNT=2 by default
   which allows to fit all the hot-path CPU clamps data into a single cache
   line while still supporting up to 2 different {min,max}_utiql clamps.
 - use -ERANGE as range violation error
 - add attributes to the default hierarchy as well as the legacy one
 - implement a "nice" semantics where cgroup clamp values are always
   used to restrict task specific clamp values,
   i.e. tasks running on a TG are only allowed to demote themself.
 - patches re-ordering in top-down way
 - rebased on v4.18-rc4


Patrick Bellasi (14):
  sched/core: uclamp: extend sched_setattr to support utilization
    clamping
  sched/core: uclamp: map TASK's clamp values into CPU's clamp groups
  sched/core: uclamp: add CPU's clamp groups accounting
  sched/core: uclamp: update CPU's refcount on clamp changes
  sched/cpufreq: uclamp: add utilization clamping for FAIR tasks
  sched/cpufreq: uclamp: add utilization clamping for RT tasks
  sched/core: uclamp: enforce last task UCLAMP_MAX
  sched/core: uclamp: extend cpu's cgroup controller
  sched/core: uclamp: propagate parent clamps
  sched/core: uclamp: map TG's clamp values into CPU's clamp groups
  sched/core: uclamp: use TG's clamps to restrict Task's clamps
  sched/core: uclamp: add system default clamps
  sched/core: uclamp: update CPU's refcount on TG's clamp changes
  sched/core: uclamp: use percentage clamp values

 Documentation/admin-guide/cgroup-v2.rst |   46 +
 include/linux/sched.h                   |   58 ++
 include/linux/sched/sysctl.h            |   11 +
 include/uapi/linux/sched.h              |    8 +-
 include/uapi/linux/sched/types.h        |   66 +-
 init/Kconfig                            |   61 ++
 kernel/sched/core.c                     | 1186 +++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c        |   38 +-
 kernel/sched/fair.c                     |    4 +
 kernel/sched/features.h                 |   10 +
 kernel/sched/rt.c                       |    4 +
 kernel/sched/sched.h                    |  194 ++++
 kernel/sysctl.c                         |   16 +
 13 files changed, 1688 insertions(+), 14 deletions(-)

-- 
2.18.0

