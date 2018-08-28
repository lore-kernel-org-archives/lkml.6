Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776B1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A432089D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A432089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeH1PQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:16:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:50938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727201AbeH1PQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:16:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA266AEA5;
        Tue, 28 Aug 2018 11:25:43 +0000 (UTC)
Date:   Tue, 28 Aug 2018 13:25:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pasha.tatashin@oracle.com
Subject: Re: [PATCH] memory_hotplug: fix kernel_panic on offline page
 processing
Message-ID: <20180828112543.GK10223@dhcp22.suse.cz>
References: <20180828090539.41491-1-zaslonko@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828090539.41491-1-zaslonko@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-08-18 11:05:39, Mikhail Zaslonko wrote:
> Within show_valid_zones() the function test_pages_in_a_zone() should be
> called for online memory blocks only. Otherwise it might lead to the
> VM_BUG_ON due to uninitialized struct pages (when CONFIG_DEBUG_VM_PGFLAGS
> kernel option is set):
> 
>  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>  ------------[ cut here ]------------
>  Call Trace:
>  ([<000000000038f91e>] test_pages_in_a_zone+0xe6/0x168)
>   [<0000000000923472>] show_valid_zones+0x5a/0x1a8
>   [<0000000000900284>] dev_attr_show+0x3c/0x78
>   [<000000000046f6f0>] sysfs_kf_seq_show+0xd0/0x150
>   [<00000000003ef662>] seq_read+0x212/0x4b8
>   [<00000000003bf202>] __vfs_read+0x3a/0x178
>   [<00000000003bf3ca>] vfs_read+0x8a/0x148
>   [<00000000003bfa3a>] ksys_read+0x62/0xb8
>   [<0000000000bc2220>] system_call+0xdc/0x2d8
> 
> That VM_BUG_ON was triggered by the page poisoning introduced in
> mm/sparse.c with the git commit d0dc12e86b31 ("mm/memory_hotplug: optimize
> memory hotplug")
> With the same commit the new 'nid' field has been added to the struct
> memory_block in order to store and later on derive the node id for offline
> pages (instead of accessing struct page which might be uninitialized). But
> one reference to nid in show_valid_zones() function has been overlooked.
> Fixed with current commit.
> Also, nr_pages will not be used any more after test_pages_in_a_zone() call,
> do not update it.
> 
> Fixes: d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug")
> Cc: <stable@vger.kernel.org> # v4.17+
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Btw. this land mines which are basically impossible to find during the
review are the reason why I was not all that happy about d0dc12e86b31.
It added a margninal improvement but opened a can of warms. On the other
hand maybe we just had to open that can one day...

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  drivers/base/memory.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index f5e560188a18..622ab8edc035 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -416,26 +416,24 @@ static ssize_t show_valid_zones(struct device *dev,
>  	struct zone *default_zone;
>  	int nid;
>  
> -	/*
> -	 * The block contains more than one zone can not be offlined.
> -	 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
> -	 */
> -	if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages, &valid_start_pfn, &valid_end_pfn))
> -		return sprintf(buf, "none\n");
> -
> -	start_pfn = valid_start_pfn;
> -	nr_pages = valid_end_pfn - start_pfn;
> -
>  	/*
>  	 * Check the existing zone. Make sure that we do that only on the
>  	 * online nodes otherwise the page_zone is not reliable
>  	 */
>  	if (mem->state == MEM_ONLINE) {
> +		/*
> +		 * The block contains more than one zone can not be offlined.
> +		 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
> +		 */
> +		if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages,
> +					  &valid_start_pfn, &valid_end_pfn))
> +			return sprintf(buf, "none\n");
> +		start_pfn = valid_start_pfn;
>  		strcat(buf, page_zone(pfn_to_page(start_pfn))->name);
>  		goto out;
>  	}
>  
> -	nid = pfn_to_nid(start_pfn);
> +	nid = mem->nid;
>  	default_zone = zone_for_pfn_range(MMOP_ONLINE_KEEP, nid, start_pfn, nr_pages);
>  	strcat(buf, default_zone->name);
>  
> -- 
> 2.16.4

-- 
Michal Hocko
SUSE Labs
