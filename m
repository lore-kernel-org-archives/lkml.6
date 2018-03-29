Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeC2EyT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 00:54:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752166AbeC2EyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 00:54:17 -0400
Date: Wed, 28 Mar 2018 19:18:12 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180328163344.GT3675@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1803281350370.1375-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1803281350370.1375-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18032904-0024-0000-0000-0000033D9E87
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008763; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009947; UDB=6.00514528; IPR=6.00789225;
 MB=3.00020304; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-29 04:54:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032904-0025-0000-0000-0000477AAE06
Message-Id: <20180329021812.GV3675@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-29_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803290054
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 02:04:07PM -0400, Alan Stern wrote:
> On Wed, 28 Mar 2018, Paul E. McKenney wrote:
> 
> > On Wed, Mar 28, 2018 at 11:01:25AM -0400, Alan Stern wrote:
> > > On Wed, 28 Mar 2018, Paul E. McKenney wrote:
> > > 
> > > > Hello!
> > > > 
> > > > The prototype patch shown below provides files required to allow herd7 to
> > > > evaluate C-language litmus tests for the multicopy-atomic TSO ordering
> > > > provided by s390.  This patch should be viewed with great suspicion.
> > > > It does what I expect it to do on SB (with and without barriers),
> > > > IRIW without barriers, and Alan's SB with read-of-write added, but my
> > > > expectations are quite likely faulty, and my test cases are very few
> > > > in number.
> > > > 
> > > > Either way, this is the easy part.  The hard part (which I am happy
> > > > to leave to others) is making litmus7 and klitmus7 able to do tests
> > > > on actual hardware, as well as enabling herd to handle litmus tests
> > > > containing BAL.  ;-)
> > > > 
> > > > Note that CPU architectures already supported by herd might well need
> > > > only a .cfg file that refers to herd's pre-existing support.
> > > > 
> > > > Thoughts?
> > > 
> > > I don't quite see the point of this.  You're not suggesting that we
> > > have one Linux Kernel Memory Consistency Model for s390 and another
> > > one for all the other architectures, are you?
> > 
> > Certainly not for common code!
> > 
> > > If the idea is merely to provide a herd model for s390 then it should 
> > > go into the DIY repository, not into the LKMM repository.
> > 
> > Makes sense.
> > 
> > In the meantime, does the cat file look to you like it correctly
> > models the combination of TSO and multicopy atomicity?  Do the
> > fences really work, or did I just get lucky with my choice of
> > litmus tests?
> 
> You got lucky.  Try creating an SB litmus test where, instead of an
> smp_mb() fence between the write and the read, each thread executes
> some other kind of fence.

Ah, it does indeed get "Never" in that case, which I do not believe
to e correct.

> The acyclicity condition should have been written more like this:
> 
> let po_ghb = ([R] ; po ; [M]) | ([M] ; po ; [W])
> 
> acyclic mfence | po_ghb | rf | fr | co as tso-mca
> 
> I don't know what the fence instruction is on s390; change the "mfence"
> above accordingly.  The main difference between this and the
> corresponding expression in x86tso.cat is that I replaced rfe with rf.

The s390 fence instruction is "bcr 14,0" or "bcr 15,0", depending on
how recent of hardware you are running.  The latter works everywhere,
if I recall correctly.  But I do not believe that herd knows about either
instruction yet.  Ah, and I need to lose the "empty rmw & (fre;coe)".
That appears to be where my spurious ordering was coming from, strange
though that seems to me.

And your use of "rf" instead of "rfe" makes sense, as that is what makes
the read-from-write provide ordering, correct?  And that should also cover
the "Uniproc check" that would otherwise be required, right?

Except that I get "Sometimes" on CoWR+poonceonce+Once.litmus...
Which I can fix by unioning po-loc into po-ghb.  Or is there some
better way to do this?

> This doesn't account for atomic operations properly; see the "implied" 
> term in x86tso.cat.

I will look at this more later, reaching end of both battery and useful
attention span...

							Thanx, Paul
