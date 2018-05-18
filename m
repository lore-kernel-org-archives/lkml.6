Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeERVrO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:47:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37444 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERVrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:47:11 -0400
X-Google-Smtp-Source: AB8JxZp1F9lu+AjWnpEBJfU1Uwt/Jmqe4b8YnJeaDxKcHJrcE/dnAMvTSeHqFmdb1/v/kxEmaQFNaA==
Date: Fri, 18 May 2018 14:47:08 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v4 5/5] remoteproc: qcom: Always assert and deassert
 reset signals in SDM845
Message-ID: <20180518214708.GU14924@minitux>
References: <20180425150843.26657-1-sibis@codeaurora.org>
 <20180425150843.26657-6-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425150843.26657-6-sibis@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 Apr 08:08 PDT 2018, Sibi Sankar wrote:

> SDM845 brings a new reset signal ALT_RESET which is a part of the MSS
> subsystem hence requires some of the active clks to be enabled before
> assert/deassert
> 
> Reset the modem if the BOOT FSM does timeout
> 
> Reset assert/deassert sequence vary across SoCs adding reset, adding
> start/stop helper functions to handle SoC specific reset sequences
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pil.c | 81 ++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
[..]
> @@ -349,6 +356,32 @@ static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
>  	return 0;
>  }
>  
> +static int q6v5_reset_assert(struct q6v5 *qproc)
> +{
> +	return reset_control_assert(qproc->mss_restart);
> +}
> +
> +static int q6v5_reset_deassert(struct q6v5 *qproc)
> +{
> +	return reset_control_deassert(qproc->mss_restart);
> +}
> +
> +static int q6v5_alt_reset_assert(struct q6v5 *qproc)
> +{
> +	return reset_control_reset(qproc->mss_restart);
> +}
> +
> +static int q6v5_alt_reset_deassert(struct q6v5 *qproc)
> +{
> +	/* Ensure alt reset is written before restart reg */
> +	writel(1, qproc->rmb_base + RMB_MBA_ALT_RESET);
> +
> +	reset_control_reset(qproc->mss_restart);
> +
> +	writel(0, qproc->rmb_base + RMB_MBA_ALT_RESET);
> +	return 0;
> +}
> +

Rather than having these four functions and scattering jumps to some
function pointer in the code I think it will be shorter and cleaner to
just have the q6v5_reset_{asert,deassert}() functions and in there check
if has_alt_reset and take appropriate action.

>  static int q6v5_rmb_pbl_wait(struct q6v5 *qproc, int ms)
>  {
>  	unsigned long timeout;
> @@ -424,6 +457,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
>  				val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
>  		if (ret) {
>  			dev_err(qproc->dev, "Boot FSM failed to complete.\n");
> +			/* Reset the modem so that boot FSM is in reset state */
> +			qproc->reset_deassert(qproc);


A thing like this typically should go into it's own patch, to keep a
clear record of why it was changed, but as this is simply amending the
previous patch it indicates that that one wasn't complete.

So if you reorder the two patches you can just put this directly into
the sdm845 patch, making it "complete".

(This also means that I want to merge the handover vs ready interrupt
patch before that one, so please include it in the next revision of the
series).

>  			return ret;
>  		}
>  
> @@ -792,12 +827,20 @@ static int q6v5_start(struct rproc *rproc)
>  		dev_err(qproc->dev, "failed to enable supplies\n");
>  		goto disable_proxy_clk;
>  	}
> -	ret = reset_control_deassert(qproc->mss_restart);
> +
> +	ret = q6v5_clk_enable(qproc->dev, qproc->reset_clks,
> +			      qproc->reset_clk_count);

Remind me, why can't you always enable the active clock before
deasserting reset? That way we wouldn't have to split out the iface
clock handling to be just slightly longer than the active clocks.

>  	if (ret) {
> -		dev_err(qproc->dev, "failed to deassert mss restart\n");
> +		dev_err(qproc->dev, "failed to enable reset clocks\n");
>  		goto disable_vdd;
>  	}
>  
> +	ret = qproc->reset_deassert(qproc);
> +	if (ret) {
> +		dev_err(qproc->dev, "failed to deassert mss restart\n");
> +		goto disable_reset_clks;
> +	}
> +
[..]
> @@ -1335,8 +1399,11 @@ static const struct rproc_hexagon_res sdm845_mss = {
>  			"prng",
>  			NULL
>  	},
> -	.active_clk_names = (char*[]){
> +	.reset_clk_names = (char*[]){
>  			"iface",
> +			NULL
> +	},
> +	.active_clk_names = (char*[]){

Again, if you reorder your patches to first add the support for
alt_reset and then introduce sdm845 you don't need to modify the
previous patch directly to make it work.

>  			"bus",
>  			"mem",
>  			"gpll0_mss",

Regards,
Bjorn
