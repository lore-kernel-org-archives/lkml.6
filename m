Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D76AECDFB4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9525A208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9525A208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeGPCyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 22:54:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbeGPCyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 22:54:05 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G2SZqp086485
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 22:28:59 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8hcgj31h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 22:28:58 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 15 Jul 2018 22:28:57 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 15 Jul 2018 22:28:53 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G2Sqla6029678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 02:28:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E7DBB2064;
        Sun, 15 Jul 2018 22:28:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CB3FB205F;
        Sun, 15 Jul 2018 22:28:46 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.190.250])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 15 Jul 2018 22:28:46 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5E18016C28AD; Sun, 15 Jul 2018 19:31:16 -0700 (PDT)
Date:   Sun, 15 Jul 2018 19:31:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180713190638.GA4269@andrea>
 <Pine.LNX.4.44L0.1807132133330.26947-100000@netrider.rowland.org>
 <CA+55aFwKpkU5C23OYt1HCiD3X5bJHVh1jz5G2dSnF1+kVrOCTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwKpkU5C23OYt1HCiD3X5bJHVh1jz5G2dSnF1+kVrOCTA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071602-0068-0000-0000-00000318AB57
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009371; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01061556; UDB=6.00545000; IPR=6.00839473;
 MB=3.00022156; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-16 02:28:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071602-0069-0000-0000-0000450B96A7
Message-Id: <20180716023116.GA6216@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=752 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 07:58:25PM -0700, Linus Torvalds wrote:
> On Fri, Jul 13, 2018 at 6:51 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > The point being that the scenarios under discussion in this thread all
> > fall most definitely into the "Non-standard usage; you'd better know
> > exactly what you're doing" category.
> 
> Well, yes and no.
> 
> The thing is, people expected unlock+lock to give a memory ordering.
> It happened in RCU, and it's happened before elsewhere.

True enough.  I have grown quite used to the current unlock+lock ordering,
but yes, it did come as a bit of a surprise when I first came across it
some years back.  And it took quite a bit of digging to work out what
was going on.  My hope is of course that whatever the eventual choice,
having the memory model in place will make it easier for developers down
the line.

> So it *is* the "pure locking" thing that ends up confusing people.
> Yes, you have some other access that then cares about the memory
> ordering, but this is a fairly natural expectation to have
> (considering that we've had the same issue before).

That said, I was doing (and am still doing) some pretty unusual things
with RCU.  It requires every access from any CPU before any given grace
period to be ordered before any access from any CPU after that same
grace period.  That sort of requirement has been rare enough that the
smp_mb__after_unlock_lock() macro RCU uses is defined locally within RCU,
and is currently used only by RCU.

But as always, your kernel, your choice!

							Thanx, Paul

