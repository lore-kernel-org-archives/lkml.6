Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeFEPg2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:36:28 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59214 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeFEPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:36:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        peterz@infradead.org, oleg@redhat.com, viro@zeniv.linux.org.uk,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        riel@redhat.com, tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
        <20180426130700.GP17484@dhcp22.suse.cz> <877enj9uwf.fsf@xmission.com>
        <20180601135725.GE15278@dhcp22.suse.cz> <87a7sey3ud.fsf@xmission.com>
        <20180601150219.GG15278@dhcp22.suse.cz> <87y3fyv88o.fsf@xmission.com>
        <c1be5b75-d17b-2bbf-8bd2-4e6ade54bdae@virtuozzo.com>
Date: Tue, 05 Jun 2018 10:36:14 -0500
In-Reply-To: <c1be5b75-d17b-2bbf-8bd2-4e6ade54bdae@virtuozzo.com> (Kirill
        Tkhai's message of "Tue, 5 Jun 2018 11:48:49 +0300")
Message-ID: <8736y1gs9d.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fQE0V-0007jE-C1;;;mid=<8736y1gs9d.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/KEJ2/svGYSpgzKiOe2w+JIVdHwWkX22w=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kirill Tkhai <ktkhai@virtuozzo.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1268 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 14 (1.1%), b_tie_ro: 7 (0.5%), parse: 3.5 (0.3%),
        extract_message_metadata: 39 (3.1%), get_uri_detail_list: 3.3 (0.3%),
        tests_pri_-1000: 15 (1.2%), tests_pri_-950: 3.8 (0.3%), tests_pri_-900: 2.7
        (0.2%), tests_pri_-400: 41 (3.2%), check_bayes: 38 (3.0%), b_tokenize: 16
        (1.3%), b_tok_get_all: 9 (0.7%), b_comp_prob: 5 (0.4%), b_tok_touch_all: 3.0
        (0.2%), b_finish: 1.01 (0.1%), tests_pri_0: 676 (53.3%),
        check_dkim_signature: 1.13 (0.1%), check_dkim_adsp: 6 (0.4%), tests_pri_500:
        459 (36.2%), poll_dns_idle: 432 (34.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner() more scalable
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Tkhai <ktkhai@virtuozzo.com> writes:

> On 01.06.2018 18:25, Eric W. Biederman wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
>> 
>>> On Fri 01-06-18 09:32:42, Eric W. Biederman wrote:
>>>> Michal Hocko <mhocko@kernel.org> writes:
>>> [...]
>>>>> Group leader exiting early without tearing down the whole thread
>>>>> group should be quite rare as well. No question that somebody might do
>>>>> that on purpose though...
>>>>
>>>> The group leader exiting early is a completely legitimate and reasonable
>>>> thing to do, even if it is rare.
>>>
>>> I am not saying it isn't legitimate. But the most common case is the
>>> main thread waiting for its threads or calling exit which would tear the
>>> whole group down. Is there any easy way to achieve this other than tkill
>>> to group leader? Calling exit(3) from the leader performs group exit
>>> IIRC.
>> 
>> pthread_exit from the group leader.
>> 
>>> I am not arguing this is non-issue. And it certainly is a problem once
>>> somebody wants to be nasty... I was more interested how often this
>>> really happens for sane workloads.
>> 
>> That is a fair question.  All I know for certain is that whatever Kirill
>> Tkhai's workload was it was triggering this the slow path.
>
> It was triggered on a server, where many VPS of many people are hosted.
> Sorry, I have no an idea what they did.

That at least tells us it was naturally occurring.  Which makes this a
real problem in the real world.

Eric
