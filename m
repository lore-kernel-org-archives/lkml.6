Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164507AbeE1Mv0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:51:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45855 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937832AbeE1MvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:51:22 -0400
Message-ID: <01fca256074b74598608c261a2f956af7308e1db.camel@pengutronix.de>
Subject: Re: [PATCH] gpu: drm: etnaviv: Change return type to vm_fault_t
From: Lucas Stach <l.stach@pengutronix.de>
To: Souptick Joarder <jrdr.linux@gmail.com>, linux+etnaviv@armlinux.org.uk,
        christian.gmeiner@gmail.com, airlied@linux.ie, willy@infradead.org,
        daniel.vetter@ffwll.ch
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date: Mon, 28 May 2018 14:50:57 +0200
In-Reply-To: <20180521171241.GA18441@jordon-HP-15-Notebook-PC>
References: <20180521171241.GA18441@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

Am Montag, den 21.05.2018, 22:42 +0530 schrieb Souptick Joarder:
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
> A non-fatal signal being delivered to a task which is
> in the middle of a page fault may well end up in an
> infinite loop, attempting to handle the page fault and
> failing forever.
> 
> On seeing NOPAGE, the fault handler believes the PTE
> is in the page table, so does nothing before it returns
> to arch code. It will end up returning to userspace if
> the signal is non-fatal, at which point it'll go right
> back into the page fault handler, and mutex_lock_interruptible()
> will immediately fail.  So we've converted a sleeping lock
> into the most expensive spinlock.
> 
> I don't think the graphics drivers really want to be
> interrupted by any signal.  I think they want to be
> interruptible by fatal signals and should use the
> mutex_lock_killable / fatal_signal_pending family of
> functions. So mutex_lock_interruptible() is replaced
> by mutex_lock_killable()

I don't think the other thread discussing this issue has reached a
proper conclusion and I would rather not pull in a patch based on thin
reasoning. If we want to change this behavior I would really like to
see the issue it is solving and it should be a separate patch, not
intermixed with some return value change.

Regards,
Lucas

> vmf_error() is the newly introduce inline function
> in 4.17-rc6.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h |  3 ++-
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 31 ++++++-------------------
> ------
>  2 files changed, 8 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> index a54f0b7..f6777f0 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -28,6 +28,7 @@
>  #include <linux/list.h>
>  #include <linux/types.h>
>  #include <linux/sizes.h>
> +#include <linux/mm_types.h>
>  
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -62,7 +63,7 @@ int etnaviv_ioctl_gem_submit(struct drm_device
> *dev, void *data,
>  		struct drm_file *file);
>  
>  int etnaviv_gem_mmap(struct file *filp, struct vm_area_struct *vma);
> -int etnaviv_gem_fault(struct vm_fault *vmf);
> +vm_fault_t etnaviv_gem_fault(struct vm_fault *vmf);
>  int etnaviv_gem_mmap_offset(struct drm_gem_object *obj, u64
> *offset);
>  struct sg_table *etnaviv_gem_prime_get_sg_table(struct
> drm_gem_object *obj);
>  void *etnaviv_gem_prime_vmap(struct drm_gem_object *obj);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index fcc969f..d9b13f0 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -180,7 +180,7 @@ int etnaviv_gem_mmap(struct file *filp, struct
> vm_area_struct *vma)
>  	return obj->ops->mmap(obj, vma);
>  }
>  
> -int etnaviv_gem_fault(struct vm_fault *vmf)
> +vm_fault_t etnaviv_gem_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct drm_gem_object *obj = vma->vm_private_data;
> @@ -191,20 +191,19 @@ int etnaviv_gem_fault(struct vm_fault *vmf)
>  
>  	/*
>  	 * Make sure we don't parallel update on a fault, nor move
> or remove
> -	 * something from beneath our feet.  Note that
> vm_insert_page() is
> +	 * something from beneath our feet.  Note that
> vmf_insert_page() is
>  	 * specifically coded to take care of this, so we don't have
> to.
>  	 */
> -	ret = mutex_lock_interruptible(&etnaviv_obj->lock);
> +	ret = mutex_lock_killable(&etnaviv_obj->lock);
>  	if (ret)
> -		goto out;
> -
> +		return VM_FAULT_NOPAGE;
>  	/* make sure we have pages attached now */
>  	pages = etnaviv_gem_get_pages(etnaviv_obj);
>  	mutex_unlock(&etnaviv_obj->lock);
>  
>  	if (IS_ERR(pages)) {
>  		ret = PTR_ERR(pages);
> -		goto out;
> +		return vmf_error(ret);
>  	}
>  
>  	/* We don't use vmf->pgoff since that has the fake offset:
> */
> @@ -215,25 +214,7 @@ int etnaviv_gem_fault(struct vm_fault *vmf)
>  	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
>  	     page_to_pfn(page), page_to_pfn(page) << PAGE_SHIFT);
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
> -		 * EBUSY is ok: this just means that another thread
> -		 * already did the job.
> -		 */
> -		return VM_FAULT_NOPAGE;
> -	case -ENOMEM:
> -		return VM_FAULT_OOM;
> -	default:
> -		return VM_FAULT_SIGBUS;
> -	}
> +	return vmf_insert_page(vma, vmf->address, page);
>  }
>  
>  int etnaviv_gem_mmap_offset(struct drm_gem_object *obj, u64 *offset)
