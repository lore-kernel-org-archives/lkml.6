Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C0EECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5CD2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5CD2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeGMEOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 00:14:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725822AbeGMEOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 00:14:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6D3wUu5101156
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:01:25 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k6gq9qa7r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:01:25 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 13 Jul 2018 00:01:24 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Jul 2018 00:01:20 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6D41Jve7340494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Jul 2018 04:01:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC66FB2064;
        Fri, 13 Jul 2018 00:01:16 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D34B7B2067;
        Fri, 13 Jul 2018 00:01:16 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.159.34])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jul 2018 00:01:16 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A034016CA298; Thu, 12 Jul 2018 21:03:39 -0700 (PDT)
Date:   Thu, 12 Jul 2018 21:03:39 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Daniel Lustig <dlustig@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
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
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com>
 <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071304-0064-0000-0000-00000329B803
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009360; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01060566; UDB=6.00544407; IPR=6.00838484;
 MB=3.00022125; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-13 04:01:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071304-0065-0000-0000-000039EBF782
Message-Id: <20180713040339.GR12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=942 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807130009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 07:05:39PM -0700, Daniel Lustig wrote:
> On 7/12/2018 11:10 AM, Linus Torvalds wrote:
> > On Thu, Jul 12, 2018 at 11:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> The locking pattern is fairly simple and shows where RCpc comes apart
> >> from expectation real nice.
> > 
> > So who does RCpc right now for the unlock-lock sequence? Somebody
> > mentioned powerpc. Anybody else?
> > 
> > How nasty would be be to make powerpc conform? I will always advocate
> > tighter locking and ordering rules over looser ones..
> > 
> >             Linus
> 
> RISC-V probably would have been RCpc if we weren't having this discussion.
> Depending on how we map atomics/acquire/release/unlock/lock, we can end up
> producing RCpc, "RCtso" (feel free to find a better name here...), or RCsc
> behaviors, and we're trying to figure out which we actually need.
> 
> I think the debate is this:
> 
> Obviously programmers would prefer just to have RCsc and not have to figure out
> all the complexity of the other options.  On x86 or architectures with native
> RCsc operations (like ARMv8), that's generally easy enough to get.
> 
> For weakly-ordered architectures that use fences for ordering (including
> PowerPC and sometimes RISC-V, see below), though, it takes extra fences to go
> from RCpc to either "RCtso" or RCsc.  People using these architectures are
> concerned about whether there's a negative performance impact from those extra
> fences.
> 
> However, some scheduler code, some RCU code, and probably some other examples
> already implicitly or explicitly assume unlock()/lock() provides stronger
> ordering than RCpc.

Just to be clear, the RCU code uses smp_mb__after_unlock_lock() to get
the ordering that it needs out of spinlocks.  Maybe that is what you
meant by "explicitly assume", but I figured I should clarify.

							Thanx, Paul

