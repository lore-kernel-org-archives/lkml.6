Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893B6C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595D42084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595D42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeLEIGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:06:53 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:40668 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbeLEIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:06:51 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 13FC5B86EA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 08:06:49 +0000 (GMT)
Received: (qmail 19886 invoked from network); 5 Dec 2018 08:06:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Dec 2018 08:06:48 -0000
Date:   Wed, 5 Dec 2018 08:06:47 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/5] mm: Stall movable allocations until kswapd
 progresses during serious external fragmentation event
Message-ID: <20181205080647.GW23260@techsingularity.net>
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
> patches. Also I'm afraid that once antifrag loses against the ultimate
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

Andrew, would you mind dropping this patch from mmotm please? I think
the benefit is marginal relative to the potential loss. If it turns out
we ever really do need it then hopefully there will be better data
supporting it.

Thanks.

-- 
Mel Gorman
SUSE Labs
