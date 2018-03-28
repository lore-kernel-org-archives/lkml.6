Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeC1N5I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:57:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751903AbeC1N5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:57:06 -0400
Date: Wed, 28 Mar 2018 06:56:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [PATCH 2/2] smp: introduce kick_active_cpus_sync()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-3-ynorov@caviumnetworks.com>
 <20180325192328.GI3675@linux.vnet.ibm.com>
 <20180325201154.icdcyl4nw2jootqq@yury-thinkpad>
 <20180326124555.GJ3675@linux.vnet.ibm.com>
 <20180328133605.u7pftfxpn3jbqire@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328133605.u7pftfxpn3jbqire@yury-thinkpad>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18032813-0024-0000-0000-0000033D1685
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008758; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009647; UDB=6.00514349; IPR=6.00788929;
 MB=3.00020289; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-28 13:55:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032813-0025-0000-0000-00004778C167
Message-Id: <20180328135617.GQ3675@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803280149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 04:36:05PM +0300, Yury Norov wrote:
> On Mon, Mar 26, 2018 at 05:45:55AM -0700, Paul E. McKenney wrote:
> > On Sun, Mar 25, 2018 at 11:11:54PM +0300, Yury Norov wrote:
> > > On Sun, Mar 25, 2018 at 12:23:28PM -0700, Paul E. McKenney wrote:
> > > > On Sun, Mar 25, 2018 at 08:50:04PM +0300, Yury Norov wrote:
> > > > > kick_all_cpus_sync() forces all CPUs to sync caches by sending broadcast IPI.
> > > > > If CPU is in extended quiescent state (idle task or nohz_full userspace), this
> > > > > work may be done at the exit of this state. Delaying synchronization helps to
> > > > > save power if CPU is in idle state and decrease latency for real-time tasks.
> > > > > 
> > > > > This patch introduces kick_active_cpus_sync() and uses it in mm/slab and arm64
> > > > > code to delay syncronization.
> > > > > 
> > > > > For task isolation (https://lkml.org/lkml/2017/11/3/589), IPI to the CPU running
> > > > > isolated task would be fatal, as it breaks isolation. The approach with delaying
> > > > > of synchronization work helps to maintain isolated state.
> > > > > 
> > > > > I've tested it with test from task isolation series on ThunderX2 for more than
> > > > > 10 hours (10k giga-ticks) without breaking isolation.
> > > > > 
> > > > > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > > > > ---
> > > > >  arch/arm64/kernel/insn.c |  2 +-
> > > > >  include/linux/smp.h      |  2 ++
> > > > >  kernel/smp.c             | 24 ++++++++++++++++++++++++
> > > > >  mm/slab.c                |  2 +-
> > > > >  4 files changed, 28 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> > > > > index 2718a77da165..9d7c492e920e 100644
> > > > > --- a/arch/arm64/kernel/insn.c
> > > > > +++ b/arch/arm64/kernel/insn.c
> > > > > @@ -291,7 +291,7 @@ int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
> > > > >  			 * synchronization.
> > > > >  			 */
> > > > >  			ret = aarch64_insn_patch_text_nosync(addrs[0], insns[0]);
> > > > > -			kick_all_cpus_sync();
> > > > > +			kick_active_cpus_sync();
> > > > >  			return ret;
> > > > >  		}
> > > > >  	}
> > > > > diff --git a/include/linux/smp.h b/include/linux/smp.h
> > > > > index 9fb239e12b82..27215e22240d 100644
> > > > > --- a/include/linux/smp.h
> > > > > +++ b/include/linux/smp.h
> > > > > @@ -105,6 +105,7 @@ int smp_call_function_any(const struct cpumask *mask,
> > > > >  			  smp_call_func_t func, void *info, int wait);
> > > > > 
> > > > >  void kick_all_cpus_sync(void);
> > > > > +void kick_active_cpus_sync(void);
> > > > >  void wake_up_all_idle_cpus(void);
> > > > > 
> > > > >  /*
> > > > > @@ -161,6 +162,7 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
> > > > >  }
> > > > > 
> > > > >  static inline void kick_all_cpus_sync(void) {  }
> > > > > +static inline void kick_active_cpus_sync(void) {  }
> > > > >  static inline void wake_up_all_idle_cpus(void) {  }
> > > > > 
> > > > >  #ifdef CONFIG_UP_LATE_INIT
> > > > > diff --git a/kernel/smp.c b/kernel/smp.c
> > > > > index 084c8b3a2681..0358d6673850 100644
> > > > > --- a/kernel/smp.c
> > > > > +++ b/kernel/smp.c
> > > > > @@ -724,6 +724,30 @@ void kick_all_cpus_sync(void)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
> > > > > 
> > > > > +/**
> > > > > + * kick_active_cpus_sync - Force CPUs that are not in extended
> > > > > + * quiescent state (idle or nohz_full userspace) sync by sending
> > > > > + * IPI. Extended quiescent state CPUs will sync at the exit of
> > > > > + * that state.
> > > > > + */
> > > > > +void kick_active_cpus_sync(void)
> > > > > +{
> > > > > +	int cpu;
> > > > > +	struct cpumask kernel_cpus;
> > > > > +
> > > > > +	smp_mb();
> > > > > +
> > > > > +	cpumask_clear(&kernel_cpus);
> > > > > +	preempt_disable();
> > > > > +	for_each_online_cpu(cpu) {
> > > > > +		if (!rcu_eqs_special_set(cpu))
> > > > 
> > > > If we get here, the CPU is not in a quiescent state, so we therefore
> > > > must IPI it, correct?
> > > > 
> > > > But don't you also need to define rcu_eqs_special_exit() so that RCU
> > > > can invoke it when it next leaves its quiescent state?  Or are you able
> > > > to ignore the CPU in that case?  (If you are able to ignore the CPU in
> > > > that case, I could give you a lower-cost function to get your job done.)
> > > > 
> > > > 							Thanx, Paul
> > > 
> > > What's actually needed for synchronization is issuing memory barrier on target
> > > CPUs before we start executing kernel code.
> > > 
> > > smp_mb() is implicitly called in smp_call_function*() path for it. In
> > > rcu_eqs_special_set() -> rcu_dynticks_eqs_exit() path, smp_mb__after_atomic()
> > > is called just before rcu_eqs_special_exit().
> > > 
> > > So I think, rcu_eqs_special_exit() may be left untouched. Empty
> > > rcu_eqs_special_exit() in new RCU path corresponds empty do_nothing() in old
> > > IPI path.
> > > 
> > > Or my understanding of smp_mb__after_atomic() is wrong? By default, 
> > > smp_mb__after_atomic() is just alias to smp_mb(). But some
> > > architectures define it differently. x86, for example, aliases it to
> > > just barrier() with a comment: "Atomic operations are already
> > > serializing on x86".
> > > 
> > > I was initially thinking that it's also fine to leave
> > > rcu_eqs_special_exit() empty in this case, but now I'm not sure...
> > > 
> > > Anyway, answering to your question, we shouldn't ignore quiescent
> > > CPUs, and rcu_eqs_special_set() path is really needed as it issues
> > > memory barrier on them.
> > 
> > An alternative approach would be for me to make something like this
> > and export it:
> > 
> > 	bool rcu_cpu_in_eqs(int cpu)
> > 	{
> > 		struct rcu_dynticks *rdtp = &per_cpu(rcu_dynticks, cpu);
> > 		int snap;
> > 
> > 		smp_mb(); /* Obtain consistent snapshot, pairs with update. */
> > 		snap = READ_ONCE(&rdtp->dynticks);
> > 		smp_mb(); /* See above. */
> > 		return !(snap & RCU_DYNTICK_CTRL_CTR);
> > 	}
> > 
> > Then you could replace your use of rcu_cpu_in_eqs() above with
> 
> Did you mean replace rcu_eqs_special_set()?

Yes, apologies for my confusion, and good show figuring it out.  ;-)

> > the new rcu_cpu_in_eqs().  This would avoid the RMW atomic, and, more
> > important, the unnecessary write to ->dynticks.
> > 
> > Or am I missing something?
> > 
> > 							Thanx, Paul
> 
> This will not work because EQS CPUs will not be charged to call
> smp_mb() on exit of EQS. 

Actually, CPUs are guaranteed to do a value-returning atomic increment
of ->dynticks on EQS exit, which implies smp_mb() both before and after
that atomic increment.

> Lets sync our understanding of IPI and RCU mechanisms.
> 
> Traditional IPI scheme looks like this:
> 
> CPU1:                                    CPU2:
> touch shared resource();                 /* running any code */
> smp_mb();
> smp_call_function();          --->       handle_IPI()

					   EQS exit here, so implied
					   smp_mb() on both sides of the
					   ->dynticks increment.

>                                          {
>                                                  /* Make resource visible */
>                                                  smp_mb();
>                                                  do_nothing();
>                                          }
> 
> And new RCU scheme for eqs CPUs looks like this:
> 
> CPU1:                                    CPU2:
> touch shared resource();                /* Running EQS */
> smp_mb();
> 
> if (RCU_DYNTICK_CTRL_CTR)
>         set(RCU_DYNTICK_CTRL_MASK);     /* Still in EQS */
>                                        
>                                         /* And later */
>                                         rcu_dynticks_eqs_exit()
>                                         {
>                                                 if (RCU_DYNTICK_CTRL_MASK) {
>                                                         /* Make resource visible */
>                                                         smp_mb(); 
>                                                         rcu_eqs_special_exit();
>                                                 }
>                                         }
> 
> Is it correct?

You are missing the atomic_add_return() that is already in
rcu_dynticks_eqs_exit(), and this value-returning atomic operation again
implies smp_mb() both before and after.  So you should be covered without
needing to worry about RCU_DYNTICK_CTRL_MASK.

Or am I missing something subtle here?

							Thanx, Paul
