Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbeBSTl0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:41:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753466AbeBSTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:41:24 -0500
Date: Mon, 19 Feb 2018 11:41:23 -0800
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
References: <20180217151413.GA3785@andrea>
 <Pine.LNX.4.44L0.1802191158320.1361-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802191158320.1361-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18021919-2213-0000-0000-00000272539F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008561; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992130; UDB=6.00504010; IPR=6.00771476;
 MB=3.00019641; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-19 19:41:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021919-2214-0000-0000-0000592BD0CD
Message-Id: <20180219194123.GZ3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802190243
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 12:14:45PM -0500, Alan Stern wrote:
> On Sat, 17 Feb 2018, Andrea Parri wrote:
> 
> > > Akira's observation about READ_ONCE extends to all (annotated) loads.  In
> > > fact, it also applies to loads corresponding to unsuccessful RMW operations;
> > > consider, for example, the following variation of MP+onceassign+derefonce:
> > > 
> > > C T
> > > 
> > > {
> > > y=z;
> > > z=0;
> > > }
> > > 
> > > P0(int *x, int **y)
> > > {
> > > 	WRITE_ONCE(*x, 1);
> > > 	smp_store_release(y, x);
> > > }
> > > 
> > > P1(int **y, int *z)
> > > {
> > > 	int *r0;
> > > 	int r1;
> > > 
> > > 	r0 = cmpxchg_relaxed(y, z, z);
> > > 	r1 = READ_ONCE(*r0);
> > > }
> > > 
> > > exists (1:r0=x /\ 1:r1=0)
> > > 
> > > The final state is allowed w/o the patch, and forbidden w/ the patch.
> > > 
> > > This also reminds me of
> > > 
> > >    5a8897cc7631fa544d079c443800f4420d1b173f
> > >    ("locking/atomics/alpha: Add smp_read_barrier_depends() to _release()/_relaxed() atomics")
> > > 
> > > (that we probably want to mention in the commit message).
> > 
> > Please also notice that 5a8897cc7631f only touched alpha's atomic.h:
> > I see no corresponding commit/change on {,cmp}xchg.h (where the "mb"
> > is currently conditionally executed).
> 
> This leaves us with a question: Do we want to change the kernel by
> adding memory barriers after unsuccessful RMW operations on Alpha, or
> do we want to change the model by excluding such operations from
> address dependencies?

I vote for adding the barrier on Alpha.  However, I don't know of any
code in the Linux kernel that relies on read-to-read address dependency
ordering headed by a failing RMW operation, so I don't feel all that
strongly about this.

> Note that operations like atomic_add_unless() already include memory 
> barriers.

And I don't see an atomic_add_unless_relaxed(), so we are good on this
one.  So far, anyway!  ;-)

							Thanx, Paul
