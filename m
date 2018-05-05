Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751118AbeEEFXo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 01:23:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750744AbeEEFXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 01:23:42 -0400
Date: Fri, 4 May 2018 22:25:00 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH] kernel/signal: Remove no longer required irqsave/restore
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180504144014.5378-1-bigeasy@linutronix.de>
 <87fu37e4rn.fsf@xmission.com>
 <20180504170459.624e7vkro5fn2bgw@linutronix.de>
 <876043e3xb.fsf@xmission.com>
 <20180504175241.GT26088@linux.vnet.ibm.com>
 <87sh77b5w7.fsf@xmission.com>
 <20180504194510.GW26088@linux.vnet.ibm.com>
 <87vac39oaf.fsf@xmission.com>
 <20180504203713.GY26088@linux.vnet.ibm.com>
 <87k1siaf8y.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1siaf8y.fsf@xmission.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050505-0040-0000-0000-00000426F387
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008972; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027702; UDB=6.00524987; IPR=6.00806836;
 MB=3.00020941; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-05 05:23:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050505-0041-0000-0000-0000082CFDA6
Message-Id: <20180505052500.GN26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805050046
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 11:38:37PM -0500, Eric W. Biederman wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> 
> > On Fri, May 04, 2018 at 03:08:40PM -0500, Eric W. Biederman wrote:
> >> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> >> 
> >> > On Fri, May 04, 2018 at 02:03:04PM -0500, Eric W. Biederman wrote:
> >> >> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> >> >> 
> >> >> > On Fri, May 04, 2018 at 12:17:20PM -0500, Eric W. Biederman wrote:
> >> >> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> >> >> >> 
> >> >> >> > On 2018-05-04 11:59:08 [-0500], Eric W. Biederman wrote:
> >> >> >> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> >> >> >> >> > From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> >> >> >> > …
> >> >> >> >> > This long-term fix has been made in commit 4abf91047cf ("rtmutex: Make >
> >> >> >> >> > wait_lock irq safe") for different reason.
> >> >> >> >> 
> >> >> >> >> Which tree has this change been made in?  I am not finding the commit
> >> >> >> >> you mention above in Linus's tree.
> >> >> >> >
> >> >> >> > I'm sorry, it should have been commit b4abf91047cf ("rtmutex: Make
> >> >> >> > wait_lock irq safe").
> >> >> >> 
> >> >> >> Can you fix that in your patch description and can you also up the
> >> >> >> description of rcu_read_unlock?
> >> >> >> 
> >> >> >> If we don't need to jump through hoops it looks very reasonable to
> >> >> >> remove this unnecessary logic.  But we should fix the description
> >> >> >> in rcu_read_unlock that still says we need these hoops.
> >> >> >
> >> >> > The hoops are still required for rcu_read_lock(), otherwise you
> >> >> > get deadlocks between the scheduler and RCU in PREEMPT=y kernels.
> >> >> > What happens with this patch (if I understand it correctly) is that the
> >> >> > signal code now uses a different way of jumping through the hoops.
> >> >> > But the hoops are still jumped through.
> >> >> 
> >> >> The patch changes:
> >> >> 
> >> >> local_irq_disable();
> >> >> rcu_read_lock();
> >> >> spin_lock();
> >> >> rcu_read_unlock();
> >> >> 
> >> >> to:
> >> >> 
> >> >> rcu_read_lock();
> >> >> spin_lock_irq();
> >> >> rcu_read_unlock();
> >> >> 
> >> >> Now that I have a chance to relfect on it the fact that the patern
> >> >> that is being restored does not work is scary.  As the failure has
> >> >> nothing to do with lock ordering and people won't realize what is going
> >> >> on.  Especially since the common rcu modes won't care.
> >> >> 
> >> >> So is it true that taking spin_lock_irq before calling rcu_read_unlock
> >> >> is a problem because of rt_mutex_unlock()?  Or has b4abf91047cf ("rtmutex: Make
> >> >> wait_lock irq safe") actually fixed that and we can correct the
> >> >> documentation of rcu_read_unlock() ?  And fix __lock_task_sighand?
> >> >
> >> > The problem is that the thing taking the lock might be the scheduler,
> >> > or one of the locks taken while the scheduler's pi and rq locks are
> >> > held.  This occurs only with RCU-preempt.
> >> >
> >> > Here is what can happen:
> >> >
> >> > o	A task does rcu_read_lock().
> >> >
> >> > o	That task is preempted.
> >> >
> >> > o	That task stays preempted for a long time, and is therefore
> >> > 	priority boosted.  This boosting involves a high-priority RCU
> >> > 	kthread creating an rt_mutex, pretending that the preempted task
> >> > 	already holds it, and then acquiring it.
> >> >
> >> > o	The task awakens, acquires the scheduler's rq lock, and
> >> > 	then does rcu_read_unlock().
> >> >
> >> > o	Because the task has been priority boosted, __rcu_read_unlock()
> >> > 	invokes the rcu_read_unlock_special() slowpath, which does
> >> > 	(as you say) rt_mutex_unlock() to deboost.  The deboosting
> >> > 	can cause the scheduler to acquire the rq and pi locks, which
> >> > 	results in deadlock.
> >> >
> >> > In contrast, holding these scheduler locks across the entirety of the
> >> > RCU-preempt read-side critical section is harmless because then the
> >> > critical section cannot be preempted, which means that priority boosting
> >> > cannot happen, which means that there will be no need to deboost at
> >> > rcu_read_unlock() time.
> >> >
> >> > This restriction has not changed, and as far as I can see is inherent
> >> > in the fact that RCU uses the scheduler and the scheduler uses RCU.
> >> > There is going to be an odd corner case in there somewhere!
> >> 
> >> However if I read things correctly b4abf91047cf ("rtmutex: Make
> >> wait_lock irq safe") did change this.
> >> 
> >> In particular it changed things so that it is only the scheduler locks
> >> that matter, not any old lock that disabled interrupts.  This was done
> >> by disabling disabling interrupts when taking the wait_lock.
> >> 
> >> The rcu_read_unlock documentation states:
> >> 
> >>  * In most situations, rcu_read_unlock() is immune from deadlock.
> >>  * However, in kernels built with CONFIG_RCU_BOOST, rcu_read_unlock()
> >>  * is responsible for deboosting, which it does via rt_mutex_unlock().
> >>  * Unfortunately, this function acquires the scheduler's runqueue and
> >>  * priority-inheritance spinlocks.  This means that deadlock could result
> >>  * if the caller of rcu_read_unlock() already holds one of these locks or
> >>  * any lock that is ever acquired while holding them; or any lock which
> >>  * can be taken from interrupt context because rcu_boost()->rt_mutex_lock()
> >>  * does not disable irqs while taking ->wait_lock.
> >> 
> >> So we can now remove the clause:
> >>  * ; or any lock which
> >>  * can be taken from interrupt context because rcu_boost()->rt_mutex_lock()
> >>  * does not disable irqs while taking ->wait_lock.
> >> 
> >> Without the any lock that disabled interrupts restriction it is now safe
> >> to not worry about the issues with the scheduler locks and the rt_mutex
> >> Which does make it safe to not worry about these crazy complexities in
> >> lock_task_sighand.
> >> 
> >> Paul do you agree or is the patch unsafe?
> >
> > Ah, I thought you were trying to get rid of all but the first line of
> > that paragraph, not just the final clause.  Apologies for my confusion!
> >
> > It looks plausible, but the patch should be stress-tested on a preemptible
> > kernel with priority boosting enabled.  Has that been done?
> >
> > (Me, I would run rcutorture scenario TREE03 for an extended time period
> > on b4abf91047cf with your patch applied.

And with lockdep enabled, which TREE03 does not do by default.

> >                                           But what testing have you
> > done already?)
> 
> Not my patch.  I was just the reviewer asking for some obvious cleanups.
> So people won't get confused.  Sebastian?  Can you tell Paul what
> testing you have done?

Ah, apologies for my confusion!

							Thanx, Paul
