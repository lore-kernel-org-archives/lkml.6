Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5165AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0768220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0768220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeGSJRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:17:36 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:52442 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727706AbeGSJRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:17:36 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id BD51FB8760
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 09:35:31 +0100 (IST)
Received: (qmail 22801 invoked from network); 19 Jul 2018 08:35:31 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.66])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 19 Jul 2018 08:35:31 -0000
Date:   Thu, 19 Jul 2018 09:35:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 3/7] mm, slab: allocate off-slab freelists as
 reclaimable when appropriate
Message-ID: <20180719083530.jhugqzkvjnbrddim@techsingularity.net>
References: <20180718133620.6205-1-vbabka@suse.cz>
 <20180718133620.6205-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180718133620.6205-4-vbabka@suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 03:36:16PM +0200, Vlastimil Babka wrote:
> In SLAB, OFF_SLAB caches allocate management structures (currently just the
> freelist) from kmalloc caches when placement in a slab page together with
> objects would lead to suboptimal memory usage. For SLAB_RECLAIM_ACCOUNT caches,
> we can allocate the freelists from the newly introduced reclaimable kmalloc
> caches, because shrinking the OFF_SLAB cache will in general result to freeing
> of the freelists as well. This should improve accounting and anti-fragmentation
> a bit.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

I'm not quite convinced by this one. The freelist cache is tied to the
lifetime of the slab and not the objects. A single freelist can be reclaimed
eventually but for caches with many objects per slab, it could take a lot
of shrinking random objects to reclaim one freelist. Functionally the
patch appears to be fine.

-- 
Mel Gorman
SUSE Labs
