Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbeEQFVN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 01:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbeEQFVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 01:21:11 -0400
Date: Thu, 17 May 2018 10:51:07 +0530
From: Vinod <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: agross@codeaurora.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: check if the runtime pm enabled
Message-ID: <20180517052107.GT13271@vkoul-mobl>
References: <20180514161852.9620-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514161852.9620-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-05-18, 17:18, Srinivas Kandagatla wrote:
> Disabling pm runtime at probe is not sufficient to get BAM working
> on remotely controller instances. pm_runtime_get_sync() would return
> -EACCES in such cases.
> So check if runtime pm is enabled before returning error from bam functions.
> 
> Fixes: 5b4a68952a89 ("dmaengine: qcom: bam_dma: disable runtime pm on remote controlled")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index d29275b97e84..5f4babebc508 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -540,7 +540,7 @@ static void bam_free_chan(struct dma_chan *chan)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(bdev->dev);
> -	if (ret < 0)
> +	if (pm_runtime_enabled(bdev->dev) && ret < 0)

would it make sense to first check enabled and do _get_sync() 

        if (pm_runtime_enabled()) {
                ret = pm_runtime_get_sync() {
                ...
                }
        }

thus making clear in code that we do calls only when it is enabled. Also you can
add a local macro for this code and use that rather than copy pasting :)

-- 
~Vinod
