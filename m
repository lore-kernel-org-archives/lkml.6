Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5454ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A8620779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A8620779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbeGPIzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:55:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54274 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbeGPIzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:55:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F11380D;
        Mon, 16 Jul 2018 01:29:24 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.210.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 520413F5A0;
        Mon, 16 Jul 2018 01:29:21 -0700 (PDT)
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
Subject: [PATCH v2 00/12] Add utilization clamping support
Date:   Mon, 16 Jul 2018 09:28:54 +0100
Message-Id: <20180716082906.6061-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a respin of:

   https://lore.kernel.org/lkml/20180409165615.2326-1-patrick.bellasi@arm.com

which addresses all the feedbacks collected from the LKML discussion as well
as during the presentation at last OSPM Summit:

   https://www.youtube.com/watch?v=0Yv9smm9i78

Further comments and feedbacks are more than welcome!

Cheers Patrick


Main changes
============

The main change of this version is an overall restructuring and polishing of
the entire series. The ultimate goals was to further optimize some data
structures as well as to (hopefully) make it more easy the review by both
reordering the patches and splitting some of them into smaller ones.

The series is now composed by the following described main sections.

.:: Per task (primary) API

  [PATCH v2 01/12] sched/core: uclamp: extend sched_setattr to support
  [PATCH v2 02/12] sched/core: uclamp: map TASK's clamp values into
  [PATCH v2 03/12] sched/core: uclamp: add CPU's clamp groups
  [PATCH v2 04/12] sched/core: uclamp: update CPU's refcount on clamp

 This first subset adds all the main required data structures and mechanism to
 support clamping in a per-task basis.

 These bits are added in a top-down way:

    01. adds the sched_setattr(2) syscall based API
    02. adds the mapping from clamp values to clamp groups
    03. adds the clamp group refcouting at {en,de}queue time
    04. sync syscall changes with CPU's clamp group refcounts


.:: Schedutil integration

  [PATCH v2 05/12] sched/cpufreq: uclamp: add utilization clamping for FAIR tasks
  [PATCH v2 06/12] sched/cpufreq: uclamp: add utilization clamping for RT tasks

 These couple of additional patches provides a first fully working solution of
 utilization clamping by using the clamp values to bias frequency selection.

 It's worth to notice that frequencies selection is just one of the possible
 utilization clamping clients. We do not introduce other possible scheduler
 integration to keep this series small enough and focused on the core bits.


.:: Per task group (secondary) API

  [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup controller
  [PATCH v2 09/12] sched/core: uclamp: map TG's clamp values into CPU's clamp groups
  [PATCH v2 10/12] sched/core: uclamp: use TG's clamps to restrict
  [PATCH v2 11/12] sched/core: uclamp: update CPU's refcount on TG's

 These additional patches introduce the cgroup support, using the same top-down
 approach of the first ones:

    08. adds the cpu.util_{min,max} attributes
    09. adds the mapping from clamp values to clamp groups
    10. uses TG clamp value to restrict the task-specific API
    11. sync TG's clamp value changes with CPU's clamp group refcounts


.:: Additional improvements

  [PATCH v2 07/12] sched/core: uclamp: enforce last task UCLAMP_MAX
  [PATCH v2 12/12] sched/core: uclamp: use percentage clamp values

 A couple of functional improvements are provided by these few additional
patches. Although these bits are not strictly required for a fully functional
solution, they are still considered improvements worth to have.


Newcomer's Short Abstract (Updated)
===================================

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

Frequency selection biasing, introduced by patches 5 and 6 of this series,
is just one possible usage of utilization clamping. Another compelling use
case this support is interesting for is in helping the scheduler on tasks
tasks placement decisions.

Indeed, utilization is a task specific property which is used by the scheduler
to know how much CPU bandwidth a task requires (under certain conditions).
Thus, the utilization clamp values defined either per-task or via the CPU
controller, can be used to represent tasks to the scheduler as being bigger (or
smaller) then what they really are.

Utilization clamping thus ultimately enable interesting additional
optimizations, especially on asymmetric capacity systems like Arm
big.LITTLE and DynamIQ CPUs, where:

 - boosting: small tasks are preferably scheduled on higher-capacity CPUs
   where, despite being less energy efficient, they can complete faster

 - clamping: big/background tasks are preferably scheduler on low-capacity CPUs
   where, being more energy efficient, they can still run but save power and
   thermal headroom for more important tasks.

This additional usage of the utilization clamping is not presented in this
series but it's an integral part of the Energy Aware Scheduler (EAS) feature
set. A similar solution (SchedTune) is already used on Android kernels, which
targets both frequency selection and task placement biasing.
This series provides the foundation bits to add similar features in mainline
and its first simple client with the schedutil integration.


Detailed Changelog
==================

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


Patrick Bellasi (12):
  sched/core: uclamp: extend sched_setattr to support utilization
    clamping
  sched/core: uclamp: map TASK's clamp values into CPU's clamp groups
  sched/core: uclamp: add CPU's clamp groups accounting
  sched/core: uclamp: update CPU's refcount on clamp changes
  sched/cpufreq: uclamp: add utilization clamping for FAIR tasks
  sched/cpufreq: uclamp: add utilization clamping for RT tasks
  sched/core: uclamp: enforce last task UCLAMP_MAX
  sched/core: uclamp: extend cpu's cgroup controller
  sched/core: uclamp: map TG's clamp values into CPU's clamp groups
  sched/core: uclamp: use TG's clamps to restrict Task's clamps
  sched/core: uclamp: update CPU's refcount on TG's clamp changes
  sched/core: uclamp: use percentage clamp values

 Documentation/admin-guide/cgroup-v2.rst |  25 +
 include/linux/sched.h                   |  53 ++
 include/uapi/linux/sched.h              |   4 +-
 include/uapi/linux/sched/types.h        |  66 +-
 init/Kconfig                            |  63 ++
 kernel/sched/core.c                     | 876 ++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c        |  51 +-
 kernel/sched/fair.c                     |   4 +
 kernel/sched/rt.c                       |   4 +
 kernel/sched/sched.h                    | 194 ++++++
 10 files changed, 1316 insertions(+), 24 deletions(-)

-- 
2.17.1

