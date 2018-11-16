Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC0AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E08E2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E08E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389329AbeKPS5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:57:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:53296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727398AbeKPS5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:57:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EEDE6ACF8;
        Fri, 16 Nov 2018 08:45:56 +0000 (UTC)
Date:   Fri, 16 Nov 2018 09:45:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/swap: use nr_node_ids for avail_lists in
 swap_info_struct
Message-ID: <20181116084556.GB14706@dhcp22.suse.cz>
References: <20181115083847.GA11129@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115083847.GA11129@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-11-18 16:38:47, Aaron Lu wrote:
> Since commit a2468cc9bfdf ("swap: choose swap device according to
> numa node"), avail_lists field of swap_info_struct is changed to
> an array with MAX_NUMNODES elements. This made swap_info_struct
> size increased to 40KiB and needs an order-4 page to hold it.
> 
> This is not optimal in that:
> 1 Most systems have way less than MAX_NUMNODES(1024) nodes so it
>   is a waste of memory;
> 2 It could cause swapon failure if the swap device is swapped on
>   after system has been running for a while, due to no order-4
>   page is available as pointed out by Vasily Averin.
> 
> Solve the above two issues by using nr_node_ids(which is the actual
> possible node number the running system has) for avail_lists instead
> of MAX_NUMNODES.
> 
> nr_node_ids is unknown at compile time so can't be directly used
> when declaring this array. What I did here is to declare avail_lists
> as zero element array and allocate space for it when allocating
> space for swap_info_struct. The reason why keep using array but
> not pointer is plist_for_each_entry needs the field to be part
> of the struct, so pointer will not work.
> 
> This patch is on top of Vasily Averin's fix commit. I think the
> use of kvzalloc for swap_info_struct is still needed in case
> nr_node_ids is really big on some systems.

I haven't seen any system with a huge nr_node_ids but using kvzalloc
is not harmfull.

> Cc: Vasily Averin <vvs@virtuozzo.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/swap.h | 11 ++++++++++-
>  mm/swapfile.c        |  3 ++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index d8a07a4f171d..3d3630b3f63d 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -233,7 +233,6 @@ struct swap_info_struct {
>  	unsigned long	flags;		/* SWP_USED etc: see above */
>  	signed short	prio;		/* swap priority of this type */
>  	struct plist_node list;		/* entry in swap_active_head */
> -	struct plist_node avail_lists[MAX_NUMNODES];/* entry in swap_avail_heads */
>  	signed char	type;		/* strange name for an index */
>  	unsigned int	max;		/* extent of the swap_map */
>  	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
> @@ -274,6 +273,16 @@ struct swap_info_struct {
>  					 */
>  	struct work_struct discard_work; /* discard worker */
>  	struct swap_cluster_list discard_clusters; /* discard clusters list */
> +	struct plist_node avail_lists[0]; /*
> +					   * entries in swap_avail_heads, one
> +					   * entry per node.
> +					   * Must be last as the number of the
> +					   * array is nr_node_ids, which is not
> +					   * a fixed value so have to allocate
> +					   * dynamically.
> +					   * And it has to be an array so that
> +					   * plist_for_each_* can work.
> +					   */
>  };
>  
>  #ifdef CONFIG_64BIT
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 8688ae65ef58..6e06821623f6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2812,8 +2812,9 @@ static struct swap_info_struct *alloc_swap_info(void)
>  	struct swap_info_struct *p;
>  	unsigned int type;
>  	int i;
> +	int size = sizeof(*p) + nr_node_ids * sizeof(struct plist_node);
>  
> -	p = kvzalloc(sizeof(*p), GFP_KERNEL);
> +	p = kvzalloc(size, GFP_KERNEL);
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.17.2
> 

-- 
Michal Hocko
SUSE Labs
