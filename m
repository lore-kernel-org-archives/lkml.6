Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBTOr7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:47:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751000AbeBTOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:47:57 -0500
Date: Tue, 20 Feb 2018 06:48:13 -0800
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
 <20180219174413.GV25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219174413.GV25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022014-0048-0000-0000-0000023C492D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008563; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992512; UDB=6.00504239; IPR=6.00771858;
 MB=3.00019656; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-20 14:47:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022014-0049-0000-0000-00004432052E
Message-Id: <20180220144813.GF3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200188
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 06:44:13PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 19, 2018 at 12:14:45PM -0500, Alan Stern wrote:
> > Note that operations like atomic_add_unless() already include memory 
> > barriers.
> 
> It is valid for atomic_add_unless() to not imply any barriers when the
> addition doesn't happen.

Agreed, given that atomic_add_unless() just returns 0 or 1, not the
pointer being added.  Of course, the __atomic_add_unless() function
that it calls is another story, as it does return the old value.  Sigh.
And __atomic_add_unless() is called directly from some code.  All of
which looks to be counters rather than pointers, thankfully.

So, do we want to rely on atomic_add_unless() always being
invoked on counters rather than pointers, or does it need an
smp_read_barrier_depends()?

							Thanx, Paul
