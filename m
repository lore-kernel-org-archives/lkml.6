Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56290C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B16320C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B16320C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbeGKQOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:14:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732433AbeGKQOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:14:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BG8l0U175684
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:09:42 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k5mcwj7e3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:09:42 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 12:09:41 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 12:09:37 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BG9bb27209414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 16:09:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5B97B2064;
        Wed, 11 Jul 2018 12:09:35 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B44EBB205F;
        Wed, 11 Jul 2018 12:09:35 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 12:09:35 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7443E16C3B68; Wed, 11 Jul 2018 09:11:55 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:11:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] doc: Replace smp_cond_acquire() with
 smp_cond_load_acquire()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1531216943-6382-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1531314530-11624-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180711153840.GS3593@linux.vnet.ibm.com>
 <20180711154830.GA14348@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711154830.GA14348@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071116-0040-0000-0000-0000044D3547
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009351; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059848; UDB=6.00543977; IPR=6.00837769;
 MB=3.00022105; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 16:09:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071116-0041-0000-0000-000008535AAB
Message-Id: <20180711161155.GU3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=700 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 05:53:55PM +0200, Andrea Parri wrote:
> On Wed, Jul 11, 2018 at 08:38:40AM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 11, 2018 at 03:08:50PM +0200, Andrea Parri wrote:
> > > Amend commit 1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire()
> > > with smp_cond_load_acquire()") by updating the documentation accordingly.
> > > Also remove some obsolete information related to the implementation.
> > > 
> > > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Nicholas Piggin <npiggin@gmail.com>
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > > Cc: Luc Maranget <luc.maranget@inria.fr>
> > > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > > Cc: Akira Yokosawa <akiyks@gmail.com>
> > > Cc: Daniel Lustig <dlustig@nvidia.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > ---
> > >  Documentation/memory-barriers.txt | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > I have queued this for further review, thank you!  Just to confirm,
> > the reason that the old passage was obsolete is because ARMv8 implements
> > smp_cond_load_acquire() as a straight acquire load, correct?
> 
> Thanks.  Yes; the generic code builds on a control dependency and an
> smp_acquire__after_ctrl_dep() (which defaults to smp_rmb()); but the
> required ordering on arm64 is given by (its) smp_load_acquire().
> 
> I thought that entering this level of details (and keeping it up-to-
> date ;) wasn't really worth/needed for this high-level doc.

Agreed!

							Thanx, Paul

>   Andrea
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > > index 0d8d7ef131e9a..c1d913944ad8b 100644
> > > --- a/Documentation/memory-barriers.txt
> > > +++ b/Documentation/memory-barriers.txt
> > > @@ -471,8 +471,7 @@ And a couple of implicit varieties:
> > >       operations after the ACQUIRE operation will appear to happen after the
> > >       ACQUIRE operation with respect to the other components of the system.
> > >       ACQUIRE operations include LOCK operations and both smp_load_acquire()
> > > -     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
> > > -     semantics from relying on a control dependency and smp_rmb().
> > > +     and smp_cond_load_acquire() operations.
> > > 
> > >       Memory operations that occur before an ACQUIRE operation may appear to
> > >       happen after it completes.
> > > -- 
> > > 2.7.4
> > > 
> > 
> 

