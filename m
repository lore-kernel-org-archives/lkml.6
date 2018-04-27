Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758189AbeD0Mgg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:36:36 -0400
Received: from foss.arm.com ([217.140.101.70]:39554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758014AbeD0Mgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:36:33 -0400
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
To: Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>
References: <cover.1523304324.git.digetx@gmail.com>
 <f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
 <20180427100202.GO30388@ulmo>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <716edf58-38a7-21e5-1668-b866bf392e34@arm.com>
Date: Fri, 27 Apr 2018 13:36:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427100202.GO30388@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 27/04/18 11:02, Thierry Reding wrote:
> On Mon, Apr 09, 2018 at 11:07:22PM +0300, Dmitry Osipenko wrote:
>> Currently GART writes one page entry at a time. More optimal would be to
>> aggregate the writes and flush BUS buffer in the end, this gives map/unmap
>> 10-40% (depending on size of mapping) performance boost compared to a
>> flushing after each entry update.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>   drivers/iommu/tegra-gart.c | 63 +++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 48 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>> index 4a0607669d34..9f59f5f17661 100644
>> --- a/drivers/iommu/tegra-gart.c
>> +++ b/drivers/iommu/tegra-gart.c
>> @@ -36,7 +36,7 @@
>>   #define GART_APERTURE_SIZE	SZ_32M
>>   
>>   /* bitmap of the page sizes currently supported */
>> -#define GART_IOMMU_PGSIZES	(SZ_4K)
>> +#define GART_IOMMU_PGSIZES	GENMASK(24, 12)
> 
> That doesn't look right. The GART really only supports 4 KiB pages. You
> seem to be "emulating" more page sizes here in order to improve mapping
> performance. That seems wrong to me. I'm wondering if this couldn't be
> improved by a similar factor by simply moving the flushing into an
> implementation of ->iotlb_sync().
> 
> That said, it seems like ->iotlb_sync() is only used for unmapping, but
> I don't see a reason why iommu_map() wouldn't need to call it as well
> after going through several calls to ->map(). It seems to me like a
> driver that implements ->iotlb_sync() would want to use it to optimize
> for both the mapping and unmapping cases.
> 
> Joerg, I've gone over the git log and header files and I see no mention
> of why the TLB flush interface isn't used for mapping. Do you recall any
> special reasons why the same shouldn't be applied for mapping? Would you
> accept any patches doing this?

In general, requiring TLB maintenance when transitioning from an invalid 
entry to a valid one tends to be the exception rather than the norm, and 
I think we ended up at the consensus that it wasn't worth the 
complication of trying to cater for this in the generic iotlb API.

To be fair, on simple hardware which doesn't implement multiple page 
sizes with associated walk depth/TLB pressure benefits for larger ones, 
there's no need for the IOMMU API (and/or the owner of the domain) to 
try harder to use them, so handling "compound" page sizes within the 
driver is a more reasonable thing to do. There is already some precedent 
for this in other drivers (e.g. mtk_iommu_v1).

Robin.

> 
> Thierry
> 
>>   
>>   #define GART_REG_BASE		0x24
>>   #define GART_CONFIG		(0x24 - GART_REG_BASE)
>> @@ -269,25 +269,21 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
>>   	kfree(gart_domain);
>>   }
>>   
>> -static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
>> -			  phys_addr_t pa, size_t bytes, int prot)
>> +static int gart_iommu_map_page(struct gart_device *gart,
>> +			       unsigned long iova,
>> +			       phys_addr_t pa)
>>   {
>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>> -	struct gart_device *gart = gart_domain->gart;
>>   	unsigned long flags;
>>   	unsigned long pfn;
>>   	unsigned long pte;
>>   
>> -	if (!gart_iova_range_valid(gart, iova, bytes))
>> -		return -EINVAL;
>> -
>> -	spin_lock_irqsave(&gart->pte_lock, flags);
>>   	pfn = __phys_to_pfn(pa);
>>   	if (!pfn_valid(pfn)) {
>>   		dev_err(gart->dev, "Invalid page: %pa\n", &pa);
>> -		spin_unlock_irqrestore(&gart->pte_lock, flags);
>>   		return -EINVAL;
>>   	}
>> +
>> +	spin_lock_irqsave(&gart->pte_lock, flags);
>>   	if (gart_debug) {
>>   		pte = gart_read_pte(gart, iova);
>>   		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
>> @@ -297,8 +293,41 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
>>   		}
>>   	}
>>   	gart_set_pte(gart, iova, GART_PTE(pfn));
>> +	spin_unlock_irqrestore(&gart->pte_lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
>> +			  phys_addr_t pa, size_t bytes, int prot)
>> +{
>> +	struct gart_domain *gart_domain = to_gart_domain(domain);
>> +	struct gart_device *gart = gart_domain->gart;
>> +	size_t mapped;
>> +	int ret = -1;
>> +
>> +	if (!gart_iova_range_valid(gart, iova, bytes))
>> +		return -EINVAL;
>> +
>> +	for (mapped = 0; mapped < bytes; mapped += GART_PAGE_SIZE) {
>> +		ret = gart_iommu_map_page(gart, iova + mapped, pa + mapped);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>>   	FLUSH_GART_REGS(gart);
>> +	return ret;
>> +}
>> +
>> +static int gart_iommu_unmap_page(struct gart_device *gart,
>> +				 unsigned long iova)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&gart->pte_lock, flags);
>> +	gart_set_pte(gart, iova, 0);
>>   	spin_unlock_irqrestore(&gart->pte_lock, flags);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -307,16 +336,20 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
>>   {
>>   	struct gart_domain *gart_domain = to_gart_domain(domain);
>>   	struct gart_device *gart = gart_domain->gart;
>> -	unsigned long flags;
>> +	size_t unmapped;
>> +	int ret;
>>   
>>   	if (!gart_iova_range_valid(gart, iova, bytes))
>>   		return 0;
>>   
>> -	spin_lock_irqsave(&gart->pte_lock, flags);
>> -	gart_set_pte(gart, iova, 0);
>> +	for (unmapped = 0; unmapped < bytes; unmapped += GART_PAGE_SIZE) {
>> +		ret = gart_iommu_unmap_page(gart, iova + unmapped);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>>   	FLUSH_GART_REGS(gart);
>> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
>> -	return bytes;
>> +	return unmapped;
>>   }
>>   
>>   static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
>> -- 
>> 2.16.3
>>
>>
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
