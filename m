Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeDYEnW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:43:22 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35132 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeDYEnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:43:17 -0400
X-Google-Smtp-Source: AIpwx4/pSkEh3D4fQQ1/6YTdwcF/pSQMZy4g+nKLerqyvyn2qtQFN+ifqOdcYUMvSY9H79lxkH8S7g==
Date: Tue, 24 Apr 2018 21:44:25 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: andy.gross@linaro.org, clew@codeaurora.org, aneela@codeaurora.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] soc: qcom: smem: byte swap values properly
Message-ID: <20180425044425.GG2052@tuxbook-pro>
References: <20180410222542.29474-1-elder@linaro.org>
 <20180410222542.29474-4-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410222542.29474-4-elder@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Apr 15:25 PDT 2018, Alex Elder wrote:

> Two places report an error when a partition header is found to
> not contain the right canary value.  The error messages do not
> properly byte swap the host ids.  Fix this, and adjust the format
> specificier to match the 16-bit unsigned data type.
> 
> Move the error handling for a bad canary value to the end of
> qcom_smem_alloc_private().  This avoids some long lines, and
> reduces the distraction of handling this unexpected problem.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/smem.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 3102aa94aec2..82f0908b90e1 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -365,13 +365,8 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
>  	cached = phdr_to_last_cached_entry(phdr);
>  
>  	while (hdr < end) {
> -		if (hdr->canary != SMEM_PRIVATE_CANARY) {
> -			dev_err(smem->dev,
> -				"Found invalid canary in hosts %d:%d partition\n",
> -				phdr->host0, phdr->host1);
> -			return -EINVAL;
> -		}
> -
> +		if (hdr->canary != SMEM_PRIVATE_CANARY)
> +			goto bad_canary;
>  		if (le16_to_cpu(hdr->item) == item)
>  			return -EEXIST;
>  
> @@ -400,6 +395,11 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
>  	le32_add_cpu(&phdr->offset_free_uncached, alloc_size);
>  
>  	return 0;
> +bad_canary:
> +	dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
> +		le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
> +
> +	return -EINVAL;
>  }
>  
>  static int qcom_smem_alloc_global(struct qcom_smem *smem,
> @@ -563,8 +563,8 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
>  	return ERR_PTR(-ENOENT);
>  
>  invalid_canary:
> -	dev_err(smem->dev, "Found invalid canary in hosts %d:%d partition\n",
> -			phdr->host0, phdr->host1);
> +	dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
> +			le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
>  
>  	return ERR_PTR(-EINVAL);
>  }
> -- 
> 2.14.1
> 
