Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD21C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03F72084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548062381;
	bh=3VrY8xj9PLffKub+Zw0KDt6XVkfF1vOGMYc0mD8QCr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AWwJNpdjFemFM5xAxSt7D+g2YEqwdOYn0ipdDvCSGZDcImYT/m/J8+EssK/eESIwW
	 JfuMVgd7mKWoWRxuUhDz3DF5PlyaW79Z+704hH39fzUVXoGQnGKcuvbC29nQD2SOtT
	 yKrwtttR+d9mcU+N7wbIuFVyGC6sLVVQo/SFCzyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfAUJTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:19:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:55752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbfAUJTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:19:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAB5BAD18;
        Mon, 21 Jan 2019 09:19:36 +0000 (UTC)
Date:   Mon, 21 Jan 2019 10:19:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, oom: remove 'prefer children over parent' heuristic
Message-ID: <20190121091933.GL4087@dhcp22.suse.cz>
References: <20190120215059.183552-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190120215059.183552-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 20-01-19 13:50:59, Shakeel Butt wrote:
> >From the start of the git history of Linux, the kernel after selecting
> the worst process to be oom-killed, prefer to kill its child (if the
> child does not share mm with the parent). Later it was changed to prefer
> to kill a child who is worst. If the parent is still the worst then the
> parent will be killed.
> 
> This heuristic assumes that the children did less work than their parent
> and by killing one of them, the work lost will be less. However this is
> very workload dependent. If there is a workload which can benefit from
> this heuristic, can use oom_score_adj to prefer children to be killed
> before the parent.
> 
> The select_bad_process() has already selected the worst process in the
> system/memcg. There is no need to recheck the badness of its children
> and hoping to find a worse candidate. That's a lot of unneeded racy
> work. So, let's remove this whole heuristic.

Yes, I agree with this direction. Let's try it and see whether there is
anything really depending on the heuristic. I hope that is not the case
but at least we will hear about it and the reasoning behind.

I think the changelog should also mension that the heuristic is
dangerous because it make fork bomb like workloads to recover much later
because we constantly pick and kill processes which are not memory hogs.

> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Appart from the nit in the printk output
Acked-by: Michal Hocko <mhocko@suse.com>

Also I would prefer s@p@victim@ because it makes the code more readable

I pressume you are going to send this along with the fix for the
use-after-free in one series.

Thanks.

> ---
>  mm/oom_kill.c | 49 ++++---------------------------------------------
>  1 file changed, 4 insertions(+), 45 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1a007dae1e8f..6cee185dc147 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -944,12 +944,7 @@ static int oom_kill_memcg_member(struct task_struct *task, void *unused)
>  static void oom_kill_process(struct oom_control *oc, const char *message)
>  {
>  	struct task_struct *p = oc->chosen;
> -	unsigned int points = oc->chosen_points;
> -	struct task_struct *victim = p;
> -	struct task_struct *child;
> -	struct task_struct *t;
>  	struct mem_cgroup *oom_group;
> -	unsigned int victim_points = 0;
>  	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
>  					      DEFAULT_RATELIMIT_BURST);
>  
> @@ -971,53 +966,17 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	if (__ratelimit(&oom_rs))
>  		dump_header(oc, p);
>  
> -	pr_err("%s: Kill process %d (%s) score %u or sacrifice child\n",
> -		message, task_pid_nr(p), p->comm, points);
> -
> -	/*
> -	 * If any of p's children has a different mm and is eligible for kill,
> -	 * the one with the highest oom_badness() score is sacrificed for its
> -	 * parent.  This attempts to lose the minimal amount of work done while
> -	 * still freeing memory.
> -	 */
> -	read_lock(&tasklist_lock);
> -
> -	/*
> -	 * The task 'p' might have already exited before reaching here. The
> -	 * put_task_struct() will free task_struct 'p' while the loop still try
> -	 * to access the field of 'p', so, get an extra reference.
> -	 */
> -	get_task_struct(p);
> -	for_each_thread(p, t) {
> -		list_for_each_entry(child, &t->children, sibling) {
> -			unsigned int child_points;
> -
> -			if (process_shares_mm(child, p->mm))
> -				continue;
> -			/*
> -			 * oom_badness() returns 0 if the thread is unkillable
> -			 */
> -			child_points = oom_badness(child,
> -				oc->memcg, oc->nodemask, oc->totalpages);
> -			if (child_points > victim_points) {
> -				put_task_struct(victim);
> -				victim = child;
> -				victim_points = child_points;
> -				get_task_struct(victim);
> -			}
> -		}
> -	}
> -	put_task_struct(p);
> -	read_unlock(&tasklist_lock);
> +	pr_err("%s: Kill process %d (%s) score %lu or sacrifice child\n",
> +		message, task_pid_nr(p), p->comm, oc->chosen_points);
>  
>  	/*
>  	 * Do we need to kill the entire memory cgroup?
>  	 * Or even one of the ancestor memory cgroups?
>  	 * Check this out before killing the victim task.
>  	 */
> -	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
> +	oom_group = mem_cgroup_get_oom_group(p, oc->memcg);
>  
> -	__oom_kill_process(victim);
> +	__oom_kill_process(p);
>  
>  	/*
>  	 * If necessary, kill all tasks in the selected memory cgroup.
> -- 
> 2.20.1.321.g9e740568ce-goog

-- 
Michal Hocko
SUSE Labs
