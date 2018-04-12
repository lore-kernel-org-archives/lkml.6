Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDLNvH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 09:51:07 -0400
Received: from foss.arm.com ([217.140.101.70]:33516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752721AbeDLNvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 09:51:05 -0400
Subject: Re: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>
Cc: Sinan Kaya <okaya@codeaurora.org>, amd-gfx@lists.freedesktop.org,
        timur@codeaurora.org, sulrich@codeaurora.org,
        Tom St Denis <tom.stdenis@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Emily Deng <Emily.Deng@amd.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Panariti <David.Panariti@amd.com>, Jim Qu <Jim.Qu@amd.com>,
        Huang Rui <ray.huang@amd.com>, Roger He <Hongbo.He@amd.com>,
        Monk Liu <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
 <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
 <20180412062600.GB30499@lst.de>
 <6802bd0c-7da6-659a-7e34-8f05d7c6422c@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7a3e7459-2965-54c8-ff0c-6edb3a6aecb5@arm.com>
Date: Thu, 12 Apr 2018 14:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6802bd0c-7da6-659a-7e34-8f05d7c6422c@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/18 10:42, Christian König wrote:
> Am 12.04.2018 um 08:26 schrieb Christoph Hellwig:
>> On Wed, Apr 11, 2018 at 01:03:59PM +0100, Robin Murphy wrote:
>>> On 10/04/18 21:59, Sinan Kaya wrote:
>>>> Code is expecing to observe the same number of buffers returned from
>>>> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
>>>> doesn't hold true universally especially for systems with IOMMU.
>>> So why not fix said code? It's clearly not a real hardware 
>>> limitation, and
>>> the map_sg() APIs have potentially returned fewer than nents since 
>>> forever,
>>> so there's really no excuse.
>> Yes, relying on dma_map_sg returning the same number of entries as passed
>> it is completely bogus.
> 
> I agree that the common DRM functions should be able to deal with both, 
> but we should let the driver side decide if it wants multiple addresses 
> combined or not.
> 
>>
>>>> IOMMU driver tries to combine buffers into a single DMA address as much
>>>> as it can. The right thing is to tell the DMA layer how much combining
>>>> IOMMU can do.
>>> Disagree; this is a dodgy hack, since you'll now end up passing
>>> scatterlists into dma_map_sg() which already violate max_seg_size to 
>>> begin
>>> with, and I think a conscientious DMA API implementation would be at 
>>> rights
>>> to fail the mapping for that reason (I know arm64 happens not to, but 
>>> that
>>> was a deliberate design decision to make my life easier at the time).
>> Agreed.
> 
> Sounds like my understanding of max_seg_size is incorrect, what exactly 
> should that describe?

The segment size and boundary mask are there to represent a device's 
hardware scatter-gather capabilities - a lot of things have limits on 
the size and alignment of the data pointed to by a single descriptor 
(e.g. an xHCI TRB, where the data buffer must not cross a 64KB boundary) 
- although they can also be relevant to non-scatter-gather devices if 
they just have limits on how big/aligned a single DMA transfer can be.

Robin.
