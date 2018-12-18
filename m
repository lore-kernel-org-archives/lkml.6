Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6C421871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeLRO36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:29:58 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:39850 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbeLRO34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:29:56 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 7388598ACF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 14:29:54 +0000 (UTC)
Received: (qmail 17733 invoked from network); 18 Dec 2018 14:29:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Dec 2018 14:29:54 -0000
Date:   Tue, 18 Dec 2018 14:29:52 +0000
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
Message-ID: <20181218142952.GL29005@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-10-mgorman@techsingularity.net>
 <f8aeec16-65de-b873-3362-3c7cb30c4ac6@suse.cz>
 <20181218135156.GK29005@techsingularity.net>
 <adae728e-0e62-abb3-901e-0696930bb7dd@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <adae728e-0e62-abb3-901e-0696930bb7dd@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:58:33PM +0100, Vlastimil Babka wrote:
> On 12/18/18 2:51 PM, Mel Gorman wrote:
> > On Tue, Dec 18, 2018 at 01:36:42PM +0100, Vlastimil Babka wrote:
> >> On 12/15/18 12:03 AM, Mel Gorman wrote:
> >>> When pageblocks get fragmented, watermarks are artifically boosted to pages
> >>> are reclaimed to avoid further fragmentation events. However, compaction
> >>> is often either fragmentation-neutral or moving movable pages away from
> >>> unmovable/reclaimable pages. As the actual watermarks are preserved,
> >>> allow compaction to ignore the boost factor.
> >>
> >> Right, I should have realized that when reviewing the boost patch. I
> >> think it would be useful to do the same change in
> >> __compaction_suitable() as well. Compaction has its own "gap".
> >>
> > 
> > That gap is somewhat static though so I'm a bit more wary of it. However,
> 
> Well, watermark boost is dynamic, but based on allocations stealing from
> other migratetypes, not reflecting compaction chances of success.
> 

True.

> > the check in __isolate_free_page looks too agressive. We isolate in
> > units of COMPACT_CLUSTER_MAX yet the watermark check there is based on
> > the allocation request. That means for THP that we check if 512 pages
> > can be allocated when only somewhere between 1 and 32 is needed for that
> > compaction cycle to complete. Adjusting that might be more appropriate?
> 
> AFAIU the code in __isolate_free_page() reflects that if there's less
> than 512 free pages gap, we might form a high-order page for THP but
> won't be able to allocate it afterwards due to watermark.

Yeah but it used to be a lot more important when watermark checking for
high-orders was very different. Now, if the watermark is met for order-0
and a large enough free page is allocated, the allocation succeeds so
it's a lot less relevant than it used to be. kswapd will still run in
the background for order-0 if necessary so a heavy watermark check there
doesn't really help.

-- 
Mel Gorman
SUSE Labs
