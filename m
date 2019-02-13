Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C0AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75B9222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfBMOPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:15:22 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:58513 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726654AbfBMOPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:15:22 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 24E41B8924
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:15:20 +0000 (GMT)
Received: (qmail 20426 invoked from network); 13 Feb 2019 14:15:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Feb 2019 14:15:20 -0000
Date:   Wed, 13 Feb 2019 14:15:18 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm, page_alloc: Fix a division by zero error when
 boosting watermarks
Message-ID: <20190213141518.GS9565@techsingularity.net>
References: <20190213131923.GQ9565@techsingularity.net>
 <295be99c-d09a-5572-fa49-2673a62c295b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <295be99c-d09a-5572-fa49-2673a62c295b@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:42:36PM +0100, Vlastimil Babka wrote:
> On 2/13/19 2:19 PM, Mel Gorman wrote:
> > Yury Norov reported that an arm64 KVM instance could not boot since after
> > v5.0-rc1 and could addressed by reverting the patches
> > 
> > 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> > 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> > 
> > The problem is that a division by zero error is possible if boosting occurs
> > either very early in boot or if the high watermark is very small. This
> > patch checks for the conditions and avoids boosting in those cases.
> 
> Hmm is it really a division by zero? The following line sets max_boost to
> pageblock_nr_pages if it's zero. And where would the division happen anyway?
> 
> So I wonder what's going on, your patch should AFAICS only take effect when
> zone->_watermark[WMARK_HIGH] is 0 or 1 to begin with, otherwise max_boost is at
> least 2?
> 

The issue can occur if pageblock_nr_pages is also zero or not yet
initialised. It means the changelog is misleading because it  has to
trigger very early in boot as happened with Yury.

> Also upon closer look, I think that (prior to the patch), boost_watermark()
> could be reduced (thanks to the max+min capping) to
> 
> zone->watermark_boost = pageblock_nr_pages
> 

I don't think it's worth being fancy about it if we're hitting
fragmentation issues that early in boot.

-- 
Mel Gorman
SUSE Labs
