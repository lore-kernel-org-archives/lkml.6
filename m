Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D73C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0588D20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="RwV9VIRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0588D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbeIHCYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:04 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:44847 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbeIHCYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356467; x=1567892467;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FU0f+cwqoFN29Hl82DulO/UtXS3O7Z8b4W1XwMfnLYA=;
  b=RwV9VIRlyTyTIojSxvLYDUMqvXKmXLAN3kB/Q6ALLDnVcBf1ZInhT/RT
   F+hGYBZHzFXRo7okptkudqhPuQSHlEgJvoviVA+Zh7+ZiS+sS4itlI0ly
   yJ8lKLy6PsaC2miJWOHdPdtHwhNPCORwgqdV/3z8nKqFfRTDBHFLDs04+
   w=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="737530357"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:41:06 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LexcE057272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:02 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LevxE027036
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:40:58 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Leulk027035;
        Fri, 7 Sep 2018 23:40:56 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 00/60] Coscheduling for Linux
Date:   Fri,  7 Sep 2018 23:39:47 +0200
Message-Id: <20180907214047.26914-1-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series extends CFS with support for coscheduling. The
implementation is versatile enough to cover many different coscheduling
use-cases, while at the same time being non-intrusive, so that behavior of
legacy workloads does not change.

Peter Zijlstra once called coscheduling a "scalability nightmare waiting to
happen". Well, with this patch series, coscheduling certainly happened.
However, I disagree on the scalability nightmare. :)

In the remainder of this email, you will find:

A) Quickstart guide for the impatient.
B) Why would I want this?
C) How does it work?
D) What can I *not* do with this?
E) What's the overhead?
F) High-level overview of the patches in this series.

Regards
Jan


A) Quickstart guide for the impatient.
--------------------------------------

Here is a quickstart guide to set up coscheduling at core-level for
selected tasks on an SMT-capable system:

1. Apply the patch series to v4.19-rc2.
2. Compile with "CONFIG_COSCHEDULING=y".
3. Boot into the newly built kernel with an additional kernel command line
   argument "cosched_max_level=1" to enable coscheduling up to core-level.
4. Create one or more cgroups and set their "cpu.scheduled" to "1".
5. Put tasks into the created cgroups and set their affinity explicitly.
6. Enjoy tasks of the same group and on the same core executing
   simultaneously, whenever they are executed.

You are not restricted to coscheduling at core-level. Just select higher
numbers in steps 3 and 4. See also further below for more information, esp.
when you want to try higher numbers on larger systems.

Setting affinity explicitly for tasks within coscheduled cgroups is
currently necessary, as the load balancing portion is still missing in this
series.


B) Why would I want this?
-------------------------

Coscheduling can be useful for many different use cases. Here is an
incomplete (very condensed) list:

1. Execute parallel applications that rely on active waiting or synchronous
   execution concurrently with other applications.

   The prime example in this class are probably virtual machines. Here,
   coscheduling is an alternative to paravirtualized spinlocks, pause loop
   exiting, and other techniques with its own set of advantages and
   disadvantages over the other approaches.

2. Execute parallel applications with architecture-specific optimizations
   concurrently with other applications.

   For example, a coscheduled application has a (usually) shared cache for
   itself, while it is executing. This keeps various cache-optimization
   techniques effective in face of other load, making coscheduling an
   alternative to other cache partitioning techniques.
 
3. Reduce resource contention between independent applications.

   This is probably one of the most researched use-cases in recent years:
   if we can derive subsets of tasks, where tasks in a subset don't
   interfere much with each other when executed in parallel, then
   coscheduling can be used to realize this more efficient schedule. And
   "resource" is a really loose term here: from execution units in an SMT
   system, over cache pressure, over memory bandwidth, to a processor's
   power budget and resulting frequency selection.

4. Support the management of (multiple) (parallel) applications.

   Coscheduling does not only enable simultaneous execution, it also gives
   a form of concurrency control, which can be used for various effects.
   The currently most relevant example in this category is, that
   coscheduling can be used to close certain side-channels or at least
   contribute to making their exploitation harder by isolating applications
   in time.
   
   In the L1TF context, it prevents other applications from loading
   additional data into the L1 cache, while one application tries to leak
   data.


C) How does it work?
--------------------

This patch series introduces hierarchical runqueues, that represent larger
and larger fractions of the system. By default, there is one runqueue per
scheduling domain. These additional levels of runqueues are activated by
the "cosched_max_level=" kernel command line argument. The bottom level is
0.

One CPU per hierarchical runqueue is considered the leader, who is
primarily responsible for the scheduling decision at this level. Once the
leader has selected a task group to execute, it notifies all leaders of the
runqueues below it to select tasks/task groups within the selected task
group.

For each task-group, the user can select at which level it should be
scheduled. If you set "cpu.scheduled" to "1", coscheduling will typically
happen at core-level on systems with SMT. That is, if one SMT sibling
executes a task from this task group, the other sibling will do so, too. If
no task is available, the SMT sibling will be idle. With "cpu.scheduled"
set to "2" this is extended to the next level, which is typically a whole
socket on many systems. And so on.  If you feel, that this does not provide
enough flexibility, you can specify "cosched_split_domains" on the kernel
command line to create more fine-grained scheduling domains for your
system.

You currently have to explicitly set affinities of tasks within coscheduled
task groups, as load balancing is not implemented for them at this point.


D) What can I *not* do with this?
---------------------------------

Besides the missing load-balancing within coscheduled task-groups, this
implementation has the following properties, which might be considered
short-comings.

This particular implementation focuses on SCHED_OTHER tasks managed by CFS
and allows coscheduling them. Interrupts as well as tasks in higher
scheduling classes are currently out-of-scope: they are assumed to be
negligible interruptions as far as coscheduling is concerned and they do
*not* cause a preemption of a whole group. This implementation could be
extended to cover higher scheduling classes. Interrupts, however, are an
orthogonal issue.

The collective context switch from one coscheduled set of tasks to another
-- while fast -- is not atomic. If a use-case needs the absolute guarantee
that all tasks of the previous set have stopped executing before any task
of the next set starts executing, an additional hand-shake/barrier needs to
be added.

Together with load-balancing, this implementation gains the ability to
restrict execution of tasks within a task-group to be below a single
hierarchical runqueue of a certain level. From there, it is a short step to
dynamically adjust this level in relation to the number of runnable tasks.
This will enable wide coscheduling with a minimum of fragmentation under
dynamic load.


E) What's the overhead?
-----------------------

Each (active) hierarchy level has roughly the same effect as one additional
level of nested cgroups. In addition -- at this stage -- there may be some
additional lock contention if you coschedule larger fractions of the system
with a dynamic task set.


F) High-level overview of the patches in this series.
-----------------------------------------------------

 1 to 21: Preparation patches that keep the following coscheduling patches
          manageable. Of general interest, even without coscheduling, may
	  be the following:

       1: Store task_group->se[] pointers as part of cfs_rq
       2: Introduce set_entity_cfs() to place a SE into a certain CFS runqueue
       4: Replace sd_numa_mask() hack with something sane
      15: Introduce parent_cfs_rq() and use it
      17: Introduce and use generic task group CFS traversal functions

      As well as some simpler clean-ups in patches 8, 10, 13, and 18.


22 to 60: The actual coscheduling functionality. Highlights are:

      23: Data structures used for coscheduling.
   24-26: Creation of root-task-group runqueue hierarchy.
   39-40: Runqueue hierarchies for normal task groups.
   41-42: Locking strategies under coscheduling.
   47-49: Adjust core CFS code.
      52: Adjust core CFS code.
   54-56: Adjust core CFS code.
   57-59: Enabling/disabling of coscheduling via cpu.scheduled


Jan H. Schönherr (60):
  sched: Store task_group->se[] pointers as part of cfs_rq
  sched: Introduce set_entity_cfs() to place a SE into a certain CFS
    runqueue
  sched: Setup sched_domain_shared for all sched_domains
  sched: Replace sd_numa_mask() hack with something sane
  sched: Allow to retrieve the sched_domain_topology
  sched: Add a lock-free variant of resched_cpu()
  sched: Reduce dependencies of init_tg_cfs_entry()
  sched: Move init_entity_runnable_average() into init_tg_cfs_entry()
  sched: Do not require a CFS in init_tg_cfs_entry()
  sched: Use parent_entity() in more places
  locking/lockdep: Increase number of supported lockdep subclasses
  locking/lockdep: Make cookie generator accessible
  sched: Remove useless checks for root task-group
  sched: Refactor sync_throttle() to accept a CFS runqueue as argument
  sched: Introduce parent_cfs_rq() and use it
  sched: Preparatory code movement
  sched: Introduce and use generic task group CFS traversal functions
  sched: Fix return value of SCHED_WARN_ON()
  sched: Add entity variants of enqueue_task_fair() and
    dequeue_task_fair()
  sched: Let {en,de}queue_entity_fair() work with a varying amount of
    tasks
  sched: Add entity variants of put_prev_task_fair() and
    set_curr_task_fair()
  cosched: Add config option for coscheduling support
  cosched: Add core data structures for coscheduling
  cosched: Do minimal pre-SMP coscheduler initialization
  cosched: Prepare scheduling domain topology for coscheduling
  cosched: Construct runqueue hierarchy
  cosched: Add some small helper functions for later use
  cosched: Add is_sd_se() to distinguish SD-SEs from TG-SEs
  cosched: Adjust code reflecting on the total number of CFS tasks on a
    CPU
  cosched: Disallow share modification on task groups for now
  cosched: Don't disable idle tick for now
  cosched: Specialize parent_cfs_rq() for hierarchical runqueues
  cosched: Allow resched_curr() to be called for hierarchical runqueues
  cosched: Add rq_of() variants for different use cases
  cosched: Adjust rq_lock() functions to work with hierarchical
    runqueues
  cosched: Use hrq_of() for rq_clock() and rq_clock_task()
  cosched: Use hrq_of() for (indirect calls to) ___update_load_sum()
  cosched: Skip updates on non-CPU runqueues in cfs_rq_util_change()
  cosched: Adjust task group management for hierarchical runqueues
  cosched: Keep track of task group hierarchy within each SD-RQ
  cosched: Introduce locking for leader activities
  cosched: Introduce locking for (mostly) enqueuing and dequeuing
  cosched: Add for_each_sched_entity() variant for owned entities
  cosched: Perform various rq_of() adjustments in scheduler code
  cosched: Continue to account all load on per-CPU runqueues
  cosched: Warn on throttling attempts of non-CPU runqueues
  cosched: Adjust SE traversal and locking for common leader activities
  cosched: Adjust SE traversal and locking for yielding and buddies
  cosched: Adjust locking for enqueuing and dequeueing
  cosched: Propagate load changes across hierarchy levels
  cosched: Hacky work-around to avoid observing zero weight SD-SE
  cosched: Support SD-SEs in enqueuing and dequeuing
  cosched: Prevent balancing related functions from crossing hierarchy
    levels
  cosched: Support idling in a coscheduled set
  cosched: Adjust task selection for coscheduling
  cosched: Adjust wakeup preemption rules for coscheduling
  cosched: Add sysfs interface to configure coscheduling on cgroups
  cosched: Switch runqueues between regular scheduling and coscheduling
  cosched: Handle non-atomicity during switches to and from coscheduling
  cosched: Add command line argument to enable coscheduling

 include/linux/lockdep.h        |    4 +-
 include/linux/sched/topology.h |   18 +-
 init/Kconfig                   |   11 +
 kernel/locking/lockdep.c       |   21 +-
 kernel/sched/Makefile          |    1 +
 kernel/sched/core.c            |  109 +++-
 kernel/sched/cosched.c         |  882 +++++++++++++++++++++++++++++
 kernel/sched/debug.c           |    2 +-
 kernel/sched/fair.c            | 1196 ++++++++++++++++++++++++++++++++--------
 kernel/sched/idle.c            |    7 +-
 kernel/sched/sched.h           |  461 +++++++++++++++-
 kernel/sched/topology.c        |   57 +-
 kernel/time/tick-sched.c       |   14 +
 13 files changed, 2474 insertions(+), 309 deletions(-)
 create mode 100644 kernel/sched/cosched.c

-- 
2.9.3.1.gcba166c.dirty

