Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B10C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4427D25EA9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4427D25EA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755517AbeFYRFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:05:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752588AbeFYRFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:05:02 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C6E14885FF8DD;
        Tue, 26 Jun 2018 01:04:46 +0800 (CST)
Received: from localhost (10.202.226.43) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Tue, 26 Jun 2018
 01:04:46 +0800
Date:   Mon, 25 Jun 2018 18:04:36 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     <osalvador@techadventures.net>
CC:     <akpm@linux-foundation.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <pasha.tatashin@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 3/4] mm/memory_hotplug: Get rid of link_mem_sections
Message-ID: <20180625180436.000049ac@huawei.com>
In-Reply-To: <20180601125321.30652-4-osalvador@techadventures.net>
References: <20180601125321.30652-1-osalvador@techadventures.net>
        <20180601125321.30652-4-osalvador@techadventures.net>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2018 14:53:20 +0200
<osalvador@techadventures.net> wrote:

> From: Oscar Salvador <osalvador@suse.de>
> 
> link_mem_sections() and walk_memory_range() share most of the code,
> so we can use walk_memory_range() with a callback to register_mem_sect_under_node()
> instead of using link_mem_sections().
> 
> To control whether the node id must be check, two new functions has been added:
> 
> register_mem_sect_under_node_nocheck_node()
> and
> register_mem_sect_under_node_check_node()
> 
> They both call register_mem_sect_under_node_check() with
> the parameter check_nid set to true or false.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  drivers/base/node.c  | 47 ++++++++++-------------------------------------
>  include/linux/node.h | 21 +++++++++------------
>  mm/memory_hotplug.c  |  8 ++++----
>  3 files changed, 23 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index a5e821d09656..248c712e8de5 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -398,6 +398,16 @@ static int __ref get_nid_for_pfn(unsigned long pfn)
>  	return pfn_to_nid(pfn);
>  }
>  
> +int register_mem_sect_under_node_check_node(struct memory_block *mem_blk, void *nid)
> +{
> +	return register_mem_sect_under_node (mem_blk, *(int *)nid, true);
> +}
> +
> +int register_mem_sect_under_node_nocheck_node(struct memory_block *mem_blk, void *nid)
> +{
> +	return register_mem_sect_under_node (mem_blk, *(int *)nid, false);
> +}
> +
>  /* register memory section under specified node if it spans that node */
>  int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
>  				 bool check_nid)
> @@ -490,43 +500,6 @@ int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>  	return 0;
>  }
>  
> -int link_mem_sections(int nid, unsigned long start_pfn, unsigned long nr_pages,
> -		      bool check_nid)
> -{
> -	unsigned long end_pfn = start_pfn + nr_pages;
> -	unsigned long pfn;
> -	struct memory_block *mem_blk = NULL;
> -	int err = 0;
> -
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> -		unsigned long section_nr = pfn_to_section_nr(pfn);
> -		struct mem_section *mem_sect;
> -		int ret;
> -
> -		if (!present_section_nr(section_nr))
> -			continue;
> -		mem_sect = __nr_to_section(section_nr);
> -
> -		/* same memblock ? */
> -		if (mem_blk)
> -			if ((section_nr >= mem_blk->start_section_nr) &&
> -			    (section_nr <= mem_blk->end_section_nr))
> -				continue;
> -
> -		mem_blk = find_memory_block_hinted(mem_sect, mem_blk);
> -
> -		ret = register_mem_sect_under_node(mem_blk, nid, check_nid);
> -		if (!err)
> -			err = ret;
> -
> -		/* discard ref obtained in find_memory_block() */
> -	}
> -
> -	if (mem_blk)
> -		kobject_put(&mem_blk->dev.kobj);
> -	return err;
> -}
> -
>  #ifdef CONFIG_HUGETLBFS
>  /*
>   * Handle per node hstate attribute [un]registration on transistions
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 6d336e38d155..1158bea9be52 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -31,19 +31,11 @@ struct memory_block;
>  extern struct node *node_devices[];
>  typedef  void (*node_registration_func_t)(struct node *);
>  
> -#if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_NUMA)
> -extern int link_mem_sections(int nid, unsigned long start_pfn,
> -			     unsigned long nr_pages, bool check_nid);
> -#else
> -static inline int link_mem_sections(int nid, unsigned long start_pfn,
> -				    unsigned long nr_pages, bool check_nid)
> -{
> -	return 0;
> -}
> -#endif
> -
>  extern void unregister_node(struct node *node);
>  #ifdef CONFIG_NUMA
> +#if defined(CONFIG_MEMORY_HOTPLUG_SPARSE)
> +extern int register_mem_sect_under_node_check_node(struct memory_block *mem_blk, void *nid);
> +#endif
>  /* Core of the node registration - only memory hotplug should use this */
>  extern int __register_one_node(int nid);
>  
> @@ -54,12 +46,17 @@ static inline int register_one_node(int nid)
>  
>  	if (node_online(nid)) {
>  		struct pglist_data *pgdat = NODE_DATA(nid);
> +		unsigned long start = pgdat->node_start_pfn;
> +		unsigned long size = pgdat->node_spanned_pages;
>  
>  		error = __register_one_node(nid);
>  		if (error)
>  			return error;
>  		/* link memory sections under this node */
> -		error = link_mem_sections(nid, pgdat->node_start_pfn, pgdat->node_spanned_pages, true);
> +#if defined(CONFIG_MEMORY_HOTPLUG_SPARSE)
> +		error = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1),
> +					(void *)&nid, register_mem_sect_under_node_check_node);
> +#endif
Apologies, my previous testing was clearly garbage.

Looks like we take the node pfns then shift them again.  Result on my system is we only get as far as pfn 22
which is still in the first memory block so rest of them are never successfully added.
Replacing with 

error = walk_memory_range(start, start + size - 1, ...

works much better and lets me test Lorenzo's patch which is what I was really trying to do today.

Sorry again for the incorrect previous tested-by.

Thanks,

Jonathan


>  	}
>  
>  	return error;
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f84ef96175ab..ac21dc506b84 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -40,6 +40,8 @@
>  
>  #include "internal.h"
>  
> +extern int register_mem_sect_under_node_nocheck_node(struct memory_block *mem_blk, void *nid);
> +
>  /*
>   * online_page_callback contains pointer to current page onlining function.
>   * Initially it is generic_online_page(). If it is required it could be
> @@ -1118,7 +1120,6 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
>  	u64 start, size;
>  	bool new_node;
>  	int ret;
> -	unsigned long start_pfn, nr_pages;
>  
>  	start = res->start;
>  	size = resource_size(res);
> @@ -1157,9 +1158,8 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
>  	}
>  
>  	/* link memory sections under this node.*/
> -	start_pfn = start >> PAGE_SHIFT;
> -	nr_pages = size >> PAGE_SHIFT;
> -	ret = link_mem_sections(nid, start_pfn, nr_pages, false);
> +	ret = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1),
> +				(void *)&nid, register_mem_sect_under_node_nocheck_node);
>  	if (ret)
>  		goto register_fail;
>  


