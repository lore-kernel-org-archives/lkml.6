Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E952133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E952133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbeK1Etz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:49:55 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:51889 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731845AbeK1Etz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:49:55 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 85146B8700
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 17:51:13 +0000 (GMT)
Received: (qmail 30526 invoked from network); 27 Nov 2018 17:51:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Nov 2018 17:51:13 -0000
Date:   Tue, 27 Nov 2018 17:51:11 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/5] mm: Stall movable allocations until kswapd
 progresses during serious external fragmentation event
Message-ID: <20181127175111.GT23260@techsingularity.net>
References: <20181123114528.28802-1-mgorman@techsingularity.net>
 <20181123114528.28802-6-mgorman@techsingularity.net>
 <e0867205-e5f1-b007-5dc7-bb4655f6e5c1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e0867205-e5f1-b007-5dc7-bb4655f6e5c1@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 02:20:30PM +0100, Vlastimil Babka wrote:
> > This patch has a marginal rate on fragmentation rates as it's rare for
> > the stall logic to actually trigger but the small stalls can be enough for
> > kswapd to catch up. How much that helps is variable but probably worthwhile
> > for long-term allocation success rates. It is possible to eliminate
> > fragmentation events entirely with tuning due to this patch although that
> > would require careful evaluation to determine if it's worthwhile.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> The gains here are relatively smaller and noisier than for the previous
> patches.

Indeed, in an earlier illogical version then it had a bigger impact but
that was due to buggy side-effects.

> Also I'm afraid that once antifrag loses against the ultimate
> adversary workload (see the "Caching/buffers become useless after some
> time" thread), then this might result in adding stalls to a workload
> that has no other options but to allocate movable pages from partially
> filled unmovable blocks, because that's simply the majority of
> pageblocks in the system, and the stalls can't help the situation. If
> that proves to be true, we could revert, but then there's the new
> user-visible tunable... and that all makes it harder for me to decide
> about this patch :) If only we could find out early while this is in
> linux-mm/linux-next...
> 

I think in the event it has to revert that it would be ok for the tuning
to disappear at the same time. There are occasions where a particular
tuning has side-effects that make it harder to remove the interface but
in this case, the tuning is directly related to the patch itself.

That said, stalling behaviour has been problematic so if we want to play
it safe then I do not mind this patch being dropped until there is a
definite benefit from it as the bulk of the series benefit is from the
first 4 patches.

-- 
Mel Gorman
SUSE Labs
