Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeCIAeN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:34:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750940AbeCIAeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:34:12 -0500
Date: Thu, 8 Mar 2018 16:34:43 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/dev 39/39] kernel/rcu/tree_exp.h:163:9: sparse:
 incorrect type in argument 1 (different modifiers)
Reply-To: paulmck@linux.vnet.ibm.com
References: <201803090524.gbCGY9DF%fengguang.wu@intel.com>
 <20180308225234.v2v6v5tnfkutwu5u@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308225234.v2v6v5tnfkutwu5u@tardis>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030900-0008-0000-0000-000002E234D2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008637; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000273; UDB=6.00508777; IPR=6.00779603;
 MB=3.00019923; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-09 00:34:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030900-0009-0000-0000-0000388102D8
Message-Id: <20180309003443.GX3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090005
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 06:52:34AM +0800, Boqun Feng wrote:
> On Fri, Mar 09, 2018 at 05:41:27AM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/dev
> > head:   b8909ec707bb5beba94e7c7d62cc6b3115ceae50
> > commit: b8909ec707bb5beba94e7c7d62cc6b3115ceae50 [39/39] rcu: Protect all sync_rcu_preempt_exp_done() with rcu_node lock
> > reproduce:
> >         # apt-get install sparse
> >         git checkout b8909ec707bb5beba94e7c7d62cc6b3115ceae50
> >         make ARCH=x86_64 allmodconfig
> >         make C=1 CF=-D__CHECK_ENDIAN__
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > 
> [...]
> >    kernel/rcu/tree.c:345:6: sparse: symbol 'rcu_dynticks_curr_cpu_in_eqs' was not declared. Should it be static?
> >    kernel/rcu/tree.c:3953:21: sparse: incorrect type in argument 1 (different modifiers) @@    expected int ( *threadfn )( ... ) @@    got int ( [noreint ( *threadfn )( ... ) @@
> >    kernel/rcu/tree.c:3953:21:    expected int ( *threadfn )( ... )
> >    kernel/rcu/tree.c:3953:21:    got int ( [noreturn] *<noident> )( ... )
> > >> kernel/rcu/tree_exp.h:163:9: sparse: incorrect type in argument 1 (different modifiers) @@    expected struct lockdep_map const *lock @@    got strustruct lockdep_map const *lock @@
> >    kernel/rcu/tree_exp.h:163:9:    expected struct lockdep_map const *lock
> >    kernel/rcu/tree_exp.h:163:9:    got struct lockdep_map [noderef] *<noident>
> >    kernel/rcu/tree.c:1752:9: sparse: context imbalance in 'rcu_start_future_gp' - different lock contexts for basic block
> >    kernel/rcu/tree.c:2786:9: sparse: context imbalance in 'force_qs_rnp' - different lock contexts for basic block
> >    kernel/rcu/tree.c:2849:25: sparse: context imbalance in 'force_quiescent_state' - unexpected unlock
> >    kernel/rcu/tree_exp.h:203:9: sparse: too many warnings
> > 
> > vim +163 kernel/rcu/tree_exp.h
> > 
> >    151	
> >    152	/*
> >    153	 * Return non-zero if there is no RCU expedited grace period in progress
> >    154	 * for the specified rcu_node structure, in other words, if all CPUs and
> >    155	 * tasks covered by the specified rcu_node structure have done their bit
> >    156	 * for the current expedited grace period.  Works only for preemptible
> >    157	 * RCU -- other RCU implementation use other means.
> >    158	 *
> >    159	 * Caller must hold the specificed rcu_node structure's ->lock
> >    160	 */
> >    161	static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
> >    162	{
> >  > 163		lockdep_assert_held(&rnp->lock);
> 
> OK, so we need ACCESS_PRIVATE() to visit ->lock in rcu_node. I will
> introduce something like:
> 
> 	#define rcu_node_lock_assert_held(rnp) lockdep_assert_held(&ACCESS_PRIVATE(rnp, lock))
> 
> in v3.

Or use this, which is in kernel/rcu/rcu.h:

#define raw_lockdep_assert_held_rcu_node(p)				\
	lockdep_assert_held(&ACCESS_PRIVATE(p, lock))

							Thanx, Paul
