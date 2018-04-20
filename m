Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754237AbeDTJZq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:25:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40797 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754119AbeDTJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:25:44 -0400
X-Google-Smtp-Source: AIpwx48flT4NFdAxrOv5apz8zxdhoxbaPJyH3ETyxbmT9YaEPgHJXCF998GphWJWSpKJXKiEPlsLpQ==
Date: Fri, 20 Apr 2018 11:25:40 +0200
From: Juri Lelli <juri.lelli@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Rework for_each_process_thread() iterations in
 tg_has_rt_tasks()
Message-ID: <20180420092540.GG24599@localhost.localdomain>
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On 19/04/18 20:29, Kirill Tkhai wrote:
> tg_rt_schedulable() iterates over all child task groups,
> while tg_has_rt_tasks() iterates over all linked tasks.
> In case of systems with big number of tasks, this may
> take a lot of time.
> 
> I observed hard LOCKUP on machine with 20000+ processes
> after write to "cpu.rt_period_us" of cpu cgroup with
> 39 children. The problem occurred because of tasklist_lock
> is held for a long time and other processes can't do fork().
> 
> PID: 1036268  TASK: ffff88766c310000  CPU: 36  COMMAND: "criu"
>  #0 [ffff887f7f408e48] crash_nmi_callback at ffffffff81050601
>  #1 [ffff887f7f408e58] nmi_handle at ffffffff816e0cc7
>  #2 [ffff887f7f408eb0] do_nmi at ffffffff816e0fb0
>  #3 [ffff887f7f408ef0] end_repeat_nmi at ffffffff816e00b9
>     [exception RIP: tg_rt_schedulable+463]
>     RIP: ffffffff810bf49f  RSP: ffff886537ad7d50  RFLAGS: 00000202
>     RAX: 0000000000000000  RBX: 000000003b9aca00  RCX: ffff883e9cb4b1b0
>     RDX: ffff887d0be43608  RSI: ffff886537ad7dd8  RDI: ffff8840a6ad0000
>     RBP: ffff886537ad7d68   R8: ffff887d0be431b0   R9: 00000000000e7ef0
>     R10: ffff88164fc39400  R11: 0000000000023380  R12: ffffffff81ef8d00
>     R13: ffffffff810bea40  R14: 0000000000000000  R15: ffff8840a6ad0000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
>  #4 [ffff886537ad7d50] tg_rt_schedulable at ffffffff810bf49f
>  #5 [ffff886537ad7d70] walk_tg_tree_from at ffffffff810c6c91
>  #6 [ffff886537ad7dc0] tg_set_rt_bandwidth at ffffffff810c6dd0
>  #7 [ffff886537ad7e28] cpu_rt_period_write_uint at ffffffff810c6eea
>  #8 [ffff886537ad7e38] cgroup_file_write at ffffffff8111cfd3
>  #9 [ffff886537ad7ec8] vfs_write at ffffffff8121eced
> #10 [ffff886537ad7f08] sys_write at ffffffff8121faff
> #11 [ffff886537ad7f50] system_call_fastpath at ffffffff816e8a7d
> 
> The patch reworks tg_has_rt_tasks() and makes it to check
> for rt_rq::rt_nr_running instead of iteration over task list.
> This makes the function to scale well, and its execution time
> does not depend on number of processes in the system.
> 
> Note, that since tasklist_lock doesn't protect a task against
> sched_class changing, we don't introduce new races in comparison
> to that we had before. Also, rt_rq::rt_nr_running contains queued
> child cfs_rq in additional to queued task. Since tg_has_rt_tasks()

s/cfs_/rt_/ , right?

> is used in case of !runtime case:
> 
> 	if (rt_bandwidth_enabled() && !runtime && tg_has_rt_tasks(tg))
> 		return -EBUSY;
> 
> the behaviour won't change. The only change is that walk_tg_tree()
> calling tg_rt_schedulable() will break its iteration on parent cfs_rq,

Ditto.

> i.e. earlier.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  kernel/sched/rt.c |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 7aef6b4e885a..601151bb9322 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2395,10 +2395,10 @@ const struct sched_class rt_sched_class = {
>   */
>  static DEFINE_MUTEX(rt_constraints_mutex);
>  
> -/* Must be called with tasklist_lock held */
>  static inline int tg_has_rt_tasks(struct task_group *tg)
>  {
> -	struct task_struct *g, *p;
> +	struct rt_rq *rt_rq;
> +	int cpu, ret = 0;
>  
>  	/*
>  	 * Autogroups do not have RT tasks; see autogroup_create().
> @@ -2406,12 +2406,18 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
>  	if (task_group_is_autogroup(tg))
>  		return 0;
>  
> -	for_each_process_thread(g, p) {
> -		if (rt_task(p) && task_group(p) == tg)
> -			return 1;
> +	preempt_disable();
> +
> +	for_each_online_cpu(cpu) {
> +		rt_rq = tg->rt_rq[cpu];
> +		if (READ_ONCE(rt_rq->rt_nr_running)) {

Isn't this however checking against the current (dynamic) number of
runnable tasks/groups instead of the "static" group membership (which
shouldn't be affected by a task running state)?

Best,

- Juri
