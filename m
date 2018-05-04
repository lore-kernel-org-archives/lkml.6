Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeEDUIv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:08:51 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37454 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeEDUIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:08:49 -0400
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
        <87sh77b5w7.fsf@xmission.com>
        <20180504194510.GW26088@linux.vnet.ibm.com>
Date: Fri, 04 May 2018 15:08:40 -0500
In-Reply-To: <20180504194510.GW26088@linux.vnet.ibm.com> (Paul E. McKenney's
        message of "Fri, 4 May 2018 12:45:10 -0700")
Message-ID: <87vac39oaf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fEh0Z-0005Mx-SI;;;mid=<87vac39oaf.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18N2sL9OgtJdvMZi8wmMklmbGFcKSqTymo=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 359 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.2 (0.6%), b_tie_ro: 1.54 (0.4%), parse: 0.86 (0.2%),
        extract_message_metadata: 14 (4.0%), get_uri_detail_list: 3.2 (0.9%),
        tests_pri_-1000: 6 (1.7%), tests_pri_-950: 1.14 (0.3%), tests_pri_-900: 0.97
        (0.3%), tests_pri_-400: 27 (7.5%), check_bayes: 26 (7.2%), b_tokenize: 10
        (2.7%), b_tok_get_all: 9 (2.4%), b_comp_prob: 2.8 (0.8%), b_tok_touch_all:
        3.1 (0.9%), b_finish: 0.57 (0.2%), tests_pri_0: 299 (83.3%),
        check_dkim_signature: 0.53 (0.1%), check_dkim_adsp: 2.8 (0.8%),
        tests_pri_500: 4.0 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kernel/signal: Remove no longer required irqsave/restore
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:

> On Fri, May 04, 2018 at 02:03:04PM -0500, Eric W. Biederman wrote:
>> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
>> 
>> > On Fri, May 04, 2018 at 12:17:20PM -0500, Eric W. Biederman wrote:
>> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> >> 
>> >> > On 2018-05-04 11:59:08 [-0500], Eric W. Biederman wrote:
>> >> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> >> >> > From: Anna-Maria Gleixner <anna-maria@linutronix.de>
>> >> > …
>> >> >> > This long-term fix has been made in commit 4abf91047cf ("rtmutex: Make >
>> >> >> > wait_lock irq safe") for different reason.
>> >> >> 
>> >> >> Which tree has this change been made in?  I am not finding the commit
>> >> >> you mention above in Linus's tree.
>> >> >
>> >> > I'm sorry, it should have been commit b4abf91047cf ("rtmutex: Make
>> >> > wait_lock irq safe").
>> >> 
>> >> Can you fix that in your patch description and can you also up the
>> >> description of rcu_read_unlock?
>> >> 
>> >> If we don't need to jump through hoops it looks very reasonable to
>> >> remove this unnecessary logic.  But we should fix the description
>> >> in rcu_read_unlock that still says we need these hoops.
>> >
>> > The hoops are still required for rcu_read_lock(), otherwise you
>> > get deadlocks between the scheduler and RCU in PREEMPT=y kernels.
>> > What happens with this patch (if I understand it correctly) is that the
>> > signal code now uses a different way of jumping through the hoops.
>> > But the hoops are still jumped through.
>> 
>> The patch changes:
>> 
>> local_irq_disable();
>> rcu_read_lock();
>> spin_lock();
>> rcu_read_unlock();
>> 
>> to:
>> 
>> rcu_read_lock();
>> spin_lock_irq();
>> rcu_read_unlock();
>> 
>> Now that I have a chance to relfect on it the fact that the patern
>> that is being restored does not work is scary.  As the failure has
>> nothing to do with lock ordering and people won't realize what is going
>> on.  Especially since the common rcu modes won't care.
>> 
>> So is it true that taking spin_lock_irq before calling rcu_read_unlock
>> is a problem because of rt_mutex_unlock()?  Or has b4abf91047cf ("rtmutex: Make
>> wait_lock irq safe") actually fixed that and we can correct the
>> documentation of rcu_read_unlock() ?  And fix __lock_task_sighand?
>
> The problem is that the thing taking the lock might be the scheduler,
> or one of the locks taken while the scheduler's pi and rq locks are
> held.  This occurs only with RCU-preempt.
>
> Here is what can happen:
>
> o	A task does rcu_read_lock().
>
> o	That task is preempted.
>
> o	That task stays preempted for a long time, and is therefore
> 	priority boosted.  This boosting involves a high-priority RCU
> 	kthread creating an rt_mutex, pretending that the preempted task
> 	already holds it, and then acquiring it.
>
> o	The task awakens, acquires the scheduler's rq lock, and
> 	then does rcu_read_unlock().
>
> o	Because the task has been priority boosted, __rcu_read_unlock()
> 	invokes the rcu_read_unlock_special() slowpath, which does
> 	(as you say) rt_mutex_unlock() to deboost.  The deboosting
> 	can cause the scheduler to acquire the rq and pi locks, which
> 	results in deadlock.
>
> In contrast, holding these scheduler locks across the entirety of the
> RCU-preempt read-side critical section is harmless because then the
> critical section cannot be preempted, which means that priority boosting
> cannot happen, which means that there will be no need to deboost at
> rcu_read_unlock() time.
>
> This restriction has not changed, and as far as I can see is inherent
> in the fact that RCU uses the scheduler and the scheduler uses RCU.
> There is going to be an odd corner case in there somewhere!

However if I read things correctly b4abf91047cf ("rtmutex: Make
wait_lock irq safe") did change this.

In particular it changed things so that it is only the scheduler locks
that matter, not any old lock that disabled interrupts.  This was done
by disabling disabling interrupts when taking the wait_lock.

The rcu_read_unlock documentation states:

 * In most situations, rcu_read_unlock() is immune from deadlock.
 * However, in kernels built with CONFIG_RCU_BOOST, rcu_read_unlock()
 * is responsible for deboosting, which it does via rt_mutex_unlock().
 * Unfortunately, this function acquires the scheduler's runqueue and
 * priority-inheritance spinlocks.  This means that deadlock could result
 * if the caller of rcu_read_unlock() already holds one of these locks or
 * any lock that is ever acquired while holding them; or any lock which
 * can be taken from interrupt context because rcu_boost()->rt_mutex_lock()
 * does not disable irqs while taking ->wait_lock.

So we can now remove the clause:
 * ; or any lock which
 * can be taken from interrupt context because rcu_boost()->rt_mutex_lock()
 * does not disable irqs while taking ->wait_lock.

Without the any lock that disabled interrupts restriction it is now safe
to not worry about the issues with the scheduler locks and the rt_mutex
Which does make it safe to not worry about these crazy complexities in
lock_task_sighand.

Paul do you agree or is the patch unsafe?

Eric
