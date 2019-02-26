Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9BA217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfBZPEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:04:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbfBZPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:04:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QF0UVw031147
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:04:38 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qw6bb66ss-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:04:37 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Feb 2019 15:04:33 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 15:04:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QF4S1O14286850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 15:04:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32B5AB2068;
        Tue, 26 Feb 2019 15:04:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1278EB2065;
        Tue, 26 Feb 2019 15:04:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 15:04:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BEC1A16C3FCB; Tue, 26 Feb 2019 07:04:27 -0800 (PST)
Date:   Tue, 26 Feb 2019 07:04:27 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Reply-To: paulmck@linux.ibm.com
References: <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
 <b8cdca74-6f7d-cfe3-636c-41a59b0d86da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8cdca74-6f7d-cfe3-636c-41a59b0d86da@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19022615-0068-0000-0000-0000039A95F7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010668; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01166673; UDB=6.00609432; IPR=6.00947278;
 MB=3.00025748; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-26 15:04:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022615-0069-0000-0000-000047A2EDFA
Message-Id: <20190226150427.GM4072@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:56:57PM +0900, Akira Yokosawa wrote:
> Hi Paul,
> 
> On Tue, 26 Feb 2019 06:28:45 -0800, Paul E. McKenney wrote:
> > On Tue, Feb 26, 2019 at 02:49:06PM +0100, Peter Zijlstra wrote:
> >> On Tue, Feb 26, 2019 at 12:38:13PM +0100, Borislav Petkov wrote:
> >>> On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
> >>>> When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
> >>>> still broken.
> >>>
> >>> As requested on IRC:
> >>
> >> What I asked was if you could get your GCC developer friends to have a
> >> look at this :-)
> > 
> > Yes, this all is a bit on the insane side from a kernel viewpoint.
> > But the paper you found does not impose this; it has instead been there
> > for about 20 years, back before C and C++ admitted to the existence
> > of concurrency.
> 
> By "it", do you mean the concept of "pointer provenance"?
> 
> I'm asking because the paper's header reads:
> 
>         "ISO/IEC JTC1/SC22/WG14 N2311, 2018-11-09"
> 
> Just wanted to make sure.

This paper introduces neither pointer provenance nor indeterminate-on-free,
but rather proposes modification.  These things have been around for a
few decades.

							Thanx, Paul

>         Thanks, Akira
> 
> >                  But of course compilers are getting more aggressive,
> > and yes, some of the problems show up in single-threaded code.
> > 
> > The usual response is "then cast the pointers to intptr_t!" but of
> > course that breaks type checking.
> > 
> > There is an effort to claw back the concurrency pieces, and I would
> > be happy to run the resulting paper past you guys.
> > 
> > I must confess to not being all that sympathetic to code that takes
> > advantage of happenstance stack-frame layout.  Is there some reason
> > we need that?
> > 
> > 							Thanx, Paul
> > 
> 

