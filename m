Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeEaFHc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 01:07:32 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45652 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeEaFH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 01:07:29 -0400
X-Google-Smtp-Source: ADUXVKL1h/DoVTE183h5It79T6hx4NZzh2MAHfAHsGm4TcSEzEWoCwE3U50pM7/c7hIXaCiomeQaVoLOqTR3HB5EAjQ=
MIME-Version: 1.0
In-Reply-To: <20180523185538.GA975@jordon-HP-15-Notebook-PC>
References: <20180523185538.GA975@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 31 May 2018 10:37:27 +0530
Message-ID: <CAFqt6zZq_GN2gjv-noP4RsOV74xCBGQjgHYadCOgaETv0wu9_g@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: ttm: Adding new return type vm_fault_t
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hongbo.He@amd.com, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 12:25 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
>
> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>
> Previously vm_insert_{mixed,pfn} returns err which driver
> mapped into VM_FAULT_* type. The new function
> vmf_insert_{mixed,pfn} will replace this inefficiency by
> returning VM_FAULT_* type.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo_vm.c | 45 ++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 8eba95b..2d13f03 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -43,10 +43,11 @@
>
>  #define TTM_BO_VM_NUM_PREFAULT 16
>
> -static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
> +static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>                                 struct vm_fault *vmf)
>  {
> -       int ret = 0;
> +       int err = 0;
> +       vm_fault_t ret = 0;
>
>         if (likely(!bo->moving))
>                 goto out_unlock;
> @@ -77,9 +78,9 @@ static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>         /*
>          * Ordinary wait.
>          */
> -       ret = dma_fence_wait(bo->moving, true);
> -       if (unlikely(ret != 0)) {
> -               ret = (ret != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
> +       err = dma_fence_wait(bo->moving, true);
> +       if (unlikely(err != 0)) {
> +               ret = (err != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
>                         VM_FAULT_NOPAGE;
>                 goto out_unlock;
>         }
> @@ -104,7 +105,7 @@ static unsigned long ttm_bo_io_mem_pfn(struct ttm_buffer_object *bo,
>                 + page_offset;
>  }
>
> -static int ttm_bo_vm_fault(struct vm_fault *vmf)
> +static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma = vmf->vma;
>         struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
> @@ -115,8 +116,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>         unsigned long pfn;
>         struct ttm_tt *ttm = NULL;
>         struct page *page;
> -       int ret;
> +       int err;
>         int i;
> +       vm_fault_t ret = VM_FAULT_NOPAGE;
>         unsigned long address = vmf->address;
>         struct ttm_mem_type_manager *man =
>                 &bdev->man[bo->mem.mem_type];
> @@ -128,9 +130,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>          * for reserve, and if it fails, retry the fault after waiting
>          * for the buffer to become unreserved.
>          */
> -       ret = ttm_bo_reserve(bo, true, true, NULL);
> -       if (unlikely(ret != 0)) {
> -               if (ret != -EBUSY)
> +       err = ttm_bo_reserve(bo, true, true, NULL);
> +       if (unlikely(err != 0)) {
> +               if (err != -EBUSY)
>                         return VM_FAULT_NOPAGE;
>
>                 if (vmf->flags & FAULT_FLAG_ALLOW_RETRY) {
> @@ -162,8 +164,8 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>         }
>
>         if (bdev->driver->fault_reserve_notify) {
> -               ret = bdev->driver->fault_reserve_notify(bo);
> -               switch (ret) {
> +               err = bdev->driver->fault_reserve_notify(bo);
> +               switch (err) {
>                 case 0:
>                         break;
>                 case -EBUSY:
> @@ -191,13 +193,13 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>                 goto out_unlock;
>         }
>
> -       ret = ttm_mem_io_lock(man, true);
> -       if (unlikely(ret != 0)) {
> +       err = ttm_mem_io_lock(man, true);
> +       if (unlikely(err != 0)) {
>                 ret = VM_FAULT_NOPAGE;
>                 goto out_unlock;
>         }
> -       ret = ttm_mem_io_reserve_vm(bo);
> -       if (unlikely(ret != 0)) {
> +       err = ttm_mem_io_reserve_vm(bo);
> +       if (unlikely(err != 0)) {
>                 ret = VM_FAULT_SIGBUS;
>                 goto out_io_unlock;
>         }
> @@ -265,23 +267,20 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>                 }
>
>                 if (vma->vm_flags & VM_MIXEDMAP)
> -                       ret = vm_insert_mixed(&cvma, address,
> +                       ret = vmf_insert_mixed(&cvma, address,
>                                         __pfn_to_pfn_t(pfn, PFN_DEV));
>                 else
> -                       ret = vm_insert_pfn(&cvma, address, pfn);
> +                       ret = vmf_insert_pfn(&cvma, address, pfn);
>
>                 /*
>                  * Somebody beat us to this PTE or prefaulting to
>                  * an already populated PTE, or prefaulting error.
>                  */
>
> -               if (unlikely((ret == -EBUSY) || (ret != 0 && i > 0)))
> +               if (unlikely((ret == VM_FAULT_NOPAGE && i > 0)))
>                         break;
> -               else if (unlikely(ret != 0)) {
> -                       ret =
> -                           (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
> +               else if (unlikely(ret & VM_FAULT_ERROR))
>                         goto out_io_unlock;
> -               }
>
>                 address += PAGE_SIZE;
>                 if (unlikely(++page_offset >= page_last))
> --
> 1.9.1
>

Any comment for this patch ?
