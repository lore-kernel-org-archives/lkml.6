Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeDYEin (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:38:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38753 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeDYEik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:38:40 -0400
X-Google-Smtp-Source: AIpwx4/fWQ+oa/E3HgHyq1MsPWgtIE7rqGfQwuybg481KB6OTZ9XS8zB+ywgQ3RrY8+NwmN8GoidWg==
Date: Tue, 24 Apr 2018 21:39:48 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: andy.gross@linaro.org, clew@codeaurora.org, aneela@codeaurora.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] soc: qcom: smem: return proper type for cached entry
 functions
Message-ID: <20180425043948.GF2052@tuxbook-pro>
References: <20180410222542.29474-1-elder@linaro.org>
 <20180410222542.29474-3-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410222542.29474-3-elder@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Apr 15:25 PDT 2018, Alex Elder wrote:

> What phdr_to_last_uncached_entry() returns is the address of the
> start of the free space following all allocated uncached entries.
> It really doesn't refer to an actual (initialized) private entry
> structure.   Similarly phdr_to_last_cached_entry() returns the
> address of the end of free space, preceding the last allocated cache
> entry.  Change both functions' return type to be pointer to void
> to reflect this.
> 
> Meanwhile, phdr_to_first_cached_entry() really *does* point to a
> private entry structure, so change its return type to reflect
> this fact.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/smem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 7f38c5e11440..3102aa94aec2 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -280,7 +280,7 @@ struct qcom_smem {
>  	struct smem_region regions[0];
>  };
>  
> -static struct smem_private_entry *
> +static void *
>  phdr_to_last_uncached_entry(struct smem_partition_header *phdr)
>  {
>  	void *p = phdr;
> @@ -288,7 +288,8 @@ phdr_to_last_uncached_entry(struct smem_partition_header *phdr)
>  	return p + le32_to_cpu(phdr->offset_free_uncached);
>  }
>  
> -static void *phdr_to_first_cached_entry(struct smem_partition_header *phdr,
> +static struct smem_private_entry *
> +phdr_to_first_cached_entry(struct smem_partition_header *phdr,
>  					size_t cacheline)
>  {
>  	void *p = phdr;
> @@ -297,7 +298,8 @@ static void *phdr_to_first_cached_entry(struct smem_partition_header *phdr,
>  	return p + le32_to_cpu(phdr->size) - ALIGN(sizeof(*e), cacheline);
>  }
>  
> -static void *phdr_to_last_cached_entry(struct smem_partition_header *phdr)
> +static void *
> +phdr_to_last_cached_entry(struct smem_partition_header *phdr)
>  {
>  	void *p = phdr;
>  
> -- 
> 2.14.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
