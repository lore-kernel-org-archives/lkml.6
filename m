Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeBXSHz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 13:07:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751357AbeBXSHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 13:07:53 -0500
Date: Sat, 24 Feb 2018 10:08:14 -0800
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
References: <20180224143658.GA3556@andrea>
 <Pine.LNX.4.44L0.1802241149090.14116-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802241149090.14116-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022418-0040-0000-0000-000003FC9083
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008591; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00994497; UDB=6.00505416; IPR=6.00773830;
 MB=3.00019724; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-24 18:07:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022418-0041-0000-0000-000007FD9905
Message-Id: <20180224180814.GV2855@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802240240
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 11:49:20AM -0500, Alan Stern wrote:
> On Sat, 24 Feb 2018, Andrea Parri wrote:
> 
> > On Fri, Feb 23, 2018 at 07:30:13PM -0800, Paul E. McKenney wrote:
> > > On Sat, Feb 24, 2018 at 12:22:24PM +0900, Akira Yokosawa wrote:
> > > > On 2018/02/22 07:29:02 +0900, Akira Yokosawa wrote:
> > > > > On 2018/02/22 2:15, Alan Stern wrote:
> > 
> > [...]
> > 
> > > > >>
> > > > >> Akira pointed out some typos in the original patch, and he noted that
> > > > >> cheatsheet.txt should be updated to indicate how unsuccessful RMW
> > > > >> operations relate to address dependencies.
> > > > > 
> > > > > My point was to separate unannotated loads from READ_ONCE(), if the
> > > > > cheatsheet should concern such accesses as well.
> > > > > Unsuccessful RMW operations were brought up by Andrea.
> > > > >
> > > > 
> > > > Paul, can you amend above paragraph in the change log to something like:
> > > > 
> > > >     Akira pointed out some typos in the original patch, and he noted that
> > > >     cheatsheet.txt should be updated to indicate READ_ONCE() implies
> > > >     address dependency, which invited Andrea's observation that it should
> > > >     also be updated to indicate how unsuccessful RMW operations relate to
> > > >     address dependencies.
> > > > 
> > > > , if Alan and Andrea are OK with the amendment.
> > > > 
> > > > Also, please append my Acked-by.
> > > > 
> > > > Acked-by: Akira Yokosawa <akiyks@gmail.com>
> > > 
> > > I can still amend this, and have added your Acked-by.  If Alan and Andrea
> > > OK with your change, I will apply that also.
> > 
> > LGTM. Thanks,
> 
> Me too.

Very good, how about this for the new version?

							Thanx, Paul

------------------------------------------------------------------------

commit 21ede43970e50b7397420f17ed08bb02c187e2eb
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Wed Feb 21 12:15:56 2018 -0500

    tools/memory-model: Update: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference
    
    Commit bf28ae562744 ("tools/memory-model: Remove rb-dep,
    smp_read_barrier_depends, and lockless_dereference") was accidentally
    merged too early, while it was still in RFC form.  This patch adds in
    the missing pieces.
    
    Akira pointed out some typos in the original patch, and he noted that
    cheatsheet.txt should indicate that READ_ONCE() now implies an address
    dependency.  Andrea suggested documenting the relationship betwwen
    unsuccessful RMW operations and address dependencies.
    
    Andrea pointed out that the macro for rcu_dereference() in linux.def
    should now use the "once" annotation instead of "deref".  He also
    suggested that the comments should mention commit 5a8897cc7631
    ("locking/atomics/alpha: Add smp_read_barrier_depends() to
    _release()/_relaxed() atomics") as an important precursor, and he
    contributed commit cb13b424e986 ("locking/xchg/alpha: Add
    unconditional memory barrier to cmpxchg()"), another prerequisite.
    
    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Suggested-by: Akira Yokosawa <akiyks@gmail.com>
    Suggested-by: Andrea Parri <parri.andrea@gmail.com>
    Fixes: bf28ae562744 ("tools/memory-model: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference")
    Acked-by: Andrea Parri <parri.andrea@gmail.com>
    Acked-by: Akira Yokosawa <akiyks@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 04e458acd6d4..956b1ae4aafb 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -1,11 +1,11 @@
                                   Prior Operation     Subsequent Operation
                                   ---------------  ---------------------------
                                C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
-                              __  ----  -  -  ---  ----  -  -  --  --  ---  --
+                              --  ----  -  -  ---  ----  -  -  --  --  ---  --
 
 Store, e.g., WRITE_ONCE()            Y                                       Y
-Load, e.g., READ_ONCE()              Y                              Y        Y
-Unsuccessful RMW operation           Y                              Y        Y
+Load, e.g., READ_ONCE()              Y                          Y   Y        Y
+Unsuccessful RMW operation           Y                          Y   Y        Y
 rcu_dereference()                    Y                          Y   Y        Y
 Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
 Successful *_release()         C        Y  Y    Y     W                      Y
diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index dae8b8cb2ad3..889fabef7d83 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -826,7 +826,7 @@ A-cumulative; they only affect the propagation of stores that are
 executed on C before the fence (i.e., those which precede the fence in
 program order).
 
-read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
+read_read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
 other properties which we discuss later.
 
 
@@ -1138,7 +1138,7 @@ final effect is that even though the two loads really are executed in
 program order, it appears that they aren't.
 
 This could not have happened if the local cache had processed the
-incoming stores in FIFO order.  In constrast, other architectures
+incoming stores in FIFO order.  By contrast, other architectures
 maintain at least the appearance of FIFO order.
 
 In practice, this difficulty is solved by inserting a special fence
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 5dfb9c7f3462..397e4e67e8c8 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -13,7 +13,7 @@ WRITE_ONCE(X,V) { __store{once}(X,V); }
 smp_store_release(X,V) { __store{release}(*X,V); }
 smp_load_acquire(X) __load{acquire}(*X)
 rcu_assign_pointer(X,V) { __store{release}(X,V); }
-rcu_dereference(X) __load{deref}(X)
+rcu_dereference(X) __load{once}(X)
 
 // Fences
 smp_mb() { __fence{mb} ; }
