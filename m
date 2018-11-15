Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39265C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0719B214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0719B214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbeKOWap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:30:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:53090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728699AbeKOWap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:30:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64AB8B023;
        Thu, 15 Nov 2018 12:23:05 +0000 (UTC)
Date:   Thu, 15 Nov 2018 13:23:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devel@linuxdriverproject.org,
        linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 6/6] PM / Hibernate: exclude all PageOffline() pages
Message-ID: <20181115122302.GR23831@dhcp22.suse.cz>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114211704.6381-7-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-11-18 22:17:04, David Hildenbrand wrote:
[...]
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index b0308a2c6000..01db1d13481a 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1222,7 +1222,7 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
>  	BUG_ON(!PageHighMem(page));
>  
>  	if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page) ||
> -	    PageReserved(page))
> +	    PageReserved(page) || PageOffline(page))
>  		return NULL;
>  
>  	if (page_is_guard(page))
> @@ -1286,6 +1286,9 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
>  	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
>  		return NULL;
>  
> +	if (PageOffline(page))
> +		return NULL;
> +
>  	if (PageReserved(page)
>  	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
>  		return NULL;

Btw. now that you are touching this file could you also make
s@pfn_to_page@pfn_to_online_page@ please? We really do not want to touch
offline pfn ranges in general. A separate patch for that of course.

Thanks!
-- 
Michal Hocko
SUSE Labs
