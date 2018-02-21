Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755099AbeBUSAD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:00:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754135AbeBUSAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:00:01 -0500
Date: Wed, 21 Feb 2018 10:00:16 -0800
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
Subject: Re: [PATCH] tools/memory-model: update: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180221160602.GD3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802211214070.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802211214070.2032-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022117-0036-0000-0000-000002C41160
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008571; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993056; UDB=6.00504564; IPR=6.00772401;
 MB=3.00019675; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-21 17:59:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022117-0037-0000-0000-0000436A53C9
Message-Id: <20180221180016.GK3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 12:15:56PM -0500, Alan Stern wrote:
> Commit bf28ae562744 ("tools/memory-model: Remove rb-dep,
> smp_read_barrier_depends, and lockless_dereference") was accidentally
> merged too early, while it was still in RFC form.  This patch adds in
> the missing pieces.
> 
> Akira pointed out some typos in the original patch, and he noted that
> cheatsheet.txt should be updated to indicate how unsuccessful RMW
> operations relate to address dependencies.
> 
> Andrea pointed out that the macro for rcu_dereference() in linux.def
> should now use the "once" annotation instead of "deref".  He also
> suggested that the comments should mention commit 5a8897cc7631
> ("locking/atomics/alpha: Add smp_read_barrier_depends() to
> _release()/_relaxed() atomics") as an important precursor, and he
> contributed commit cb13b424e986 ("locking/xchg/alpha: Add
> unconditional memory barrier to cmpxchg()"), another prerequisite.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Suggested-by: Akira Yokosawa <akiyks@gmail.com>
> Suggested-by: Andrea Parri <parri.andrea@gmail.com>
> Fixes: bf28ae562744 ("tools/memory-model: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference")

Queued, thank you!

							Thanx, Paul

> ---
> 
>  tools/memory-model/Documentation/cheatsheet.txt  |    6 +++---
>  tools/memory-model/Documentation/explanation.txt |    4 ++--
>  tools/memory-model/linux-kernel.def              |    2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> Index: usb-4.x/tools/memory-model/Documentation/cheatsheet.txt
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/Documentation/cheatsheet.txt
> +++ usb-4.x/tools/memory-model/Documentation/cheatsheet.txt
> @@ -1,11 +1,11 @@
>                                    Prior Operation     Subsequent Operation
>                                    ---------------  ---------------------------
>                                 C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
> -                              __  ----  -  -  ---  ----  -  -  --  --  ---  --
> +                              --  ----  -  -  ---  ----  -  -  --  --  ---  --
> 
>  Store, e.g., WRITE_ONCE()            Y                                       Y
> -Load, e.g., READ_ONCE()              Y                              Y        Y
> -Unsuccessful RMW operation           Y                              Y        Y
> +Load, e.g., READ_ONCE()              Y                          Y   Y        Y
> +Unsuccessful RMW operation           Y                          Y   Y        Y
>  rcu_dereference()                    Y                          Y   Y        Y
>  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
>  Successful *_release()         C        Y  Y    Y     W                      Y
> Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-4.x/tools/memory-model/Documentation/explanation.txt
> @@ -826,7 +826,7 @@ A-cumulative; they only affect the propa
>  executed on C before the fence (i.e., those which precede the fence in
>  program order).
> 
> -read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
> +read_read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
>  other properties which we discuss later.
> 
> 
> @@ -1138,7 +1138,7 @@ final effect is that even though the two
>  program order, it appears that they aren't.
> 
>  This could not have happened if the local cache had processed the
> -incoming stores in FIFO order.  In constrast, other architectures
> +incoming stores in FIFO order.  By contrast, other architectures
>  maintain at least the appearance of FIFO order.
> 
>  In practice, this difficulty is solved by inserting a special fence
> Index: usb-4.x/tools/memory-model/linux-kernel.def
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.def
> +++ usb-4.x/tools/memory-model/linux-kernel.def
> @@ -13,7 +13,7 @@ WRITE_ONCE(X,V) { __store{once}(X,V); }
>  smp_store_release(X,V) { __store{release}(*X,V); }
>  smp_load_acquire(X) __load{acquire}(*X)
>  rcu_assign_pointer(X,V) { __store{release}(X,V); }
> -rcu_dereference(X) __load{deref}(X)
> +rcu_dereference(X) __load{once}(X)
> 
>  // Fences
>  smp_mb() { __fence{mb} ; }
> 
