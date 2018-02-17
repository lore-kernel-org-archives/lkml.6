Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbeBQAjs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 19:39:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750933AbeBQAjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 19:39:47 -0500
Date: Fri, 16 Feb 2018 16:39:59 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180216165301.GF3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802161707350.1402-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802161707350.1402-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18021700-0044-0000-0000-000003E58613
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008545; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00990791; UDB=6.00503209; IPR=6.00770138;
 MB=3.00019596; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-17 00:39:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021700-0045-0000-0000-000008158838
Message-Id: <20180217003959.GR3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802170006
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 05:22:55PM -0500, Alan Stern wrote:
> Since commit 76ebbe78f739 ("locking/barriers: Add implicit
> smp_read_barrier_depends() to READ_ONCE()") was merged for the 4.15
> kernel, it has not been necessary to use smp_read_barrier_depends().
> Similarly, commit 59ecbbe7b31c ("locking/barriers: Kill
> lockless_dereference()") removed lockless_dereference() from the
> kernel.
> 
> Since these primitives are no longer part of the kernel, they do not
> belong in the Linux Kernel Memory Consistency Model.  This patch
> removes them, along with the internal rb-dep relation, and updates the
> revelant documentation.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

I queued this, but would welcome an update that addressed Akira's
feedback as appropriate.

							Thanx, Paul

> ---
> 
> Index: usb-4.x/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-4.x/tools/memory-model.orig/linux-kernel.cat
> +++ usb-4.x/tools/memory-model/linux-kernel.cat
> @@ -25,7 +25,6 @@ include "lock.cat"
>  (*******************)
> 
>  (* Fences *)
> -let rb-dep = [R] ; fencerel(Rb_dep) ; [R]
>  let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
>  let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
> @@ -61,11 +60,9 @@ let dep = addr | data
>  let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int)
> -let rrdep = addr | (dep ; rfi)
> -let strong-rrdep = rrdep+ & rb-dep
> -let to-r = strong-rrdep | rfi-rel-acq
> +let to-r = addr | (dep ; rfi) | rfi-rel-acq
>  let fence = strong-fence | wmb | po-rel | rmb | acq-po
> -let ppo = rrdep* ; (to-r | to-w | fence)
> +let ppo = to-r | to-w | fence
> 
>  (* Propagation: Ordering from release operations and strong fences. *)
>  let A-cumul(r) = rfe? ; r
> Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-4.x/tools/memory-model.orig/Documentation/explanation.txt
> +++ usb-4.x/tools/memory-model/Documentation/explanation.txt
> @@ -1,5 +1,5 @@
> -Explanation of the Linux-Kernel Memory Model
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Explanation of the Linux-Kernel Memory Consistency Model
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>  :Author: Alan Stern <stern@rowland.harvard.edu>
>  :Created: October 2017
> @@ -35,25 +35,24 @@ Explanation of the Linux-Kernel Memory M
>  INTRODUCTION
>  ------------
> 
> -The Linux-kernel memory model (LKMM) is rather complex and obscure.
> -This is particularly evident if you read through the linux-kernel.bell
> -and linux-kernel.cat files that make up the formal version of the
> -memory model; they are extremely terse and their meanings are far from
> -clear.
> +The Linux-kernel memory consistency model (LKMM) is rather complex and
> +obscure.  This is particularly evident if you read through the
> +linux-kernel.bell and linux-kernel.cat files that make up the formal
> +version of the model; they are extremely terse and their meanings are
> +far from clear.
> 
>  This document describes the ideas underlying the LKMM.  It is meant
> -for people who want to understand how the memory model was designed.
> -It does not go into the details of the code in the .bell and .cat
> -files; rather, it explains in English what the code expresses
> -symbolically.
> +for people who want to understand how the model was designed.  It does
> +not go into the details of the code in the .bell and .cat files;
> +rather, it explains in English what the code expresses symbolically.
> 
>  Sections 2 (BACKGROUND) through 5 (ORDERING AND CYCLES) are aimed
> -toward beginners; they explain what memory models are and the basic
> -notions shared by all such models.  People already familiar with these
> -concepts can skim or skip over them.  Sections 6 (EVENTS) through 12
> -(THE FROM_READS RELATION) describe the fundamental relations used in
> -many memory models.  Starting in Section 13 (AN OPERATIONAL MODEL),
> -the workings of the LKMM itself are covered.
> +toward beginners; they explain what memory consistency models are and
> +the basic notions shared by all such models.  People already familiar
> +with these concepts can skim or skip over them.  Sections 6 (EVENTS)
> +through 12 (THE FROM_READS RELATION) describe the fundamental
> +relations used in many models.  Starting in Section 13 (AN OPERATIONAL
> +MODEL), the workings of the LKMM itself are covered.
> 
>  Warning: The code examples in this document are not written in the
>  proper format for litmus tests.  They don't include a header line, the
> @@ -827,8 +826,8 @@ A-cumulative; they only affect the propa
>  executed on C before the fence (i.e., those which precede the fence in
>  program order).
> 
> -smp_read_barrier_depends(), rcu_read_lock(), rcu_read_unlock(), and
> -synchronize_rcu() fences have other properties which we discuss later.
> +read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
> +other properties which we discuss later.
> 
> 
>  PROPAGATION ORDER RELATION: cumul-fence
> @@ -988,8 +987,8 @@ Another possibility, not mentioned earli
>  section, is:
> 
>  	X and Y are both loads, X ->addr Y (i.e., there is an address
> -	dependency from X to Y), and an smp_read_barrier_depends()
> -	fence occurs between them.
> +	dependency from X to Y), and X is a READ_ONCE() or an atomic
> +	access.
> 
>  Dependencies can also cause instructions to be executed in program
>  order.  This is uncontroversial when the second instruction is a
> @@ -1015,9 +1014,9 @@ After all, a CPU cannot ask the memory s
>  a particular location before it knows what that location is.  However,
>  the split-cache design used by Alpha can cause it to behave in a way
>  that looks as if the loads were executed out of order (see the next
> -section for more details).  For this reason, the LKMM does not include
> -address dependencies between read events in the ppo relation unless an
> -smp_read_barrier_depends() fence is present.
> +section for more details).  The kernel includes a workaround for this
> +problem when the loads come from READ_ONCE(), and therefore the LKMM
> +includes address dependencies to loads in the ppo relation.
> 
>  On the other hand, dependencies can indirectly affect the ordering of
>  two loads.  This happens when there is a dependency from a load to a
> @@ -1114,11 +1113,12 @@ code such as the following:
>  		int *r1;
>  		int r2;
> 
> -		r1 = READ_ONCE(ptr);
> +		r1 = ptr;
>  		r2 = READ_ONCE(*r1);
>  	}
> 
> -can malfunction on Alpha systems.  It is quite possible that r1 = &x
> +can malfunction on Alpha systems (notice that P1 uses an ordinary load
> +to read ptr instead of READ_ONCE()).  It is quite possible that r1 = &x
>  and r2 = 0 at the end, in spite of the address dependency.
> 
>  At first glance this doesn't seem to make sense.  We know that the
> @@ -1141,11 +1141,15 @@ This could not have happened if the loca
>  incoming stores in FIFO order.  In constrast, other architectures
>  maintain at least the appearance of FIFO order.
> 
> -In practice, this difficulty is solved by inserting an
> -smp_read_barrier_depends() fence between P1's two loads.  The effect
> -of this fence is to cause the CPU not to execute any po-later
> -instructions until after the local cache has finished processing all
> -the stores it has already received.  Thus, if the code was changed to:
> +In practice, this difficulty is solved by inserting a special fence
> +between P1's two loads when the kernel is compiled for the Alpha
> +architecture.  In fact, as of version 4.15, the kernel automatically
> +adds this fence (called smp_read_barrier_depends() and defined as
> +nothing at all on non-Alpha builds) after every READ_ONCE() and atomic
> +load.  The effect of the fence is to cause the CPU not to execute any
> +po-later instructions until after the local cache has finished
> +processing all the stores it has already received.  Thus, if the code
> +was changed to:
> 
>  	P1()
>  	{
> @@ -1153,13 +1157,15 @@ the stores it has already received.  Thu
>  		int r2;
> 
>  		r1 = READ_ONCE(ptr);
> -		smp_read_barrier_depends();
>  		r2 = READ_ONCE(*r1);
>  	}
> 
>  then we would never get r1 = &x and r2 = 0.  By the time P1 executed
>  its second load, the x = 1 store would already be fully processed by
> -the local cache and available for satisfying the read request.
> +the local cache and available for satisfying the read request.  Thus
> +we have yet another reason why shared data should always be read with
> +READ_ONCE() or another synchronization primitive rather than accessed
> +directly.
> 
>  The LKMM requires that smp_rmb(), acquire fences, and strong fences
>  share this property with smp_read_barrier_depends(): They do not allow
> @@ -1751,11 +1757,10 @@ no further involvement from the CPU.  Si
>  the value of x, there is nothing for the smp_rmb() fence to act on.
> 
>  The LKMM defines a few extra synchronization operations in terms of
> -things we have already covered.  In particular, rcu_dereference() and
> -lockless_dereference() are both treated as a READ_ONCE() followed by
> -smp_read_barrier_depends() -- which also happens to be how they are
> -defined in include/linux/rcupdate.h and include/linux/compiler.h,
> -respectively.
> +things we have already covered.  In particular, rcu_dereference() is
> +treated as READ_ONCE() and rcu_assign_pointer() is treated as
> +smp_store_release() -- which is basically how the Linux kernel treats
> +them.
> 
>  There are a few oddball fences which need special treatment:
>  smp_mb__before_atomic(), smp_mb__after_atomic(), and
> Index: usb-4.x/tools/memory-model/linux-kernel.bell
> ===================================================================
> --- usb-4.x/tools/memory-model.orig/linux-kernel.bell
> +++ usb-4.x/tools/memory-model/linux-kernel.bell
> @@ -24,7 +24,6 @@ instructions RMW[{'once,'acquire,'releas
>  enum Barriers = 'wmb (*smp_wmb*) ||
>  		'rmb (*smp_rmb*) ||
>  		'mb (*smp_mb*) ||
> -		'rb_dep (*smp_read_barrier_depends*) ||
>  		'rcu-lock (*rcu_read_lock*)  ||
>  		'rcu-unlock (*rcu_read_unlock*) ||
>  		'sync-rcu (*synchronize_rcu*) ||
> Index: usb-4.x/tools/memory-model/linux-kernel.def
> ===================================================================
> --- usb-4.x/tools/memory-model.orig/linux-kernel.def
> +++ usb-4.x/tools/memory-model/linux-kernel.def
> @@ -13,14 +13,12 @@ WRITE_ONCE(X,V) { __store{once}(X,V); }
>  smp_store_release(X,V) { __store{release}(*X,V); }
>  smp_load_acquire(X) __load{acquire}(*X)
>  rcu_assign_pointer(X,V) { __store{release}(X,V); }
> -lockless_dereference(X) __load{lderef}(X)
>  rcu_dereference(X) __load{deref}(X)
> 
>  // Fences
>  smp_mb() { __fence{mb} ; }
>  smp_rmb() { __fence{rmb} ; }
>  smp_wmb() { __fence{wmb} ; }
> -smp_read_barrier_depends() { __fence{rb_dep}; }
>  smp_mb__before_atomic() { __fence{before-atomic} ; }
>  smp_mb__after_atomic() { __fence{after-atomic} ; }
>  smp_mb__after_spinlock() { __fence{after-spinlock} ; }
> Index: usb-4.x/tools/memory-model/Documentation/cheatsheet.txt
> ===================================================================
> --- usb-4.x/tools/memory-model.orig/Documentation/cheatsheet.txt
> +++ usb-4.x/tools/memory-model/Documentation/cheatsheet.txt
> @@ -6,8 +6,7 @@
>  Store, e.g., WRITE_ONCE()            Y                                       Y
>  Load, e.g., READ_ONCE()              Y                              Y        Y
>  Unsuccessful RMW operation           Y                              Y        Y
> -smp_read_barrier_depends()              Y                       Y   Y
> -*_dereference()                      Y                          Y   Y        Y
> +rcu_dereference()                    Y                          Y   Y        Y
>  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
>  Successful *_release()         C        Y  Y    Y     W                      Y
>  smp_rmb()                               Y       R        Y      Y        R
> 
> 
