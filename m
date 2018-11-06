Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27818C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1B32083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1B32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbeKFXd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:33:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:38218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730481AbeKFXd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:33:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E599DB68C;
        Tue,  6 Nov 2018 14:08:01 +0000 (UTC)
Date:   Tue, 6 Nov 2018 15:08:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v6 2/2] mm/page_alloc: remove software prefetching in
 __free_pages_core
Message-ID: <20181106140801.GO27423@dhcp22.suse.cz>
References: <1541484194-1493-1-git-send-email-arunks@codeaurora.org>
 <1541484194-1493-2-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541484194-1493-2-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-11-18 11:33:14, Arun KS wrote:
> They not only increase the code footprint, they actually make things
> slower rather than faster. Remove them as contemporary hardware doesn't
> need any hint.

I guess I have already asked for that. When you argue about performance
then always add some numbers.

I do agree we want to get rid of the prefetching because it is just too
of an micro-optimization without any reasonable story behind.

> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> ---
>  mm/page_alloc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7cf503f..a1b9a6a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1270,14 +1270,10 @@ void __free_pages_core(struct page *page, unsigned int order)
>  	struct page *p = page;
>  	unsigned int loop;
>  
> -	prefetchw(p);
> -	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
> -		prefetchw(p + 1);
> +	for (loop = 0; loop < nr_pages ; loop++, p++) {
>  		__ClearPageReserved(p);
>  		set_page_count(p, 0);
>  	}
> -	__ClearPageReserved(p);
> -	set_page_count(p, 0);
>  
>  	page_zone(page)->managed_pages += nr_pages;
>  	set_page_refcounted(page);
> -- 
> 1.9.1

-- 
Michal Hocko
SUSE Labs
