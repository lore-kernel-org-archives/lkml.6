Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968008AbeBOMcl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:32:41 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41586 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967204AbeBOMcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:32:39 -0500
X-Google-Smtp-Source: AH8x224Tau6BtGgvjIeXadT/7yzjekx+w5Z0+HUjacT2SdzhHRVzSuGFA/LG6kaMC/VF9qQaj/VNVA==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/amdgpu_gem: fix error handling path in
 amdgpu_gem_va_update_vm
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180215052000.GA25691@embeddedgus>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b3638ffe-b29f-b30b-4a2c-ccc50f7562b0@gmail.com>
Date: Thu, 15 Feb 2018 13:32:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215052000.GA25691@embeddedgus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.02.2018 um 06:20 schrieb Gustavo A. R. Silva:
> Currently, if amdgpu_vm_bo_update() fails, the returned error
> is being ignored.
>
> Fix this by properly checking _r_ after calling amdgpu_vm_bo_update.
> Also, remove redundant code just before label _error_.
>
> Addresses-Coverity-ID: 1464280 ("Unused value")
> Fixes: 0abc6878fc2d ("drm/amdgpu: update VM PDs after the PTs")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e48b4ec..db85fc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -523,12 +523,13 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>   		goto error;
>   
>   	if (operation == AMDGPU_VA_OP_MAP ||
> -	    operation == AMDGPU_VA_OP_REPLACE)
> +	    operation == AMDGPU_VA_OP_REPLACE) {
>   		r = amdgpu_vm_bo_update(adev, bo_va, false);
> +		if (r)
> +			goto error;
> +	}
>   
>   	r = amdgpu_vm_update_directories(adev, vm);
> -	if (r)
> -		goto error;
>   
>   error:
>   	if (r && r != -ERESTARTSYS)
