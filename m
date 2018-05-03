Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeECWGz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:06:55 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42435 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeECWGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:06:53 -0400
X-Google-Smtp-Source: AB8JxZr0m5KvCgXKFPccp6YbOEHr2sqhev8JJGw6C7m7962Pnn6xnx0xzKlv17CH+Mg+PanHuJtHXQ==
Date: Thu, 3 May 2018 15:06:51 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v7 06/10] drivers: qcom: rpmh-rsc: allow invalidation of
 sleep/wake TCS
Message-ID: <20180503220651.GB19594@google.com>
References: <20180502193749.31004-1-ilina@codeaurora.org>
 <20180502193749.31004-7-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180502193749.31004-7-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

On Wed, May 02, 2018 at 01:37:45PM -0600, Lina Iyer wrote:
> Allow sleep and wake commands to be cleared from the respective TCSes,
> so that they can be re-populated.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> 
> Changes in v7:
> 	- Move bitmap_zero() outside the loop
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
> index 4e2144a14c31..42aedf2d80fe 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -104,6 +104,51 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
>  	return &drv->tcs[type];
>  }
>  
> +static int tcs_invalidate(struct rsc_drv *drv, int type)
> +{
> +	int m;

nit: use tcs_id?

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
> +	}
> +	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);

You didn't reply to (or address) my comment on v6:

It could occur that one or more TCSes are disabled, then tcs_is_free()
returns false for the next TCS and the function returns without having
updated tcs->slots for the TCSes that have been disabled.
