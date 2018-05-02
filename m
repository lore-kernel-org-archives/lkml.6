Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeEBVmk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:42:40 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40800 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbeEBVmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 17:42:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        oleg@redhat.com, viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
        <20180426130700.GP17484@dhcp22.suse.cz> <87efj2q6sq.fsf@xmission.com>
        <20180426192818.GX17484@dhcp22.suse.cz>
        <20180427070848.GA17484@dhcp22.suse.cz> <87r2n01q58.fsf@xmission.com>
        <87o9hz2sw3.fsf@xmission.com> <87h8nr2sa3.fsf_-_@xmission.com>
        <20180502084708.GC26305@dhcp22.suse.cz>
        <20180502132026.GB16060@cmpxchg.org> <87lgd1zww0.fsf_-_@xmission.com>
        <20180502140453.086f862f94496197cfa7d813@linux-foundation.org>
Date: Wed, 02 May 2018 16:35:03 -0500
In-Reply-To: <20180502140453.086f862f94496197cfa7d813@linux-foundation.org>
        (Andrew Morton's message of "Wed, 2 May 2018 14:04:53 -0700")
Message-ID: <877eolzqpk.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDzRy-0005lK-EL;;;mid=<877eolzqpk.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19NvT3fB3JTUROatjQDyFemkTs84tP83mI=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andrew Morton <akpm@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15050 ms - load_scoreonly_sql: 0.15 (0.0%),
        signal_user_changed: 4.7 (0.0%), b_tie_ro: 2.5 (0.0%), parse: 7 (0.0%),
        extract_message_metadata: 25 (0.2%), get_uri_detail_list: 3.6 (0.0%),
        tests_pri_-1000: 8 (0.1%), compile_eval: 36 (0.2%), tests_pri_-950: 2.8
        (0.0%), tests_pri_-900: 1.68 (0.0%), tests_pri_-400: 67 (0.4%), check_bayes:
        65 (0.4%), b_tokenize: 21 (0.1%), b_tok_get_all: 33 (0.2%), b_comp_prob: 5
        (0.0%), b_tok_touch_all: 2.9 (0.0%), b_finish: 0.85 (0.0%), tests_pri_0: 5380
        (35.7%), check_dkim_signature: 0.89 (0.0%), check_dkim_adsp: 4006 (26.6%),
        tests_pri_500: 9547 (63.4%), poll_dns_idle: 9537 (63.4%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] memcg: Replace mm->owner with mm->memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 02 May 2018 14:21:35 -0500 ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> Recently it was reported that mm_update_next_owner could get into
>> cases where it was executing it's fallback for_each_process part of
>> the loop and thus taking up a lot of time.
>> 
>> To deal with this replace mm->owner with mm->memcg.  This just reduces
>> the complexity of everything.  As much as possible I have maintained
>> the current semantics.  There are two siginificant exceptions.  During
>> fork the memcg of the process calling fork is charged rather than
>> init_css_set.  During memory cgroup migration the charges are migrated
>> not if the process is the owner of the mm, but if the process being
>> migrated has the same memory cgroup as the mm.
>> 
>> I believe it was a bug if init_css_set is charged for memory activity
>> during fork, and the old behavior was simply a consequence of the new
>> task not having tsk->cgroup not initialized to it's proper cgroup.
>> 
>> Durhing cgroup migration only thread group leaders are allowed to
>> migrate.  Which means in practice there should only be one.  Linux
>> tasks created with CLONE_VM are the only exception, but the common
>> cases are already ruled out.  Processes created with vfork have a
>> suspended parent and can do nothing but call exec so they should never
>> show up.  Threads of the same cgroup are not the thread group leader
>> so also should not show up.  That leaves the old LinuxThreads library
>> which is probably out of use by now, and someone doing something very
>> creative with cgroups, and rolling their own threads with CLONE_VM.
>> So in practice I don't think the difference charge migration will
>> affect anyone.
>> 
>> To ensure that mm->memcg is updated appropriately I have implemented
>> cgroup "attach" and "fork" methods.  This ensures that at those
>> points the mm pointed to the task has the appropriate memory cgroup.
>> 
>> For simplicity instead of introducing a new mm lock I simply use
>> exchange on the pointer where the mm->memcg is updated to get
>> atomic updates.
>> 
>> Looking at the history effectively this change is a revert.  The
>> reason given for adding mm->owner is so that multiple cgroups can be
>> attached to the same mm.  In the last 8 years a second user of
>> mm->owner has not appeared.  A feature that has never used, makes the
>> code more complicated and has horrible worst case performance should
>> go.
>
> Cleanliness nit: I'm not sure that the removal and open-coding of
> mem_cgroup_from_task() actually improved things.  Should we restore
> it?

While writing the patch itself removing mem_cgroup_from_task forced
thinking about which places should use mm->memcg and which places
should use an alternative.

If we want to add it back afterwards with a second patch I don't mind.

I just don't want to have that in the same patch as opportunities get
lost to look at how the memory cgroup should be derived.

Eric

> --- a/mm/memcontrol.c~memcg-replace-mm-owner-with-mm-memcg-fix
> +++ a/mm/memcontrol.c
> @@ -664,6 +664,11 @@ static void memcg_check_events(struct me
>  	}
>  }
>  
> +static inline struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
> +{
> +	return mem_cgroup_from_css(task_css(p, memory_cgrp_id));
> +}
> +
>  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  {
>  	struct mem_cgroup *memcg = NULL;
> @@ -1011,7 +1016,7 @@ bool task_in_mem_cgroup(struct task_stru
>  		 * killed to prevent needlessly killing additional tasks.
>  		 */
>  		rcu_read_lock();
> -		task_memcg = mem_cgroup_from_css(task_css(task, memory_cgrp_id));
> +		task_memcg = mem_cgroup_from_task(task);
>  		css_get(&task_memcg->css);
>  		rcu_read_unlock();
>  	}
> @@ -4829,7 +4834,7 @@ static int mem_cgroup_can_attach(struct
>  	if (!move_flags)
>  		return 0;
>  
> -	from = mem_cgroup_from_css(task_css(p, memory_cgrp_id));
> +	from = mem_cgroup_from_task(p);
>  
>  	VM_BUG_ON(from == memcg);
>  
> @@ -5887,7 +5892,7 @@ void mem_cgroup_sk_alloc(struct sock *sk
>  	}
>  
>  	rcu_read_lock();
> -	memcg = mem_cgroup_from_css(task_css(current, memory_cgrp_id));
> +	memcg = mem_cgroup_from_task(current);
>  	if (memcg == root_mem_cgroup)
>  		goto out;
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
> _
