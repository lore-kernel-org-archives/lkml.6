Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAF6C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269CC20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfARSx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:53:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728695AbfARSx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:53:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0IImpA4091453
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:53:55 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q3hm37gmq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:53:55 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 18 Jan 2019 18:53:54 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Jan 2019 18:53:50 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0IIrnWw19792012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 18:53:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8927CB205F;
        Fri, 18 Jan 2019 18:53:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43F5EB2066;
        Fri, 18 Jan 2019 18:53:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.140.225])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jan 2019 18:53:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 54FD216C35B9; Fri, 18 Jan 2019 10:53:48 -0800 (PST)
Date:   Fri, 18 Jan 2019 10:53:48 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
Reply-To: paulmck@linux.ibm.com
References: <20190116213658.GA3984@andrea>
 <Pine.LNX.4.44L0.1901171121360.1207-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901171121360.1207-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011818-0072-0000-0000-000003EC236E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010431; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01148364; UDB=6.00598266; IPR=6.00928667;
 MB=3.00025190; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-18 18:53:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011818-0073-0000-0000-00004ADBD95E
Message-Id: <20190118185348.GE4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=689 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901180135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 02:43:54PM -0500, Alan Stern wrote:
> On Wed, 16 Jan 2019, Andrea Parri wrote:
> 
> > Can the compiler (maybe, it does?) transform, at the C or at the "asm"
> > level, LB1's P0 in LB2's P0 (LB1 and LB2 are reported below)?
> > 
> > C LB1
> > 
> > {
> > 	int *x = &a;
> > }
> > 
> > P0(int **x, int *y)
> > {
> > 	int *r0;
> > 
> > 	r0 = rcu_dereference(*x);
> > 	*r0 = 0;
> > 	smp_wmb();
> > 	WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int **x, int *y, int *b)
> > {
> > 	int r0;
> > 
> > 	r0 = READ_ONCE(*y);
> > 	rcu_assign_pointer(*x, b);
> > }
> > 
> > exists (0:r0=b /\ 1:r0=1)
> > 
> > 
> > C LB2
> > 
> > {
> > 	int *x = &a;
> > }
> > 
> > P0(int **x, int *y)
> > {
> > 	int *r0;
> > 
> > 	r0 = rcu_dereference(*x);
> > 	if (*r0)
> > 		*r0 = 0;
> > 	smp_wmb();
> > 	WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int **x, int *y, int *b)
> > {
> > 	int r0;
> > 
> > 	r0 = READ_ONCE(*y);
> > 	rcu_assign_pointer(*x, b);
> > }
> > 
> > exists (0:r0=b /\ 1:r0=1)
> > 
> > LB1 and LB2 are data-race free, according to the patch; LB1's "exists"
> > clause is not satisfiable, while LB2's "exists" clause is satisfiable.
> 
> Umm.  Transforming
> 
> 	*r0 = 0;
> 
> to
> 
> 	if (*r0 != 0)
> 		*r0 = 0;
> 
> wouldn't work on Alpha if r0 was assigned from a plain read with no
> memory barrier between.  But when r0 is assigned from an
> rcu_dereference call, or if there's no indirection (as in "if (a != 0)
> a = 0;"), the compiler is indeed allowed to perform this
> transformation.
> 
> This means my definition of preserved writes was wrong; a write we 
> thought had to be preserved could instead be transformed into a read.
> 
> This objection throws a serious monkey wrench into my approach.  For
> one thing, it implies that (as in the example) we can't expect
> smp_wmb() always to order plain writes.  For another, it means we have
> to assume a lot more writes need not be preserved.
> 
> I don't know.  This may doom the effort to formalize dependencies to
> plain accesses.  Or at least, those other than address dependencies
> from marked reads.

(Catching up, hello from Auckland!)

At this point, I am very much in favor of taking the simpler starting
point.  If someone is using any sort of dependency from a plain access,
all bets are off.  Similarly, if someone is using a control or data
dependency even from a marked access, the later dependent access must
be marked to guarantee ordering.

I believe that the transformation from "*r0 = 0" should be convincing.  ;-)

							Thanx, Paul

