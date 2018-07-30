Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BE7FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75ADE20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75ADE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbeG3PgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:36:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:33122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730790AbeG3PgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:36:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5ABD5AE5B;
        Mon, 30 Jul 2018 14:01:01 +0000 (UTC)
Date:   Mon, 30 Jul 2018 16:00:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador@techadventures.net
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, sfr@canb.auug.org.au,
        rientjes@google.com, pasha.tatashin@oracle.com,
        kemi.wang@intel.com, jia.he@hxt-semitech.com, ptesarik@suse.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Remove zone_id() and make use of zone_idx() in
 is_dev_zone()
Message-ID: <20180730140059.GU24267@dhcp22.suse.cz>
References: <20180730133718.28683-1-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730133718.28683-1-osalvador@techadventures.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-07-18 15:37:18, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> is_dev_zone() is using zone_id() to check if the zone is ZONE_DEVICE.
> zone_id() looks pretty much the same as zone_idx(), and while the use of
> zone_idx() is quite spread in the kernel, zone_id() is only being
> used by is_dev_zone().
> 
> This patch removes zone_id() and makes is_dev_zone() use zone_idx()
> to check the zone, so we do not have two things with the same
> functionality around.

Yes this looks like a pointless code duplication. I guess Dan just
wasn't aware of zone_idx() macro.

> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mmzone.h | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 83b1d11e90eb..dbe7635c33dd 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -755,25 +755,6 @@ static inline bool pgdat_is_empty(pg_data_t *pgdat)
>  	return !pgdat->node_start_pfn && !pgdat->node_spanned_pages;
>  }
>  
> -static inline int zone_id(const struct zone *zone)
> -{
> -	struct pglist_data *pgdat = zone->zone_pgdat;
> -
> -	return zone - pgdat->node_zones;
> -}
> -
> -#ifdef CONFIG_ZONE_DEVICE
> -static inline bool is_dev_zone(const struct zone *zone)
> -{
> -	return zone_id(zone) == ZONE_DEVICE;
> -}
> -#else
> -static inline bool is_dev_zone(const struct zone *zone)
> -{
> -	return false;
> -}
> -#endif
> -
>  #include <linux/memory_hotplug.h>
>  
>  void build_all_zonelists(pg_data_t *pgdat);
> @@ -824,6 +805,18 @@ static inline int local_memory_node(int node_id) { return node_id; };
>   */
>  #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
>  
> +#ifdef CONFIG_ZONE_DEVICE
> +static inline bool is_dev_zone(const struct zone *zone)
> +{
> +	return zone_idx(zone) == ZONE_DEVICE;
> +}
> +#else
> +static inline bool is_dev_zone(const struct zone *zone)
> +{
> +	return false;
> +}
> +#endif
> +
>  /*
>   * Returns true if a zone has pages managed by the buddy allocator.
>   * All the reclaim decisions have to use this function rather than
> -- 
> 2.13.6
> 

-- 
Michal Hocko
SUSE Labs
