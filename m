Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeEPIJv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:09:51 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46102 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeEPIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:09:48 -0400
X-Google-Smtp-Source: AB8JxZpNyykppowDh3pqwsFKI1rjTw0xtSfAidZyZSNyasabpHZZEuXdL5lSS/sJXHJSTmwSPQOBBS+jrMVV2PiqHlY=
MIME-Version: 1.0
In-Reply-To: <20180516165326.47e96000@canb.auug.org.au>
References: <20180516165326.47e96000@canb.auug.org.au>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Wed, 16 May 2018 11:09:16 +0300
Message-ID: <CAFCwf119c0vsR8uxqHZu6h12tWhaW6mh9pDYqGPriC60s-+h6Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 9:53 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the drm tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c: In function 'init_user_pages':
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:632:3: error: implicit declaration of function 'release_pages'; did you mean 'release_task'? [-Werror=implicit-function-declaration]
>    release_pages(mem->user_pages, bo->tbo.ttm->num_pages);
>    ^~~~~~~~~~~~~
>    release_task
>
> Caused by commit
>
>   5ae0283e831a ("drm/amdgpu: Add userptr support for KFD")
>
> I have applied the following patch for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 16 May 2018 16:43:34 +1000
> Subject: [PATCH] drm/amdgpu: include pagemap.h for release_pages()
>
> Fixes: 5ae0283e831a ("drm/amdgpu: Add userptr support for KFD"
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 72ab2b1ffe75..ff8fd75f7ca5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -23,6 +23,7 @@
>  #define pr_fmt(fmt) "kfd2kgd: " fmt
>
>  #include <linux/list.h>
> +#include <linux/pagemap.h>
>  #include <linux/sched/mm.h>
>  #include <drm/drmP.h>
>  #include "amdgpu_object.h"
> --
> 2.17.0
>
> --
> Cheers,
> Stephen Rothwell

Thanks Stephen,

I'll add it to amdkfd-next and send it to Dave with other fixes.

Oded
