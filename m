Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966302AbeBUQMV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:12:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932757AbeBUQMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:12:18 -0500
Date: Wed, 21 Feb 2018 08:12:23 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, nborisov@suse.com
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802211001030.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802211001030.2032-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022116-0024-0000-0000-0000032A35D1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008570; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993020; UDB=6.00504543; IPR=6.00772365;
 MB=3.00019674; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-21 16:12:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022116-0025-0000-0000-0000471A2E76
Message-Id: <20180221161223.GE3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210196
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 10:09:00AM -0500, Alan Stern wrote:
> On Tue, 20 Feb 2018, Paul E. McKenney wrote:
> 
> > From: Alan Stern <stern@rowland.harvard.edu>
> > 
> > This commit adds a litmus test in which P0() and P1() form a lock-based S
> > litmus test, with the addition of P2(), which observes P0()'s and P1()'s
> 
> Why do you call this an "S" litmus test?  Isn't ISA2 a better 
> description?

Indeed, the name of the test is in fact ISA2.

> > accesses with a full memory barrier but without the lock.  This litmus
> > test asks whether writes carried out by two different processes under the
> > same lock will be seen in order by a third process not holding that lock.
> > The answer to this question is "yes" for all architectures supporting
> > the Linux kernel, but is "no" according to the current version of LKMM.
> > 
> > A patch to LKMM is under development.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  .../ISA2+pooncelock+pooncelock+pombonce.litmus     | 41 ++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> 
> Aren't these tests supposed to be described in litmus-tests/README?
> 
> > diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> > new file mode 100644
> > index 000000000000..7a39a0aaa976
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> > @@ -0,0 +1,41 @@
> > +C ISA2+pooncelock+pooncelock+pombonce.litmus
> > +
> > +(*
> > + * Result: Sometimes
> > + *
> > + * This test shows that the ordering provided by a lock-protected S
> > + * litmus test (P0() and P1()) are not visible to external process P2().
> > + * This is likely to change soon.
> 
> That last line may be premature.  We haven't reached any consensus on 
> how RISC-V will handle this.  If RISC-V allows the test then the memory 
> model can't forbid it.

Agreed.  How about this?  If the RISC-V question is answered by the
end of next week, I update accordingly.  If not, I update the comment
to give the details.

Hey, at least having the memory model go in at about the same time as
a new architecture is giving us good practice!  ;-)

							Thanx, Paul

> Alan
> 
> > + *)
> > +
> > +{}
> > +
> > +P0(int *x, int *y, spinlock_t *mylock)
> > +{
> > +	spin_lock(mylock);
> > +	WRITE_ONCE(*x, 1);
> > +	WRITE_ONCE(*y, 1);
> > +	spin_unlock(mylock);
> > +}
> > +
> > +P1(int *y, int *z, spinlock_t *mylock)
> > +{
> > +	int r0;
> > +
> > +	spin_lock(mylock);
> > +	r0 = READ_ONCE(*y);
> > +	WRITE_ONCE(*z, 1);
> > +	spin_unlock(mylock);
> > +}
> > +
> > +P2(int *x, int *z)
> > +{
> > +	int r1;
> > +	int r2;
> > +
> > +	r2 = READ_ONCE(*z);
> > +	smp_mb();
> > +	r1 = READ_ONCE(*x);
> > +}
> > +
> > +exists (1:r0=1 /\ 2:r2=1 /\ 2:r1=0)
> > 
> 
> 
