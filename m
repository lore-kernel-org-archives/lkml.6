Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754771AbeDTMBH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:01:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTMBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:01:04 -0400
Date: Fri, 20 Apr 2018 14:00:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        dan.j.williams@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180420120044.GN4064@hirez.programming.kicks-ass.net>
References: <20180419051510.GA21898@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419051510.GA21898@mwanda>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dan,

awesome stuff...

So I fear that many are actually things we want to fix. Our policy was
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store.

Also, many of the reported things (for the ones I looked at) are on slow
paths and fixing them is a no brainer.

Let me go write Changelogs for the onces I pasted below.

On Thu, Apr 19, 2018 at 08:15:10AM +0300, Dan Carpenter wrote:

> kernel/events/ring_buffer.c:871 perf_mmap_to_page() warn: potential spectre issue 'rb->aux_pages'

That one looks legit.

---
 kernel/events/ring_buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 6c6b3c48db71..709458b2b839 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -867,8 +867,10 @@ perf_mmap_to_page(struct ring_buffer *rb, unsigned long pgoff)
 			return NULL;
 
 		/* AUX space */
-		if (pgoff >= rb->aux_pgoff)
-			return virt_to_page(rb->aux_pages[pgoff - rb->aux_pgoff]);
+		if (pgoff >= rb->aux_pgoff) {
+			int aux_pgoff = array_index_nospec(pgoff - rb->aux_pgoff, rb->aux_nr_pages);
+			return virt_to_page(rb->aux_pages[aux_pgoff]);
+		}
 	}
 
 	return __perf_mmap_to_page(rb, pgoff);

> arch/x86/events/core.c:319 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_event_ids[cache_type]' (local cap)
> arch/x86/events/core.c:319 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_event_ids' (local cap)
> arch/x86/events/core.c:328 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_extra_regs[cache_type]' (local cap)
> arch/x86/events/core.c:328 set_ext_hw_attr() warn: potential spectre issue 'hw_cache_extra_regs' (local cap)

These are legit. At first I figured they'd be of limited exploitablility
because we already mask them to 0xFF, but given its a 3 dimensional
array, the highest order term can go quite far.

Also, its a slow path. So we should probably fix this.

---
 arch/x86/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7a987e6c7c35..b1a1b19b9a4f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -304,17 +304,20 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 
 	config = attr->config;
 
-	cache_type = (config >>  0) & 0xff;
+	cache_type = (config >> 0) & 0xff;
 	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
 		return -EINVAL;
+	cache_type = array_index_nospec(cache_type, PERF_COUNT_HW_CACHE_MAX);
 
 	cache_op = (config >>  8) & 0xff;
 	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
 		return -EINVAL;
+	cache_op = array_index_nospec(cache_op, PERF_COUNT_HW_CACHE_OP_MAX);
 
 	cache_result = (config >> 16) & 0xff;
 	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
 		return -EINVAL;
+	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
 
 	val = hw_cache_event_ids[cache_type][cache_op][cache_result];
 


> arch/x86/events/intel/cstate.c:307 cstate_pmu_event_init() warn: potential spectre issue 'pkg_msr' (local cap)
> arch/x86/events/intel/core.c:337 intel_pmu_event_map() warn: potential spectre issue 'intel_perfmon_event_map'
> arch/x86/events/intel/knc.c:122 knc_pmu_event_map() warn: potential spectre issue 'knc_perfmon_event_map'
> arch/x86/events/intel/p4.c:722 p4_pmu_event_map() warn: potential spectre issue 'p4_general_events'
> arch/x86/events/intel/p6.c:116 p6_pmu_event_map() warn: potential spectre issue 'p6_perfmon_event_map'
> arch/x86/events/amd/core.c:132 amd_pmu_event_map() warn: potential spectre issue 'amd_perfmon_event_map'

They also look legit.

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7a987e6c7c35..e1972f96d043 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -421,6 +424,8 @@ int x86_setup_perfctr(struct perf_event *event)
 	if (attr->config >= x86_pmu.max_events)
 		return -EINVAL;
 
+	attr->config = array_index_nospec(attr->config, x86_pmu.max_events);
+
 	/*
 	 * The generic map:
 	 */


> arch/x86/events/msr.c:178 msr_event_init() warn: potential spectre issue 'msr' (local cap)

 arch/x86/events/msr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index e7edf19e64c2..6dcdce729b1f 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -158,9 +158,6 @@ static int msr_event_init(struct perf_event *event)
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (cfg >= PERF_MSR_EVENT_MAX)
-		return -EINVAL;
-
 	/* unsupported modes and filters */
 	if (event->attr.exclude_user   ||
 	    event->attr.exclude_kernel ||
@@ -171,6 +168,11 @@ static int msr_event_init(struct perf_event *event)
 	    event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
+	if (cfg >= PERF_MSR_EVENT_MAX)
+		return -EINVAL;
+
+	cfg = array_index_nospec(cfg, PERF_MSR_EVENT_MAX);
+
 	if (!msr[cfg].attr)
 		return -EINVAL;
 
> kernel/sched/core.c:6921 cpu_weight_nice_write_s64() warn: potential spectre issue 'sched_prio_to_weight'

again, looks like we want to fix that.

 kernel/sched/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10aaeebfcc..b5d1dfc8f71a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6928,11 +6928,14 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 				     struct cftype *cft, s64 nice)
 {
 	unsigned long weight;
+	int idx;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -ERANGE;
 
-	weight = sched_prio_to_weight[NICE_TO_PRIO(nice) - MAX_RT_PRIO];
+	idx = array_index_nospec(NICE_TO_PRIO(nice) - MAX_RT_PRIO, 40);
+	weight = sched_prio_to_weight[idx];
+
 	return sched_group_set_shares(css_tg(css), scale_load(weight));
 }
 #endif

> kernel/sched/autogroup.c:230 proc_sched_autogroup_set_nice() warn: potential spectre issue 'sched_prio_to_weight'


 kernel/sched/autogroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 6be6c575b6cd..9459fe57af4c 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -209,7 +209,7 @@ int proc_sched_autogroup_set_nice(struct task_struct *p, int nice)
 	static unsigned long next = INITIAL_JIFFIES;
 	struct autogroup *ag;
 	unsigned long shares;
-	int err;
+	int err, idx;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -EINVAL;
@@ -227,7 +227,9 @@ int proc_sched_autogroup_set_nice(struct task_struct *p, int nice)
 
 	next = HZ / 10 + jiffies;
 	ag = autogroup_task_get(p);
-	shares = scale_load(sched_prio_to_weight[nice + 20]);
+
+	idx = array_index_nospec(nice + 20, 40);
+	shares = scale_load(sched_prio_to_weight[idx]);
 
 	down_write(&ag->lock);
 	err = sched_group_set_shares(ag->tg, shares);
