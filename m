Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeFAP0G (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:26:06 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47450 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeFAP0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:26:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Michal Hocko <mhocko@kernel.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, oleg@redhat.com, viro@zeniv.linux.org.uk,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        riel@redhat.com, tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
        <20180426130700.GP17484@dhcp22.suse.cz> <877enj9uwf.fsf@xmission.com>
        <20180601135725.GE15278@dhcp22.suse.cz> <87a7sey3ud.fsf@xmission.com>
        <20180601150219.GG15278@dhcp22.suse.cz>
Date: Fri, 01 Jun 2018 10:25:59 -0500
In-Reply-To: <20180601150219.GG15278@dhcp22.suse.cz> (Michal Hocko's message
        of "Fri, 1 Jun 2018 17:02:19 +0200")
Message-ID: <87y3fyv88o.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fOlwJ-0006mZ-FX;;;mid=<87y3fyv88o.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/DCXvdLvE3MjPj0TAxC6VunwjNLAJSRIY=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 503 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.6%), b_tie_ro: 1.99 (0.4%), parse: 1.22 (0.2%),
        extract_message_metadata: 4.4 (0.9%), get_uri_detail_list: 1.77 (0.4%),
        tests_pri_-1000: 7 (1.3%), tests_pri_-950: 2.2 (0.4%), tests_pri_-900: 1.81
        (0.4%), tests_pri_-400: 31 (6.2%), check_bayes: 29 (5.8%), b_tokenize: 11
        (2.1%), b_tok_get_all: 8 (1.5%), b_comp_prob: 4.1 (0.8%), b_tok_touch_all:
        2.8 (0.6%), b_finish: 0.90 (0.2%), tests_pri_0: 423 (84.1%),
        check_dkim_signature: 0.87 (0.2%), check_dkim_adsp: 4.5 (0.9%),
        tests_pri_500: 9 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner() more scalable
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Fri 01-06-18 09:32:42, Eric W. Biederman wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
> [...]
>> > Group leader exiting early without tearing down the whole thread
>> > group should be quite rare as well. No question that somebody might do
>> > that on purpose though...
>> 
>> The group leader exiting early is a completely legitimate and reasonable
>> thing to do, even if it is rare.
>
> I am not saying it isn't legitimate. But the most common case is the
> main thread waiting for its threads or calling exit which would tear the
> whole group down. Is there any easy way to achieve this other than tkill
> to group leader? Calling exit(3) from the leader performs group exit
> IIRC.

pthread_exit from the group leader.

> I am not arguing this is non-issue. And it certainly is a problem once
> somebody wants to be nasty... I was more interested how often this
> really happens for sane workloads.

That is a fair question.  All I know for certain is that whatever Kirill
Tkhai's workload was it was triggering this the slow path.

Eric
