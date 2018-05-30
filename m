Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeE3MR3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:17:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:43286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbeE3MRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:17:24 -0400
Date: Wed, 30 May 2018 14:17:21 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/2] mm->owner to mm->memcg fixes
Message-ID: <20180530121721.GD27180@dhcp22.suse.cz>
References: <20180504145435.GA26573@redhat.com>
 <87y3gzfmjt.fsf@xmission.com>
 <20180504162209.GB26573@redhat.com>
 <871serfk77.fsf@xmission.com>
 <87tvrncoyc.fsf_-_@xmission.com>
 <20180510121418.GD5325@dhcp22.suse.cz>
 <20180522125757.GL20020@dhcp22.suse.cz>
 <87wovu889o.fsf@xmission.com>
 <20180524111002.GB20441@dhcp22.suse.cz>
 <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-05-18 14:16:35, Andrew Morton wrote:
> On Thu, 24 May 2018 13:10:02 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > I would really prefer and appreciate a repost with all the fixes folded
> > in.
> 
> [1/2]

Thanks Andrew and sorry it took so long! This seems to be missing the
fix for the issue I've mentioned in http://lkml.kernel.org/r/20180510121838.GE5325@dhcp22.suse.cz
and Eric wanted to handle by http://lkml.kernel.org/r/87wovu889o.fsf@xmission.com.
I do not think that this fix is really correct one though. I will
comment in a reply to that email.

In any case I really think this should better be reposted in one patch
series and restart the discussion. I strongly suggest revisiting my
previous attempt http://lkml.kernel.org/r/1436358472-29137-8-git-send-email-mhocko@kernel.org
including the follow up discussion regarding the unfortunate CLONE_VM
outside of thread group case and potential solution for that.

> -static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
> +static void mm_init_memcg(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_MEMCG
> -	mm->owner = p;
> +	struct cgroup_subsys_state *css;
> +
> +	/* Ensure mm->memcg is initialized */
> +	mm->memcg = NULL;
> +
> +	rcu_read_lock();
> +	css = task_css(current, memory_cgrp_id);
> +	if (css && css_tryget(css))
> +		mm_update_memcg(mm, mem_cgroup_from_css(css));
> +	rcu_read_unlock();

Is it possible that css_tryget ever fails here? I remember I used to do
plain css_get in my patch.

> @@ -4850,15 +4836,16 @@ static int mem_cgroup_can_attach(struct
>  	if (!move_flags)
>  		return 0;
>  
> -	from = mem_cgroup_from_task(p);
> +	from = mem_cgroup_from_css(task_css(p, memory_cgrp_id));
>  
>  	VM_BUG_ON(from == memcg);
>  
>  	mm = get_task_mm(p);
>  	if (!mm)
>  		return 0;
> -	/* We move charges only when we move a owner of the mm */
> -	if (mm->owner == p) {
> +
> +	/* We move charges except for creative uses of CLONE_VM */
> +	if (mm->memcg == from) {

I must be missing something here but how do you prevent those cases?
AFAICS processes sharing the mm will simply allow to migrate.

>  		VM_BUG_ON(mc.from);
>  		VM_BUG_ON(mc.to);
>  		VM_BUG_ON(mc.precharge);

Other than that the patch makes sense to me.
-- 
Michal Hocko
SUSE Labs
