Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDLVRj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:17:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750797AbeDLVRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:17:37 -0400
Date: Thu, 12 Apr 2018 14:18:36 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] memory-model: fix cheat sheet typo
Reply-To: paulmck@linux.vnet.ibm.com
References: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
 <20180409184258.GP3948@linux.vnet.ibm.com>
 <20180410203214.GA19606@linux.vnet.ibm.com>
 <8cbda122-6aa3-365b-fd09-52dca0644cbd@redhat.com>
 <20180410213434.GC3948@linux.vnet.ibm.com>
 <156ac07b-7393-449f-518a-6b1c2cff8efb@redhat.com>
 <20180412092303.GA6044@andrea>
 <eda463d8-aa4e-2e6b-9d1d-41a5a4eaa3a7@redhat.com>
 <20180412112155.GA9154@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412112155.GA9154@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18041221-0024-0000-0000-000003461B4C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008844; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01016987; UDB=6.00518662; IPR=6.00796224;
 MB=3.00020545; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-12 21:17:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041221-0025-0000-0000-000047A49509
Message-Id: <20180412211836.GG3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804120202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 01:21:55PM +0200, Andrea Parri wrote:
> On Thu, Apr 12, 2018 at 12:18:13PM +0200, Paolo Bonzini wrote:
> > On 12/04/2018 11:23, Andrea Parri wrote:
> > >>
> > >> - smp_store_mb() is missing
> > > 
> > > Good point. In fact, we could add this to the model as well:
> > > following Peter's remark/the generic implementation,
> > 
> > Good idea.  smp_store_mb() can save some clock cycles in the relatively
> > common idiom
> > 
> > 	write a				write b
> > 	read b				read a
> > 	if (b)				if (a)
> > 	  wake 'em			  we've been woken
> > 
> > > Yeah, those 'Ordering is cumulative', 'Ordering propagates' could
> > > mean different things to different readers... IMO, we may even omit
> > > such information; this doc. does not certainly aim for completeness,
> > > after all. OTOH, we ought to refrain from making this doc. an excuse
> > > to transform (what it is really) high-school maths into some black
> > > magic.
> > FWIW, what I miss in explanation.txt (and to some extent in the paper)
> > is a clear pointer to litmus tests that rely on cumulativity and
> > propagation.  In the meanwhile I'll send some patches.  Thanks for the
> > feedback, as it also helps validating my understanding of the model.
> 
> The litmus test that first comes to my mind when I think of cumulativity
> (at least, 'cumulativity' as intended in LKMM) is:
> 
>    WRC+pooncerelease+rmbonceonce+Once.litmus

Removing the "cumul-fence* ;" from "let prop" does cause this test to be
allowed, so looks plausible.

> for 'propagation', I could mention:
> 
>    IRIW+mbonceonces+OnceOnce.litmus

And removing the "acyclic pb as propagation" causes this one to be allowed,
so again plausible.

> (both tests are availabe in tools/memory-model/litmus-tests/). It would
> be a nice to mention these properties in the test descriptions, indeed.

Please see below.

							Thanx, Paul

> You might find it useful to also visualize the 'valid' executions (with
> the main events/relations) associated to each of these tests; for this,
> 
>    $ herd7 -conf linux-kernel.cfg litmus-tests/your-test.litmus \
> 	-show all -gv
> 
> (assuming you have 'gv' installed).

------------------------------------------------------------------------

commit 494f11d10dd7d86e4a381cbe79e77f04cb0cee04
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Thu Apr 12 14:15:57 2018 -0700

    EXP tools/memory-model: Flag "cumulativity" and "propagation" tests
    
    This commit flags WRC+pooncerelease+rmbonceonce+Once.litmus as being
    forbidden by LKMM cumulativity and IRIW+mbonceonces+OnceOnce.litmus as
    being forbidden by LKMM propagation.
    
    Suggested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
index 50d5db9ea983..98a3716efa37 100644
--- a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
@@ -7,7 +7,7 @@ C IRIW+mbonceonces+OnceOnce
  * between each pairs of reads.  In other words, is smp_mb() sufficient to
  * cause two different reading processes to agree on the order of a pair
  * of writes, where each write is to a different variable by a different
- * process?
+ * process?  This litmus test exercises LKMM's "propagation" rule.
  *)
 
 {}
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 6919909bbd0f..178941d2a51a 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -23,7 +23,8 @@ IRIW+mbonceonces+OnceOnce.litmus
 	between each pairs of reads.  In other words, is smp_mb()
 	sufficient to cause two different reading processes to agree on
 	the order of a pair of writes, where each write is to a different
-	variable by a different process?
+	variable by a different process?  This litmus test is an example
+	that is forbidden by LKMM propagation.
 
 IRIW+poonceonces+OnceOnce.litmus
 	Test of independent reads from independent writes with nothing
@@ -121,6 +122,7 @@ WRC+poonceonces+Once.litmus
 WRC+pooncerelease+rmbonceonce+Once.litmus
 	These two are members of an extension of the MP litmus-test class
 	in which the first write is moved to a separate process.
+	The second is an example that is forbidden by LKMM cumulativity.
 
 Z6.0+pooncelock+pooncelock+pombonce.litmus
 	Is the ordering provided by a spin_unlock() and a subsequent
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
index 97fcbffde9a0..5bda4784eb34 100644
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
@@ -5,7 +5,8 @@ C WRC+pooncerelease+rmbonceonce+Once
  *
  * This litmus test is an extension of the message-passing pattern, where
  * the first write is moved to a separate process.  Because it features
- * a release and a read memory barrier, it should be forbidden.
+ * a release and a read memory barrier, it should be forbidden.  This
+ * litmus test exercises LKMM cumulativity.
  *)
 
 {}
