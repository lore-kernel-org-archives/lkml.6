Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbeBIM4z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:56:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750920AbeBIM4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:56:51 -0500
Date: Fri, 9 Feb 2018 04:56:55 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        boqun.feng@gmail.com, will.deacon@arm.com, npiggin@gmail.com,
        dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com,
        akiyks@gmail.com
Subject: Re: [GIT PULL tools] Linux kernel memory model
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180208184106.GA17043@e110439-lin>
 <20180208200219.GE25181@hirez.programming.kicks-ass.net>
 <20180209091110.GA14128@andrea>
 <20180209112937.GU3617@linux.vnet.ibm.com>
 <20180209124112.GA21524@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209124112.GA21524@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020912-0056-0000-0000-000004182543
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008503; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000250; SDB=6.00987199; UDB=6.00501066; IPR=6.00766557;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019457; XFM=3.00000015;
 UTC=2018-02-09 12:56:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020912-0057-0000-0000-0000084F971E
Message-Id: <20180209125655.GA3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802090166
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 01:41:12PM +0100, Andrea Parri wrote:
> On Fri, Feb 09, 2018 at 03:29:37AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 09, 2018 at 10:11:10AM +0100, Andrea Parri wrote:
> > > On Thu, Feb 08, 2018 at 09:02:19PM +0100, Peter Zijlstra wrote:
> > > > On Thu, Feb 08, 2018 at 06:41:06PM +0000, Patrick Bellasi wrote:
> > > > > Hi Paul,
> > > > > thanks to you and all the involved guys for this useful tool.
> > > > > 
> > > > > I give it a try today and found that by installing herd7 by just
> > > > > following the instruction in herdtools7/INSTALL.md, and precisely
> > > > > installing it via:
> > > > > 
> > > > >    opam install herdtools7
> > > > > 
> > > > > it seems to give you a tool which fails to run the basic example in
> > > > > your README with this error:
> > > > > 
> > > > >    File "./linux-kernel.def", line 44, characters 29-30: unexpected '-' (in macros)
> > > > > 
> > > > > As suggested by Will, by building instead herd7 HEAD (commit 44d69c2)
> > > > > everything works fine.
> > > > > 
> > > > > Maybe it's a know issue, in case just ignore me. :)
> > > > > 
> > > > > Otherwise, maybe it can be worth to add to the README a note on which
> > > > > minimum version of the herd7 tool is required.
> > > > > 
> > > > >  opma   version (not working)    : 7.47, Rev: exported
> > > > >  master version (working for me) : 7.47+7(dev), Rev: 44d69c2b1b5ca0f97bd138899d31532ee5e4e084
> > > > 
> > > > Urgh. So that's why it wouldn't work.
> > > > 
> > > > I remember Paul saying you needed the latest version, which is why I
> > > > rebuild from opam, but building top of git is a bit much.
> > > 
> > > +1
> > > 
> > > _Sadly_ enough, co-developers and I were aware of this issue,
> > > but it was only mildly reported here (c.f.,
> > > 
> > >   https://marc.info/?l=linux-kernel&m=151638196427685&w=2 ).
> > > 
> > > This bisects to that (crazy):
> > > 
> > >   2d5fba7782d669c6a1cc577dbc3bf507780273bb
> > >   ("linux-kernel*: Make RCU identifiers match ASPLOS paper")
> > > 
> > >   From repo.: https://github.com/aparri/memory-model
> > > 
> > > which not only did break 7.47, but also made the bell uglier
> > > by mixing dashes and underscores in a very same block.
> > > 
> > > As a solution to this issue, I can envisage a partial revert
> > > of that commit (just replace those dashes); Paul, Jade, Luc:
> > > any better solution?
> > > 
> > > (Sorry for being late on IRC, glad this came out here,)
> > 
> > Or maybe a 7.48 release?
> 
> This would work, _prior upgrade. (This's not my call of course).
> 
> I do however want to iterate, looking again at the above commit:
> 
>  		'rb_dep (*smp_read_barrier_depends*) ||
> -		'rcu_read_lock (*rcu_read_lock*)  ||
> -		'rcu_read_unlock (*rcu_read_unlock*) ||
> -		'sync (*synchronize_rcu*) ||
> +		'rcu-lock (*rcu_read_lock*)  ||
> +		'rcu-unlock (*rcu_read_unlock*) ||
> +		'sync-rcu (*synchronize_rcu*) ||
>  		'before_atomic (*smp_mb__before_atomic*) ||
>  		'after_atomic (*smp_mb__after_atomic*) ||
>  		'after_spinlock (*smp_mb__after_spinlock*)
> 
> The question arises: dash or underscore? This needs to be fixed.

The underscore in rb_dep is determined by herd, so the best shot there
is to update the model based on the de-Alpha-ication of the kernel,
thus (I believe) allowing rb_dep to be removed entirely, along with
its underscore.

As far as I know, there is nothing preventing removing underscores
from before_atomic, after_atomic, and after_spinlock, and the diff
below seems to work OK.  And I did have to make a litmus test for
smp_mb__before_atomic() and smp_mb__after_atomic().  ;-)

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index b984bbda01a5..18885ad15de9 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -28,9 +28,9 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
 		'sync-rcu (*synchronize_rcu*) ||
-		'before_atomic (*smp_mb__before_atomic*) ||
-		'after_atomic (*smp_mb__after_atomic*) ||
-		'after_spinlock (*smp_mb__after_spinlock*)
+		'before-atomic (*smp_mb__before_atomic*) ||
+		'after-atomic (*smp_mb__after_atomic*) ||
+		'after-spinlock (*smp_mb__after_spinlock*)
 instructions F[Barriers]
 
 (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index babe2b3b0bb3..f0d27f813ec2 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -29,9 +29,9 @@ let rb-dep = [R] ; fencerel(Rb_dep) ; [R]
 let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
 let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
-	([M] ; fencerel(Before_atomic) ; [RMW] ; po? ; [M]) |
-	([M] ; po? ; [RMW] ; fencerel(After_atomic) ; [M]) |
-	([M] ; po? ; [LKW] ; fencerel(After_spinlock) ; [M])
+	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
+	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
+	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
 let gp = po ; [Sync-rcu] ; po?
 
 let strong-fence = mb | gp
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index a397387f77cc..f5a1eb04cb64 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -21,9 +21,9 @@ smp_mb() { __fence{mb} ; }
 smp_rmb() { __fence{rmb} ; }
 smp_wmb() { __fence{wmb} ; }
 smp_read_barrier_depends() { __fence{rb_dep}; }
-smp_mb__before_atomic() { __fence{before_atomic} ; }
-smp_mb__after_atomic() { __fence{after_atomic} ; }
-smp_mb__after_spinlock() { __fence{after_spinlock} ; }
+smp_mb__before_atomic() { __fence{before-atomic} ; }
+smp_mb__after_atomic() { __fence{after-atomic} ; }
+smp_mb__after_spinlock() { __fence{after-spinlock} ; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
