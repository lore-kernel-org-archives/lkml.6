Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeECOjP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:39:15 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54765 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeECOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:39:14 -0400
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
References: <20180426130700.GP17484@dhcp22.suse.cz>
        <87efj2q6sq.fsf@xmission.com> <20180426192818.GX17484@dhcp22.suse.cz>
        <20180427070848.GA17484@dhcp22.suse.cz> <87r2n01q58.fsf@xmission.com>
        <87o9hz2sw3.fsf@xmission.com> <87h8nr2sa3.fsf_-_@xmission.com>
        <20180502084708.GC26305@dhcp22.suse.cz>
        <20180502132026.GB16060@cmpxchg.org> <87lgd1zww0.fsf_-_@xmission.com>
        <20180503133338.GA23401@redhat.com>
Date: Thu, 03 May 2018 09:39:03 -0500
In-Reply-To: <20180503133338.GA23401@redhat.com> (Oleg Nesterov's message of
        "Thu, 3 May 2018 15:33:39 +0200")
Message-ID: <87y3h0x0qg.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEFO2-0002Vz-PS;;;mid=<87y3h0x0qg.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19cLS7CrME7Ifkj3V6NEEyzbLSCtXYY4SU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 312 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 5 (1.7%), b_tie_ro: 3.2 (1.0%), parse: 1.27 (0.4%),
        extract_message_metadata: 3.4 (1.1%), get_uri_detail_list: 1.17 (0.4%),
        tests_pri_-1000: 7 (2.2%), tests_pri_-950: 1.86 (0.6%), tests_pri_-900: 1.61
        (0.5%), tests_pri_-400: 40 (12.7%), check_bayes: 38 (12.2%), b_tokenize: 11
        (3.5%), b_tok_get_all: 11 (3.5%), b_comp_prob: 2.7 (0.9%), b_tok_touch_all: 7
        (2.2%), b_finish: 3.8 (1.2%), tests_pri_0: 235 (75.5%), check_dkim_signature:
        0.94 (0.3%), check_dkim_adsp: 2.9 (0.9%), tests_pri_500: 5 (1.7%),
        rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] memcg: Replace mm->owner with mm->memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/02, Eric W. Biederman wrote:
>>
>> +static void mem_cgroup_fork(struct task_struct *tsk)
>> +{
>> +	struct cgroup_subsys_state *css;
>> +
>> +	rcu_read_lock();
>> +	css = task_css(tsk, memory_cgrp_id);
>> +	if (css && css_tryget(css))
>> +		task_update_memcg(tsk, mem_cgroup_from_css(css));
>> +	rcu_read_unlock();
>> +}
>
> Why do we need it?
>
> The child's mm->memcg was already initialized by mm_init_memcg() and we can't
> race with migrate until cgroup_threadgroup_change_end() ?

I admit I missed the cgroup_threadgroup_change_begin
cgroup_threadgroup_change_end pair in fs fork.  In this case it doesn't
matter because mm_init_memcg is called from:

   copy_mm
      dup_mm
        mm_init

And copy_mm is called before we call cgroup_threadgroup_change_begin.
So the race remains.

We could move move cgroup_threadgroup_change_begin earlier, to remove
the need for mem_cgroup_fork.  But I have not analyzed that.

Eric
