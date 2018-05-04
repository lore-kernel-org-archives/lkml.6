Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEDOgd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:36:33 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33637 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEDOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:36:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
References: <20180426192818.GX17484@dhcp22.suse.cz>
        <20180427070848.GA17484@dhcp22.suse.cz> <87r2n01q58.fsf@xmission.com>
        <87o9hz2sw3.fsf@xmission.com> <87h8nr2sa3.fsf_-_@xmission.com>
        <20180502084708.GC26305@dhcp22.suse.cz>
        <20180502132026.GB16060@cmpxchg.org> <87lgd1zww0.fsf_-_@xmission.com>
        <20180503133338.GA23401@redhat.com> <87y3h0x0qg.fsf@xmission.com>
        <20180504142056.GA26151@redhat.com>
Date: Fri, 04 May 2018 09:36:11 -0500
In-Reply-To: <20180504142056.GA26151@redhat.com> (Oleg Nesterov's message of
        "Fri, 4 May 2018 16:20:57 +0200")
Message-ID: <87r2mrh4is.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEboq-0003iR-Ex;;;mid=<87r2mrh4is.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/kI8aX3LrjKjOVtuoo9SreGr7sjkGqs88=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1336 ms - load_scoreonly_sql: 0.31 (0.0%),
        signal_user_changed: 4.0 (0.3%), b_tie_ro: 2.8 (0.2%), parse: 1.29 (0.1%),
        extract_message_metadata: 13 (1.0%), get_uri_detail_list: 11 (0.8%),
        tests_pri_-1000: 9 (0.7%), tests_pri_-950: 2.3 (0.2%), tests_pri_-900: 1.93
        (0.1%), tests_pri_-400: 62 (4.6%), check_bayes: 47 (3.5%), b_tokenize: 25
        (1.9%), b_tok_get_all: 11 (0.8%), b_comp_prob: 4.0 (0.3%), b_tok_touch_all:
        2.9 (0.2%), b_finish: 0.87 (0.1%), tests_pri_0: 1147 (85.9%),
        check_dkim_signature: 1.04 (0.1%), check_dkim_adsp: 21 (1.6%), tests_pri_500:
        25 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] memcg: Replace mm->owner with mm->memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/03, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > On 05/02, Eric W. Biederman wrote:
>> >>
>> >> +static void mem_cgroup_fork(struct task_struct *tsk)
>> >> +{
>> >> +	struct cgroup_subsys_state *css;
>> >> +
>> >> +	rcu_read_lock();
>> >> +	css = task_css(tsk, memory_cgrp_id);
>> >> +	if (css && css_tryget(css))
>> >> +		task_update_memcg(tsk, mem_cgroup_from_css(css));
>> >> +	rcu_read_unlock();
>> >> +}
>> >
>> > Why do we need it?
>> >
>> > The child's mm->memcg was already initialized by mm_init_memcg() and we can't
>> > race with migrate until cgroup_threadgroup_change_end() ?
>>
>> I admit I missed the cgroup_threadgroup_change_begin
>> cgroup_threadgroup_change_end pair in fs fork.  In this case it doesn't
>> matter because mm_init_memcg is called from:
>>
>>    copy_mm
>>       dup_mm
>>         mm_init
>>
>> And copy_mm is called before we call cgroup_threadgroup_change_begin.
>> So the race remains.
>
> Ah yes, you are right.
>
>> We could move move cgroup_threadgroup_change_begin earlier, to remove
>> the need for mem_cgroup_fork.  But I have not analyzed that.
>
> No, cgroup_threadgroup_change_begin() was called early and this was wrong, see
> 568ac888215c7fb2fabe8ea739b00ec3c1f5d440. Actually there were more problems, say
> copy_net() could deadlock because cleanup_net() does do_wait() with net_mutex held.
>
>
> OK, what about exec() ? mm_init_memcg() initializes bprm->mm->memcg early in
> bprm_mm_init(). What if the execing task migrates before exec_mmap() ?

We need the the cgroup when the mm is initialized.  That way we have the
cgroup information when initializing the mm.

I don't know if a lock preventing changing the cgroup in exec or just
a little bit of code in exec_mmap to ensure mm->memcg is properly set
is the better approach.  I have not analyzed that code path.

This does look like a very good place for an incremental patch to close
that race.

Eric
