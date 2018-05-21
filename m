Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeEUXev (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 19:34:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44168 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbeEUXet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 19:34:49 -0400
Date: Mon, 21 May 2018 16:34:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: ufo19890607 <ufo19890607@gmail.com>
Cc: mhocko@suse.com, rientjes@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v3] Print the memcg's name when system-wide OOM happened
Message-Id: <20180521163447.c01c53f0ee9354c02d0d77d3@linux-foundation.org>
In-Reply-To: <1526632851-25613-1-git-send-email-ufo19890607@gmail.com>
References: <1526632851-25613-1-git-send-email-ufo19890607@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018 09:40:51 +0100 ufo19890607 <ufo19890607@gmail.com> wrote:

> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> The dump_header does not print the memcg's name when the system
> oom happened. So users cannot locate the certain container which
> contains the task that has been killed by the oom killer.
> 
> System oom report will contain the memcg's name after this patch,
> so users can get the memcg's path from the oom report and check
> that container more quickly.
> 
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1118,6 +1118,19 @@ static const char *const memcg1_stat_names[] = {
>  };
>  
>  #define K(x) ((x) << (PAGE_SHIFT-10))
> +
> +/**
> + * mem_cgroup_print_memcg_name: Print the memcg's name which contains the task
> + * that will be killed by the oom-killer.
> + * @p: Task that is going to be killed
> + */
> +void mem_cgroup_print_memcg_name(struct task_struct *p)
> +{
> +	pr_info("Task in ");
> +	pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
> +	pr_cont(" killed as a result of limit of ");
> +}
> +
>  /**
>   * mem_cgroup_print_oom_info: Print OOM information relevant to memory controller.
>   * @memcg: The memory cgroup that went over limit
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 8ba6cb88cf58..73fdfa2311d5 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -433,6 +433,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_print_oom_info(oc->memcg, p);
>  	else {
> +		mem_cgroup_print_memcg_name(p);
>  		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
>  		if (is_dump_unreclaim_slabs())
>  			dump_unreclaimable_slab();

I'd expect the output to look rather strange.  "Task in wibble killed
as a result of limit of " with no newline, followed by the show_mem()
output.

Is this really what you intended?  If so, why?

It would help to include an example dump in the changelog so that
others can more easily review your intent.
