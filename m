Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDSAF3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 20:05:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752291AbeDSAF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 20:05:28 -0400
Date: Wed, 18 Apr 2018 17:06:30 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC tools/memory-model 2/5] tools/memory-model: Add
 litmus test for multicopy atomicity
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180416162228.GA18167@linux.vnet.ibm.com>
 <1523895771-19224-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180418094033.GA3409@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418094033.GA3409@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18041900-0024-0000-0000-0000034ACD70
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008879; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019919; UDB=6.00520363; IPR=6.00799160;
 MB=3.00020650; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-19 00:05:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041900-0025-0000-0000-000047B7A223
Message-Id: <20180419000630.GX26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180213
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 11:40:33AM +0200, Andrea Parri wrote:
> On Mon, Apr 16, 2018 at 09:22:48AM -0700, Paul E. McKenney wrote:
> > This commit adds a litmus test suggested by Alan Stern that is forbidden
> > on multicopy atomic systems, but allowed on non-multicopy atomic systems.
> > Note that other-multicopy atomic systems are examples of non-multicopy
> > atomic systems.
> > 
> > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  .../litmus-tests/SB+poonceoncescoh.litmus          | 31 ++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
> 
> We seem to be missing an entry in litmus-tests/README...

We are, and I will add one once ...

> > diff --git a/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
> > new file mode 100644
> > index 000000000000..991a2d6dec63
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
> > @@ -0,0 +1,31 @@
> > +C SB+poonceoncescoh
> > +
> > +(*
> > + * Result: Sometimes
> > + *
> > + * This litmus test demonstrates that LKMM is not multicopy atomic.
> > + *)
> > +
> > +{}
> > +
> > +P0(int *x, int *y)
> > +{
> > +	int r1;
> > +	int r2;
> > +
> > +	WRITE_ONCE(*x, 1);
> > +	r1 = READ_ONCE(*x);
> > +	r2 = READ_ONCE(*y);
> > +}
> > +
> > +P1(int *x, int *y)
> > +{
> > +	int r3;
> > +	int r4;
> > +
> > +	WRITE_ONCE(*y, 1);
> > +	r3 = READ_ONCE(*y);
> > +	r4 = READ_ONCE(*x);
> > +}
> > +
> > +exists (0:r2=0 /\ 1:r4=0 /\ 0:r1=1 /\ 1:r3=1)
> 
> This test has a normalised name:  why don't use that?

... we come to agreement on the documentation on how to produce a
normalized name given a standard litmus test.

Ditto for the tests whose names include the string "silsil", but
those involve locking so might be considered lower priority.

							Thanx, Paul
