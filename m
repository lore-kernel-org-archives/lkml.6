Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8636C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C61206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393016AbfAPNMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:12:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392952AbfAPNL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:11:59 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GD9JHW085449
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:11:57 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q23ekd8tm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:11:57 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 13:11:56 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 13:11:51 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GDBojr21954598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 13:11:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68292B206A;
        Wed, 16 Jan 2019 13:11:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46D1DB205F;
        Wed, 16 Jan 2019 13:11:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.203.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 13:11:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6238E16C618A; Wed, 16 Jan 2019 05:11:50 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:11:50 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
Reply-To: paulmck@linux.ibm.com
References: <20190115142545.GA9255@andrea>
 <Pine.LNX.4.44L0.1901151003470.1408-100000@iolanthe.rowland.org>
 <20190116115752.GB10803@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116115752.GB10803@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011613-0060-0000-0000-000002FA6673
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010417; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01147300; UDB=6.00597622; IPR=6.00927595;
 MB=3.00025155; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-16 13:11:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-0061-0000-0000-000047F1D072
Message-Id: <20190116131150.GH1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:57:52PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 15, 2019 at 10:19:10AM -0500, Alan Stern wrote:
> > On Tue, 15 Jan 2019, Andrea Parri wrote:
> > 
> > > Unless I'm mis-reading/-applying this definition, this will flag the
> > > following test (a variation on your "race.litmus") with "data-race":
> > > 
> > > C no-race
> > > 
> > > {}
> > > 
> > > P0(int *x, spinlock_t *s)
> > > {
> > > 	spin_lock(s);
> > >         WRITE_ONCE(*x, 1);	/* A */
> > > 	spin_unlock(s);	/* B */
> > > }
> > > 
> > > P1(int *x, spinlock_t *s)
> > > {
> > >         int r1;
> > > 
> > > 	spin_lock(s); /* C */
> > >         r1 = *x;	/* D */
> > > 	spin_unlock(s);
> > > }
> > > 
> > > exists (1:r1=1)
> > > 
> > > Broadly speaking, this is due to the fact that the modified "happens-
> > > before" axiom does not forbid the execution with the (MP-) cycle
> > > 
> > > 	A ->po-rel B ->rfe C ->acq-po D ->fre A
> > > 
> > > and then to the link "D ->race-from-r A" here defined.
> > 
> > Yes, that cycle certainly should be forbidden.  On the other hand, we
> > don't want to insist that C happens before D, given that D may not
> > happen at all.
> > 
> > This is a real problem.  Can we solve it by adding a modified
> > "happens-before" which says essentially that _if_ D is preserved _then_
> > C happens before D?  But then what about cycles involving more than one
> > possibly preserved access?  Or maybe a relation which says that D
> > cannot execute before C (so if D executes at all, it has to come after
> > C)?
> 
> The latter; there is a compiler barrier implied at the end of
> spin_lock() such that anything later (in PO) must indeed be later.
> 
> > Now you see why this stuff is so difficult...  At the moment, I don't
> > know how to fix this.

In the spirit of cutting the Gordian Knot...

Given that we are flagging data races, how much do we really lose by
simply ignoring the possibility of removed accesses?

							Thanx, Paul

