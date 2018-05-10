Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933911AbeEJDJi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 23:09:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59323 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756584AbeEJDJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 23:09:34 -0400
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
References: <20180503133338.GA23401@redhat.com> <87y3h0x0qg.fsf@xmission.com>
        <20180504142056.GA26151@redhat.com> <87r2mrh4is.fsf@xmission.com>
        <20180504145435.GA26573@redhat.com> <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com> <871serfk77.fsf@xmission.com>
        <20180507143358.GA3071@redhat.com> <87vabyvnw0.fsf@xmission.com>
        <20180509144016.GA25742@redhat.com>
Date: Wed, 09 May 2018 22:09:25 -0500
In-Reply-To: <20180509144016.GA25742@redhat.com> (Oleg Nesterov's message of
        "Wed, 9 May 2018 16:40:16 +0200")
Message-ID: <87vabwp5p6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fGbxT-0007JS-0y;;;mid=<87vabwp5p6.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/9y98JOJXTymzqFuqsmdGX3vLJuwRupnM=
X-SA-Exim-Connect-IP: 97.90.247.198
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
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1275 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.8 (0.2%), b_tie_ro: 1.87 (0.1%), parse: 0.86 (0.1%),
        extract_message_metadata: 3.3 (0.3%), get_uri_detail_list: 1.59 (0.1%),
        tests_pri_-1000: 4.2 (0.3%), tests_pri_-950: 1.24 (0.1%), tests_pri_-900:
        1.04 (0.1%), tests_pri_-400: 27 (2.1%), check_bayes: 25 (2.0%), b_tokenize: 8
        (0.6%), b_tok_get_all: 7 (0.6%), b_comp_prob: 2.3 (0.2%), b_tok_touch_all:
        4.5 (0.4%), b_finish: 1.99 (0.2%), tests_pri_0: 1222 (95.8%),
        check_dkim_signature: 0.55 (0.0%), check_dkim_adsp: 2.9 (0.2%),
        tests_pri_500: 4.9 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] memcg: Replace mm->owner with mm->memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/07, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > before your patch get_mem_cgroup_from_mm() looks at mm->owner == current
>> > (in this case) and mem_cgroup_from_task() should return the correct memcg
>> > even if execing task migrates after bprm_mm_init(). At least in the common
>> > case when the old mm is not shared.
>> >
>> > After your patch the memory allocations in copy_strings() won't be accounted
>> > correctly, bprm->mm->memcg is wrong if this task migrates. And iiuc your recent
>> > "[PATCH 2/2] memcg: Close the race between migration and installing bprm->mm as mm"
>> > doesn't fix the problem.
>> >
>> > No?
>>
>> The patch does solve the issue.  There should be nothing a userspace
>> process can observe that should tell it where in the middle of exec
>> such a migration happend so placing the migration at what from the
>> kernel's perspective might be technically later should not be a problem.
>>
>> If it is a problem the issue is that there is a way to observe the
>> difference.
>
> So. The task migrates from some MEMCG right after bprm_mm_init().
>
> copy_strings() triggers OOM in MEMCG. This is quite possible, it can use a lot
> of memory and that is why we have acct_arg_size() to make these allocations
> visible to oom killer.
>
> task_in_mem_cgroup(MEMCG) returns false and oom killer has to kill another
> innocent process in MEMCG.
>
> Does this look like a way to observe the difference?

Sort of.

I don't know how the memcg gets away without migrating charges
when it migrates a process.  With charges not being migrated
I don't think this is observable.

That does look like a real issue however.

>> > Perhaps we can change get_mem_cgroup_from_mm() to use
>> > mem_cgroup_from_css(current, memory_cgrp_id) if mm->memcg == NULL?
>>
>> Please God no.  Having any unnecessary special case is just going to
>> confuse people and cause bugs.
>
> To me the unnecessary special case is the new_mm->memcg which is used for
> accounting but doesn't follow migration till exec_mmap(). But I won't
> argue.

Eric
