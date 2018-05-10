Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966367AbeEJQab (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:30:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935410AbeEJQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:30:30 -0400
Date: Thu, 10 May 2018 09:30:23 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Huaisheng Ye <yehs1@lenovo.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, mhocko@suse.com,
        vbabka@suse.cz, mgorman@techsingularity.net,
        alexander.levin@verizon.com, colyli@suse.de, chengnt@lenovo.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] include/linux/gfp.h: getting rid of GFP_ZONE_TABLE/BAD
Message-ID: <20180510163023.GB30442@bombadil.infradead.org>
References: <1525968625-40825-1-git-send-email-yehs1@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525968625-40825-1-git-send-email-yehs1@lenovo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 12:10:25AM +0800, Huaisheng Ye wrote:
> -#define __GFP_DMA	((__force gfp_t)___GFP_DMA)
> -#define __GFP_HIGHMEM	((__force gfp_t)___GFP_HIGHMEM)
> -#define __GFP_DMA32	((__force gfp_t)___GFP_DMA32)
> +#define __GFP_DMA	((__force gfp_t)OPT_ZONE_DMA ^ ZONE_NORMAL)
> +#define __GFP_HIGHMEM	((__force gfp_t)ZONE_MOVABLE ^ ZONE_NORMAL)
> +#define __GFP_DMA32	((__force gfp_t)OPT_ZONE_DMA32 ^ ZONE_NORMAL)

No, you've made gfp_zone even more complex than it already is.
If you can't use OPT_ZONE_HIGHMEM here, then this is a waste of time.

>  static inline enum zone_type gfp_zone(gfp_t flags)
>  {
>  	enum zone_type z;
> -	int bit = (__force int) (flags & GFP_ZONEMASK);
> +	z = ((__force unsigned int)flags & ___GFP_ZONE_MASK) ^ ZONE_NORMAL;
> +
> +	if (z > OPT_ZONE_HIGHMEM)
> +		z = OPT_ZONE_HIGHMEM +
> +			!!((__force unsigned int)flags & ___GFP_MOVABLE);
>  
> -	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
> -					 ((1 << GFP_ZONES_SHIFT) - 1);
> -	VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> +	VM_BUG_ON(z > ZONE_MOVABLE);
>  	return z;
>  }
