Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E21C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C31D21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeLRNwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:52:06 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:40628 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbeLRNwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:52:01 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 9A494B8829
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:51:58 +0000 (GMT)
Received: (qmail 7453 invoked from network); 18 Dec 2018 13:51:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Dec 2018 13:51:58 -0000
Date:   Tue, 18 Dec 2018 13:51:56 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/14] mm, compaction: Ignore the fragmentation avoidance
 boost for isolation and compaction
Message-ID: <20181218135156.GK29005@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-10-mgorman@techsingularity.net>
 <f8aeec16-65de-b873-3362-3c7cb30c4ac6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <f8aeec16-65de-b873-3362-3c7cb30c4ac6@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 01:36:42PM +0100, Vlastimil Babka wrote:
> On 12/15/18 12:03 AM, Mel Gorman wrote:
> > When pageblocks get fragmented, watermarks are artifically boosted to pages
> > are reclaimed to avoid further fragmentation events. However, compaction
> > is often either fragmentation-neutral or moving movable pages away from
> > unmovable/reclaimable pages. As the actual watermarks are preserved,
> > allow compaction to ignore the boost factor.
> 
> Right, I should have realized that when reviewing the boost patch. I
> think it would be useful to do the same change in
> __compaction_suitable() as well. Compaction has its own "gap".
> 

That gap is somewhat static though so I'm a bit more wary of it.  However,
the check in __isolate_free_page looks too agressive. We isolate in
units of COMPACT_CLUSTER_MAX yet the watermark check there is based on
the allocation request. That means for THP that we check if 512 pages
can be allocated when only somewhere between 1 and 32 is needed for that
compaction cycle to complete. Adjusting that might be more appropriate?

-- 
Mel Gorman
SUSE Labs
