Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D09C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF6E2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF6E2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbeJ3DXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:23:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44488 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbeJ3DXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:23:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66109341;
        Mon, 29 Oct 2018 11:33:24 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4FA6A3F6A8;
        Mon, 29 Oct 2018 11:33:21 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v5 00/15] Add utilization clamping support
Date:   Mon, 29 Oct 2018 18:32:54 +0000
Message-Id: <20181029183311.29175-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this is a respin of:

   https://lore.kernel.org/lkml/20180828135324.21976-1-patrick.bellasi@arm.com/

which has been rebased on v4.19.

Thanks for all the valuable comments collected so far!

This version will be presented and discussed at the upcoming LPC.
Meanwhile, any comments and feedbacks are more than welcome!

Cheers Patrick


Main changes in v5
==================

.:: Better split core bits from task groups support
---------------------------------------------------

As per Tejun request:

  https://lore.kernel.org/lkml/20180911162827.GJ1100574@devbig004.ftw2.facebook.com/

we now have _all and only_ the core scheduler bits at the beginning of
the series, the first 10 patches of this series provide:
 - per task utilization clamping API,
    via sched_setattr
 - system default clamps for both FAIR and RT tasks,
    via /proc/sys/kernel/sched_uclamp_util_{min,max}
 - schedutil integration for both FAIR and RT tasks

cgroups v1 and v2 support comes as an extension of the CPU controller in the
last 5 patches of this series. These bits are kept together with the core
scheduler ones to give a better view on the overall solution we are proposing.
Moreover, it helps to ensure we have core data structure and concepts which
properly fits for cgroups usage too.


.:: Spinlock removal in favour of atomic operations
---------------------------------------------------

As suggested by Peter:

   https://lore.kernel.org/lkml/20180912161218.GW24082@hirez.programming.kicks-ass.net/

the main data structures, i.e. clamp maps and clamp groups, have been
re-defined as bitfields mainly to:
 a) compress those data structures to use less memory
 b) avoid usage of spinlocks in favor of atomic operations

As an additional bonus, some spare bits can now be dedicated to track and flag
special conditions which was previously encoded in a more confusing way.
The final code looks (hopefully) much more clean and easy to read.


.:: Improve consistency and enforce invariant conditions
--------------------------------------------------------

We now ensure that every scheduling entity has always a valid clamp group and
value assigned. This made it possible to remove the previously confusing usage
of the UCLAMP_NOT_VALID=-1 special value and different checks here and there.

Data type for clamp groups and values are consistently defined and always used
as "unsigned", while spare bits are used whenever a special condition still
need to be tracked.


.:: Use of bucketization since the beginning
--------------------------------------------

In the previous version we added a couple of patches to deal with the limited
number of clamp groups. Those patches introduced the idea of using buckets for
the per-CPU clamp groups used to refcount RUNNABLE tasks. However, as pointed
out by Peter:

   https://lore.kernel.org/lkml/20180914111003.GC24082@hirez.programming.kicks-ass.net/

the previous implementation was misleading and it also introduced some checks
not really required, e.g. a privileged API to request a clamp which should
always be possible.

Since the fundamental idea of bucketization still seems to be sound and
acceptable, those bits have been used from the start of this patch-set.
This made it possible to simplify the overall series, thanks to the removal of
code previously required just to deal with the limited number of clamp groups.

The new implementation should now implement what Peter proposed above,
specifically:

 a) we don't need to search anymore for all the required groups before actually
    refcounting them. A clamp group is now granted to be always available for
    each possible requested clamp value.

 b) the userspace APIs to set scheduling entity specific clamp values are no
    more privileged. Userspace can always ask for a clamp value and the system
    will always assign it to the most appropriate "effective" clamp group
    which matches with all the task group or system default clamps constraints.


.:: Series Organization
-----------------------

The series is organized into these main sections:

- Patches [01-08]: Per task (primary) API
- Patches [09-10]: Schedutil integration for CFS and RT tasks
- Patches [11-15]: Per task group (secondary) API


Newcomer's Short Abstract (Updated)
===================================

The Linux scheduler tracks a "utilization" signal for each scheduling entity
(SE), e.g. tasks, to know how much CPU time they use. This signal allows the
scheduler to know how "big" a task is and, in principle, it can support
advanced task placement strategies by selecting the best CPU to run a task.
Some of these strategies are represented by the Energy Aware Scheduler [1].

When the schedutil cpufreq governor is in use, the utilization signal allows
the Linux scheduler also to drive frequency selection. The CPU utilization
signal, which represents the aggregated utilization of tasks scheduled on that
CPU, is used to select the frequency which best fits the workload generated by
the tasks.

However, the current translation of utilization values into a frequency
selection is pretty simple: we just go to max for RT tasks or to the minimum
frequency which can accommodate the utilization of DL+FAIR tasks.
Instead, utilization is of limited usage for tasks placement since its value
alone is not enough to properly describe what the _expected_ power/performance
behaviors of each task really is from a userspace standpoint.

In general, for both RT and FAIR tasks we can aim at better tasks placement and
frequency selection policies if we take hints coming from user-space into
consideration.

Utilization clamping is a mechanism which allows to "clamp" (i.e. filter) the
utilization generated by RT and FAIR tasks within a range defined from
user-space. The clamped utilization value can then be used, for example, to
enforce a minimum and/or maximum frequency depending on which tasks are
currently active on a CPU.

The main use-cases for utilization clamping are:

 - boosting: better interactive response for small tasks which
   are affecting the user experience.

   Consider for example the case of a small control thread for an external
   accelerator (e.g. GPU, DSP, other devices). In this case, from the task
   utilization the scheduler does not have a complete view of what the task
   requirements are and, if it's a small utilization task, it keep selecting a
   more energy efficient CPU, with smaller capacity and lower frequency, thus
   affecting the overall time required to complete task activations.

 - capping: increase energy efficiency for background tasks not directly
   affecting the user experience.

   Since running on a lower capacity CPU at a lower frequency is in general
   more energy efficient, when the completion time is not a main goal, then
   capping the utilization considered for certain (maybe big) tasks can have
   positive effects, both on energy consumption and thermal headroom.
   Moreover, this feature allows also to make RT tasks more energy
   friendly on mobile systems, where running them on high capacity CPUs and at
   the maximum frequency is not strictly required.

From these two use-cases, it's worth to notice that frequency selection
biasing, introduced by patches 9 and 10 of this series, is just one possible
usage of utilization clamping. Another compelling extension of utilization
clamping is in helping the scheduler on tasks placement decisions.

Utilization is (also) a task specific property which is used by the scheduler
to know how much CPU bandwidth a task requires, at least as long as there is
idle time.
Thus, the utilization clamp values, defined either per-task or per-taskgroup,
can be used to represent tasks to the scheduler as being bigger (or smaller)
than what they really are.

Utilization clamping thus ultimately enables interesting additional
optimizations, especially on asymmetric capacity systems like Arm
big.LITTLE and DynamIQ CPUs, where:

 - boosting: small/foreground tasks are preferably scheduled on
   higher-capacity CPUs where, despite being less energy efficient, they are
   expected to complete faster.

 - capping: big/background tasks are preferably scheduled on low-capacity CPUs
   where, being more energy efficient, they can still run but save power and
   thermal headroom for more important tasks.

This additional usage of utilization clamping is not presented in this series
but it's an integral part of the EAS feature set, where [1] is one of its main
components. A solution similar to utilization clamping, namely SchedTune, is
already used on Android kernels to bias both 'frequency selection' and 'task
placement'.

This series provides the foundation bits to add similar features to mainline
while focusing, for the time being, just on schedutil integration.

[1] https://lore.kernel.org/lkml/20181016101513.26919-1-quentin.perret@arm.com/


Detailed Changelog
==================

Changes in v5:
 Message-ID: <20180912161218.GW24082@hirez.programming.kicks-ass.net>
 - use bitfields and atomic_long_cmpxchg() operations to both compress
   the clamp maps and avoid usage of spinlock.
 - remove enforced __cacheline_aligned_in_smp on uclamp_map since it's
   accessed from the slow path only and we don't care about performance
 - better describe the usage of uclamp_map::se_lock
 Message-ID: <20180912162427.GA24106@hirez.programming.kicks-ass.net>
 - remove inline from uclamp_group_{get,put}() and __setscheduler_uclamp()
 - set lower/upper bounds at the beginning of __setscheduler_uclamp()
 - avoid usage of pr_err from unprivileged syscall paths
   in  __setscheduler_uclamp(), replaced by ratelimited version
 Message-ID: <20180914134128.GP1413@e110439-lin>
 - remove/limit usage of UCLAMP_NOT_VALID whenever not strictly required
 Message-ID: <20180905104545.GB20267@localhost.localdomain>
 - allow sched_setattr() syscall to sleep on mutex
 - fix return value for successfull uclamp syscalls
 Message-ID: <CAJuCfpF36-VZm0JVVNnOnGm-ukVejzxbPhH33X3z9gAQ06t9gQ@mail.gmail.com>
 - reorder conditions in uclamp_group_find() loop
 - use uc_se->xxx in uclamp_fork()
 Message-ID: <20180914134128.GP1413@e110439-lin>
 - remove not required check for (group_id == UCLAMP_NOT_VALID)
   in uclamp_cpu_put_id
 - remove not required uclamp_task_affects() since now all tasks always
   have a valid clamp group assigned
 Message-ID: <20180912174456.GJ1413@e110439-lin>
 - use bitfields to compress uclamp_group
 Message-ID: <20180905110108.GC20267@localhost.localdomain>
 - added patch 02/15 which allows to change clamp values without affecting
   current policy
 Message-ID: <20180914133654.GL24124@hirez.programming.kicks-ass.net>
  - add a comment to justify the assumptions on util clamping for FAIR tasks
  Message-ID: <20180914093240.GB24082@hirez.programming.kicks-ass.net>
  - removed uclamp_value and use inline access to data structures
  Message-ID: <20180914135712.GQ1413@e110439-lin>
  - the (unlikely(val == UCLAMP_NOT_VALID)) check is not more required
    since we now ensure we always have a valid value configured
 Message-ID: <20180912125133.GE1413@e110439-lin>
 - make more clear the definition of cpu.util.min.effective
 - small typos fixed
 Others:
 - renamed uclamp_round into uclamp_group_value to better represent
   what this function returns
 - reduce usage of alias local variables whenever the global ones can
   still be used without affecting code readability
 - consistently use "unsigned int" for both clamp_id and group_id
 - fixup documentation
 - reduced usage of inline comments
 - use UCLAMP_GROUPS to track (CONFIG_UCLAMP_GROUPS_COUNT+1)
 - rebased on v4.19

Changes in v4:
 Message-ID: <20180809152313.lewfhufidhxb2qrk@darkstar>
 - implements the idea discussed in this thread
 Message-ID: <87897157-0b49-a0be-f66c-81cc2942b4dd@infradead.org>
 - remove not required default setting
 - fixed some tabs/spaces
 Message-ID: <20180807095905.GB2288@localhost.localdomain>
 - replace/rephrase "bandwidth" references to use "capacity"
 - better stress that this do not enforce any bandwidth requirement
   but "just" give hints to the scheduler
 - fixed some typos
 Message-ID: <20180814112509.GB2661@codeaurora.org>
 - add uclamp_exit_task() to release clamp refcount from do_exit()
 Message-ID: <20180816133249.GA2964@e110439-lin>
 - keep the WARN but beautify a bit that code
 - keep the WARN in uclamp_cpu_put_id() but beautify a bit that code
 - add another WARN on the unexpected condition of releasing a refcount
   from a CPU which has a lower clamp value active
 Message-ID: <20180413082648.GP4043@hirez.programming.kicks-ass.net>
 - move uclamp_enabled at the top of sched_class to keep it on the same
   cache line of other main wakeup time callbacks
 Message-ID: <20180816132249.GA2960@e110439-lin>
 - inline uclamp_task_active() code into uclamp_task_update_active()
 - get rid of the now unused uclamp_task_active()
 Message-ID: <20180816172016.GG2960@e110439-lin>
 - ensure to always reset clamp holding on wakeup from IDLE
 Message-ID: <CAKfTPtC2adLupg7wy1JU9zxKx1466Sza6fSCcr92wcawm1OYkg@mail.gmail.com>
 - use *rq instead of cpu for both uclamp_util() and uclamp_value()
 Message-ID: <20180816135300.GC2960@e110439-lin>
 - remove uclamp_value() which is never used outside CONFIG_UCLAMP_TASK
 Message-ID: <20180816140731.GD2960@e110439-lin>
 - add ".effective" attributes to the default hierarchy
 - reuse already existing:
     task_struct::uclamp::effective::group_id
   instead of adding:
     task_struct::uclamp_group_id
   to back annotate the effective clamp group in which a task has been
   refcounted
 Message-ID: <20180820122728.GM2960@e110439-lin>
 - fix unwanted reset of clamp values on refcount success
 Other:
 - by default all tasks have a UCLAMP_NOT_VALID task specific clamp
 - always use:
      p->uclamp[clamp_id].effective.value
   to track the actual clamp value the task has been refcounted into.
   This matches with the usage of
      p->uclamp[clamp_id].effective.group_id
 - allow to call uclamp_group_get() without a task pointer, which is
   used to refcount the initial clamp group for all the global objects
   (init_task, root_task_group and system_defaults)
 - ensure (and check) that all tasks have a valid group_id at
   uclamp_cpu_get_id()
 - rework uclamp_cpu layout to better fit into just 2x64B cache lines
 - fix some s/SCHED_DEBUG/CONFIG_SCHED_DEBUG/
 - init uclamp for the init_task and refcount its clamp groups
 - add uclamp specific fork time code into uclamp_fork
 - add support for SCHED_FLAG_RESET_ON_FORK
   default clamps are now set for init_task and inherited/reset at
   fork time (when then flag is set for the parent)
 - enable uclamp only for FAIR tasks, RT class will be enabled only
   by a following patch which also integrate the class to schedutil
 - define uclamp_maps ____cacheline_aligned_in_smp
 - in uclamp_group_get() ensure to include uclamp_group_available() and
   uclamp_group_init() into the atomic section defined by:
      uc_map[next_group_id].se_lock
 - do not use mutex_lock(&uclamp_mutex) in uclamp_exit_task
   which is also not needed since refcounting is already guarded by
   the uc_map[group_id].se_lock spinlock
 - consolidate init_uclamp_sched_group() into init_uclamp()
 - refcount root_task_group's clamp groups from init_uclamp()
 - small documentation fixes
 - rebased on v4.19-rc1

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


Patrick Bellasi (15):
  sched/core: uclamp: extend sched_setattr to support utilization
    clamping
  sched/core: make sched_setattr able to tune the current policy
  sched/core: uclamp: map TASK's clamp values into CPU's clamp groups
  sched/core: uclamp: add CPU's clamp groups refcounting
  sched/core: uclamp: update CPU's refcount on clamp changes
  sched/core: uclamp: enforce last task UCLAMP_MAX
  sched/core: uclamp: add clamp group bucketing support
  sched/core: uclamp: add system default clamps
  sched/cpufreq: uclamp: add utilization clamping for FAIR tasks
  sched/cpufreq: uclamp: add utilization clamping for RT tasks
  sched/core: uclamp: extend CPU's cgroup controller
  sched/core: uclamp: propagate parent clamps
  sched/core: uclamp: map TG's clamp values into CPU's clamp groups
  sched/core: uclamp: use TG's clamps to restrict TASK's clamps
  sched/core: uclamp: update CPU's refcount on TG's clamp changes

 Documentation/admin-guide/cgroup-v2.rst |   46 +
 include/linux/sched.h                   |   78 ++
 include/linux/sched/sysctl.h            |   11 +
 include/linux/sched/task.h              |    6 +
 include/linux/sched/topology.h          |    6 -
 include/uapi/linux/sched.h              |   11 +-
 include/uapi/linux/sched/types.h        |   67 +-
 init/Kconfig                            |   63 ++
 init/init_task.c                        |    1 +
 kernel/exit.c                           |    1 +
 kernel/sched/core.c                     | 1112 ++++++++++++++++++++++-
 kernel/sched/cpufreq_schedutil.c        |   31 +-
 kernel/sched/fair.c                     |    4 +
 kernel/sched/features.h                 |    5 +
 kernel/sched/rt.c                       |    4 +
 kernel/sched/sched.h                    |  121 ++-
 kernel/sysctl.c                         |   16 +
 17 files changed, 1553 insertions(+), 30 deletions(-)

-- 
2.18.0

