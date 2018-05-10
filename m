Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966050AbeEJO2O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:28:14 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32878 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935632AbeEJO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:28:13 -0400
X-Google-Smtp-Source: AB8JxZpq+1BNdMCcdw0RjXUE3tQxjlpH7ACUhFEWkv0liLAcBK2uxpa99Lo7bgPnbQqg/ZtOKaMdCziMWaw2mlcZhSc=
MIME-Version: 1.0
In-Reply-To: <20180416150232.GA26745@jordon-HP-15-Notebook-PC>
References: <20180416150232.GA26745@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 10 May 2018 19:58:11 +0530
Message-ID: <CAFqt6zZ6VaPXoPs+3exLjNZ6yzS=v9=2TMXdFqHf_Zv5zEvSAA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: vgem: Change return type to vm_fault_t
To: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Mon, Apr 16, 2018 at 8:32 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  drivers/gpu/drm/vgem/vgem_drv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> index 2524ff1..c64a859 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -61,13 +61,13 @@ static void vgem_gem_free_object(struct drm_gem_object *obj)
>         kfree(vgem_obj);
>  }
>
> -static int vgem_gem_fault(struct vm_fault *vmf)
> +static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma = vmf->vma;
>         struct drm_vgem_gem_object *obj = vma->vm_private_data;
>         /* We don't use vmf->pgoff since that has the fake offset */
>         unsigned long vaddr = vmf->address;
> -       int ret;
> +       vm_fault_t ret = VM_FAULT_SIGBUS;
>         loff_t num_pages;
>         pgoff_t page_offset;
>         page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
> @@ -77,7 +77,6 @@ static int vgem_gem_fault(struct vm_fault *vmf)
>         if (page_offset > num_pages)
>                 return VM_FAULT_SIGBUS;
>
> -       ret = -ENOENT;
>         mutex_lock(&obj->pages_lock);
>         if (obj->pages) {
>                 get_page(obj->pages[page_offset]);
> --
> 1.9.1
>

Any further comment on this patch ?
