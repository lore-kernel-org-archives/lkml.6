Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AE7C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB4920854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB4920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeILP4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:56:16 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:44537 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727047AbeILP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:56:16 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id BE3861C25AA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:52:13 +0100 (IST)
Received: (qmail 11735 invoked from network); 12 Sep 2018 10:52:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Sep 2018 10:52:13 -0000
Date:   Wed, 12 Sep 2018 11:52:12 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Do not move imbalanced load purely on
 the basis of an idle CPU
Message-ID: <20180912105211.GI1719@techsingularity.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907101139.20760-5-mgorman@techsingularity.net>
 <20180907113309.GU24106@hirez.programming.kicks-ass.net>
 <20180907123739.GE1719@techsingularity.net>
 <20180910094147.GH1719@techsingularity.net>
 <20180912065410.GA5352@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180912065410.GA5352@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 12:24:10PM +0530, Srikar Dronamraju wrote:
> > > > Srikar's patch here:
> > > > 
> > > >   http://lkml.kernel.org/r/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> > > > 
> > > > Also frobs this condition, but in a less radical way. Does that yield
> > > > similar results?
> > > 
> > > I can check. I do wonder of course if the less radical approach just means
> > > that automatic NUMA balancing and the load balancer simply disagree about
> > > placement at a different time. It'll take a few days to have an answer as
> > > the battery of workloads to check this take ages.
> > > 
> > 
> > Tests completed over the weekend and I've found that the performance of
> > both patches are very similar for two machines (both 2 socket) running a
> > variety of workloads. Hence, I'm not worried about which patch gets picked
> > up. However, I would prefer my own on the grounds that the additional
> > complexity does not appear to get us anything. Of course, that changes if
> > Srikar's tests on his larger ppc64 machines show the more complex approach
> > is justified.
> > 
> 
> Running SPECJbb2005. Higher bops are better.
> 
> Kernel A = 4.18+ 13 sched patches part of v4.19-rc1.
> Kernel B = Kernel A + 6 patches (http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com)
> Kernel C = Kernel B - (Avoid task migration for small numa improvement) i.e
> 	http://lore.kernel.org/lkml/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> 	+ 2 patches from Mel
> 	(Do not move imbalanced load purely)
> 	http://lore.kernel.org/lkml/20180907101139.20760-5-mgorman@techsingularity.net
> 	(Stop comparing tasks for NUMA placement)
> 	http://lore.kernel.org/lkml/20180907101139.20760-4-mgorman@techsingularity.net
> 

We ended up comparing different things. I started with 4.19-rc1 with
patches 1-3 from my series. I then compared my patch "Do not move
imbalanced load" with just yours so there was one point of variability.
You compared one patch of yours against two of mine so we ended up
looking at different things. That aside;

> 2 node x86 Haswell
> 
> v4.18 or 94710cac0ef4
> JVMS  Prev    Current  %Change
> 4     203769
> 1     316734
> 
> Kernel A
> JVMS  Prev    Current  %Change
> 4     203769  209790   2.95482
> 1     316734  312377   -1.3756
> 
> Kernel B
> JVMS  Prev    Current  %Change
> 4     209790  202059   -3.68511
> 1     312377  326987   4.67704
> 
> Kernel C
> JVMS  Prev    Current  %Change
> 4     202059  200681   -0.681979
> 1     326987  316715   -3.14141

Overall, this is actually not that promising. With Kernel B, we lose
almost as much as we gain depending on the thread count but the data
presented is very limited.

I can correlate though that the Haswll results make some sense. The
baseline here is my patch and it's comparing against yours

2 socket Haswell machine
1 JVM -- 1-3.5% gain -- http://www.skynet.ie/~mel/postings/numab-20180912/global-dhp__jvm-specjbb2005-single/marvin5/
2 JVM -- 1-6.3% gain -- http://www.skynet.ie/~mel/postings/numab-20180912/global-dhp__jvm-specjbb2005-multi/marvin5/

Results are similarly good for Broadwell. But it's not universal. It's
both good and bad with specjbb2015 depending on the CPU family. For
example, on Haswell with one JVM per load I see a 5% gain with your
patch and with Broadwell, I see an 8% loss.

For tbench, yours was a marginal loss, autonuma benchmark was a win on
one machine, a loss on another. hackbench showed both gains and losses.
All the results I had were marginal which is why I was not convinced the
complexity was justified.

Your ppc64 figures look a bit more convincing and while I'm disappointed
that you did not make a like-like comparison, I'm happy enough to go with
your version. I can re-evaluate "Stop comparing tasks for NUMA placement"
on its own later as well as the fast-migrate patches.

Thanks Srikar.

-- 
Mel Gorman
SUSE Labs
