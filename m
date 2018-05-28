Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754114AbeE1IwG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:52:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:63389 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753994AbeE1IwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:52:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,451,1520924400";
   d="scan'208";a="232298139"
Date: Mon, 28 May 2018 16:52:01 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: kernel test robot <xiaolong.ye@intel.com>, lkp@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [LKP] [lkp-robot] [mm] e27be240df: will-it-scale.per_process_ops
 -27.2% regression
Message-ID: <20180528085201.GA2918@intel.com>
References: <20180508053451.GD30203@yexl-desktop>
 <20180508172640.GB24175@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180508172640.GB24175@cmpxchg.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 01:26:40PM -0400, Johannes Weiner wrote:
> Hello,
> 
> On Tue, May 08, 2018 at 01:34:51PM +0800, kernel test robot wrote:
> > FYI, we noticed a -27.2% regression of will-it-scale.per_process_ops due to commit:
> > 
> > 
> > commit: e27be240df53f1a20c659168e722b5d9f16cc7f4 ("mm: memcg: make sure memory.events is uptodate when waking pollers")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: will-it-scale
> > on test machine: 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 128G memory
> > with following parameters:
> > 
> > 	nr_task: 100%
> > 	mode: process
> > 	test: page_fault3
> > 	cpufreq_governor: performance
> > 
> > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > test-url: https://github.com/antonblanchard/will-it-scale
> 
> This is surprising. Do you run these tests in a memory cgroup with a
> limit set? Can you dump that cgroup's memory.events after the run?

"Some background in case it's forgotten: we do not set any memory control
group specifically and the test machine is using ramfs as its root.
The machine has plenty memory, no swap is setup. All pages belong to
root_mem_cgroup"

Turned out the performance change is due to 'struct mem_cgroup' layout
change, i.e. if I do:

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d99b71bc2c66..c767db1da0bb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -205,7 +205,6 @@ struct mem_cgroup {
 	int		oom_kill_disable;
 
 	/* memory.events */
-	atomic_long_t memory_events[MEMCG_NR_MEMORY_EVENTS];
 	struct cgroup_file events_file;
 
 	/* protect arrays of thresholds */
@@ -238,6 +237,7 @@ struct mem_cgroup {
 	struct mem_cgroup_stat_cpu __percpu *stat_cpu;
 	atomic_long_t		stat[MEMCG_NR_STAT];
 	atomic_long_t		events[NR_VM_EVENT_ITEMS];
+	atomic_long_t memory_events[MEMCG_NR_MEMORY_EVENTS];
 
 	unsigned long		socket_pressure;
 
The performance will restore.

Move information:
With this patch, perf profile+annotate showed increased cycles spent on
accessing root_mem_cgroup->stat_cpu in count_memcg_event_mm()(called by
handle_mm_fault()):

       │             x = count + __this_cpu_read(memcg->stat_cpu->events[idx]);
 92.31 │       mov    0x308(%rcx),%rax
  0.58 │       mov    %gs:0x1b0(%rax),%rdx
  0.09 │       add    $0x1,%rdx

And in __mod_memcg_state() called by page_add_file_rmap():

       │             x = val + __this_cpu_read(memcg->stat_cpu->count[idx]);
 70.89 │       mov    0x308(%rdi),%rdx
  0.43 │       mov    %gs:0x68(%rdx),%rax
  0.08 │       add    %rbx,%rax
       │             if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {

My first reaction is, with the patch changing the sturcture layout, the
stat_cpu field might end up in a cacheline that is constantly being
written to. With the help of pahole, I got:
1 after this patch(bad)
       
        /* --- cacheline 12 boundary (768 bytes) --- */
        long unsigned int          move_lock_flags;      /*   768     8 */
        struct mem_cgroup_stat_cpu * stat_cpu;           /*   776     8 */
        atomic_long_t              stat[34];             /*   784     0 */

stat[0] - stat[5] falls in this cacheline.

2 before this patch(good)
        /* --- cacheline 11 boundary (704 bytes) was 8 bytes ago --- */
        long unsigned int          move_charge_at_immigrate; /*   712     8 */
        atomic_t                   moving_account;       /*   720     0 */

        /* XXX 4 bytes hole, try to pack */

        spinlock_t                 move_lock;            /*   724     0 */

        /* XXX 4 bytes hole, try to pack */

        struct task_struct *       move_lock_task;       /*   728     8 */
        long unsigned int          move_lock_flags;      /*   736     8 */
        struct mem_cgroup_stat_cpu * stat_cpu;           /*   744     8 */
        atomic_long_t              stat[34];             /*   752     0 */

stat[0] - stat[1] falls in this cacheline.

We now have more stat[]s fall in the cacheline, but then I realized
stats[0] - stat[12] are never written to for a memory control group, the
first written field is 13(NR_FILE_MAPPED).

So I think my first reaction is wrong.

Looking at the good layout, there is a field moving_account that will be
accessed during the test in lock_page_memcg(), and that access is always
read only since there is no page changing memcg. So the good performance
might be due to having the two fields in the cache line. I moved the
moving_account field to the same cacheline as stat_cpu for the bad case,
the performance restored a lot but still not as good as base.

I'm not sure where to go next step and would like to seek some
suggestion. Based on my analysis, it appears the good performance for
base is entirely by accident(having moving_account and stat_cpu in the
same cacheline), we never ensure that. In the meantime, it might not be
a good idea to ensure that since stat_cpu should be an always_read field
while moving_account will be modified when needed.

Or any idea what might be the cause? Thanks.
