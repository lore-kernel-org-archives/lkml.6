Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753712AbeDYWLb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:11:31 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46378 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbeDYWLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:11:24 -0400
X-Google-Smtp-Source: AIpwx48twdQ7q1LMpmmnRA+B6Y2No23xmkMZ8sxUOl3nlk0g5XvPxjTDlrCHshuxXd1LTr+4IOn+xg==
Date: Wed, 25 Apr 2018 15:11:23 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v6 06/10] drivers: qcom: rpmh-rsc: allow invalidation of
 sleep/wake TCS
Message-ID: <20180425221123.GD243180@google.com>
References: <20180419221635.17849-1-ilina@codeaurora.org>
 <20180419221635.17849-7-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419221635.17849-7-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:16:31PM -0600, Lina Iyer wrote:
> Allow sleep and wake commands to be cleared from the respective TCSes,
> so that they can be re-populated.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> 
> Changes in v6:
> 	- remove unnecessary locks around __tcs_invalidate
> 	- rename function to tcs_invaldiate
> 
> Changes in v4:
> 	- refactored the rphm_rsc_invalidate()
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 45 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index d169f7da5422..170d4a10275d 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -101,6 +101,51 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
>  	return &drv->tcs[type];
>  }
>  
> +static int tcs_invalidate(struct rsc_drv *drv, int type)
> +{
> +	int m;
> +	struct tcs_group *tcs;
> +
> +	tcs = get_tcs_of_type(drv, type);
> +	if (IS_ERR(tcs))
> +		return PTR_ERR(tcs);
> +
> +	spin_lock(&tcs->lock);
> +	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
> +		spin_unlock(&tcs->lock);
> +		return 0;
> +	}
> +
> +	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
> +		if (!tcs_is_free(drv, m)) {
> +			spin_unlock(&tcs->lock);
> +			return -EAGAIN;
> +		}
> +		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
> +		bitmap_zero(tcs->slots, MAX_TCS_SLOTS);

Shouldn't this only clear the slots corresponding to 'm'?

If resetting the entire bitmap is really intended it could be done
once after the loop, though the bitmap might be left in an
inconsistent state if a TCS is still in use.
