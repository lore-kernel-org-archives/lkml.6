Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91063217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551191035;
	bh=lMK1aXy6BGJso1g7I/yVryJ6TBMD0wxc4OB5+J8VA6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mwz8/cFG3hUARgdoUNfyPIImD0XYUO+Dw1qMHKp6Tyj1WKQ463abCz1GSIisyLhp9
	 yAUukebEg/UbpL9sbePU3QR1cPgnHB9zlcRwGsaBOxMZ2GRZhWplFC61Fj65mi9v+D
	 zeSqpzvgsdF4FkEj1r4t7yRBI+61sO5bTTHaqjX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfBZOXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:23:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:34748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfBZOXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:23:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAD46AF57;
        Tue, 26 Feb 2019 14:23:52 +0000 (UTC)
Date:   Tue, 26 Feb 2019 15:23:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: fix an imbalance with DEBUG_PAGEALLOC
Message-ID: <20190226142352.GC10588@dhcp22.suse.cz>
References: <20190225191710.48131-1-cai@lca.pw>
 <20190226123521.GZ10588@dhcp22.suse.cz>
 <4d4d3140-6d83-6d22-efdb-370351023aea@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d4d3140-6d83-6d22-efdb-370351023aea@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-02-19 09:16:30, Qian Cai wrote:
> 
> 
> On 2/26/19 7:35 AM, Michal Hocko wrote:
> > On Mon 25-02-19 14:17:10, Qian Cai wrote:
> >> When onlining memory pages, it calls kernel_unmap_linear_page(),
> >> However, it does not call kernel_map_linear_page() while offlining
> >> memory pages. As the result, it triggers a panic below while onlining on
> >> ppc64le as it checks if the pages are mapped before unmapping,
> >> Therefore, let it call kernel_map_linear_page() when setting all pages
> >> as reserved.
> > 
> > This really begs for much more explanation. All the pages should be
> > unmapped as they get freed AFAIR. So why do we need a special handing
> > here when this path only offlines free pages?
> > 
> 
> It sounds like this is exact the point to explain the imbalance. When offlining,
> every page has already been unmapped and marked reserved. When onlining, it
> tries to free those reserved pages via __online_page_free(). Since those pages
> are order 0, it goes free_unref_page() which in-turn call
> kernel_unmap_linear_page() again without been mapped first.

How is this any different from an initial page being freed to the
allocator during the boot?

-- 
Michal Hocko
SUSE Labs
