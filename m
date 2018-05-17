Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeEQKry (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbeEQKrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:47:52 -0400
Date: Thu, 17 May 2018 16:17:48 +0530
From: Vinod <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: agross@codeaurora.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dmaengine: qcom: bam_dma: check if the runtime pm
 enabled
Message-ID: <20180517104748.GY13271@vkoul-mobl>
References: <20180517094232.27924-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517094232.27924-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 10:42, Srinivas Kandagatla wrote:
> Disabling pm runtime at probe is not sufficient to get BAM working
> on remotely controller instances. pm_runtime_get_sync() would return
> -EACCES in such cases.
> So check if runtime pm is enabled before returning error from bam functions.
> 
> Fixes: 5b4a68952a89 ("dmaengine: qcom: bam_dma: disable runtime pm on remote controlled")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index d29275b97e84..4a828c18099a 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -524,6 +524,14 @@ static int bam_alloc_chan(struct dma_chan *chan)
>  	return 0;
>  }
>  
> +static int bam_pm_runtime_get_sync(struct device *dev)
> +{
> +	if (pm_runtime_enabled(dev))
> +		return pm_runtime_get_sync(dev);
> +
> +	return 0;
> +}

This makes it look lot neater :)

Applied, thanks

-- 
~Vinod
