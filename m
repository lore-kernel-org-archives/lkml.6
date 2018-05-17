Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeEQSSS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:18:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeEQSSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:18:17 -0400
Date: Thu, 17 May 2018 11:18:15 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-mm@kvack.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/dmapool: localize page allocations
Message-ID: <20180517181815.GC26718@bombadil.infradead.org>
References: <1526578581-7658-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526578581-7658-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 01:36:19PM -0400, Sinan Kaya wrote:
> Try to keep the pool closer to the device's NUMA node by changing kmalloc()
> to kmalloc_node() and devres_alloc() to devres_alloc_node().

Have you measured any performance gains by doing this?  The thing is that
these allocations are for the metadata about the page, and the page is
going to be used by CPUs in every node.  So it's not clear to me that
allocating it on the node nearest to the device is going to be any sort
of a win.

> @@ -504,7 +504,8 @@ struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
>  {
>  	struct dma_pool **ptr, *pool;
>  
> -	ptr = devres_alloc(dmam_pool_release, sizeof(*ptr), GFP_KERNEL);
> +	ptr = devres_alloc_node(dmam_pool_release, sizeof(*ptr), GFP_KERNEL,
> +				dev_to_node(dev));
>  	if (!ptr)
>  		return NULL;

... are we really calling devres_alloc() for sizeof(void *)?  That's sad.
