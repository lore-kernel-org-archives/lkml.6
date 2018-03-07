Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934137AbeCGRHa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:07:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933533AbeCGRH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:07:26 -0500
Date: Wed, 7 Mar 2018 07:54:44 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: Simplifying our RCU models
Reply-To: paulmck@linux.vnet.ibm.com
References: <CAOS58YPzLeiZnwEeN31wWMZhki0t9+3ozdRNv9DgxWKY7OKmGA@mail.gmail.com>
 <CA+55aFx48U4W5tUgqW9ioZOHibPhQoDCUDWF_d-7yNCbqFQ7zg@mail.gmail.com>
 <20180305001600.GO3918@linux.vnet.ibm.com>
 <CA+55aFyOi1XnSqHtg=VfcUiBL+egNL==NRX1Zaeihe8W5OJVgw@mail.gmail.com>
 <20180305030949.GP3918@linux.vnet.ibm.com>
 <20180305082441.4hao2z4dqn2n5on6@gmail.com>
 <87po4izj67.fsf_-_@xmission.com>
 <20180305161446.GQ3918@linux.vnet.ibm.com>
 <20180306084738.tcs4ggbby77phlbh@gmail.com>
 <20180306203906.GA3918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306203906.GA3918@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030717-0008-0000-0000-000002E0DCD7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008629; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999654; UDB=6.00508493; IPR=6.00779060;
 MB=3.00019896; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-07 17:07:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030717-0009-0000-0000-0000387D2286
Message-Id: <20180307155444.GA10367@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 12:39:06PM -0800, Paul E. McKenney wrote:
> On Tue, Mar 06, 2018 at 09:47:38AM +0100, Ingo Molnar wrote:
> > 
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > > > But if we look at the bigger API picture:
> > > > >
> > > > >                           !PREEMPT_RCU  PREEMPT_RCU=y
> > > > >   rcu_read_lock():        atomic        preemptible
> > > > >   rcu_read_lock_sched():  atomic        atomic
> > > > >   srcu_read_lock():       preemptible   preemptible
> > > > >
> > > > > Then we could maintain full read side API flexibility by making PREEMPT_RCU=y the 
> > > > > only model, merging it with SRCU and using these main read side APIs:
> > > > >
> > > > >   rcu_read_lock_preempt_disable():	atomic
> > > > >   rcu_read_lock():			preemptible
> > > 
> > > One issue with merging SRCU into rcu_read_lock() is the general blocking within 
> > > SRCU readers.  Once merged in, these guys block everyone.  We should focus 
> > > initially on the non-SRCU variants.
> > > 
> > > On the other hand, Linus's suggestion of merging rcu_read_lock_sched()
> > > into rcu_read_lock() just might be feasible.  If that really does pan
> > > out, we end up with the following:
> > > 
> > >				!PREEMPT	PREEMPT=y
> > >	rcu_read_lock():	atomic		preemptible
> > >	srcu_read_lock():	preemptible	preemptible
> > > 
> > > In this model, rcu_read_lock_sched() maps to preempt_disable() and (as
> > > you say above) rcu_read_lock_bh() maps to local_bh_disable().  The way
> > > this works is that in PREEMPT=y kernels, synchronize_rcu() waits not
> > > only for RCU read-side critical sections, but also for regions of code
> > > with preemption disabled.  The main caveat seems to be that there be an
> > > assumed point of preemptibility between each interrupt and each softirq
> > > handler, which should be OK.
> > > 
> > > There will be some adjustments required for lockdep-RCU, but that should
> > > be reasonably straightforward.
> > > 
> > > Seem reasonable?
> > 
> > Yes, that approach sounds very reasonable to me: it is similar to what we do on 
> > the locking side as well, where we have 'atomic' variants (spinlocks/rwlocks) and 
> > 'sleeping' variants (mutexes, rwsems, etc.).
> > 
> > ( This means there will be more automatic coupling between BH and preempt critical
> >   sections and RCU models not captured via explicit RCU-namespace APIs, but that
> >   should be OK I think. )
> 
> Thus far, I have been unable to prove that it cannot work, which is about
> as good as it gets at this stage.  So here is hoping!  ;-)
> 
> I will look at your later corrected message, but will gratefully accept
> your offer of help with the naming transition.

Ah, and any thoughts on how best to get feedback from the various people
who would need to reprogram their fingers?  Or is everyone already on
board with changing these various names?

							Thanx, Paul
