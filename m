Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EB8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339B92087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfAROqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:46:07 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:46332 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbfAROqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:46:05 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 78F831C33C9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:46:03 +0000 (GMT)
Received: (qmail 25076 invoked from network); 18 Jan 2019 14:46:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jan 2019 14:46:03 -0000
Date:   Fri, 18 Jan 2019 14:46:01 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 25/25] mm, compaction: Do not direct compact remote memory
Message-ID: <20190118144601.GS27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-26-mgorman@techsingularity.net>
 <84a7b23a-1cb7-b888-4245-6b1e829f472b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <84a7b23a-1cb7-b888-4245-6b1e829f472b@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:51:00PM +0100, Vlastimil Babka wrote:
> On 1/4/19 1:50 PM, Mel Gorman wrote:
> > Remote compaction is expensive and possibly counter-productive. Locality
> > is expected to often have better performance characteristics than remote
> > high-order pages. For small allocations, it's expected that locality is
> > generally required or fallbacks are possible. For larger allocations such
> > as THP, they are forbidden at the time of writing but if __GFP_THISNODE
> > is ever removed, then it would still be preferable to fallback to small
> > local base pages over remote THP in the general case. kcompactd is still
> > woken via kswapd so compaction happens eventually.
> > 
> > While this patch potentially has both positive and negative effects,
> > it is best to avoid the possibility of remote compaction given the cost
> > relative to any potential benefit.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Generally agree with the intent, but what if there's e.g. high-order (but not
> costly) kernel allocation on behalf of user process on cpu belonging to a
> movable node, where the only non-movable node is node 0. It will have to keep
> reclaiming until a large enough page is formed, or wait for kcompactd?

Nnnggghhh, movable nodes. Yes, in such a case it would have to wait for
reclaim or kcompactd which could be problematic. This would have to be
special cased further.

> So maybe do this only for costly orders?
> 

This was written on the basis of the __GFP_THISNODE discussion which is
THP specific so costly didn't come into my thinking. If that ever gets
resurrected properly, this patch can be revisited. It would be trivial to
check if the preferred node is a movable node and allow remote compaction
in such cases but I'm not aiming at any specific problem with this patch
so it's too hand-wavy.

> Also I think compaction_zonelist_suitable() should be also updated, or we might
> be promising the reclaim-compact loop e.g. that we will compact after enough
> reclaim, but then we won't.
> 

True. I think I'll kill this patch as __GFP_THISNODE is now used again
for THP (regardless of how one feels about the subject) and we don't have
good examples where remote compaction for lower-order kernel allocations
is a problem.

-- 
Mel Gorman
SUSE Labs
