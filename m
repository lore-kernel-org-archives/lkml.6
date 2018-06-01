Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeFABH7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:07:59 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37340 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeFABHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:07:54 -0400
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
        <20180426130700.GP17484@dhcp22.suse.cz>
Date: Thu, 31 May 2018 20:07:28 -0500
In-Reply-To: <20180426130700.GP17484@dhcp22.suse.cz> (Michal Hocko's message
        of "Thu, 26 Apr 2018 15:07:00 +0200")
Message-ID: <877enj9uwf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fOYXW-0003eo-UJ;;;mid=<877enj9uwf.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+j1zZ1Uv3mYOBfdKuywxLKMqRWQwqN+cU=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15017 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.0%), b_tie_ro: 1.75 (0.0%), parse: 0.71 (0.0%),
        extract_message_metadata: 2.4 (0.0%), get_uri_detail_list: 0.94 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.15 (0.0%), tests_pri_-900:
        0.97 (0.0%), tests_pri_-400: 22 (0.1%), check_bayes: 21 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 8 (0.1%), b_comp_prob: 1.94 (0.0%), b_tok_touch_all:
        3.6 (0.0%), b_finish: 0.49 (0.0%), tests_pri_0: 172 (1.1%),
        check_dkim_signature: 0.46 (0.0%), check_dkim_adsp: 3.0 (0.0%),
        tests_pri_500: 14806 (98.6%), poll_dns_idle: 14799 (98.5%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner() more scalable
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Thu 26-04-18 14:00:19, Kirill Tkhai wrote:
>> This function searches for a new mm owner in children and siblings,
>> and then iterates over all processes in the system in unlikely case.
>> Despite the case is unlikely, its probability growths with the number
>> of processes in the system. The time, spent on iterations, also growths.
>> I regulary observe mm_update_next_owner() in crash dumps (not related
>> to this function) of the nodes with many processes (20K+), so it looks
>> like it's not so unlikely case.
>
> Did you manage to find the pattern that forces mm_update_next_owner to
> slow paths? This really shouldn't trigger very often. If we can fallback
> easily then I suspect that we should be better off reconsidering
> mm->owner and try to come up with something more clever. I've had a
> patch to remove owner few years back. It needed some work to finish but
> maybe that would be a better than try to make non-scalable thing suck
> less.

Reading through the code I just found a trivial pattern that triggers
this.  Create a multi-threaded process.  Have the thread group leader
(the first thread) exit.

This has the potential to be a significant DOS attack if anyone cares.

Eric
