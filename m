Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6913EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37838206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37838206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405953AbeKWDCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:02:35 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:57810 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405481AbeKWDCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:02:35 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id BB970B8C39
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 16:22:29 +0000 (GMT)
Received: (qmail 31940 invoked from network); 22 Nov 2018 16:22:29 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.69])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Nov 2018 16:22:29 -0000
Date:   Thu, 22 Nov 2018 16:22:28 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] mm: Reclaim small amounts of memory when an external
 fragmentation event occurs
Message-ID: <20181122162228.GL23260@techsingularity.net>
References: <20181121101414.21301-1-mgorman@techsingularity.net>
 <20181121101414.21301-4-mgorman@techsingularity.net>
 <cc8ec820-1526-d753-4619-dedaa227a179@suse.cz>
 <20181122150446.GK23260@techsingularity.net>
 <c65bf59a-1134-0fc8-5718-dbd6752fa851@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <c65bf59a-1134-0fc8-5718-dbd6752fa851@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 04:35:58PM +0100, Vlastimil Babka wrote:
> >> I think I don't understand this comment :( Do you want to avoid waking
> >> up kswapd from steal_suitable_fallback() (introduced above) for
> >> allocations without __GFP_KSWAPD_RECLAIM? But returning 0 here means
> >> actually allowing the allocation go through steal_suitable_fallback()?
> >> So should it return ALLOC_NOFRAGMENT below, or was the intent different?
> >>
> > 
> > I want to avoid waking kswapd in steal_suitable_fallback if waking
> > kswapd is not allowed.
> 
> OK, but then this 'if' should return ALLOC_NOFRAGMENT, not 0?
> But that will still not prevent waking kswapd for nodes where there's no
> ZONE_DMA32, or any node when get_page_from_freelist() retries without
> fallback.
> 
> > If the calling context does not allow it, it does
> > mean that fragmentation will be allowed to occur. I'm banking on it
> > being a relatively rare case but potentially it'll be problematic. The
> > main source of allocation requests that I expect to hit this are THP and
> > as they are already at pageblock_order, it has limited impact from a
> > fragmentation perspective -- particularly as pageblock_order stealing is
> > allowed even with ALLOC_NOFRAGMENT.
> 
> Yep, THP will skip the wakeup in steal_suitable_fallback() via 'goto
> single_page' above it. For other users of ~__GFP_KSWAPD_RECLAIM (are
> there any?) we could maybe just ignore and wakeup kswapd anyway, since
> avoiding fragmentation is more important? Or if we wanted to avoid
> wakeup reliably, then steal_suitable_fallback() would have to know and
> check gfp_flags I'm afraid, and that doesn't seem worth the trouble.

Indeed. While it works in some cases, it'll be full of holes and while
I could close them, it just turns into a subtle mess. I've prepared a
preparation path that encodes __GFP_KSWAPD_RECLAIM in alloc_flags and checks
based on that.  It's a lot cleaner overall, it's less of a mess than passing
gfp_flags all the way through for one test and there are fewer side-effects.

Thanks!

-- 
Mel Gorman
SUSE Labs
