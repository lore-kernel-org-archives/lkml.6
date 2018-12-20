Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C824CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AB221741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545311170;
	bh=Mj2lGGs4tORXf3mdd0HHcvRK2TfEiht1IQNUE0dKT1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PZXcHs3AJOzi0wyOAUtDPWIBxxuBgph7SBRR3XMUtpesp1XeZNT1/YjuM3SfNdE1K
	 pxIR17IOUnHU5cbaEAw1AaCE7Xn5z2QDVu3oSnHlIiI7WjUw4xno0Byd37s8UbRU5y
	 sqL1269izh4ulZU+eD3MwMZ8C5G6U9A4GAnN6ChY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbeLTNGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:06:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:34460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728803AbeLTNGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:06:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DFB7ADF3;
        Thu, 20 Dec 2018 13:06:07 +0000 (UTC)
Date:   Thu, 20 Dec 2018 14:06:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, pavel.tatashin@microsoft.com,
        rppt@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181220130606.GG9104@dhcp22.suse.cz>
References: <20181217225113.17864-1-osalvador@suse.de>
 <20181219142528.yx6ravdyzcqp5wtd@master>
 <20181219233914.2fxe26pih26ifvmt@d104.suse.de>
 <20181220091228.GB14234@dhcp22.suse.cz>
 <20181220124925.itwuuacgztpgsk7s@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220124925.itwuuacgztpgsk7s@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-12-18 13:49:28, Oscar Salvador wrote:
> On Thu, Dec 20, 2018 at 10:12:28AM +0100, Michal Hocko wrote:
> > > <--
> > > skip_pages = (1 << compound_order(head)) - (page - head);
> > > iter = skip_pages - 1;
> > > --
> > > 
> > > which looks more simple IMHO.
> > 
> > Agreed!
> 
> Andrew, can you please apply the next diff chunk on top of the patch:
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4812287e56a0..978576d93783 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8094,7 +8094,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  				goto unmovable;
>  
>  			skip_pages = (1 << compound_order(head)) - (page - head);
> -			iter = round_up(iter + 1, skip_pages) - 1;
> +			iter = skip_pages - 1;

You did want iter += skip_pages - 1 here right?

-- 
Michal Hocko
SUSE Labs
