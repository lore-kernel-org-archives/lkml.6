Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1067FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB2C20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfAIRLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:11:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbfAIRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:11:01 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09H90l9196275
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 12:10:59 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwjvsfcw8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 12:10:59 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 17:10:58 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 17:10:55 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09HAsfh22413490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 17:10:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56E24B2065;
        Wed,  9 Jan 2019 17:10:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3046DB205F;
        Wed,  9 Jan 2019 17:10:54 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 17:10:54 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CB32F16C6335; Wed,  9 Jan 2019 09:10:53 -0800 (PST)
Date:   Wed, 9 Jan 2019 09:10:53 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Luc Maranget <luc.maranget@inria.fr>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: seqcount usage in xt_replace_table()
Reply-To: paulmck@linux.ibm.com
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190109000214.GA5907@andrea>
 <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
 <20190109112432.GA6351@andrea>
 <CACT4Y+YAr1XuwAy1qRL678VHZjzsbAQ05o1zoN9ZfC0muYzK8g@mail.gmail.com>
 <20190109121126.GA7141@andrea>
 <CACT4Y+azpzvjmUTdWj6H4qe4mELx924pGrY_VFZD9Hi+4VMj5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+azpzvjmUTdWj6H4qe4mELx924pGrY_VFZD9Hi+4VMj5g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010917-0052-0000-0000-0000037598BC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010373; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144059; UDB=6.00595657; IPR=6.00924321;
 MB=3.00025052; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 17:10:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010917-0053-0000-0000-00005F66F989
Message-Id: <20190109171053.GY1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:29:02PM +0100, Dmitry Vyukov wrote:
> On Wed, Jan 9, 2019 at 1:11 PM Andrea Parri
> <andrea.parri@amarulasolutions.com> wrote:
> >
> > On Wed, Jan 09, 2019 at 12:55:27PM +0100, Dmitry Vyukov wrote:
> > > On Wed, Jan 9, 2019 at 12:24 PM Andrea Parri
> > > <andrea.parri@amarulasolutions.com> wrote:
> > > >
> > > > On Tue, Jan 08, 2019 at 04:36:46PM -0800, Anatol Pomozov wrote:
> > > > > Hello
> > > > >
> > > > > On Tue, Jan 8, 2019 at 4:02 PM Andrea Parri
> > > > > <andrea.parri@amarulasolutions.com> wrote:
> > > > > >
> > > > > > Hi Anatol,
> > > > > >
> > > > > > On Tue, Jan 08, 2019 at 11:33:39AM -0800, Anatol Pomozov wrote:
> > > > > > > Hello folks,
> > > > > > >
> > > > > > > A bit of context what I am doing. I am trying to port KTSAN (Kernel
> > > > > > > Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
> > > > > > > and makes sure it is accessed in a thread-safe manner.
> > > > > >
> > > > > > Interesting!  FYI, some LKMM's maintainers (Paul included) had and
> > > > > > continued to have some "fun" discussing topics related to "thread-
> > > > > > safe memory accesses": I'm sure that they'll be very interested in
> > > > > > such work of yours and eager to discuss your results.
> > > > >
> > > > > Thread Sanitizer is a great tool to find thread-safety issues with
> > > > > user-space code. The tool been developed by a team of smart people
> > > > > from Google [1].
> > > > >
> > > > > KTSAN is an attempt to bring the same ideas to Linux kernel [2]. A
> > > > > bunch of work been done there but the project is still at
> > > > > proof-of-concept point.
> > > >
> > > > Yes, I have been aware of these tools since at least  ;-)
> > > >
> > > >   https://groups.google.com/forum/#!msg/ktsan/bVZ1c6H2NE0/Dxrw55bfBAAJ
> > > >
> > > >
> > > > >
> > > > > I am not a part of Google's dynamic tools team. But I've decided to
> > > > > pick something to do during the New Year holidays so started porting
> > > > > KTSAN from v4.2 to v4.20. The work is "almost completed" but I need to
> > > > > fix a few crashes [3].
> > > >
> > > > I guess my first reaction would remain
> > > >
> > > >   "it's kind of hard (to use an euphemism) to review 7,582 additions
> > > >   or so for a data race detector without a clear/an accepted (by the
> > > >   community) notion of data race..."
> > >
> > > Tsan's notion of a data race is basically the C/C++'s notion:
> > > concurrent/unsynchronized non-atomic access in different threads at
> > > least one of which is a write.
> >
> > Yeah, I think that this notion needs to be detailed, discussed,
> > documented, and discussed again. ;-)
> >
> >
> > > Tremendous (for such a project) benefits of automatic data race
> > > detection is a good motivation to finally agree on and accept a
> > > practically useful notion of a data race.
> >
> > Agreed.
> 
> While having a 100% formal definition of a data race upfront would be
> useful, I don't think this is a hard requirement for deployment of
> KTSAN. What I think is required is:
> 1. Agree that the overall direction is right.
> 2. Agree that we want to enable data race detection and resolve
> problems as they appear in a practical manner (rather than block whole
> effort on every small thing).
> We deployed TSAN in user-space in much larger code bases than kernel,
> and while we had the C/C++ formal definition of a data race, practical
> and legacy matters were similar to that of the kernel (lots of legacy
> code, different opinions, etc). Doing both things in tandem (defining
> a memory model and deploying a data race detector) can actually have
> benefits as a race detector may point to under-defined or
> impractically defined areas, and will otherwise help to validate that
> the model works and is useful.
> KTSAN is not fixed as well. We adopted it as we gathered more
> knowledge and understanding of the kernel. So it's not that we have to
> commit to something upfront.

In any case, there might well be some differences in approach between
KTSAN and LKMM due to input size differences:  One would expect LKMM
to be able to tolerate a more computationally intensive definition as
a consequence of KTSAN's ability to process much larger code bases.

But I nevertheless believe that it would be good to have these differences
be a matter of conscious choice rather than a matter of chance.  ;-)

My guess is that LKMM picks its starting point (which might take some
additional time), then KTSAN critiques it, and then we work out what
differences should result in a change to one or the other (or both)
and which differences are inherent in the different workloads that LKMM
and KTSAN are presented with.

Seem reasonable?

							Thanx, Paul

