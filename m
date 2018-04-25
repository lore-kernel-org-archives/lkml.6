Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeDYEek (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:34:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36029 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeDYEef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:34:35 -0400
X-Google-Smtp-Source: AIpwx4/dgUYta+domyFS3j7ljaS1plaQxkqhSFPbYrNHrced36pWZTB7fD1VoeA0NJFDj/g/+PipJQ==
Date: Tue, 24 Apr 2018 21:35:43 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: andy.gross@linaro.org, clew@codeaurora.org, aneela@codeaurora.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] soc: qcom: smem: fix first cache entry calculation
Message-ID: <20180425043543.GE2052@tuxbook-pro>
References: <20180410222542.29474-1-elder@linaro.org>
 <20180410222542.29474-2-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410222542.29474-2-elder@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Apr 15:25 PDT 2018, Alex Elder wrote:

> Cached items are found at the high end of an smem partition.  A
> cached item's shared memory precedes the private entry structure
> that describes it.
> 
> The address of the structure describing the first cached item should
> be returned by phdr_to_first_cached_entry().  However the function
> calculates the start address using the wrong structure size.
> 
> Fix this by computing the first item's entry structure address by
> subtracting the size of a private entry structure rather than a
> partition header structure.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Sorry, I didn't spot these on the mailing list.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/smem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 0b94d62fad2b..7f38c5e11440 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -292,8 +292,9 @@ static void *phdr_to_first_cached_entry(struct smem_partition_header *phdr,
>  					size_t cacheline)
>  {
>  	void *p = phdr;
> +	struct smem_private_entry *e;
>  
> -	return p + le32_to_cpu(phdr->size) - ALIGN(sizeof(*phdr), cacheline);
> +	return p + le32_to_cpu(phdr->size) - ALIGN(sizeof(*e), cacheline);
>  }
>  
>  static void *phdr_to_last_cached_entry(struct smem_partition_header *phdr)
> -- 
> 2.14.1
> 
