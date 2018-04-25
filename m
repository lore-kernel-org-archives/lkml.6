Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754102AbeDYX3d (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 19:29:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeDYX32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 19:29:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 068AF60227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=clew@codeaurora.org
Subject: Re: [PATCH] soc: qcom: smem: introduce qcom_smem_virt_to_phys()
To: Alex Elder <elder@linaro.org>, andy.gross@linaro.org
Cc: aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180425151820.25595-1-elder@linaro.org>
From: Chris Lew <clew@codeaurora.org>
Message-ID: <4a127dda-576c-4eae-80d3-a928e578a1b9@codeaurora.org>
Date: Wed, 25 Apr 2018 16:29:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425151820.25595-1-elder@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Minor comment.

On 4/25/2018 8:18 AM, Alex Elder wrote:
> Create function qcom_smem_virt_to_phys(), which returns the physical
> address corresponding to a given SMEM item's virtual address.  This
> feature is required for a driver that will soon be out for review.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>   drivers/soc/qcom/smem.c       | 27 +++++++++++++++++++++++++++
>   include/linux/soc/qcom/smem.h |  2 ++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 7d9a43da5084..70b2ee80d6bd 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -655,6 +655,33 @@ int qcom_smem_get_free_space(unsigned host)
>   }
>   EXPORT_SYMBOL(qcom_smem_get_free_space);
>   
> +/**
> + * qcom_smem_virt_to_phys() - return the physical address associated
> + * with an smem item pointer (previously returned by qcom_smem_get()
> + * @p:	the virtual address to convert
> + *
> + * Returns 0 if the pointer provided is not within any smem region.
> + */
> +phys_addr_t qcom_smem_virt_to_phys(void *p)
> +{
> +	unsigned i;
> +

We have a null pointer check for __smem here since it is called by 
external clients. This case should probably never happen though.

> +	for (i = 0; i < __smem->num_regions; i++) {
> +		struct smem_region *region = &__smem->regions[i];
> +
> +		if (p < region->virt_base)
> +			continue;
> +		if (p < region->virt_base + region->size) {
> +			u64 offset = p - region->virt_base;
> +
> +			return (phys_addr_t)region->aux_base + offset;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(qcom_smem_virt_to_phys);

Thanks,
Chris

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
