Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeDJRuI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:50:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41218 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbeDJRuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:50:07 -0400
Subject: Re: [PATCH] swiotlb: Fix unexpected swiotlb_alloc_coherent() failures
To: Takashi Iwai <tiwai@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20180410170513.22834-1-tiwai@suse.de>
 <20180410170615.GA27589@lst.de> <s5hzi2bat25.wl-tiwai@suse.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <40618b9c-786d-7f5f-3f5b-fc1dd8375846@arm.com>
Date: Tue, 10 Apr 2018 18:50:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5hzi2bat25.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/18 18:07, Takashi Iwai wrote:
> On Tue, 10 Apr 2018 19:06:15 +0200,
> Christoph Hellwig wrote:
>>
>> On Tue, Apr 10, 2018 at 07:05:13PM +0200, Takashi Iwai wrote:
>>> The code refactoring by commit 0176adb00406 ("swiotlb: refactor
>>> coherent buffer allocation") made swiotlb_alloc_buffer() almost always
>>> failing due to a thinko: namely, the function evaluates the
>>> dma_coherent_ok() call incorrectly and dealing as if it's invalid.
>>> This ends up with weird errors like iwlwifi probe failure or amdgpu
>>> screen flickering.
>>>
>>> This patch corrects the logic error.
>>
>> This looks ok, although even hitting this code is a bad sign.  Do you
>> know why the previous dma_direct_alloc didn't succeed?
> 
> That I have no idea, sorry.  I just figured out the regression just
> from the dmesg output of 4.16 kernel in bugzilla reports.
> Could you take a look at the bugzilla reports there?

In the first one, the machine appears to have enough RAM that most of it 
is beyond the device's 36-bit DMA mask, thus it's fairly likely for the 
initial direct alloc to come back with something unsuitable.

Robin.

> 
> 
> thanks,
> 
> Takashi
> 
>>> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1088658
>>> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1088902
>>> Fixes: 0176adb00406 ("swiotlb: refactor coherent buffer allocation")
>>> Cc: <stable@vger.kernel.org> # v4.16+
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>>   lib/swiotlb.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
>>> index 47aeb04c1997..de7cc540450f 100644
>>> --- a/lib/swiotlb.c
>>> +++ b/lib/swiotlb.c
>>> @@ -719,7 +719,7 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>>   		goto out_warn;
>>>   
>>>   	*dma_handle = __phys_to_dma(dev, phys_addr);
>>> -	if (dma_coherent_ok(dev, *dma_handle, size))
>>> +	if (!dma_coherent_ok(dev, *dma_handle, size))
>>>   		goto out_unmap;
>>>   
>>>   	memset(phys_to_virt(phys_addr), 0, size);
>>> -- 
>>> 2.16.3
>> ---end quoted text---
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
