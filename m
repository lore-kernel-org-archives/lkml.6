Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeDYEvx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:51:53 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43751 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDYEvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:51:51 -0400
X-Google-Smtp-Source: AIpwx4/DX37jZL+qRfIKf0GxN4/7t9XMElb8zkc66KfKUxPWGHYoP0F0q/qGchq2Vni8rB6vMgvNyw==
Date: Tue, 24 Apr 2018 21:52:59 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: andy.gross@linaro.org, clew@codeaurora.org, aneela@codeaurora.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] soc: qcom: smem: check sooner in
 qcom_smem_set_global_partition()
Message-ID: <20180425045259.GJ2052@tuxbook-pro>
References: <20180410222542.29474-1-elder@linaro.org>
 <20180410222542.29474-7-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410222542.29474-7-elder@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Apr 15:25 PDT 2018, Alex Elder wrote:

> There's no sense in scanning the partition table again if we know
> the global partition has already been discovered.  Check for a
> non-null global_partition pointer in qcom_smem_set_global_partition()
> immediately.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/smem.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 6e42599b70d4..7d9a43da5084 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -364,6 +364,11 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
>  	end = phdr_to_last_uncached_entry(phdr);
>  	cached = phdr_to_last_cached_entry(phdr);
>  
> +	if (smem->global_partition) {
> +		dev_err(smem->dev, "Already found the global partition\n");
> +		return -EINVAL;
> +	}
> +
>  	while (hdr < end) {
>  		if (hdr->canary != SMEM_PRIVATE_CANARY)
>  			goto bad_canary;
> @@ -729,11 +734,6 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
>  		return -EINVAL;
>  	}
>  
> -	if (smem->global_partition) {
> -		dev_err(smem->dev, "Already found the global partition\n");
> -		return -EINVAL;
> -	}
> -
>  	header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
>  	host0 = le16_to_cpu(header->host0);
>  	host1 = le16_to_cpu(header->host1);
> -- 
> 2.14.1
> 
