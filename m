Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeEDPuB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:50:01 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50837 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbeEDPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:50:00 -0400
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
References: <87r2n01q58.fsf@xmission.com> <87o9hz2sw3.fsf@xmission.com>
        <87h8nr2sa3.fsf_-_@xmission.com>
        <20180502084708.GC26305@dhcp22.suse.cz>
        <20180502132026.GB16060@cmpxchg.org> <87lgd1zww0.fsf_-_@xmission.com>
        <20180503133338.GA23401@redhat.com> <87y3h0x0qg.fsf@xmission.com>
        <20180504142056.GA26151@redhat.com> <87r2mrh4is.fsf@xmission.com>
        <20180504145435.GA26573@redhat.com>
Date: Fri, 04 May 2018 10:49:42 -0500
In-Reply-To: <20180504145435.GA26573@redhat.com> (Oleg Nesterov's message of
        "Fri, 4 May 2018 16:54:35 +0200")
Message-ID: <87y3gzfmjt.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEcxy-0003mT-Ll;;;mid=<87y3gzfmjt.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19lWGyTpACqGv4JGaF66BWOver70sR3m0Y=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 234 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.6 (1.5%), b_tie_ro: 2.7 (1.2%), parse: 0.82 (0.4%),
        extract_message_metadata: 2.6 (1.1%), get_uri_detail_list: 0.99 (0.4%),
        tests_pri_-1000: 4.1 (1.8%), tests_pri_-950: 1.17 (0.5%), tests_pri_-900:
        0.98 (0.4%), tests_pri_-400: 21 (8.9%), check_bayes: 20 (8.5%), b_tokenize: 7
        (2.9%), b_tok_get_all: 7 (2.8%), b_comp_prob: 1.88 (0.8%), b_tok_touch_all:
        2.8 (1.2%), b_finish: 0.52 (0.2%), tests_pri_0: 189 (80.7%),
        check_dkim_signature: 0.49 (0.2%), check_dkim_adsp: 3.2 (1.4%),
        tests_pri_500: 4.0 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] memcg: Replace mm->owner with mm->memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/04, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > OK, what about exec() ? mm_init_memcg() initializes bprm->mm->memcg early in
>> > bprm_mm_init(). What if the execing task migrates before exec_mmap() ?
>>
>> We need the the cgroup when the mm is initialized.  That way we have the
>> cgroup information when initializing the mm.
>
> Yes, we need to initialize new_mm->memcg but iiuc mostly for the error path,
>
>> I don't know if a lock preventing changing the cgroup in exec or just
>> a little bit of code in exec_mmap to ensure mm->memcg is properly set
>> is the better approach.
>
> I'd vote for the change in exec_mmap(). This way mm_init_memcg() can just
> nullify mm->memcg.

There is at least one common path where we need the memory control group
properly initialized so memory allocations don't escape the memory
control group.

do_execveat_common
   copy_strings
      get_arg_page
         get_user_pages_remote
            __get_user_pages_locked
               __get_user_pages
                  faultin_page
                     handle_mm_fault
                        count_memcg_event_mm
                        __handle_mm_fault
                          handle_pte_fault
                             do_anonymous_page
                                mem_cgroup_try_charge
                      
I am surprised I can't easily find more.   Apparently in load_elf_binary
we call elf_mmap after set_new_exec and install_exec_creds, making
a gracefull recovery from elf_mmap failures impossible.

In any case we most definitely need the memory control group properly
setup before exec_mmap.

Eric
