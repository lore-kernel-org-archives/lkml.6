Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeBTOtc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:49:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751000AbeBTOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:49:31 -0500
Date: Tue, 20 Feb 2018 06:49:39 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180217151413.GA3785@andrea>
 <Pine.LNX.4.44L0.1802191158320.1361-100000@iolanthe.rowland.org>
 <20180219194123.GZ3617@linux.vnet.ibm.com>
 <20180219202844.GW25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219202844.GW25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022014-0008-0000-0000-000002D83572
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008563; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992513; UDB=6.00504240; IPR=6.00771859;
 MB=3.00019656; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-20 14:49:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022014-0009-0000-0000-00003853C93F
Message-Id: <20180220144939.GG3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 09:28:44PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 19, 2018 at 11:41:23AM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 19, 2018 at 12:14:45PM -0500, Alan Stern wrote:
> > > This leaves us with a question: Do we want to change the kernel by
> > > adding memory barriers after unsuccessful RMW operations on Alpha, or
> > > do we want to change the model by excluding such operations from
> > > address dependencies?
> > 
> > I vote for adding the barrier on Alpha.  However, I don't know of any
> > code in the Linux kernel that relies on read-to-read address dependency
> > ordering headed by a failing RMW operation, so I don't feel all that
> > strongly about this.
> 
> Right, but not knowing doesn't mean doesn't exist, and most certainly
> doesn't mean will never exist.

Fair enough, safety first!

> > > Note that operations like atomic_add_unless() already include memory 
> > > barriers.
> > 
> > And I don't see an atomic_add_unless_relaxed(), so we are good on this
> > one.  So far, anyway!  ;-)
> 
> Not the point, add_unless() is a conditional operation, and therefore
> doesn't need to imply anything when failing.

Plus it doesn't return a pointer, so there is no problem with dereferences.
Unless someone wants to use its return value as an array index and rely
on dependency ordering to the array, but I would NAK that use case.

							Thanx, Paul
