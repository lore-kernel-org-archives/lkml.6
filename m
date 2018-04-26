Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeDZBcE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 21:32:04 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35768 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeDZBcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 21:32:02 -0400
X-Google-Smtp-Source: AB8JxZoWypQ+FUzog+hagYfJSznjXg1m6/3OyGV9vszlSp7lpwiQoX+w+NRPnWMyrPmHYRjeXGd6LA==
Subject: Re: [PATCH] soc: qcom: smem: introduce qcom_smem_virt_to_phys()
To: Chris Lew <clew@codeaurora.org>, andy.gross@linaro.org
Cc: aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180425151820.25595-1-elder@linaro.org>
 <4a127dda-576c-4eae-80d3-a928e578a1b9@codeaurora.org>
From: Alex Elder <elder@linaro.org>
Message-ID: <a46d6e74-92ca-b1b8-48b5-1f7e2572eb9d@linaro.org>
Date: Wed, 25 Apr 2018 20:31:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4a127dda-576c-4eae-80d3-a928e578a1b9@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/2018 06:29 PM, Chris Lew wrote:
> Hi Alex,
> 
> Minor comment.
> 
> On 4/25/2018 8:18 AM, Alex Elder wrote:
>> Create function qcom_smem_virt_to_phys(), which returns the physical
>> address corresponding to a given SMEM item's virtual address.  This
>> feature is required for a driver that will soon be out for review.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>   drivers/soc/qcom/smem.c       | 27 +++++++++++++++++++++++++++
>>   include/linux/soc/qcom/smem.h |  2 ++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>> index 7d9a43da5084..70b2ee80d6bd 100644
>> --- a/drivers/soc/qcom/smem.c
>> +++ b/drivers/soc/qcom/smem.c
>> @@ -655,6 +655,33 @@ int qcom_smem_get_free_space(unsigned host)
>>   }
>>   EXPORT_SYMBOL(qcom_smem_get_free_space);
>>   +/**
>> + * qcom_smem_virt_to_phys() - return the physical address associated
>> + * with an smem item pointer (previously returned by qcom_smem_get()
>> + * @p:    the virtual address to convert
>> + *
>> + * Returns 0 if the pointer provided is not within any smem region.
>> + */
>> +phys_addr_t qcom_smem_virt_to_phys(void *p)
>> +{
>> +    unsigned i;
>> +
> 
> We have a null pointer check for __smem here since it is called by
> external clients. This case should probably never happen though.

I think you're suggesting that we should verify __smem is non-null first?

I'll make a few statements about that.
- This function can only be called with a pointer that was returned by
  qcom_smem_get().  That function won't return a valid pointer unless
  __smem was non-null.
- The only other way __smem would be null is if this were called after
  qcom_smem_remove(), which is erroneous.
- I think putting a null pointer check suggests that it's a condition
  that might be expected to occur.  If anything, I'd put an assertion
  in there (e.g. BUG_ON(!__smem)) but I don't think it's warranted.

I do understand why you suggest this--and it's a relatively harmless
check.   But I think it's better without it.

					-Alex


>> +    for (i = 0; i < __smem->num_regions; i++) {
>> +        struct smem_region *region = &__smem->regions[i];
>> +
>> +        if (p < region->virt_base)
>> +            continue;
>> +        if (p < region->virt_base + region->size) {
>> +            u64 offset = p - region->virt_base;
>> +
>> +            return (phys_addr_t)region->aux_base + offset;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(qcom_smem_virt_to_phys);
> 
> Thanks,
> Chris
> 
