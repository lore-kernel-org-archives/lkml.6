Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389A9C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A2F20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A2F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeILQBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:01:31 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:47093 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727644AbeILQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:01:31 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 02EC71C16A1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:57:29 +0100 (IST)
Received: (qmail 7540 invoked from network); 12 Sep 2018 10:57:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Sep 2018 10:57:28 -0000
Date:   Wed, 12 Sep 2018 11:57:27 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Do not move imbalanced load purely on
 the basis of an idle CPU
Message-ID: <20180912105727.GJ1719@techsingularity.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907101139.20760-5-mgorman@techsingularity.net>
 <20180907113309.GU24106@hirez.programming.kicks-ass.net>
 <20180907123739.GE1719@techsingularity.net>
 <20180910094147.GH1719@techsingularity.net>
 <20180912065410.GA5352@linux.vnet.ibm.com>
 <20180912095742.GA3333@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180912095742.GA3333@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 11:57:42AM +0200, Ingo Molnar wrote:
> > * Mel Gorman <mgorman@techsingularity.net> [2018-09-10 10:41:47]:
> > 
> > > On Fri, Sep 07, 2018 at 01:37:39PM +0100, Mel Gorman wrote:
> > > > > Srikar's patch here:
> > > > > 
> > > > >   http://lkml.kernel.org/r/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> > > > > 
> > > > > Also frobs this condition, but in a less radical way. Does that yield
> > > > > similar results?
> > > > 
> > > > I can check. I do wonder of course if the less radical approach just means
> > > > that automatic NUMA balancing and the load balancer simply disagree about
> > > > placement at a different time. It'll take a few days to have an answer as
> > > > the battery of workloads to check this take ages.
> > > > 
> > > 
> > > Tests completed over the weekend and I've found that the performance of
> > > both patches are very similar for two machines (both 2 socket) running a
> > > variety of workloads. Hence, I'm not worried about which patch gets picked
> > > up. However, I would prefer my own on the grounds that the additional
> > > complexity does not appear to get us anything. Of course, that changes if
> > > Srikar's tests on his larger ppc64 machines show the more complex approach
> > > is justified.
> > > 
> > 
> > Running SPECJbb2005. Higher bops are better.
> > 
> > Kernel A = 4.18+ 13 sched patches part of v4.19-rc1.
> > Kernel B = Kernel A + 6 patches (http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com)
> > Kernel C = Kernel B - (Avoid task migration for small numa improvement) i.e
> > 	http://lore.kernel.org/lkml/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> > 	+ 2 patches from Mel
> > 	(Do not move imbalanced load purely)
> > 	http://lore.kernel.org/lkml/20180907101139.20760-5-mgorman@techsingularity.net
> > 	(Stop comparing tasks for NUMA placement)
> > 	http://lore.kernel.org/lkml/20180907101139.20760-4-mgorman@techsingularity.net
> 
> We absolutely need the 'best' pre-regression baseline kernel measurements as well - was it 
> vanilla v4.17?
> 

That will hit a separate problem -- the scheduler patches that prefer
keeping new children local instead of spreading wide prematurely. The patch
in question favours communicating tasks (e.g. short-lived communicating
processes from shell scripts) but hurts loads that prefer spreading early
(e.g. STREAM). So while a comparison tells us something, it tells us
relatively little about this series in isolation.

The comparison with 4.17 is expected to be resolved by allowing data to
migrate faster if the load balancer spreads the load without wake-affine
disagreeing about placement. Patches for that exist but they were confirmed
to be working correctly on top of and old version of Srikar's series
based on 4.18. If we get get this series resolved, I can rebase the old
series and baring any major surprises, that should improve things
overall while mitigating the STREAM regression against 4.17.

-- 
Mel Gorman
SUSE Labs
