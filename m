Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDYEt1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:49:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35828 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeDYEtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:49:24 -0400
X-Google-Smtp-Source: AIpwx4/6V8gyWKOD0kTbC1Q+zm7Y1SGlMsX/GbYLr0swlueP6OAdIf3T48sk5eyEcpBVNXhw6Sgr9g==
Date: Tue, 24 Apr 2018 21:50:33 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: andy.gross@linaro.org, clew@codeaurora.org, aneela@codeaurora.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] soc: qcom: smem: fix qcom_smem_set_global_partition()
Message-ID: <20180425045033.GI2052@tuxbook-pro>
References: <20180410222542.29474-1-elder@linaro.org>
 <20180410222542.29474-6-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410222542.29474-6-elder@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Apr 15:25 PDT 2018, Alex Elder wrote:

> If there is at least one entry in the partition table, but no global
> entry, the qcom_smem_set_global_partition() should return an error
> just like it does if there are no partition table entries.
> 
> It turns out the function still returns an error in this case, but
> it waits to do so until it has mistakenly treated the last entry in
> the table as if it were the global entry found.
> 
> Fix the function to return immediately if no global entry is found
> in the table.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/smem.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 0ed263055988..6e42599b70d4 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -698,9 +698,10 @@ static u32 qcom_smem_get_item_count(struct qcom_smem *smem)
>  static int qcom_smem_set_global_partition(struct qcom_smem *smem)
>  {
>  	struct smem_partition_header *header;
> -	struct smem_ptable_entry *entry = NULL;
> +	struct smem_ptable_entry *entry;
>  	struct smem_ptable *ptable;
>  	u32 host0, host1, size;
> +	bool found = false;
>  	int i;
>  
>  	ptable = qcom_smem_get_ptable(smem);
> @@ -712,11 +713,13 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
>  		host0 = le16_to_cpu(entry->host0);
>  		host1 = le16_to_cpu(entry->host1);
>  
> -		if (host0 == SMEM_GLOBAL_HOST && host0 == host1)
> +		if (host0 == SMEM_GLOBAL_HOST && host0 == host1) {
> +			found = true;
>  			break;
> +		}
>  	}
>  
> -	if (!entry) {
> +	if (!found) {
>  		dev_err(smem->dev, "Missing entry for global partition\n");
>  		return -EINVAL;
>  	}
> -- 
> 2.14.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
