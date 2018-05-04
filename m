Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEDQkj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:40:39 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34153 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDQki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:40:38 -0400
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
References: <87h8nr2sa3.fsf_-_@xmission.com>
        <20180502084708.GC26305@dhcp22.suse.cz>
        <20180502132026.GB16060@cmpxchg.org> <87lgd1zww0.fsf_-_@xmission.com>
        <20180503133338.GA23401@redhat.com> <87y3h0x0qg.fsf@xmission.com>
        <20180504142056.GA26151@redhat.com> <87r2mrh4is.fsf@xmission.com>
        <20180504145435.GA26573@redhat.com> <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com>
Date: Fri, 04 May 2018 11:40:28 -0500
In-Reply-To: <20180504162209.GB26573@redhat.com> (Oleg Nesterov's message of
        "Fri, 4 May 2018 18:22:09 +0200")
Message-ID: <871serfk77.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEdl6-0000FC-CU;;;mid=<871serfk77.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19QU+EHFRwBYf8/27GWTAdbUmHJdYWpr/Y=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 260 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.9%), b_tie_ro: 1.72 (0.7%), parse: 0.77 (0.3%),
        extract_message_metadata: 2.8 (1.1%), get_uri_detail_list: 1.25 (0.5%),
        tests_pri_-1000: 4.0 (1.5%), tests_pri_-950: 1.13 (0.4%), tests_pri_-900:
        0.99 (0.4%), tests_pri_-400: 27 (10.4%), check_bayes: 26 (10.0%), b_tokenize:
        7 (2.8%), b_tok_get_all: 12 (4.4%), b_comp_prob: 1.91 (0.7%),
        b_tok_touch_all: 2.6 (1.0%), b_finish: 0.53 (0.2%), tests_pri_0: 210 (80.8%),
        check_dkim_signature: 0.47 (0.2%), check_dkim_adsp: 3.5 (1.3%),
        tests_pri_500: 3.8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] memcg: Replace mm->owner with mm->memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/04, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > I'd vote for the change in exec_mmap(). This way mm_init_memcg() can just
>> > nullify mm->memcg.
>>
>> There is at least one common path where we need the memory control group
>> properly initialized so memory allocations don't escape the memory
>> control group.
>>
>> do_execveat_common
>>    copy_strings
>>       get_arg_page
>>          get_user_pages_remote
>>             __get_user_pages_locked
>>                __get_user_pages
>>                   faultin_page
>>                      handle_mm_fault
>>                         count_memcg_event_mm
>>                         __handle_mm_fault
>>                           handle_pte_fault
>>                              do_anonymous_page
>>                                 mem_cgroup_try_charge
>>
>> I am surprised I can't easily find more.   Apparently in load_elf_binary
>> we call elf_mmap after set_new_exec and install_exec_creds, making
>> a gracefull recovery from elf_mmap failures impossible.
>>
>> In any case we most definitely need the memory control group properly
>> setup before exec_mmap.
>
> Confused ...
>
> new_mm->memcg has no effect until exec_mmap(), why it can't be NULL ?

new_mm->memcg does have effect before exec_mmap.  

> and why do you think mem_cgroup_try_charge() can use the wrong memcg
> in this case?

It would only use the wrong memcg if you had bprm->mm->memcg == NULL.

mm_init_memcg is at the same point as mm_init_owner.  So my change did
not introduce any logic changes on when the memory control group became
valid.

get_user_pages_remote is passed bprm->mm.  So all of the above happens
on bprm->mm.  Then bprm->mm->memcg is charged and fails if the memory
control group is full.


It would actually be pointless to allocate and initialized bprm->mm as
early as we do if we were not using it before exec_mmap.  Using bprm->mm
implies there will be charges to the bprm->mm->memcg.

If bprm->mm was not used until exec_mmap we could just delay the
allocation until there and avoid these kind of challenges. 

Eric
