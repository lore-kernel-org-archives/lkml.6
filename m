Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5A3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1473217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548239000;
	bh=da4Jl6cHv4qIH9dB3tNQMFgYz5tddGYxoqWxmLjxOVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EA9ZOHM1d0O0ULz/lc1ChrlRI2X7ZLD1TH9m9t1v9FcGYzXc/dCxohD2bl+LjsBWF
	 bUO6HpQYdBQvqefNVA6ZpNqWQADL6NJ4BFc2LaDrWZQS9OdcggousQ1G/7mj82TVXP
	 brbRrvo3YvqHoroEgxmPKWeJhU/l6iGr6omq+emo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfAWKXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:23:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:47826 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfAWKXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:23:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDEDFAD9F;
        Wed, 23 Jan 2019 10:23:16 +0000 (UTC)
Date:   Wed, 23 Jan 2019 11:22:42 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [PATCH] mm,memory_hotplug: Fix scan_movable_pages for gigantic
 hugepages
Message-ID: <20190123102242.GT4087@dhcp22.suse.cz>
References: <20190122154407.18417-1-osalvador@suse.de>
 <20190123094717.GQ4087@dhcp22.suse.cz>
 <20190123101838.qxsapn4dhcergs6t@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123101838.qxsapn4dhcergs6t@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-01-19 11:18:42, Oscar Salvador wrote:
> On Wed, Jan 23, 2019 at 10:47:17AM +0100, Michal Hocko wrote:
> > So this should be probably folded into the above patch as it is
> > incomplete unless I am missing something.
> 
> Well, they are triggered from different paths.
> The former error was triggered in:
> 
> removable_show
>  is_mem_section_removable
>   is_pageblock_removable_nolock
>    has_unmovable_pages
> 
> while this one is triggered when actually doing the offline operation

But it would trigger from the offline path as well, no?

> __offline_pages
>  scan_movable_pages
>  
> But I do agree that one without the other is not really useful, an incomplete.
> The truth is that I did not spot this one when fixing [1] because I did not
> really try to offline the memblock back then, so my fault.

I should have noticed that during the review but those paths are really
far away from each other so this is hard to spot indeed

> While I agree that the best approach would be to fold this one into [1],
> I am not sure if it is too late for that as it seems that [1] was already
> released into mainline, and moreover to stable.

OK, I wasn't aware of that. Then my suggestion is clearly moot.

> I guess I will have Andrew decide what is the best way to carry on here.
> 
> [1] https://patchwork.kernel.org/patch/10739963/
> 
> > 
> > > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > 
> > Other than that the change looks good to me.
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks!
> -- 
> Oscar Salvador
> SUSE L3

-- 
Michal Hocko
SUSE Labs
