Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757642AbeD0SFs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 14:05:48 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:39418 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeD0SFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 14:05:46 -0400
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
        <20180426130700.GP17484@dhcp22.suse.cz> <87efj2q6sq.fsf@xmission.com>
        <20180426192818.GX17484@dhcp22.suse.cz>
        <20180427070848.GA17484@dhcp22.suse.cz>
Date: Fri, 27 Apr 2018 13:05:23 -0500
In-Reply-To: <20180427070848.GA17484@dhcp22.suse.cz> (Michal Hocko's message
        of "Fri, 27 Apr 2018 09:08:48 +0200")
Message-ID: <87r2n01q58.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fC7kO-0004eF-ON;;;mid=<87r2n01q58.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/56PfpoB8imCLJCyB0PQ27A9hPjg7CT5E=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15029 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 6 (0.0%), b_tie_ro: 6 (0.0%), parse: 0.83 (0.0%),
        extract_message_metadata: 11 (0.1%), get_uri_detail_list: 2.2 (0.0%),
        tests_pri_-1000: 3.2 (0.0%), tests_pri_-950: 1.22 (0.0%), tests_pri_-900:
        1.06 (0.0%), tests_pri_-400: 28 (0.2%), check_bayes: 27 (0.2%), b_tokenize: 8
        (0.1%), b_tok_get_all: 9 (0.1%), b_comp_prob: 2.7 (0.0%), b_tok_touch_all:
        4.2 (0.0%), b_finish: 0.65 (0.0%), tests_pri_0: 249 (1.7%),
        check_dkim_signature: 0.79 (0.0%), check_dkim_adsp: 5 (0.0%), tests_pri_500:
        14724 (98.0%), poll_dns_idle: 14714 (97.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner() more scalable
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Thu 26-04-18 21:28:18, Michal Hocko wrote:
>> On Thu 26-04-18 11:19:33, Eric W. Biederman wrote:
>> > Michal Hocko <mhocko@kernel.org> writes:
>> > 
>> > > I've had a patch to remove owner few years back. It needed some work
>> > > to finish but maybe that would be a better than try to make
>> > > non-scalable thing suck less.
>> > 
>> > I have a question.  Would it be reasonable to just have a mm->memcg?
>> > That would appear to be the simplest solution to the problem.
>> 
>> I do not remember details. Have to re-read the whole thing again. Hope
>> to get to this soon but with the current jet lag and backlog from the
>> LSFMM I rather not promis anything. Going with mm->memcg would be the
>> most simple of course but I have a very vague recollection that it was
>> not possible. Maybe I misremember...
>
> Just for the record, the last version where I've tried to remove owner
> was posted here: http://lkml.kernel.org/r/1436358472-29137-1-git-send-email-mhocko@kernel.org
>
> I didn't get to remember details yet, but the primary problem was the
> task migration between cgroups and the nasty case when different thread
> grounds share the mm. At some point I just suggested to not care
> about semantic of these weird threads all that much. We can either
> migrate all tasks sharing the mm struct or just keep the inconsistency.
>
> Anyway, removing this ugliness would be so cool!

I suspect the only common user of CLONE_VM today is vfork.  And I do
think it is crazy to migrate a process that has called vfork before
calling exec.  Other useses of CLONE_VM seem even crazier.

I think the easiest change to make in mem_cgroup_can_attach would
be just to change the test for when charges are migrated.  AKA

from:

	if (mm->owner == p) {
        	....
        }

to
	if (mem_cgroup_from_task(p) == mm->memcg) {
        	...
        }

That allows using mm->memcg with no new limitations on when migration
can be called.  In crazy cases that has the potential to change which
memcgroup the charges are accounted to, but the choice is already
somewhat arbitrary so I don't think that will be a problem.  Especially
given that mm_update_next_owner does not migrate charges if the next
owner is in a different memory cgroup.  A mm with tasks using it in
two different cgroups is already questionable if not outright
problematic.


Kirill Tkhai do you think you would be able adapt Michal Hoko's old
patch at https://marc.info/?l=linux-kernel&m=143635857131756&w=2
that replaces mm->owner with mm->memcg?

We probably want to outlaw migrating an mm where we are not migrating
all of the mm->users eventually.  Just because that case is crazy.
But it doesn't look like we need to do that to fix the memory control
group data structures.

Eric
