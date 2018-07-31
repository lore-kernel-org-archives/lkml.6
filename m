Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE87AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B85B20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B85B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbeGaId1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:33:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:56596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbeGaId1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:33:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 807CEAD11;
        Tue, 31 Jul 2018 06:54:37 +0000 (UTC)
Date:   Tue, 31 Jul 2018 08:54:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [mm, oom]  c1e4c54f9c: BUG:KASAN:null-ptr-deref_in_d
Message-ID: <20180731065434.GB4557@dhcp22.suse.cz>
References: <20180730090320.GD30690@shao2-debian>
 <20180730095635.GI24267@dhcp22.suse.cz>
 <alpine.DEB.2.21.1807301854040.198273@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807301854040.198273@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-07-18 19:05:50, David Rientjes wrote:
> On Mon, 30 Jul 2018, Michal Hocko wrote:
> 
> > On Mon 30-07-18 17:03:20, kernel test robot wrote:
> > [...]
> > > [    9.034310] BUG: KASAN: null-ptr-deref in dump_header+0x10c/0x448
> > 
> > Could you faddr2line on the offset please?
> > 
> 
> It's possible that p is NULL when calling dump_header().  In this case we 
> do not want to print any line concerning a victim because no oom kill has 
> occurred.

You are right. I have missed those.

> This code shouldn't be part of dump_header(), which is called from 
> multiple contexts even when an oom kill has not occurred, and is 
> ratelimited.  The single line output should be the canonical way that 
> userspace parses the log for oom victims, we can't ratelimit it.
> 
> The following would be a fix patch, but it will be broken if the cgroup 
> aware oom killer is removed from -mm so that the oom_group stuff can be 
> merged.

cgroup aware oom killer is going to be replaced by a new implementation
IIUC so the fix should be based on the yuzhoujian patch. Ideally to be
resubmitted.

I would just suggest adding it into a function
dump_oom_summary(struct oom_control *oc, struct task_struct *p)

yuzhoujian could you take care of that please?

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -438,14 +438,6 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  
>  	dump_stack();
>  
> -	/* one line summary of the oom killer context. */
> -	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
> -			oom_constraint_text[oc->constraint],
> -			nodemask_pr_args(oc->nodemask));
> -	cpuset_print_current_mems_allowed();
> -	mem_cgroup_print_oom_context(oc->memcg, p);
> -	pr_cont(",task=%s,pid=%d,uid=%d\n", p->comm, p->pid,
> -		from_kuid(&init_user_ns, task_uid(p)));
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_print_oom_meminfo(oc->memcg);
>  	else {
> @@ -836,7 +828,8 @@ static bool task_will_free_mem(struct task_struct *task)
>  	return ret;
>  }
>  
> -static void __oom_kill_process(struct task_struct *victim)
> +static void __oom_kill_process(struct task_struct *victim,
> +			       struct oom_control *oc)
>  {
>  	struct task_struct *p;
>  	struct mm_struct *mm;
> @@ -883,6 +876,18 @@ static void __oom_kill_process(struct task_struct *victim)
>  		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
>  		K(get_mm_counter(victim->mm, MM_FILEPAGES)),
>  		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
> +
> +	if (oc) {
> +		/* One line summary for non-group oom kills */
> +		pr_info("oom-kill: constraint=%s, nodemask=%*pbl",
> +			oom_constraint_text[oc->constraint],
> +			nodemask_pr_args(oc->nodemask));
> +		cpuset_print_current_mems_allowed();
> +		mem_cgroup_print_oom_context(oc->memcg, victim);
> +		pr_cont(", task=%s, pid=%d, uid=%d\n",
> +			victim->comm, victim->pid,
> +			from_kuid(&init_user_ns, task_uid(victim)));
> +	}
>  	task_unlock(victim);
>  
>  	/*
> @@ -986,13 +991,13 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	}
>  	read_unlock(&tasklist_lock);
>  
> -	__oom_kill_process(victim);
> +	__oom_kill_process(victim, oc);
>  }
>  
>  static int oom_kill_memcg_member(struct task_struct *task, void *unused)
>  {
>  	get_task_struct(task);
> -	__oom_kill_process(task);
> +	__oom_kill_process(task, NULL);
>  	return 0;
>  }
>  
> @@ -1020,7 +1025,7 @@ static bool oom_kill_memcg_victim(struct oom_control *oc)
>  		    oc->chosen_task == INFLIGHT_VICTIM)
>  			goto out;
>  
> -		__oom_kill_process(oc->chosen_task);
> +		__oom_kill_process(oc->chosen_task, oc);
>  	}
>  
>  out:

-- 
Michal Hocko
SUSE Labs
