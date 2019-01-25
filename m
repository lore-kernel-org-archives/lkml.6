Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEBDC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3AB2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="hYmFchma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfAYRTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:19:23 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:37072 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYRTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=3sjfNLszyjWDC/jo15UgIwGUs42l1MlpSXqlFMM/Vzo=;
        b=hYmFchmaiCYj4Wp8ld9rF7bGNoMG51G0cQhPkSCJjRL30Wh3rZkpKE3U+9iy0lnx9/7H0G+k52Q8LnmcDxSklLyKuj8wmY8In3C7TPDItZHMOHb2TBQXqSEOYvTCe76jdXJyYO6+glNtVtDmlxjyonXrmMA62c8fcgBB+2/evKSbLYe/FngcyLO54O4liMSwpJgRkaToEUDBx4i8eDO8dBaQVrK7E53S+Gi/tMGP6sPzEQdRogAC/ptI/iZNKUb/EGu6zBGdo7Y6FMQbAkErgFK/QJQgTYb8uSEVadcHQFU0+BrqEG3NqZ1cocBjbbNks+oDDi+H97gv4VGKaoxwQw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:50359 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn58S-0002TC-Ht; Fri, 25 Jan 2019 18:19:20 +0100
Subject: Re: [PATCH v3 16/23] drm/qxl: implement prime kmap/kunmap
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-17-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <ba5088e7-fc42-8918-fb26-94c299caa9f9@tronnes.org>
Date:   Fri, 25 Jan 2019 18:19:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-17-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> Generic fbdev emulation needs this.  Also: We must keep track of the
> number of mappings now, so we don't unmap early in case two users want a
> kmap of the same bo.  Add a sanity check to destroy callback to make
> sure kmap/kunmap is balanced.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Just a note: You catch the one-to-many kmap type of unbalance, but not
the one-too-many kunmap situation.

Acked-by: Noralf Trønnes <noralf@tronnes.org>


>  drivers/gpu/drm/qxl/qxl_drv.h    |  1 +
>  drivers/gpu/drm/qxl/qxl_object.c |  6 ++++++
>  drivers/gpu/drm/qxl/qxl_prime.c  | 17 +++++++++++++----
>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
> index 43c6df9cf9..8c3af1cdbe 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -84,6 +84,7 @@ struct qxl_bo {
>  	struct ttm_bo_kmap_obj		kmap;
>  	unsigned int pin_count;
>  	void				*kptr;
> +	unsigned int                    map_count;
>  	int                             type;
>  
>  	/* Constant after initialization */
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
> index 024c8dd317..4928fa6029 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -36,6 +36,7 @@ static void qxl_ttm_bo_destroy(struct ttm_buffer_object *tbo)
>  	qdev = (struct qxl_device *)bo->gem_base.dev->dev_private;
>  
>  	qxl_surface_evict(qdev, bo, false);
> +	WARN_ON_ONCE(bo->map_count > 0);
>  	mutex_lock(&qdev->gem.mutex);
>  	list_del_init(&bo->list);
>  	mutex_unlock(&qdev->gem.mutex);
> @@ -131,6 +132,7 @@ int qxl_bo_kmap(struct qxl_bo *bo, void **ptr)
>  	if (bo->kptr) {
>  		if (ptr)
>  			*ptr = bo->kptr;
> +		bo->map_count++;
>  		return 0;
>  	}
>  	r = ttm_bo_kmap(&bo->tbo, 0, bo->tbo.num_pages, &bo->kmap);
> @@ -139,6 +141,7 @@ int qxl_bo_kmap(struct qxl_bo *bo, void **ptr)
>  	bo->kptr = ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);
>  	if (ptr)
>  		*ptr = bo->kptr;
> +	bo->map_count = 1;
>  	return 0;
>  }
>  
> @@ -180,6 +183,9 @@ void qxl_bo_kunmap(struct qxl_bo *bo)
>  {
>  	if (bo->kptr == NULL)
>  		return;
> +	bo->map_count--;
> +	if (bo->map_count > 0)
> +		return;
>  	bo->kptr = NULL;
>  	ttm_bo_kunmap(&bo->kmap);
>  }
> diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
> index a55dece118..708378844c 100644
> --- a/drivers/gpu/drm/qxl/qxl_prime.c
> +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> @@ -22,7 +22,7 @@
>   * Authors: Andreas Pokorny
>   */
>  
> -#include "qxl_drv.h"
> +#include "qxl_object.h"
>  
>  /* Empty Implementations as there should not be any other driver for a virtual
>   * device that might share buffers with qxl */
> @@ -54,13 +54,22 @@ struct drm_gem_object *qxl_gem_prime_import_sg_table(
>  
>  void *qxl_gem_prime_vmap(struct drm_gem_object *obj)
>  {
> -	WARN_ONCE(1, "not implemented");
> -	return ERR_PTR(-ENOSYS);
> +	struct qxl_bo *bo = gem_to_qxl_bo(obj);
> +	void *ptr;
> +	int ret;
> +
> +	ret = qxl_bo_kmap(bo, &ptr);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	return ptr;
>  }
>  
>  void qxl_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
>  {
> -	WARN_ONCE(1, "not implemented");
> +	struct qxl_bo *bo = gem_to_qxl_bo(obj);
> +
> +	qxl_bo_kunmap(bo);
>  }
>  
>  int qxl_gem_prime_mmap(struct drm_gem_object *obj,
> 
