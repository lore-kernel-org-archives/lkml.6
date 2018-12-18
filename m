Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5C8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDEF21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="IvBnaQXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeLRTUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:20:33 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:60364 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=8do4X7Uz9PMiaMztRi95Zr0NPZOgiH8juAmY4uRymXk=;
        b=IvBnaQXgjAabOaJXljCiTZYu/NRrzGH6JGHTSmN0YSmGN7uouVlNjFhoeWn/iFJBYXcPvefyunTiCiqeNMnk7lJMfFoYKWrws2dAa0qpGh1gK63sigkJxww3VcMjwBZodaM/elzzVx5onM0QB7LRkRZIS0u9jqdhx+HJesbeSD3/qZXbLczuOJYrNqLJC6u4dqfAm7I4bvCRZkfJ2oNh6zqc+Tv+vMgtzgAcqZwxm6bS4ugx1SpdI58MUsIUZJv2qsyTCgbbfiEc72awk7MQHxqt2MVaTvy6JgL1x0BfhjhemcB7PF9dcrd2VzcNoaYYOcrihPBRj4yH7QWrme91yw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:62873 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gZKup-0007MS-TY; Tue, 18 Dec 2018 20:20:27 +0100
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181127103252.20994-1-andr2000@gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
Date:   Tue, 18 Dec 2018 20:20:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181127103252.20994-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 27.11.2018 11.32, skrev Oleksandr Andrushchenko:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> When GEM backing storage is allocated with drm_gem_get_pages
> the backing pages may be cached, thus making it possible that
> the backend sees only partial content of the buffer which may
> lead to screen artifacts. Make sure that the frontend's
> memory is coherent and the backend always sees correct display
> buffer content.
>
> Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/xen/xen_drm_front_gem.c | 62 +++++++++++++++++++------
>   1 file changed, 48 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> index 47ff019d3aef..c592735e49d2 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> @@ -33,8 +33,11 @@ struct xen_gem_object {
>   	/* set for buffers allocated by the backend */
>   	bool be_alloc;
>   
> -	/* this is for imported PRIME buffer */
> -	struct sg_table *sgt_imported;
> +	/*
> +	 * this is for imported PRIME buffer or the one allocated via
> +	 * drm_gem_get_pages.
> +	 */
> +	struct sg_table *sgt;
>   };
>   
>   static inline struct xen_gem_object *
> @@ -77,10 +80,21 @@ static struct xen_gem_object *gem_create_obj(struct drm_device *dev,
>   	return xen_obj;
>   }
>   
> +struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
> +{
> +	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
> +
> +	if (!xen_obj->pages)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
> +}
> +
>   static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>   {
>   	struct xen_drm_front_drm_info *drm_info = dev->dev_private;
>   	struct xen_gem_object *xen_obj;
> +	struct address_space *mapping;
>   	int ret;
>   
>   	size = round_up(size, PAGE_SIZE);
> @@ -113,10 +127,14 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>   		xen_obj->be_alloc = true;
>   		return xen_obj;
>   	}
> +
>   	/*
>   	 * need to allocate backing pages now, so we can share those
>   	 * with the backend
>   	 */


Let's see if I understand what you're doing:

Here you say that the pages should be DMA accessible for devices that can
only see 4GB.

> +	mapping = xen_obj->base.filp->f_mapping;
> +	mapping_set_gfp_mask(mapping, GFP_USER | __GFP_DMA32);
> +
>   	xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
>   	xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
>   	if (IS_ERR_OR_NULL(xen_obj->pages)) {
> @@ -125,8 +143,27 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>   		goto fail;
>   	}
>   
> +	xen_obj->sgt = xen_drm_front_gem_get_sg_table(&xen_obj->base);
> +	if (IS_ERR_OR_NULL(xen_obj->sgt)){
> +		ret = PTR_ERR(xen_obj->sgt);
> +		xen_obj->sgt = NULL;
> +		goto fail_put_pages;
> +	}
> +
> +	if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
> +			DMA_BIDIRECTIONAL)) {


Are you using the DMA streaming API as a way to flush the caches?
Does this mean that GFP_USER isn't making the buffer coherent?

Noralf.

> +		ret = -EFAULT;
> +		goto fail_free_sgt;
> +	}
> +
>   	return xen_obj;
>   
> +fail_free_sgt:
> +	sg_free_table(xen_obj->sgt);
> +	xen_obj->sgt = NULL;
> +fail_put_pages:
> +	drm_gem_put_pages(&xen_obj->base, xen_obj->pages, true, false);
> +	xen_obj->pages = NULL;
>   fail:
>   	DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
>   	return ERR_PTR(ret);
> @@ -149,7 +186,7 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
>   	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>   
>   	if (xen_obj->base.import_attach) {
> -		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt_imported);
> +		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt);
>   		gem_free_pages_array(xen_obj);
>   	} else {
>   		if (xen_obj->pages) {
> @@ -158,6 +195,13 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
>   							xen_obj->pages);
>   				gem_free_pages_array(xen_obj);
>   			} else {
> +				if (xen_obj->sgt) {
> +					dma_unmap_sg(xen_obj->base.dev->dev,
> +						     xen_obj->sgt->sgl,
> +						     xen_obj->sgt->nents,
> +						     DMA_BIDIRECTIONAL);
> +					sg_free_table(xen_obj->sgt);
> +				}
>   				drm_gem_put_pages(&xen_obj->base,
>   						  xen_obj->pages, true, false);
>   			}
> @@ -174,16 +218,6 @@ struct page **xen_drm_front_gem_get_pages(struct drm_gem_object *gem_obj)
>   	return xen_obj->pages;
>   }
>   
> -struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
> -{
> -	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
> -
> -	if (!xen_obj->pages)
> -		return ERR_PTR(-ENOMEM);
> -
> -	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
> -}
> -
>   struct drm_gem_object *
>   xen_drm_front_gem_import_sg_table(struct drm_device *dev,
>   				  struct dma_buf_attachment *attach,
> @@ -203,7 +237,7 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
>   	if (ret < 0)
>   		return ERR_PTR(ret);
>   
> -	xen_obj->sgt_imported = sgt;
> +	xen_obj->sgt = sgt;
>   
>   	ret = drm_prime_sg_to_page_addr_arrays(sgt, xen_obj->pages,
>   					       NULL, xen_obj->num_pages);
