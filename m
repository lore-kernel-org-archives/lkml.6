Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C09C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F13120850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfAHO3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:29:48 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:46713 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728573AbfAHO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:29:48 -0500
X-IronPort-AV: E=Sophos;i="5.56,454,1539640800"; 
   d="scan'208";a="363106391"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 15:29:45 +0100
Date:   Tue, 8 Jan 2019 15:29:43 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Christoph Hellwig <hch@lst.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-mapping: remove dma_zalloc_coherent()
In-Reply-To: <20190108130701.14161-4-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1901081528350.6130@hadrien>
References: <20190108130701.14161-1-hch@lst.de> <20190108130701.14161-4-hch@lst.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2019, Christoph Hellwig wrote:

> From: Luis Chamberlain <mcgrof@kernel.org>
>
> dma_zalloc_coherent() is no longer needed as it has no users because
> dma_alloc_coherent() already zeroes out memory for us.
>
> The Coccinelle grammar rule that used to check for dma_alloc_coherent()
> + memset() is modified so that it just tells the user that the memset is
> not needed anymore.
>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/dma-mapping.h                      |  9 ---------
>  scripts/coccinelle/api/alloc/alloc_cast.cocci    |  8 ++++----
>  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 11 +----------
>  3 files changed, 5 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index cef2127e1d70..f6ded992c183 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -717,15 +717,6 @@ static inline unsigned long dma_max_pfn(struct device *dev)
>  }
>  #endif
>
> -/*
> - * Please always use dma_alloc_coherent instead as it already zeroes the memory!
> - */
> -static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
> -					dma_addr_t *dma_handle, gfp_t flag)
> -{
> -	return dma_alloc_coherent(dev, size, dma_handle, flag);
> -}
> -
>  static inline int dma_get_cache_alignment(void)
>  {
>  #ifdef ARCH_DMA_MINALIGN
> diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/coccinelle/api/alloc/alloc_cast.cocci
> index 408ee3879f9b..18fedf7c60ed 100644
> --- a/scripts/coccinelle/api/alloc/alloc_cast.cocci
> +++ b/scripts/coccinelle/api/alloc/alloc_cast.cocci
> @@ -32,7 +32,7 @@ type T;
>    (T *)
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> -   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
>     kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
>     pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
>     kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> @@ -55,7 +55,7 @@ type r1.T;
>  * (T *)
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> -   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
>     kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
>     pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
>     kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> @@ -78,7 +78,7 @@ type r1.T;
>  - (T *)
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> -   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
>     kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
>     pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
>     kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> @@ -95,7 +95,7 @@ position p;
>   (T@p *)
>    \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
>     kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
> -   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
> +   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
>     kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
>     pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
>     kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
> diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> index d819275b7fde..5cd1991c582e 100644
> --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> @@ -69,15 +69,6 @@ statement S;
>  - x = (T)vmalloc(E1);
>  + x = (T)vzalloc(E1);
>  |
> -- x = dma_alloc_coherent(E2,E1,E3,E4);
> -+ x = dma_zalloc_coherent(E2,E1,E3,E4);
> -|
> -- x = (T *)dma_alloc_coherent(E2,E1,E3,E4);
> -+ x = dma_zalloc_coherent(E2,E1,E3,E4);
> -|
> -- x = (T)dma_alloc_coherent(E2,E1,E3,E4);
> -+ x = (T)dma_zalloc_coherent(E2,E1,E3,E4);

Perhaps it would be better to make a separate rule that removed the
memset?  It wouldn't need the three cases.
x = (T)dma_alloc_coherent(E2,E1,E3,E4); would take care of everything.

julia

> -|
>  - x = kmalloc_node(E1,E2,E3);
>  + x = kzalloc_node(E1,E2,E3);
>  |
> @@ -225,7 +216,7 @@ p << r2.p;
>  x << r2.x;
>  @@
>
> -msg="WARNING: dma_zalloc_coherent should be used for %s, instead of dma_alloc_coherent/memset" % (x)
> +msg="WARNING: dma_alloc_coherent use in %s already zeroes out memory,  so memset is not needed" % (x)
>  coccilib.report.print_report(p[0], msg)
>
>  //-----------------------------------------------------------------
> --
> 2.20.1
>
>
