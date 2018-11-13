Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3222CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F248A2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F248A2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbeKMSAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:00:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:34644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728379AbeKMSAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:00:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F922B0EC;
        Tue, 13 Nov 2018 08:03:55 +0000 (UTC)
Date:   Tue, 13 Nov 2018 09:03:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/5] mm, memory_hotplug: be more verbose for memory
 offline failures
Message-ID: <20181113080354.GJ15120@dhcp22.suse.cz>
References: <20181107101830.17405-1-mhocko@kernel.org>
 <20181107101830.17405-6-mhocko@kernel.org>
 <b23ebcb3-e4f1-be78-bd5f-84c685979ab7@arm.com>
 <20181108081231.GN27423@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108081231.GN27423@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, could you pick up this one as well please? Let me know if you
prefer me to send the whole pile with all the fixes again.

> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index bf214beccda3..820397e18e59 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1411,9 +1411,9 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
>  		if (ret) {
>  			list_for_each_entry(page, &source, lru) {
> -				pr_warn("migrating pfn %lx failed ",
> +				pr_warn("migrating pfn %lx failed ret:%d ",
>  				       page_to_pfn(page), ret);
> -				dump_page(page, NULL);
> +				dump_page(page, "migration failure");
>  			}
>  			putback_movable_pages(&source);
>  		}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 23267767bf98..ec2c7916dc2d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7845,7 +7845,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  	return false;
>  unmovable:
>  	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> -	dump_page(pfn_to_page(pfn+iter), "has_unmovable_pages");
> +	dump_page(pfn_to_page(pfn+iter), "unmovable page");
>  	return true;
>  }
>  
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
