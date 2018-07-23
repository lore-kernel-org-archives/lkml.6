Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198CEECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE742064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE742064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbeGWJmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:42:20 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:50579 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbeGWJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:42:20 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 75DB624000B;
        Mon, 23 Jul 2018 08:42:09 +0000 (UTC)
Date:   Mon, 23 Jul 2018 10:42:07 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
Message-ID: <20180723084207.GI6784@w540>
References: <20180719130516.1989-1-hch@lst.de>
 <20180719130516.1989-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline
In-Reply-To: <20180719130516.1989-5-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Christoph,

I have a single comment on something I noticed which might be an
implementation bug. On the overall patch architecture, it's very hard
for me to provide a valuable opinion as it's all relatively new for me
here :)

On Thu, Jul 19, 2018 at 06:05:15AM -0700, Christoph Hellwig wrote:
> Half of the file just contains platform device memory setup code which
> is required for all builds, and half contains helpers for dma coherent
> allocation, which is only needed if CONFIG_DMA_NONCOHERENT is enabled.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/sh/kernel/Makefile       |  2 +-
>  arch/sh/kernel/dma-coherent.c | 85 +++++++++++++++++++++++++++++++++++
>  arch/sh/mm/consistent.c       | 80 ---------------------------------
>  3 files changed, 86 insertions(+), 81 deletions(-)
>  create mode 100644 arch/sh/kernel/dma-coherent.c
>
> diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
> index cb5f1bfb52de..d5ddb64bfffe 100644
> --- a/arch/sh/kernel/Makefile
> +++ b/arch/sh/kernel/Makefile
> @@ -45,7 +45,7 @@ obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
>  obj-$(CONFIG_HIBERNATION)	+= swsusp.o
>  obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
> -obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o
> +obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o dma-coherent.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
>
>  ccflags-y := -Werror
> diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
> new file mode 100644
> index 000000000000..0e7720b5d495
> --- /dev/null
> +++ b/arch/sh/kernel/dma-coherent.c
> @@ -0,0 +1,85 @@
> +/*
> + * Copyright (C) 2004 - 2007  Paul Mundt
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +#include <linux/mm.h>
> +#include <linux/init.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <asm/cacheflush.h>
> +#include <asm/addrspace.h>
> +
> +void *dma_generic_alloc_coherent(struct device *dev, size_t size,
> +				 dma_addr_t *dma_handle, gfp_t gfp,
> +				 unsigned long attrs)
> +{
> +	void *ret, *ret_nocache;
> +	int order = get_order(size);
> +
> +	gfp |= __GFP_ZERO;
> +
> +	ret = (void *)__get_free_pages(gfp, order);
> +	if (!ret)
> +		return NULL;
> +
> +	/*
> +	 * Pages from the page allocator may have data present in
> +	 * cache. So flush the cache before using uncached memory.
> +	 */
> +	sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
> +
> +	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
> +	if (!ret_nocache) {
> +		free_pages((unsigned long)ret, order);
> +		return NULL;
> +	}
> +
> +	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
> +
> +	*dma_handle = virt_to_phys(ret);
> +	if (!WARN_ON(!dev))
> +		*dma_handle - PFN_PHYS(dev->dma_pfn_offset);

I guess this comes from below...

> +
> +	return ret_nocache;
> +}
> +
> +void dma_generic_free_coherent(struct device *dev, size_t size,
> +			       void *vaddr, dma_addr_t dma_handle,
> +			       unsigned long attrs)
> +{
> +	int order = get_order(size);
> +	unsigned long pfn = (dma_handle >> PAGE_SHIFT);
> +	int k;
> +
> +	if (!WARN_ON(!dev))
> +		pfn + dev->dma_pfn_offset;
> +
> +	for (k = 0; k < (1 << order); k++)
> +		__free_pages(pfn_to_page(pfn + k), 0);
> +
> +	iounmap(vaddr);
> +}
> +
> +void sh_sync_dma_for_device(void *vaddr, size_t size,
> +		    enum dma_data_direction direction)
> +{
> +	void *addr = sh_cacheop_vaddr(vaddr);
> +
> +	switch (direction) {
> +	case DMA_FROM_DEVICE:		/* invalidate only */
> +		__flush_invalidate_region(addr, size);
> +		break;
> +	case DMA_TO_DEVICE:		/* writeback only */
> +		__flush_wback_region(addr, size);
> +		break;
> +	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
> +		__flush_purge_region(addr, size);
> +		break;
> +	default:
> +		BUG();
> +	}
> +}
> +EXPORT_SYMBOL(sh_sync_dma_for_device);
> diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
> index 1622ae6b9dbd..792f36129062 100644
> --- a/arch/sh/mm/consistent.c
> +++ b/arch/sh/mm/consistent.c
> @@ -1,10 +1,6 @@
>  /*
> - * arch/sh/mm/consistent.c
> - *
>   * Copyright (C) 2004 - 2007  Paul Mundt
>   *
> - * Declared coherent memory functions based on arch/x86/kernel/pci-dma_32.c
> - *
>   * This file is subject to the terms and conditions of the GNU General Public
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
> @@ -13,83 +9,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/dma-debug.h>
>  #include <linux/io.h>
> -#include <linux/module.h>
> -#include <linux/gfp.h>
> -#include <asm/cacheflush.h>
> -#include <asm/addrspace.h>
> -
> -void *dma_generic_alloc_coherent(struct device *dev, size_t size,
> -				 dma_addr_t *dma_handle, gfp_t gfp,
> -				 unsigned long attrs)
> -{
> -	void *ret, *ret_nocache;
> -	int order = get_order(size);
> -
> -	gfp |= __GFP_ZERO;
> -
> -	ret = (void *)__get_free_pages(gfp, order);
> -	if (!ret)
> -		return NULL;
> -
> -	/*
> -	 * Pages from the page allocator may have data present in
> -	 * cache. So flush the cache before using uncached memory.
> -	 */
> -	sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
> -
> -	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
> -	if (!ret_nocache) {
> -		free_pages((unsigned long)ret, order);
> -		return NULL;
> -	}
> -
> -	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
> -
> -	*dma_handle = virt_to_phys(ret);
> -	if (!WARN_ON(!dev))
> -		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);

... here

Is the s/-=/- intended?

Snippets copied here below:

> +	*dma_handle = virt_to_phys(ret);
> +	if (!WARN_ON(!dev))
> +		*dma_handle - PFN_PHYS(dev->dma_pfn_offset);
vs
> -	*dma_handle = virt_to_phys(ret);
> -	if (!WARN_ON(!dev))
> -		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);



--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbVZTfAAoJEHI0Bo8WoVY8ACMP/3SFUmXHB3DC+La4lFnC9/Wn
wzjjONpPwkZLx4Ly7r2AxUSraloiwUhp00fT7glnOzYF9FgOJz78oFebb1evh4D8
+UQMoTHhjRl0TF1OcQYvvVl0OBNDfNfiLlwC5miPuViFsas37OITFavIlwzp8zID
jYw1GtLA0QyffdVhgVwIbODZDwFFbEg//EIwU/yLHu9egdRBxOIRgYs854yQXwa3
pBn/2NugUgByVLFcpg5dMX3eyA4MeVGPTlxhc6OFiq9D8zAMiFxaxwI8zNryvN2m
D1yoVvodrb7TAi7sTP6Obwbaw5DgpNFsFwXgYfC7hFbtj7EjzQjEkjqf76KGfqjB
Vx+SSdnUTZBpVe4n0ynPHLYKDFBJXUxERn/+7/5XbUw5w33MeR5ebIvojqQjN7Gc
psCB6Za2TnHKASdpSm4e2cewfqnfTPUOHS+Yv4DNFXJa7RttRZs5lptGIwp2YwNq
cd6h0jmJeRhWZITvWqJ/BQ+fk/WgoSUIoEX6RKZYYM1l0DfJmOzeJqNHVBLLb5a1
xY0zugo+n52pHoAt31m0jxJtDTVWkMLA1bKyLxRyTZAXXWBNIRMrCyte9UdYG2y8
rq+oxkfN+8Sc7A28hNUWtHLxG4NHA5v/i8b7PotGItdXCmlkIqNKaTrx8NR8pqwK
tQ6PrQzodz/7fD3RYMgQ
=p5wX
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
