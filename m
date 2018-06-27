Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91CCC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756C12408F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756C12408F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeF0LFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:05:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:40757 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753144AbeF0LF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:05:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 57D08AC25;
        Wed, 27 Jun 2018 11:05:28 +0000 (UTC)
Date:   Wed, 27 Jun 2018 13:05:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        JianKang Chen <chenjiankang1@huawei.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xieyisheng1@huawei.com,
        guohanjun@huawei.com, wangkefeng.wang@huawei.com,
        Huaisheng Ye <yehs2007@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: drop VM_BUG_ON from __get_free_pages
Message-ID: <20180627110527.GM32348@dhcp22.suse.cz>
References: <20180622162841.25114-1-mhocko@kernel.org>
 <6886dee0-3ac4-ef5d-3597-073196c81d88@suse.cz>
 <20180626100416.a3ff53f5c4aac9fae954e3f6@linux-foundation.org>
 <20180627073420.GD32348@dhcp22.suse.cz>
 <e0f4426d-1b7c-e590-aae0-e8f7ae3bb948@suse.cz>
 <20180627075403.GG32348@dhcp22.suse.cz>
 <fee289c8-fa8f-d9d6-be33-fdd20c71cbca@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee289c8-fa8f-d9d6-be33-fdd20c71cbca@suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-06-18 12:47:39, Vlastimil Babka wrote:
> On 06/27/2018 09:54 AM, Michal Hocko wrote:
> > On Wed 27-06-18 09:50:01, Vlastimil Babka wrote:
> >> On 06/27/2018 09:34 AM, Michal Hocko wrote:
> >>> On Tue 26-06-18 10:04:16, Andrew Morton wrote:
> >>>
> >>> And as I've argued before the code would be wrong regardless. We would
> >>> leak the memory or worse touch somebody's else kmap without knowing
> >>> that.  So we have a choice between a mem leak, data corruption k or a
> >>> silent fixup. I would prefer the last option. And blowing up on a BUG
> >>> is not much better on something that is easily fixable. I am not really
> >>> convinced that & ~__GFP_HIGHMEM is something to lose sleep over.
> >>
> >> Maybe put the fixup into a "#ifdef CONFIG_HIGHMEM" block and then modern
> >> systems won't care? In that case it could even be if (WARN_ON_ONCE(...))
> >> so future cases with wrong expectations would become known.
> > 
> > Yes that could be done as well. Or maybe we can make __GFP_HIGHMEM 0 for
> > !HIGHMEM systems. Does something really rely on it being non-zero?
> 
> I guess gfp_zone() would have to be checked, dunno about the rewrite of
> GFP_ZONE_TABLE (CCing people).
> In general checks like "if (flags & __GFP_HIGHMEM)" would become false,
> which probably should not be a problem, unless something expect the flag
> to be there and errors out if it isn't.

Well, __GFP_HIGHMEM should be basically GFP_KERNEL for !highmem systems.
But most checks I have seen try to mask it off. Having it 0 would help
to reduce at least some code.

-- 
Michal Hocko
SUSE Labs
