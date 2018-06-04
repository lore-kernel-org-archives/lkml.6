Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeFDJbn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:31:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53249 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeFDJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:31:41 -0400
Message-ID: <1528104679.2728.8.camel@pengutronix.de>
Subject: Re: [PATCH v2] gpu: drm: etnaviv: Change return type to vm_fault_t
From: Lucas Stach <l.stach@pengutronix.de>
To: Souptick Joarder <jrdr.linux@gmail.com>, christian.gmeiner@gmail.com,
        airlied@linux.ie, willy@infradead.org, daniel.vetter@ffwll.ch
Cc: linux+etnaviv@armlinux.org.uk, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 04 Jun 2018 11:31:19 +0200
In-Reply-To: <20180529134727.GA18374@jordon-HP-15-Notebook-PC>
References: <20180529134727.GA18374@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 29.05.2018, 19:17 +0530 schrieb Souptick Joarder:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Ref- commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> Previously vm_insert_page() returns err which driver
> mapped into VM_FAULT_* type. The new function
> vmf_insert_page() will replace this inefficiency by
> returning VM_FAULT_* type.
> 
> vmf_error() is the newly introduce inline function
> in 4.17-rc6.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Thanks, applied.

This won't be part of 4.18, as it's obviously too late for this
release, but will work it's way upstream with the next batch of etnaviv
updates.

Regards,
Lucas

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h |  3 ++-
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 37 +++++++++--------------
> ------------
>  2 files changed, 11 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> index a54f0b7..f6777f0 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -28,6 +28,7 @@
>  #include <linux/list.h>
>  #include <linux/types.h>
>  #include <linux/sizes.h>
> +#include <linux/mm_types.h>
>  
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -62,7 +63,7 @@ int etnaviv_ioctl_gem_submit(struct drm_device
> *dev, void *data,
>  		struct drm_file *file);
>  
>  int etnaviv_gem_mmap(struct file *filp, struct vm_area_struct *vma);
> -int etnaviv_gem_fault(struct vm_fault *vmf);
> +vm_fault_t etnaviv_gem_fault(struct vm_fault *vmf);
>  int etnaviv_gem_mmap_offset(struct drm_gem_object *obj, u64
> *offset);
>  struct sg_table *etnaviv_gem_prime_get_sg_table(struct
> drm_gem_object *obj);
>  void *etnaviv_gem_prime_vmap(struct drm_gem_object *obj);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index fcc969f..b36e1ef 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -180,31 +180,30 @@ int etnaviv_gem_mmap(struct file *filp, struct
> vm_area_struct *vma)
>  	return obj->ops->mmap(obj, vma);
>  }
>  
> -int etnaviv_gem_fault(struct vm_fault *vmf)
> +vm_fault_t etnaviv_gem_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct drm_gem_object *obj = vma->vm_private_data;
>  	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>  	struct page **pages, *page;
>  	pgoff_t pgoff;
> -	int ret;
> +	int err;
>  
>  	/*
>  	 * Make sure we don't parallel update on a fault, nor move
> or remove
> -	 * something from beneath our feet.  Note that
> vm_insert_page() is
> +	 * something from beneath our feet.  Note that
> vmf_insert_page() is
>  	 * specifically coded to take care of this, so we don't have
> to.
>  	 */
> -	ret = mutex_lock_interruptible(&etnaviv_obj->lock);
> -	if (ret)
> -		goto out;
> -
> +	err = mutex_lock_interruptible(&etnaviv_obj->lock);
> +	if (err)
> +		return VM_FAULT_NOPAGE;
>  	/* make sure we have pages attached now */
>  	pages = etnaviv_gem_get_pages(etnaviv_obj);
>  	mutex_unlock(&etnaviv_obj->lock);
>  
>  	if (IS_ERR(pages)) {
> -		ret = PTR_ERR(pages);
> -		goto out;
> +		err = PTR_ERR(pages);
> +		return vmf_error(err);
>  	}
>  
>  	/* We don't use vmf->pgoff since that has the fake offset:
> */
> @@ -215,25 +214,7 @@ int etnaviv_gem_fault(struct vm_fault *vmf)
>  	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
>  	     page_to_pfn(page), page_to_pfn(page) << PAGE_SHIFT);
>  
> -	ret = vm_insert_page(vma, vmf->address, page);
> -
> -out:
> -	switch (ret) {
> -	case -EAGAIN:
> -	case 0:
> -	case -ERESTARTSYS:
> -	case -EINTR:
> -	case -EBUSY:
> -		/*
> -		 * EBUSY is ok: this just means that another thread
> -		 * already did the job.
> -		 */
> -		return VM_FAULT_NOPAGE;
> -	case -ENOMEM:
> -		return VM_FAULT_OOM;
> -	default:
> -		return VM_FAULT_SIGBUS;
> -	}
> +	return vmf_insert_page(vma, vmf->address, page);
>  }
>  
>  int etnaviv_gem_mmap_offset(struct drm_gem_object *obj, u64 *offset)
