Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeEDTDP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:03:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39501 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbeEDTDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:03:13 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
References: <20180504144014.5378-1-bigeasy@linutronix.de>
        <87fu37e4rn.fsf@xmission.com>
        <20180504170459.624e7vkro5fn2bgw@linutronix.de>
        <876043e3xb.fsf@xmission.com>
        <20180504175241.GT26088@linux.vnet.ibm.com>
Date: Fri, 04 May 2018 14:03:04 -0500
In-Reply-To: <20180504175241.GT26088@linux.vnet.ibm.com> (Paul E. McKenney's
        message of "Fri, 4 May 2018 10:52:41 -0700")
Message-ID: <87sh77b5w7.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fEfz6-0006F7-8Z;;;mid=<87sh77b5w7.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19AOhYxMGB1gWpPYm5DiaRurCZMlpxcKQI=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 501 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.0 (0.6%), b_tie_ro: 2.1 (0.4%), parse: 1.33 (0.3%),
        extract_message_metadata: 26 (5.2%), get_uri_detail_list: 3.0 (0.6%),
        tests_pri_-1000: 10 (2.0%), tests_pri_-950: 2.0 (0.4%), tests_pri_-900: 1.60
        (0.3%), tests_pri_-400: 32 (6.4%), check_bayes: 30 (6.1%), b_tokenize: 11
        (2.3%), b_tok_get_all: 7 (1.5%), b_comp_prob: 4.4 (0.9%), b_tok_touch_all:
        4.1 (0.8%), b_finish: 0.74 (0.1%), tests_pri_0: 412 (82.2%),
        check_dkim_signature: 0.86 (0.2%), check_dkim_adsp: 4.8 (1.0%),
        tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kernel/signal: Remove no longer required irqsave/restore
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:

> On Fri, May 04, 2018 at 12:17:20PM -0500, Eric W. Biederman wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> 
>> > On 2018-05-04 11:59:08 [-0500], Eric W. Biederman wrote:
>> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> >> > From: Anna-Maria Gleixner <anna-maria@linutronix.de>
>> > …
>> >> > This long-term fix has been made in commit 4abf91047cf ("rtmutex: Make >
>> >> > wait_lock irq safe") for different reason.
>> >> 
>> >> Which tree has this change been made in?  I am not finding the commit
>> >> you mention above in Linus's tree.
>> >
>> > I'm sorry, it should have been commit b4abf91047cf ("rtmutex: Make
>> > wait_lock irq safe").
>> 
>> Can you fix that in your patch description and can you also up the
>> description of rcu_read_unlock?
>> 
>> If we don't need to jump through hoops it looks very reasonable to
>> remove this unnecessary logic.  But we should fix the description
>> in rcu_read_unlock that still says we need these hoops.
>
> The hoops are still required for rcu_read_lock(), otherwise you
> get deadlocks between the scheduler and RCU in PREEMPT=y kernels.
> What happens with this patch (if I understand it correctly) is that the
> signal code now uses a different way of jumping through the hoops.
> But the hoops are still jumped through.

The patch changes:

local_irq_disable();
rcu_read_lock();
spin_lock();
rcu_read_unlock();

to:

rcu_read_lock();
spin_lock_irq();
rcu_read_unlock();

Now that I have a chance to relfect on it the fact that the patern
that is being restored does not work is scary.  As the failure has
nothing to do with lock ordering and people won't realize what is going
on.  Especially since the common rcu modes won't care.

So is it true that taking spin_lock_irq before calling rcu_read_unlock
is a problem because of rt_mutex_unlock()?  Or has b4abf91047cf ("rtmutex: Make
wait_lock irq safe") actually fixed that and we can correct the
documentation of rcu_read_unlock() ?  And fix __lock_task_sighand?

Eric
