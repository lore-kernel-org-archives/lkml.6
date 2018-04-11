Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeDKMEH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:04:07 -0400
Received: from foss.arm.com ([217.140.101.70]:48410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbeDKMEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:04:05 -0400
Subject: Re: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
To: Sinan Kaya <okaya@codeaurora.org>, amd-gfx@lists.freedesktop.org,
        timur@codeaurora.org, sulrich@codeaurora.org
Cc: Tom St Denis <tom.stdenis@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Emily Deng <Emily.Deng@amd.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Panariti <David.Panariti@amd.com>, Jim Qu <Jim.Qu@amd.com>,
        Huang Rui <ray.huang@amd.com>, Roger He <Hongbo.He@amd.com>,
        Monk Liu <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
        hch@lst.de
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
Date: Wed, 11 Apr 2018 13:03:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/18 21:59, Sinan Kaya wrote:
> Code is expecing to observe the same number of buffers returned from
> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
> doesn't hold true universally especially for systems with IOMMU.

So why not fix said code? It's clearly not a real hardware limitation, 
and the map_sg() APIs have potentially returned fewer than nents since 
forever, so there's really no excuse.

> IOMMU driver tries to combine buffers into a single DMA address as much
> as it can. The right thing is to tell the DMA layer how much combining
> IOMMU can do.

Disagree; this is a dodgy hack, since you'll now end up passing 
scatterlists into dma_map_sg() which already violate max_seg_size to 
begin with, and I think a conscientious DMA API implementation would be 
at rights to fail the mapping for that reason (I know arm64 happens not 
to, but that was a deliberate design decision to make my life easier at 
the time).

As a short-term fix, at least do something like what i915 does and 
constrain the table allocation to the desired segment size as well, so 
things remain self-consistent. But still never claim that faking a 
hardware constraint as a workaround for a driver shortcoming is "the 
right thing to do" ;)

Robin.

> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 +
>   4 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 8e28270..1b031eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -851,7 +851,7 @@ static int gmc_v6_0_sw_init(void *handle)
>   		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
>   		dev_warn(adev->dev, "amdgpu: No coherent DMA available.\n");
>   	}
> -
> +	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
>   	r = gmc_v6_0_init_microcode(adev);
>   	if (r) {
>   		dev_err(adev->dev, "Failed to load mc firmware!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 86e9d682..0a4b2cc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -999,6 +999,7 @@ static int gmc_v7_0_sw_init(void *handle)
>   		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
>   		pr_warn("amdgpu: No coherent DMA available\n");
>   	}
> +	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
>   
>   	r = gmc_v7_0_init_microcode(adev);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 9a813d8..b171529 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1096,6 +1096,7 @@ static int gmc_v8_0_sw_init(void *handle)
>   		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
>   		pr_warn("amdgpu: No coherent DMA available\n");
>   	}
> +	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
>   
>   	r = gmc_v8_0_init_microcode(adev);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 3b7e7af..36e658ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -855,6 +855,7 @@ static int gmc_v9_0_sw_init(void *handle)
>   		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
>   		printk(KERN_WARNING "amdgpu: No coherent DMA available.\n");
>   	}
> +	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
>   
>   	r = gmc_v9_0_mc_init(adev);
>   	if (r)
> 
