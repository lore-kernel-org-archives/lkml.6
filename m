Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeDKOdW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:33:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38646 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbeDKOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:33:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49914603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
To: Robin Murphy <robin.murphy@arm.com>, amd-gfx@lists.freedesktop.org,
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
 <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <1a1d0069-c8d3-cc0d-cf1c-8e90e4a2b0d7@codeaurora.org>
Date: Wed, 11 Apr 2018 10:33:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2018 8:03 AM, Robin Murphy wrote:
> On 10/04/18 21:59, Sinan Kaya wrote:
>> Code is expecing to observe the same number of buffers returned from
>> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
>> doesn't hold true universally especially for systems with IOMMU.
> 
> So why not fix said code? It's clearly not a real hardware limitation, and the map_sg() APIs have potentially returned fewer than nents since forever, so there's really no excuse.

Sure, I'll take a better fix if there is one.

> 
>> IOMMU driver tries to combine buffers into a single DMA address as much
>> as it can. The right thing is to tell the DMA layer how much combining
>> IOMMU can do.
> 
> Disagree; this is a dodgy hack, since you'll now end up passing scatterlists into dma_map_sg() which already violate max_seg_size to begin with, and I think a conscientious DMA API implementation would be at rights to fail the mapping for that reason (I know arm64 happens not to, but that was a deliberate design decision to make my life easier at the time).
> 
> As a short-term fix, at least do something like what i915 does and constrain the table allocation to the desired segment size as well, so things remain self-consistent. But still never claim that faking a hardware constraint as a workaround for a driver shortcoming is "the right thing to do" ;)

You are asking for something like this from here, right?

https://elixir.bootlin.com/linux/v4.16.1/source/drivers/gpu/drm/i915/i915_gem_dmabuf.c#L58


	ret = sg_alloc_table(st, obj->mm.pages->nents, GFP_KERNEL);
	if (ret)
		goto err_free;

	src = obj->mm.pages->sgl;
	dst = st->sgl;
	for (i = 0; i < obj->mm.pages->nents; i++) {
		sg_set_page(dst, sg_page(src), src->length, 0);
		dst = sg_next(dst);
		src = sg_next(src);
	}

This seems to allocate the scatter gather list and fill it in manually before passing it
to dma_map_sg(). I'll give it a try. 

Just double checking.

> 
> Robin.
> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
