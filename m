Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754470AbeE1Js3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:48:29 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42001 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754442AbeE1JsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:48:24 -0400
X-Google-Smtp-Source: ADUXVKLHs5CTuXPvvTwi5DNT72TJ2Cn5ILdazEp0fLyXChqUEobo+ZW/VfhXgnoX0r8ETJ64NilQSdfzZ0jxQrazCoQ=
MIME-Version: 1.0
In-Reply-To: <20180525155030.3667352-2-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de> <20180525155030.3667352-2-arnd@arndb.de>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Mon, 28 May 2018 12:47:53 +0300
Message-ID: <CAFCwf10AWL4qg+chyARMgDzEqFAqm7O0=xD7d9jspJyvKCfUFA@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/amdgpu: fix 32-bit build warning
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Andres Rodriguez <andresx7@gmail.com>,
        Kent Russell <kent.russell@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 6:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Casting a pointer to a 64-bit type causes a warning on 32-bit targets:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:473:24: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>           lower_32_bits((uint64_t)wptr));
>                         ^
> drivers/gpu/drm/amd/amdgpu/amdgpu.h:1701:53: note: in definition of macro 'WREG32'
>  #define WREG32(reg, v) amdgpu_mm_wreg(adev, (reg), (v), 0)
>                                                      ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:473:10: note: in expansion of macro 'lower_32_bits'
>           lower_32_bits((uint64_t)wptr));
>           ^~~~~~~~~~~~~
>
> The correct method is to cast to 'uintptr_t'.
>
> Fixes: d5a114a6c5f7 ("drm/amdgpu: Add GFXv9 kfd2kgd interface functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 8f37991df61b..f0c0d3953f69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -470,9 +470,9 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>                 WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
>                        upper_32_bits(guessed_wptr));
>                 WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
> -                      lower_32_bits((uint64_t)wptr));
> +                      lower_32_bits((uintptr_t)wptr));
>                 WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> -                      upper_32_bits((uint64_t)wptr));
> +                      upper_32_bits((uintptr_t)wptr));
>                 WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
>                        get_queue_mask(adev, pipe_id, queue_id));
>         }
> --
> 2.9.0
>

There is a change scheduled for the next merge window that will cause
this file to not build anymore on 32-bit targets (because the amdkfd
driver is not supported on 32 bit targets).

Never the less I'm taking the patch for good measure.

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
