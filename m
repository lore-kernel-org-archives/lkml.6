Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932182AbeBABqU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 20:46:20 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38603 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932118AbeBABqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 20:46:18 -0500
X-Google-Smtp-Source: AH8x224cETqoHt54J0OItjff4ExQ2xi5yYyUbmsSvl3k6MG2DhPr9M3i5aRhD4K2SUJfMDDcwfEs9w==
Message-ID: <1517449575.3715.113.camel@gmail.com>
Subject: Re: [PATCH] iommu/vt-d: add NUMA awareness to intel_alloc_coherent()
From: Eric Dumazet <eric.dumazet@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Benjamin Serebrin <serebrin@google.com>,
        David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Date: Wed, 31 Jan 2018 17:46:15 -0800
In-Reply-To: <1517438756.3715.108.camel@gmail.com>
References: <1517438756.3715.108.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-01-31 at 14:45 -0800, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Some devices (like mlx4) try hard to allocate memory on selected
> NUMA node, but it turns out intel_alloc_coherent() is not NUMA
> aware yet.
> 
> Note that dma_generic_alloc_coherent() in arch/x86/kernel/pci-dma.c
> gets this right.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Benjamin Serebrin <serebrin@google.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/intel-iommu.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a1373cf343269455808f66ad18dc0a2fb7aa73f2..0efef077abc099eb29ebc5cefdd1b996f025dffd 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3734,8 +3734,11 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
>  		}
>  	}
>  
> -	if (!page)
> -		page = alloc_pages(flags, order);
> +	if (!page) {
> +		page = alloc_pages_node(dev_to_node(dev), flags, order);
> +		if (!page)
> +			page = alloc_pages(flags, order);

I'll send a V2 without the fallback to alloc_pages()

This seems not necessary at all.


> +	}
>  	if (!page)
>  		return NULL;
>  	memset(page_address(page), 0, size);
