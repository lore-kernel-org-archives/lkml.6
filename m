Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F5CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC4B21848
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeLRIi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:38:27 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:49413 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbeLRIi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:38:27 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id D0DA11C18F2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 08:38:25 +0000 (GMT)
Received: (qmail 11244 invoked from network); 18 Dec 2018 08:38:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Dec 2018 08:38:25 -0000
Date:   Tue, 18 Dec 2018 08:38:24 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/14] mm, compaction: Skip pageblocks with reserved pages
Message-ID: <20181218083823.GI29005@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-6-mgorman@techsingularity.net>
 <b1d38179-4ccf-f34a-dffa-26c7957b8aed@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <b1d38179-4ccf-f34a-dffa-26c7957b8aed@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 09:08:02AM +0100, Vlastimil Babka wrote:
> On 12/15/18 12:03 AM, Mel Gorman wrote:
> > Reserved pages are set at boot time, tend to be clustered and almost
> > never become unreserved. When isolating pages for migrating, skip
> > the entire pageblock is one PageReserved page is encountered on the
> > grounds that it is highly probable the entire pageblock is reserved.
> 
> Agreed, but maybe since it's highly probable and not certain, this
> skipping should not be done on the highest compaction priority?
> 

I don't think that's necessary at this time. For the most part, you are
talking about one partial pageblock at best given how the early memory
allocator works so it would only ever be useful for a high-order kernel
allocation. Second, one of compactions primary problems is inefficient
scanning where viable pageblocks are easily skipped over or only partially
scanned which is something I'm still looking at. Lastly, maximum priority
compaction is rarely hit in practice as far as I can tell.

-- 
Mel Gorman
SUSE Labs
