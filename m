Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0029C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A797121904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbfBMTRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:17:10 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:50991 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbfBMTRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:17:09 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id AC1E1B8719
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 19:17:07 +0000 (GMT)
Received: (qmail 3371 invoked from network); 13 Feb 2019 19:17:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Feb 2019 19:17:07 -0000
Date:   Wed, 13 Feb 2019 19:17:06 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
Subject: Re: [PATCH v0 1/2] perf: Add an option to ask for high order
 allocations for AUX buffers
Message-ID: <20190213191705.GV9565@techsingularity.net>
References: <20190213114716.63972-1-alexander.shishkin@linux.intel.com>
 <20190213114716.63972-2-alexander.shishkin@linux.intel.com>
 <20190213130755.GQ32494@hirez.programming.kicks-ass.net>
 <20190213174756.GU9565@techsingularity.net>
 <20190213175434.GA32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190213175434.GA32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 06:54:34PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 05:47:56PM +0000, Mel Gorman wrote:
> > If there is a tangiable performance benefit from using contiguous regions
> > then I would suggest optimistically allocating them with appropriate
> > GFP flags to avoid large latencies at startup time and fall back if
> > necessary. 
> 
> Right; the code does the fallback thing. It successively tries smaller
> order allocations until 0-order fails.
> 
> It currently uses:
> 
> #define PERF_AUX_GFP    (GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
> 
> Is that what you could consider appropriate?

Yeah, spot on. Conceivably the semantics of __GFP_NORETY will change a
little at some point in the next year but not in any way I'd consider
harmful (depends on how THP and locality discussions go). Even *if*
we did something harmful, there will be complaints before it's problematic.

-- 
Mel Gorman
SUSE Labs
