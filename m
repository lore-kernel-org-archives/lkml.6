Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754745AbeEHKOg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:14:36 -0400
Received: from foss.arm.com ([217.140.101.70]:55528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754490AbeEHKOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:14:35 -0400
Subject: Re: [PATCH] dma-debug: Check scatterlist segments
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <5952922c7980b5c9091692d886bbca220e7371c2.1524586299.git.robin.murphy@arm.com>
 <20180425055856.GA10738@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b49180f4-3e1b-d1f3-c6c3-98fbe1e66e4b@arm.com>
Date: Tue, 8 May 2018 11:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425055856.GA10738@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/18 06:58, Christoph Hellwig wrote:
> This looks interesting.  I suspect it is going to blow up in
> quite a few places, so maybe at least for now it might make sense
> to have a separate config option?

True, it's nice to verify this for 'traditional' dma_map_sg() usage, but 
places where it's just used as an intermediate shorthand for "prepare 
all these pages for arbitrary future DMA" are liable to be noisy with 
false-positives for not respecting the default values when they arguably 
don't matter. I'll respin this as an additional config under 
DMA_API_DEBUG, and then we can debate "default y" or not.

Robin.

> On Tue, Apr 24, 2018 at 05:12:19PM +0100, Robin Murphy wrote:
>> Drivers/subsystems creating scatterlists for DMA should be taking care
>> to respect the scatter-gather limitations of the appropriate device, as
>> described by dma_parms. A DMA API implementation cannot feasibly split
>> a scatterlist into *more* entries than originally passed, so it is not
>> well defined what they should do when given a segment larger than the
>> limit they are also required to respect.
>>
>> Conversely, devices which are less limited than the rather conservative
>> defaults, or indeed have no limitations at all (e.g. GPUs with their own
>> internal MMU), should be encouraged to set appropriate dma_parms, as
>> they may get more efficient DMA mapping performance out of it.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   lib/dma-debug.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
>> index 7f5cdc1e6b29..9f158941004d 100644
>> --- a/lib/dma-debug.c
>> +++ b/lib/dma-debug.c
>> @@ -1293,6 +1293,30 @@ static void check_sync(struct device *dev,
>>   	put_hash_bucket(bucket, &flags);
>>   }
>>   
>> +static void check_sg_segment(struct device *dev, struct scatterlist *sg)
>> +{
>> +	unsigned int max_seg = dma_get_max_seg_size(dev);
>> +	dma_addr_t start, end, boundary = dma_get_seg_boundary(dev);
>> +
>> +	/*
>> +	 * Either the driver forgot to set dma_parms appropriately, or
>> +	 * whoever generated the list forgot to check them.
>> +	 */
>> +	if (sg->length > max_seg)
>> +		err_printk(dev, NULL, "DMA-API: mapping sg segment longer than device claims to support [len=%u] [max=%u]\n",
>> +			   sg->length, max_seg);
>> +	/*
>> +	 * In some cases this could potentially be the DMA API
>> +	 * implementation's fault, but it would usually imply that
>> +	 * the scatterlist was built inappropriately to begin with.
>> +	 */
>> +	start = sg_dma_address(sg);
>> +	end = start + sg_dma_len(sg) - 1;
>> +	if ((start ^ end) & ~boundary)
>> +		err_printk(dev, NULL, "DMA-API: mapping sg segment across boundary [start=0x%016llx] [end=0x%016llx] [boundary=0x%016llx]\n",
>> +			   start, end, boundary);
>> +}
>> +
>>   void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
>>   			size_t size, int direction, dma_addr_t dma_addr,
>>   			bool map_single)
>> @@ -1423,6 +1447,8 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>   			check_for_illegal_area(dev, sg_virt(s), sg_dma_len(s));
>>   		}
>>   
>> +		check_sg_segment(dev, s);
>> +
>>   		add_dma_entry(entry);
>>   	}
>>   }
>> -- 
>> 2.17.0.dirty
> ---end quoted text---
> 
