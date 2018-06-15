Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1542C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7CB20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7CB20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756324AbeFOSLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:11:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50356 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbeFOSLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:11:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so4863988wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kIhPURL6ey1eznLXSt4y9mijU+BGtrO1E8mfaP1GJ+Q=;
        b=Tp5kcd/7drmmROeL2V/87pn6BwddRvsTsOAfEeAlkGUxISaZ6pd4KOY6+fT+ge67sZ
         iprANNX0kauk0h9BPu1n4BidvAT3y/iK7Q40PEY4Fb2jZLoHztYuYIm8QLLvy1pUIt4q
         bTVxWP4rAyu5sWOfVQJq66AVrrBbudxvYI4iHqgxq49wveNDScuCCuL2QFZkhYWW9a5q
         4hr+Uv6Y/UFbB4nH7BZan6+HaPJO9/SOl4aOSpvPOhQhCtjN/eknjg3ZW4+JAeE3zqT4
         rM+9/nvaUYgkNQk3Tc9XVu6mpPt8MMkGqknEx/RwDgBfEkIWaeNhKOH8TRTNDnPzogQ5
         /bmA==
X-Gm-Message-State: APt69E1GanCCTgg5HffYm1NQWAHqoAZRyVZN8ULbyADfsbnCVcbQTS/K
        USea67ve/m1Lc9mXU6/4t/w=
X-Google-Smtp-Source: ADUXVKKOajHdoQ9xyjoMhJQ3pGRueeT1h7FryTIXMBTL8/NXwIe/lnPS4B83gNCtCdz/Hjtq3IoL+w==
X-Received: by 2002:a1c:7d56:: with SMTP id y83-v6mr2191154wmc.65.1529086274919;
        Fri, 15 Jun 2018 11:11:14 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l41-v6sm13986564wre.87.2018.06.15.11.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 11:11:14 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 1385512350E; Fri, 15 Jun 2018 20:11:13 +0200 (CEST)
Date:   Fri, 15 Jun 2018 20:11:13 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        osalvador@suse.de, willy@infradead.org, mingo@kernel.org,
        dan.j.williams@intel.com, ying.huang@intel.com
Subject: Re: [PATCH] mm: skip invalid pages block at a time in
 zero_resv_unresv
Message-ID: <20180615181113.GA27558@techadventures.net>
References: <20180615155733.1175-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615155733.1175-1-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:57:33AM -0400, Pavel Tatashin wrote:
> The role of zero_resv_unavail() is to make sure that every struct page that
> is allocated but is not backed by memory that is accessible by kernel is
> zeroed and not in some uninitialized state.
> 
> Since struct pages are allocated in blocks (2M pages in x86 case), we can
> skip pageblock_nr_pages at a time, when the first one is found to be
> invalid.
> 
> This optimization may help since now on x86 every hole in e820 maps
> is marked as reserved in memblock, and thus will go through this function.
> 
> This function is called before sched_clock() is initialized, so I used my
> x86 early boot clock patches to measure the performance improvement.
> 
> With 1T hole on i7-8700 currently we would take 0.606918s of boot time, but
> with this optimization 0.001103s.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  mm/page_alloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1521100f1e63..94f1b3201735 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6404,8 +6404,11 @@ void __paginginit zero_resv_unavail(void)
>  	pgcnt = 0;
>  	for_each_resv_unavail_range(i, &start, &end) {
>  		for (pfn = PFN_DOWN(start); pfn < PFN_UP(end); pfn++) {
> -			if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
> +			if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
> +				pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
> +					+ pageblock_nr_pages - 1;
>  				continue;
> +			}
>  			mm_zero_struct_page(pfn_to_page(pfn));
>  			pgcnt++;
>  		}

Hi Pavel,

Thanks for the patch.
This looks good to me.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> -- 
> 2.17.1
> 

Best Regards
Oscar Salvador
