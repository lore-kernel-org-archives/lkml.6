Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeBVUCX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:02:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750776AbeBVUCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:02:22 -0500
Date: Thu, 22 Feb 2018 12:02:37 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Lustig <dlustig@nvidia.com>,
        Andrea Parri <parri.andrea@gmail.com>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH] riscv/locking: Strengthen spin_lock() and
 spin_unlock()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519301990-11766-1-git-send-email-parri.andrea@gmail.com>
 <20180222134004.GN25181@hirez.programming.kicks-ass.net>
 <20180222141249.GA14033@andrea>
 <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com>
 <20180222181317.GI2855@linux.vnet.ibm.com>
 <20180222182717.GS25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222182717.GS25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022220-0008-0000-0000-000002D9D27A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008578; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993577; UDB=6.00504877; IPR=6.00772917;
 MB=3.00019692; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-22 20:02:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022220-0009-0000-0000-0000385A7283
Message-Id: <20180222200237.GK2855@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 07:27:17PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 10:13:17AM -0800, Paul E. McKenney wrote:
> > So we have something that is not all that rare in the Linux kernel
> > community, namely two conflicting more-or-less concurrent changes.
> > This clearly needs to be resolved, either by us not strengthening the
> > Linux-kernel memory model in the way we were planning to or by you
> > strengthening RISC-V to be no weaker than PowerPC for these sorts of
> > externally viewed release-acquire situations.
> > 
> > Other thoughts?
> 
> Like said in the other email, I would _much_ prefer to not go weaker
> than PPC, I find that PPC is already painfully weak at times.

And here are the four PowerPC litmus tests.  As expected, a
release-acquire pair within a given process orders everything except
for prior stores against later loads, from the viewpoint of some other
process.

And yes, a few of the filenames are unfortunate.

							Thanx, Paul

------------------------------------------------------------------------

PPC MP+o-r-a-o+o-rmb-o
""
(* 22-Feb-2018: ppcmem says "Never" *)
{
0:r1=1; 0:r4=x; 0:r5=y; 0:r6=z;
1:r1=1; 1:r4=x; 1:r5=y; 1:r6=z;
}
 P0           | P1           ;
 stw r1,0(r4) | lwz r7,0(r6) ;
 lwsync       | lwsync       ;
 stw r1,0(r5) | lwz r8,0(r4) ;
 lwz r7,0(r5) |              ;
 lwsync       |              ;
 stw r1,0(r6) |              ;


exists
(1:r7=1 /\ 1:r8=0)

------------------------------------------------------------------------

PPC SB+o-r-a-o+o-rmb-o
""
(* 22-Feb-2018: ppcmem says "Sometimes" *)
{
0:r1=1; 0:r4=x; 0:r5=y; 0:r6=z;
1:r1=1; 1:r4=x; 1:r5=y; 1:r6=z;
}
 P0           | P1           ;
 stw r1,0(r4) | stw r1,0(r6) ;
 lwsync       | lwsync       ;
 stw r1,0(r5) | lwz r7,0(r4) ;
 lwz r8,0(r5) |              ;
 lwsync       |              ;
 lwz r7,0(r6) |              ;


exists
(0:r7=0 /\ 1:r7=0)

------------------------------------------------------------------------

PPC LB+o-r-a-o+o-rmb-o
""
(* 22-Feb-2018: ppcmem says "Never" *)
{
0:r1=1; 0:r4=x; 0:r5=y; 0:r6=z;
1:r1=1; 1:r4=x; 1:r5=y; 1:r6=z;
}
 P0           | P1           ;
 lwz r7,0(r4) | lwz r7,0(r6) ;
 lwsync       | lwsync       ;
 stw r1,0(r5) | stw r1,0(r4) ;
 lwz r8,0(r5) |              ;
 lwsync       |              ;
 stw r1,0(r6) |              ;


exists
(0:r7=1 /\ 1:r7=1)

------------------------------------------------------------------------

PPC MP+o-rmb-o+o-r-a-o.litmus
""
(* 22-Feb-2018: ppcmem says "Never" *)
{
0:r1=1; 0:r4=x; 0:r5=y; 0:r6=z;
1:r1=1; 1:r4=x; 1:r5=y; 1:r6=z;
}
 P0           | P1           ;
 lwz r7,0(r4) | stw r1,0(r6) ;
 lwsync       | lwsync       ;
 stw r1,0(r5) | stw r1,0(r4) ;
 lwz r8,0(r5) |              ;
 lwsync       |              ;
 lwz r9,0(r6) |              ;


exists
(0:r7=1 /\ 0:r9=0)
