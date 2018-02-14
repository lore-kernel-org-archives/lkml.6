Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032358AbeBNQRo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:17:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50532 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032153AbeBNQRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:17:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71EA560385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Wed, 14 Feb 2018 09:17:39 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] drm/msm: Trigger fence completion from GPU
Message-ID: <20180214161739.GB25422@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180214064658.15741-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214064658.15741-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:46:58PM -0800, Bjorn Andersson wrote:
> Interrupt commands causes the CP to trigger an interrupt as the command
> is processed, regardless of the GPU being done processing previous
> commands. This is seen by the interrupt being delivered before the
> fence is written on 8974 and is likely the cause of the additional
> CP_WAIT_FOR_IDLE workaround found for a306, which would cause the CP to
> wait for the GPU to go idle before triggering the interrupt.
> 
> Instead we can set the (undocumented) BIT(31) of the CACHE_FLUSH_TS
> which will cause a special CACHE_FLUSH_TS interrupt to be triggered from
> the GPU as the write event is processed.
> 
> Add CACHE_FLUSH_TS to the IRQ masks of A3xx and A4xx and remove the
> workaround for A306.
> 
> Suggested-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

LGTM. This should help your races.

> ---
> 
> This is only tested on 8974.
> 
>  drivers/gpu/drm/msm/adreno/a3xx_gpu.c   |  1 +
>  drivers/gpu/drm/msm/adreno/a4xx_gpu.c   |  1 +
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 18 ++----------------
>  3 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> index 4baef2738178..a3a43be920d0 100644
> --- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> @@ -35,6 +35,7 @@
>  	 A3XX_INT0_CP_RB_INT |             \
>  	 A3XX_INT0_CP_REG_PROTECT_FAULT |  \
>  	 A3XX_INT0_CP_AHB_ERROR_HALT |     \
> +	 A3XX_INT0_CACHE_FLUSH_TS |        \
>  	 A3XX_INT0_UCHE_OOB_ACCESS)
>  
>  extern bool hang_debug;
> diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> index 8199a4b9f2fa..b44cd0d90621 100644
> --- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
> @@ -27,6 +27,7 @@
>  	 A4XX_INT0_CP_RB_INT |             \
>  	 A4XX_INT0_CP_REG_PROTECT_FAULT |  \
>  	 A4XX_INT0_CP_AHB_ERROR_HALT |     \
> +	 A4XX_INT0_CACHE_FLUSH_TS |        \
>  	 A4XX_INT0_UCHE_OOB_ACCESS)
>  
>  extern bool hang_debug;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index de63ff26a062..5806f9942514 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -293,26 +293,12 @@ void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>  		OUT_RING(ring, 0x00000000);
>  	}
>  
> +	/* BIT(31) of CACHE_FLUSH_TS triggers CACHE_FLUSH_TS IRQ from GPU */
>  	OUT_PKT3(ring, CP_EVENT_WRITE, 3);
> -	OUT_RING(ring, CACHE_FLUSH_TS);
> +	OUT_RING(ring, CACHE_FLUSH_TS | BIT(31));
>  	OUT_RING(ring, rbmemptr(ring, fence));
>  	OUT_RING(ring, submit->seqno);
>  
> -	/* we could maybe be clever and only CP_COND_EXEC the interrupt: */
> -	OUT_PKT3(ring, CP_INTERRUPT, 1);
> -	OUT_RING(ring, 0x80000000);
> -
> -	/* Workaround for missing irq issue on 8x16/a306.  Unsure if the
> -	 * root cause is a platform issue or some a306 quirk, but this
> -	 * keeps things humming along:
> -	 */
> -	if (adreno_is_a306(adreno_gpu)) {
> -		OUT_PKT3(ring, CP_WAIT_FOR_IDLE, 1);
> -		OUT_RING(ring, 0x00000000);
> -		OUT_PKT3(ring, CP_INTERRUPT, 1);
> -		OUT_RING(ring, 0x80000000);
> -	}
> -
>  #if 0
>  	if (adreno_is_a3xx(adreno_gpu)) {
>  		/* Dummy set-constant to trigger context rollover */
> -- 
> 2.15.0
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
