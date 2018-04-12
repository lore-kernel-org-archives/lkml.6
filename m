Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeDLKc7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 06:32:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59028 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbeDLKc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 06:32:58 -0400
Subject: Re: [PATCH] swiotlb: Fix unexpected swiotlb_alloc_coherent() failures
To: Takashi Iwai <tiwai@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180410170513.22834-1-tiwai@suse.de>
 <20180410170615.GA27589@lst.de> <s5hzi2bat25.wl-tiwai@suse.de>
 <40618b9c-786d-7f5f-3f5b-fc1dd8375846@arm.com>
 <20180410181020.GA28565@lst.de> <s5h4lkib3rd.wl-tiwai@suse.de>
 <20180412060227.GA30248@lst.de> <s5h3700am1f.wl-tiwai@suse.de>
 <s5hy3hs96rq.wl-tiwai@suse.de> <s5hwoxc96d5.wl-tiwai@suse.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <81b9eae2-11d4-162d-9d3a-12e06eff9fea@arm.com>
Date: Thu, 12 Apr 2018 11:32:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5hwoxc96d5.wl-tiwai@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/18 09:27, Takashi Iwai wrote:
> On Thu, 12 Apr 2018 10:19:05 +0200,
> Takashi Iwai wrote:
>>
>> On Thu, 12 Apr 2018 10:03:56 +0200,
>> Takashi Iwai wrote:
>>>
>>> On Thu, 12 Apr 2018 08:02:27 +0200,
>>> Christoph Hellwig wrote:
>>>>
>>>> On Wed, Apr 11, 2018 at 09:28:54AM +0200, Takashi Iwai wrote:
>>>>>> But we should try a GFP_DMA32 allocation first, so this is a bit
>>>>>> surprising.
>>>>>
>>>>> Hm, do we really try that?
>>>>> Through a quick glance, dma_alloc_coherent_gfp_flags() gives GFP_DMA32
>>>>> only when coherent mask <= DMA_BIT_MASK(32); in the case of iwlwifi,
>>>>> it's 36bit, so GFP_DMA isn't set.
>>>>
>>>> Oh, yes - it is using an odd dma mask, and amdgpu seems to use an
>>>> just as odd 40-bit dma mask.
>>>>
>>>>> We had a fallback allocation with GFP_DMA32 in the past, but this
>>>>> seems gone long time ago along with cleanups (commit c647c3bb2d16).
>>>>>
>>>>> But I haven't followed about this topic for long time, so I might have
>>>>> missed obviously...
>>>>
>>>> I think a fallback would be much better here rather than relying on the
>>>> limited swiotlb buffer bool.  dma_direct_alloc (which in 4.17 is also
>>>> used for x86) already has a GFP_DMA fallback, so extending this for
>>>> GFP_DMA32 as well would seem reasonable.
>>>>
>>>> Any volunteers?
>>>
>>> Below is a quick attempt, totally untested.  Actually the retry with
>>> GFP_DMA is superfluous for archs without it, so the first patch
>>> corrects it.
>>
>> Gah, scratch this, it doesn't work.  A different check is needed...
> 
> The v2 patches are below, replaced with IS_ENABLED(CONFIG_ZONE_DMA).

That looks pretty reasonable to me - I'd be tempted to try a factoring 
out a helper function to avoid the "goto again" logic, but that's hardly 
crucial.

What I'd really love to see is something like the alloc_pages_mask() 
proposal from years ago to come back such that GFP_DMA32 could die 
entirely, but I don't know anywhere near enough about the mm layer to 
consider taking that on myself :(

Robin.
