Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754561AbeEHHIl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:08:41 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38028 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754269AbeEHHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:08:39 -0400
X-Google-Smtp-Source: AB8JxZoczXk+8ZvS4w5t6hDTO8FJsLoJIdy6p+zqEEhT85d7VV0mhfy5beAJXNN6TFxbfubgAdSoaQ==
Subject: Re: linux-next: build failure after merge of the drm-intel tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>
Cc: Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Nipun Gupta <nipun.gupta@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20180508110716.53dfef41@canb.auug.org.au>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <9043c118-6095-1eca-3bac-455ad136823e@gmail.com>
Date: Tue, 8 May 2018 10:08:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508110716.53dfef41@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 04:07 AM, Stephen Rothwell wrote:
> Hi all,
>
> After merging the drm-intel tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpu/drm/xen/xen_drm_front.c: In function 'xen_drv_probe':
> drivers/gpu/drm/xen/xen_drm_front.c:740:10: error: 'struct bus_type' has no member named 'force_dma'
>    dev->bus->force_dma = true;
>            ^~
> drivers/gpu/drm/xen/xen_drm_front.c:742:8: error: too few arguments to function 'of_dma_configure'
>    ret = of_dma_configure(dev, NULL);
>          ^~~~~~~~~~~~~~~~
> In file included from drivers/gpu/drm/xen/xen_drm_front.c:16:0:
> include/linux/of_device.h:58:5: note: declared here
>   int of_dma_configure(struct device *dev,
>       ^~~~~~~~~~~~~~~~
>
> Caused by commit
>
>    c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")
>
> interacting with commit
>
>    3d6ce86ee794 ("drivers: remove force dma flag from buses")
>
> from the dma-mapping tree.
>
> I have added the following merge fix patch:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 8 May 2018 11:02:24 +1000
> Subject: [PATCH] drm/xen-front: merge fix for "drivers: remove force dma flag from buses"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Thank you,
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/xen/xen_drm_front.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
> index 1b0ea9ac330e..0e486cb1c10c 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
> @@ -737,9 +737,8 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
>   	 * is not correct: to fix this call of_dma_configure() with a NULL
>   	 * node to set default DMA ops.
>   	 */
> -	dev->bus->force_dma = true;
>   	dev->coherent_dma_mask = DMA_BIT_MASK(32);
> -	ret = of_dma_configure(dev, NULL);
> +	ret = of_dma_configure(dev, NULL, true);
>   	if (ret < 0) {
>   		DRM_ERROR("Cannot setup DMA ops, ret %d", ret);
>   		return ret;
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
