Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C185C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F6D2089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F6D2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeGILT1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:19:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933111AbeGILTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:19:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 708C5AD14;
        Mon,  9 Jul 2018 11:19:22 +0000 (UTC)
Date:   Mon, 9 Jul 2018 13:19:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     ufo19890607@gmail.com
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian@didichuxing.com
Subject: Re: [PATCH v12 2/2] Add the missing information for the oom report
Message-ID: <20180709111921.GI22049@dhcp22.suse.cz>
References: <1530796829-4539-1-git-send-email-ufo19890607@gmail.com>
 <1530796829-4539-2-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530796829-4539-2-git-send-email-ufo19890607@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject is not informative. What is the information?
Add oom victim's memmcg to the oom context information

On Thu 05-07-18 21:20:29, ufo19890607@gmail.com wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> The current oom report doesn't display victim's memcg context during the
> global OOM situation. While this information is not strictly needed, it
> can be really helpful for containerized environments to locate which
> container has lost a process. Now that we have a single line for the oom
> context, we can trivially add both the oom memcg (this can be either
> global_oom or a specific memcg which hits its hard limits) and task_memcg
> which is the victim's memcg.

The <insert your usecase> is clearly missing.

An example of the oom context line would be appropriate.

> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>

The patch looks good otherwise. I would suggest switching cpuset and
memcg information ordering but that is not crucial AFAICS. So you can
add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 14 +++++++++++---
>  mm/memcontrol.c            | 36 ++++++++++++++++++++++--------------
>  mm/oom_kill.c              | 10 ++++++----
>  3 files changed, 39 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6c6fb116e925..96a73f989101 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -491,8 +491,10 @@ void mem_cgroup_handle_over_high(void);
>  
>  unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
>  
> -void mem_cgroup_print_oom_info(struct mem_cgroup *memcg,
> -				struct task_struct *p);
> +void mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
> +		struct task_struct *p);
> +
> +void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg);
>  
>  static inline void mem_cgroup_oom_enable(void)
>  {
> @@ -903,7 +905,13 @@ static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
>  }
>  
>  static inline void
> -mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
> +mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
> +				struct task_struct *p)
> +{
> +}
> +
> +static inline void
> +mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  {
>  }
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e6f0d5ef320a..18deea974cfd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1119,32 +1119,40 @@ static const char *const memcg1_stat_names[] = {
>  
>  #define K(x) ((x) << (PAGE_SHIFT-10))
>  /**
> - * mem_cgroup_print_oom_info: Print OOM information relevant to memory controller.
> - * @memcg: The memory cgroup that went over limit
> + * mem_cgroup_print_oom_context: Print OOM context information relevant to
> + * memory controller.
> + * @memcg: The origin memory cgroup that went over limit
>   * @p: Task that is going to be killed
>   *
>   * NOTE: @memcg and @p's mem_cgroup can be different when hierarchy is
>   * enabled
>   */
> -void mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
> +void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *p)
>  {
> -	struct mem_cgroup *iter;
> -	unsigned int i;
> +	struct cgroup *origin_cgrp, *kill_cgrp;
>  
>  	rcu_read_lock();
> -
> +	if (memcg) {
> +		pr_cont(",oom_memcg=");
> +		pr_cont_cgroup_path(memcg->css.cgroup);
> +	} else
> +		pr_cont(",global_oom");
>  	if (p) {
> -		pr_info("Task in ");
> +		pr_cont(",task_memcg=");
>  		pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
> -		pr_cont(" killed as a result of limit of ");
> -	} else {
> -		pr_info("Memory limit reached of cgroup ");
>  	}
> -
> -	pr_cont_cgroup_path(memcg->css.cgroup);
> -	pr_cont("\n");
> -
>  	rcu_read_unlock();
> +}
> +
> +/**
> + * mem_cgroup_print_oom_meminfo: Print OOM memory information relevant to
> + * memory controller.
> + * @memcg: The memory cgroup that went over limit
> + */
> +void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup *iter;
> +	unsigned int i;
>  
>  	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
>  		K((u64)page_counter_read(&memcg->memory)),
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index c38f224b0d9e..9e80f6c2eb2e 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -430,13 +430,15 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  	dump_stack();
>  
>  	/* one line summary of the oom killer context. */
> -	pr_info("oom-kill:constraint=%s,nodemask=%*pbl,task=%s,pid=%5d,uid=%5d",
> +	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
>  			oom_constraint_text[oc->constraint],
> -			nodemask_pr_args(oc->nodemask),
> -			p->comm, p->pid, from_kuid(&init_user_ns, task_uid(p)));
> +			nodemask_pr_args(oc->nodemask));
> +	mem_cgroup_print_oom_context(oc->memcg, p);
>  	cpuset_print_current_mems_allowed();
> +	pr_cont(",task=%s,pid=%5d,uid=%5d\n", p->comm, p->pid,
> +		from_kuid(&init_user_ns, task_uid(p)));
>  	if (is_memcg_oom(oc))
> -		mem_cgroup_print_oom_info(oc->memcg, p);
> +		mem_cgroup_print_oom_meminfo(oc->memcg);
>  	else {
>  		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
>  		if (is_dump_unreclaim_slabs())
> -- 
> 2.14.1
> 

-- 
Michal Hocko
SUSE Labs
