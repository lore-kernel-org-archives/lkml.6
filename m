Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756975AbeDZQWE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:22:04 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50965 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756689AbeDZQVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:21:05 -0400
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
Date: Thu, 26 Apr 2018 11:19:33 -0500
In-Reply-To: <20180426130700.GP17484@dhcp22.suse.cz> (Michal Hocko's message
        of "Thu, 26 Apr 2018 15:07:00 +0200")
Message-ID: <87efj2q6sq.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fBjdk-00046F-T4;;;mid=<87efj2q6sq.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18GJcmTpH5m6JDbFw/QRGEx3BqHLlxcJIg=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 165 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.4 (2.6%), b_tie_ro: 3.4 (2.1%), parse: 0.96 (0.6%),
        extract_message_metadata: 2.5 (1.5%), get_uri_detail_list: 0.76 (0.5%),
        tests_pri_-1000: 3.5 (2.1%), tests_pri_-950: 1.16 (0.7%), tests_pri_-900:
        1.04 (0.6%), tests_pri_-400: 17 (10.5%), check_bayes: 16 (9.9%), b_tokenize:
        4.2 (2.5%), b_tok_get_all: 6 (3.5%), b_comp_prob: 1.22 (0.7%),
        b_tok_touch_all: 3.0 (1.8%), b_finish: 0.74 (0.4%), tests_pri_0: 123 (74.1%),
        check_dkim_signature: 0.36 (0.2%), check_dkim_adsp: 2.6 (1.6%),
        tests_pri_500: 3.7 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner() more scalable
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> I've had a patch to remove owner few years back. It needed some work
> to finish but maybe that would be a better than try to make
> non-scalable thing suck less.

I have a question.  Would it be reasonable to just have a mm->memcg?
That would appear to be the simplest solution to the problem.

That would require failing migration between memory cgroups if you are
not moving all of processes/threads that have a given mm_struct.  That
should not be a huge restriction as typically it is only threads that
share a mm.  Further the check should be straigh forward: counting the
number of threads and verifying the count matches the count on the
mm_struct.

Eric
