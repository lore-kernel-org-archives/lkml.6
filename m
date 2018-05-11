Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeEKJWe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:22:34 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42892 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbeEKJWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:22:33 -0400
Date: Fri, 11 May 2018 10:22:06 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v2] gpu: drm: armada: Adding new typedef vm_fault_t
Message-ID: <20180511092205.GB16141@n2100.armlinux.org.uk>
References: <20180510150448.GA26306@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510150448.GA26306@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 08:34:48PM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler in
> struct vm_operations_struct. For now, this is just
> documenting that the function returns a VM_FAULT
> value rather than an errno. Once all instances are
> converted, vm_fault_t will become a distinct type.
> 
> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> Previously vm_insert_pfn() returns err which driver
> mapped into VM_FAULT_* type. The new function
> vmf_insert_pfn() will replace this inefficiency by
> returning VM_FAULT_* type.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

> ---
> v2: Updated the change log
> 
>  drivers/gpu/drm/armada/armada_gem.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
> index a97f509..81a55b7 100644
> --- a/drivers/gpu/drm/armada/armada_gem.c
> +++ b/drivers/gpu/drm/armada/armada_gem.c
> @@ -13,25 +13,14 @@
>  #include <drm/armada_drm.h>
>  #include "armada_ioctlP.h"
> 
> -static int armada_gem_vm_fault(struct vm_fault *vmf)
> +static vm_fault_t armada_gem_vm_fault(struct vm_fault *vmf)
>  {
>  	struct drm_gem_object *gobj = vmf->vma->vm_private_data;
>  	struct armada_gem_object *obj = drm_to_armada_gem(gobj);
>  	unsigned long pfn = obj->phys_addr >> PAGE_SHIFT;
> -	int ret;
> 
>  	pfn += (vmf->address - vmf->vma->vm_start) >> PAGE_SHIFT;
> -	ret = vm_insert_pfn(vmf->vma, vmf->address, pfn);
> -
> -	switch (ret) {
> -	case 0:
> -	case -EBUSY:
> -		return VM_FAULT_NOPAGE;
> -	case -ENOMEM:
> -		return VM_FAULT_OOM;
> -	default:
> -		return VM_FAULT_SIGBUS;
> -	}
> +	return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
>  }
> 
>  const struct vm_operations_struct armada_gem_vm_ops = {
> --
> 1.9.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
