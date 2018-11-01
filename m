Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0A3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6113C20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6113C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeKAV6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:58:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:53604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727966AbeKAV6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:58:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04982AFF9;
        Thu,  1 Nov 2018 12:55:45 +0000 (UTC)
Date:   Thu, 1 Nov 2018 13:55:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2] mm/kvmalloc: do not call kmalloc for size >
 KMALLOC_MAX_SIZE
Message-ID: <20181101125543.GH23921@dhcp22.suse.cz>
References: <154106356066.887821.4649178319705436373.stgit@buzz>
 <154106695670.898059.5301435081426064314.stgit@buzz>
 <20181101102405.GE23921@dhcp22.suse.cz>
 <cd2a55be-17f1-5da9-1154-8e291fe958cd@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd2a55be-17f1-5da9-1154-8e291fe958cd@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-11-18 13:48:17, Konstantin Khlebnikov wrote:
> 
> 
> On 01.11.2018 13:24, Michal Hocko wrote:
> > On Thu 01-11-18 13:09:16, Konstantin Khlebnikov wrote:
> > > Allocations over KMALLOC_MAX_SIZE could be served only by vmalloc.
> > 
> > I would go on and say that allocations with sizes too large can actually
> > trigger a warning (once you have posted in the previous version outside
> > of the changelog area) because that might be interesting to people -
> > there are deployments to panic on warning and then a warning is much
> > more important.
> 
> It seems that warning isn't completely valid.
> 
> 
> __alloc_pages_slowpath() handles this more gracefully:
> 
> 	/*
> 	 * In the slowpath, we sanity check order to avoid ever trying to
> 	 * reclaim >= MAX_ORDER areas which will never succeed. Callers may
> 	 * be using allocators in order of preference for an area that is
> 	 * too large.
> 	 */
> 	if (order >= MAX_ORDER) {
> 		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
> 		return NULL;
> 	}
> 
> 
> Fast path is ready for order >= MAX_ORDER
> 
> 
> Problem is in node_reclaim() which is called earlier than __alloc_pages_slowpath()
> from surprising place - get_page_from_freelist()
> 
> 
> Probably node_reclaim() simply needs something like this:
> 
> 	if (order >= MAX_ORDER)
> 		return NODE_RECLAIM_NOSCAN;

Maybe but the point is that triggering this warning is possible. Even if
the warning is bogus it doesn't really make much sense to even try
kmalloc if the size is not supported by the allocator.

-- 
Michal Hocko
SUSE Labs
