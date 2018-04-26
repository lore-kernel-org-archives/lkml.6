Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeDZBWL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 21:22:11 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35555 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbeDZBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 21:22:09 -0400
X-Google-Smtp-Source: AIpwx48NNoxFnBCBH9hJpEv9IFJWWYBWMTGEH39yKQrWLJVG5fB9RSM7i3E5N1BOyWbxxqtQaqQ/ug==
Subject: Re: [PATCH] soc: qcom: smem: introduce qcom_smem_virt_to_phys()
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: andy.gross@linaro.org, clew@codeaurora.org, aneela@codeaurora.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180425151820.25595-1-elder@linaro.org>
 <20180425231424.GJ18510@minitux>
From: Alex Elder <elder@linaro.org>
Message-ID: <725190d3-a4bf-3170-d88a-5964c64a9077@linaro.org>
Date: Wed, 25 Apr 2018 20:22:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425231424.GJ18510@minitux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/2018 06:14 PM, Bjorn Andersson wrote:
> On Wed 25 Apr 08:18 PDT 2018, Alex Elder wrote:
> 
>> Create function qcom_smem_virt_to_phys(), which returns the physical
>> address corresponding to a given SMEM item's virtual address.  This
>> feature is required for a driver that will soon be out for review.
>>
> 
> It might be wise to turn the aux_base in smem_region into a phys_addr_t
> and then mask that with AUX_BASE_MASK before comparing with the entry's
> aux_base in qcom_smem_get_global(). But this will work fine until the
> day someone places smem above 4GB.

I thought of that but went for this for now, because it made for a
nice, concise change.  I agree with you though.

Thanks a lot for the quick review.

					-Alex

> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>  drivers/soc/qcom/smem.c       | 27 +++++++++++++++++++++++++++
>>  include/linux/soc/qcom/smem.h |  2 ++
>>  2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>> index 7d9a43da5084..70b2ee80d6bd 100644
>> --- a/drivers/soc/qcom/smem.c
>> +++ b/drivers/soc/qcom/smem.c
>> @@ -655,6 +655,33 @@ int qcom_smem_get_free_space(unsigned host)
>>  }
>>  EXPORT_SYMBOL(qcom_smem_get_free_space);
>>  
>> +/**
>> + * qcom_smem_virt_to_phys() - return the physical address associated
>> + * with an smem item pointer (previously returned by qcom_smem_get()
>> + * @p:	the virtual address to convert
>> + *
>> + * Returns 0 if the pointer provided is not within any smem region.
>> + */
>> +phys_addr_t qcom_smem_virt_to_phys(void *p)
>> +{
>> +	unsigned i;
>> +
>> +	for (i = 0; i < __smem->num_regions; i++) {
>> +		struct smem_region *region = &__smem->regions[i];
>> +
>> +		if (p < region->virt_base)
>> +			continue;
>> +		if (p < region->virt_base + region->size) {
>> +			u64 offset = p - region->virt_base;
>> +
>> +			return (phys_addr_t)region->aux_base + offset;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(qcom_smem_virt_to_phys);
>> +
>>  static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
>>  {
>>  	struct smem_header *header;
>> diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
>> index c1657ed27b30..86e1b358688a 100644
>> --- a/include/linux/soc/qcom/smem.h
>> +++ b/include/linux/soc/qcom/smem.h
>> @@ -9,4 +9,6 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
>>  
>>  int qcom_smem_get_free_space(unsigned host);
>>  
>> +phys_addr_t qcom_smem_virt_to_phys(void *p);
>> +
>>  #endif
>> -- 
>> 2.14.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
