Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeCEOeI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:34:08 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36157 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbeCEOeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:34:01 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        <linux-kernel@vger.kernel.org>
References: <CAG48ez17vOL0oEWqoqdHCjqfGVX+aPhHBrtgCfn35z6jZ=8-Xg@mail.gmail.com>
        <CA+55aFzQPQw2UqQ2EEGN1Xe7=qDs-2VTvHVi7SSqGNwqNRg0cQ@mail.gmail.com>
        <CAOS58YPzLeiZnwEeN31wWMZhki0t9+3ozdRNv9DgxWKY7OKmGA@mail.gmail.com>
        <CA+55aFx48U4W5tUgqW9ioZOHibPhQoDCUDWF_d-7yNCbqFQ7zg@mail.gmail.com>
        <20180305001600.GO3918@linux.vnet.ibm.com>
        <CA+55aFyOi1XnSqHtg=VfcUiBL+egNL==NRX1Zaeihe8W5OJVgw@mail.gmail.com>
        <20180305030949.GP3918@linux.vnet.ibm.com>
        <20180305082441.4hao2z4dqn2n5on6@gmail.com>
Date: Mon, 05 Mar 2018 08:33:20 -0600
In-Reply-To: <20180305082441.4hao2z4dqn2n5on6@gmail.com> (Ingo Molnar's
        message of "Mon, 5 Mar 2018 09:24:42 +0100")
Message-ID: <87po4izj67.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1esrBe-0007BN-SU;;;mid=<87po4izj67.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/9xh0Qgis50nDuf+D64g+ROOP0WwgOtzM=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ingo Molnar <mingo@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 480 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.0 (0.6%), b_tie_ro: 1.94 (0.4%), parse: 1.67 (0.3%),
        extract_message_metadata: 9 (1.8%), get_uri_detail_list: 6 (1.2%),
        tests_pri_-1000: 6 (1.2%), tests_pri_-950: 1.84 (0.4%), tests_pri_-900: 1.46
        (0.3%), tests_pri_-400: 41 (8.5%), check_bayes: 39 (8.2%), b_tokenize: 16
        (3.4%), b_tok_get_all: 12 (2.5%), b_comp_prob: 4.7 (1.0%), b_tok_touch_all:
        3.8 (0.8%), b_finish: 0.73 (0.2%), tests_pri_0: 401 (83.4%),
        check_dkim_signature: 0.68 (0.1%), check_dkim_adsp: 2.9 (0.6%),
        tests_pri_500: 3.6 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Simplifying our RCU models
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Moving this discussion to a public list as discussing how to reduce the
number of rcu variants does not make sense in private.  We should have
an archive of such discussions.

Ingo Molnar <mingo@kernel.org> writes:

> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
>
>> > So if people really want that low-cost RCU, and some people really
>> > need the sleepable version, the only one that can _possibly_ be dumped
>> > is the preempt one.
>> > 
>> > But I may - again - be confused and/or missing something.
>> 
>> I am going to do something very stupid and say that I was instead thinking in 
>> terms of getting rid of RCU-bh, thus reminding you of its existence.  ;-)
>> 
>> The reason for believing that it is possible to get rid of RCU-bh is the work 
>> that has gone into improving the forward progress of RCU grace periods under 
>> heavy load and in corner-case workloads.
>>
>
> [...]
>
>> The other reason for RCU-sched is it has the side effect of waiting
>> for all in-flight hardware interrupt handlers, NMI handlers, and
>> preempt-disable regions of code to complete, and last I checked, this side
>> effect is relied on.  In contrast, RCU-preeempt is only guaranteed to wait
>> on regions of code protected by rcu_read_lock() and rcu_read_unlock().
>
> Instead of only trying to fix the documentation (which is never a bad idea but it 
> is fighting the symptom in this case), I think the first step should be to 
> simplify the RCU read side APIs of RCU from 4 APIs:
>
> 	rcu_read_lock()
> 	srcu_read_lock()
> 	rcu_read_lock_sched()
> 	rcu_read_lock_bh()
>
> ... which have ~8 further sub-model variations depending on CONFIG_PREEMPT, 
> CONFIG_PREEMPT_RCU - which is really a crazy design!
>
> I think we could reduce this to just two APIs with no Kconfig dependencies:
>
> 	rcu_read_lock()
> 	rcu_read_lock_preempt_disable()
>
> Which would be much, much simpler.
>
> This is how we could do it I think:
>
> 1)
>
> Getting rid of the _bh() variant should be reasonably simple and involve a 
> treewide replacement of:
>
> 	rcu_read_lock_bh()   -> local_bh_disable()
> 	rcu_read_unlock_bh() -> local_bh_enable()
>
> Correct?
>
> 2)
>
> Further reducing the variants is harder, due to this main asymmetry:
>
>                           !PREEMPT_RCU  PREEMPT_RCU=y
>   rcu_read_lock_sched():  atomic        atomic
>   rcu_read_lock():        atomic        preemptible
>
> ('atomic' here is meant in the scheduler, non-preemptible sense.)
>
> But if we look at the bigger API picture:
>
>                           !PREEMPT_RCU  PREEMPT_RCU=y
>   rcu_read_lock():        atomic        preemptiblep
>   rcu_read_lock_sched():  atomic        atomic
>   srcu_read_lock():       preemptible   preemptible
>
> Then we could maintain full read side API flexibility by making PREEMPT_RCU=y the 
> only model, merging it with SRCU and using these main read side APIs:
>
>   rcu_read_lock_preempt_disable(():	atomic
>   rcu_read_lock()			preemptible
>
> It's a _really_ simple and straightforward RCU model, with very obvious semantics 
> all around:
>
> - Note how the 'atomic' (non-preempt) variant uses the well-known 
>   preempt_disable() name as a postfix to signal its main property. (It's also a 
>   bit of a mouthful, which should discourage over-use.)
>
> - The read side APIs are really as straightforward as possible: there's no SRCU 
>   distinction on the read side, no _bh() distinction and no _sched() distinction. 
>   (On -rt all of these would turn into preemptible sections,
>   obviously.)

And it looses the one advantage of srcu_read_lock.  That you don't have
to wait for the entire world.  If you actually allow sleeping that is an
important distinction to have.  Or are you proposing that we add the
equivalent of init_srcu_struct to all of the rcu users?

That rcu_read_lock would need to take an argument about which rcu region
we are talking about.

> rcu_read_lock_preempt_disable() would essentially be all the current 
> rcu_read_lock_sched() users (where the _sched() postfix was a confusing misnomer 
> anyway).
>
> Wrt. merging SRCU and RCU: this can be done by making PREEMPT_RCU=y the one and 
> only main RCU model and converting all SRCU users to main RCU. This is relatively 
> straightforward to perform, as there are only ~170 SRCU critical sections, versus 
> the 3000+ main RCU critical sections ...

It really sounds like you are talking about adding a requirement that
everyone update their rcu_read_lock() calls with information about which
region you are talking about.  That seems like quite a bit of work.

Doing something implicit when PREEMPT_RCU=y and converting
"rcu_read_lock()" to "srcu_read_lock(&kernel_srcu_region)" only in that
case I can see.

Except in very specific circustances I don't think I ever want to run a
kernel with PREEMPT_RCU the default.  All of that real time stuff trades
off predictability with performance.  Having lost enough performance to
spectre and meltdown I don't think it makes sense for us all to start
runing predictable^H^H^H^H^H^H^H^H^H^H^H time kernels now.

> AFAICS this should be a possible read side design that keeps correctness, without 
> considering grace period length patterns, i.e. without considering GC latency and 
> scalability aspects.
>
> Before we get into ways to solve the latency and scalability aspects of such a 
> simplified RCU model, do you agree with this analysis so far, or have I missed 
> something important wrt. correctness?

RCU region specification.  If we routinely allow preemption of rcu
critical sections for any length of time I can't imagine we will want to
wait for every possible preempted rcu critical section.

Of course I could see the merge working the other way.  Adding the
debugging we need to find rcu critical secions that are held to long and
shrinking them so we don't need PREEMPT_RCU at all.

Eric
