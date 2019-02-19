Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADE7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E242147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfBSDYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:24:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:37670 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfBSDYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:24:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 19:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,385,1544515200"; 
   d="scan'208";a="118975993"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.161.32])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2019 19:24:20 -0800
Date:   Tue, 19 Feb 2019 11:21:33 +0800
From:   Yuan Yao <yuan.yao@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        dan.j.williams@intel.com
Subject: Re: [PATCH] kernel, resource: use resource_overlaps() to simplify
 region_intersects()
Message-ID: <20190219032133.GA14023@yy-desk-7060>
References: <20190121012028.3913-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121012028.3913-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Reviewed-by: Yuan Yao <yuan.yao@linux.intel.com>


On Mon, Jan 21, 2019 at 09:20:28AM +0800, Wei Yang wrote:
> The three checks in region_intersects() is to see whether two resources
> overlap. This means it could be simplified with one resource_overlaps().
> 
> Also fix two typo in related function.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  kernel/iomem.c    |  4 ++--
>  kernel/resource.c | 11 +++++------
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/iomem.c b/kernel/iomem.c
> index f7525e14ebc6..93c264444510 100644
> --- a/kernel/iomem.c
> +++ b/kernel/iomem.c
> @@ -55,7 +55,7 @@ static void *try_ram_remap(resource_size_t offset, size_t size,
>   *
>   * MEMREMAP_WB - matches the default mapping for System RAM on
>   * the architecture.  This is usually a read-allocate write-back cache.
> - * Morever, if MEMREMAP_WB is specified and the requested remap region is RAM
> + * Moreover, if MEMREMAP_WB is specified and the requested remap region is RAM
>   * memremap() will bypass establishing a new mapping and instead return
>   * a pointer into the direct map.
>   *
> @@ -86,7 +86,7 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
>  	/* Try all mapping types requested until one returns non-NULL */
>  	if (flags & MEMREMAP_WB) {
>  		/*
> -		 * MEMREMAP_WB is special in that it can be satisifed
> +		 * MEMREMAP_WB is special in that it can be satisfied
>  		 * from the direct map.  Some archs depend on the
>  		 * capability of memremap() to autodetect cases where
>  		 * the requested range is potentially in System RAM.
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b0fbf685c77a..34dfb94305bb 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -521,21 +521,20 @@ EXPORT_SYMBOL_GPL(page_is_ram);
>  int region_intersects(resource_size_t start, size_t size, unsigned long flags,
>  		      unsigned long desc)
>  {
> -	resource_size_t end = start + size - 1;
> +	struct resource res;
>  	int type = 0; int other = 0;
>  	struct resource *p;
>  
> +	res.start = start;
> +	res.end = start + size - 1;
> +
>  	read_lock(&resource_lock);
>  	for (p = iomem_resource.child; p ; p = p->sibling) {
>  		bool is_type = (((p->flags & flags) == flags) &&
>  				((desc == IORES_DESC_NONE) ||
>  				 (desc == p->desc)));
>  
> -		if (start >= p->start && start <= p->end)
> -			is_type ? type++ : other++;
> -		if (end >= p->start && end <= p->end)
> -			is_type ? type++ : other++;
> -		if (p->start >= start && p->end <= end)
> +		if (resource_overlaps(p, &res))
>  			is_type ? type++ : other++;
>  	}
>  	read_unlock(&resource_lock);
> -- 
> 2.19.1
