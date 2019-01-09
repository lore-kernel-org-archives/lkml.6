Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CBEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA6120859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="covnt8Se";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jzctDUVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfAIOk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:40:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35876 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbfAIOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:40:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF526601DA; Wed,  9 Jan 2019 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547044826;
        bh=5GkCLWdKym0RO7Cz8WlQatBMDx4xO274jfu9GrfL7jI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=covnt8Sedd1B2FpGCmIFh+In/zujtKvZo5KLypA18BX1DsIGDE6MWOcQcSexD6Yn1
         NaPksVqE7Kvl+f0db+tOkO7Ur+shc63UeMA/Rm20m1Ncijbf53DlqzEtC/gt4rfGE1
         K50j7jzAmpxk+J8lJ1ut72KiiuuVBmBIyBSl/Va4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A31B9601DA;
        Wed,  9 Jan 2019 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547044825;
        bh=5GkCLWdKym0RO7Cz8WlQatBMDx4xO274jfu9GrfL7jI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jzctDUVhom9A7HNb8vA2w6HNz27zTL7kMaHkMak0y4Xfm1nkD/EwMg6UXYEOTuEYN
         ME8yhuLOj9clMn2OPbYmeNwk0V64DcROko2r4V278xQR0gONUa5aWh6ifhMdnqjnY6
         7qO8aPul/LP2LuL1M5B8wXkFwfZPQwJrvWEtGTVs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Jan 2019 20:10:25 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 5/7] remoteproc: q6v5-mss: Active powerdomain for
 SDM845
In-Reply-To: <20190106080915.4493-6-bjorn.andersson@linaro.org>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
 <20190106080915.4493-6-bjorn.andersson@linaro.org>
Message-ID: <df33fe44c56424ca1d5865c972e0034e@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-06 13:39, Bjorn Andersson wrote:
> The SDM845 MSS needs the load_state powerdomain voted for during the
> duration of the MSS being powered on, to let the AOSS know that it may
> not perform certain power save measures. So vote for this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - New patch
> 

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Tested-by: Sibi Sankar <sibis@codeaurora.org>

>  drivers/remoteproc/qcom_q6v5_mss.c | 31 ++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c
> b/drivers/remoteproc/qcom_q6v5_mss.c
> index 62cf16ddb7af..7f86d9c551c4 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -133,6 +133,7 @@ struct rproc_hexagon_res {
>  	char **proxy_clk_names;
>  	char **reset_clk_names;
>  	char **active_clk_names;
> +	char **active_pd_names;
>  	char **proxy_pd_names;
>  	int version;
>  	bool need_mem_protection;
> @@ -159,10 +160,12 @@ struct q6v5 {
>  	struct clk *active_clks[8];
>  	struct clk *reset_clks[4];
>  	struct clk *proxy_clks[4];
> +	struct device *active_pds[1];
>  	struct device *proxy_pds[3];
>  	int active_clk_count;
>  	int reset_clk_count;
>  	int proxy_clk_count;
> +	int active_pd_count;
>  	int proxy_pd_count;
> 
>  	struct reg_info active_regs[1];
> @@ -730,10 +733,16 @@ static int q6v5_mba_load(struct q6v5 *qproc)
> 
>  	qcom_q6v5_prepare(&qproc->q6v5);
> 
> +	ret = q6v5_pds_enable(qproc, qproc->active_pds, 
> qproc->active_pd_count);
> +	if (ret < 0) {
> +		dev_err(qproc->dev, "failed to enable active power domains\n");
> +		goto disable_irqs;
> +	}
> +
>  	ret = q6v5_pds_enable(qproc, qproc->proxy_pds, 
> qproc->proxy_pd_count);
>  	if (ret < 0) {
>  		dev_err(qproc->dev, "failed to enable proxy power domains\n");
> -		goto disable_irqs;
> +		goto disable_active_pds;
>  	}
> 
>  	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
> @@ -839,6 +848,8 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>  			       qproc->proxy_reg_count);
>  disable_proxy_pds:
>  	q6v5_pds_disable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
> +disable_active_pds:
> +	q6v5_pds_disable(qproc, qproc->active_pds, qproc->active_pd_count);
>  disable_irqs:
>  	qcom_q6v5_unprepare(&qproc->q6v5);
> 
> @@ -878,6 +889,7 @@ static void q6v5_mba_reclaim(struct q6v5 *qproc)
>  			 qproc->active_clk_count);
>  	q6v5_regulator_disable(qproc, qproc->active_regs,
>  			       qproc->active_reg_count);
> +	q6v5_pds_disable(qproc, qproc->active_pds, qproc->active_pd_count);
> 
>  	/* In case of failure or coredump scenario where reclaiming MBA 
> memory
>  	 * could not happen reclaim it here.
> @@ -1410,11 +1422,19 @@ static int q6v5_probe(struct platform_device 
> *pdev)
>  	}
>  	qproc->active_reg_count = ret;
> 
> +	ret = q6v5_pds_attach(&pdev->dev, qproc->active_pds,
> +			      desc->active_pd_names);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to attach active power domains\n");
> +		goto free_rproc;
> +	}
> +	qproc->active_pd_count = ret;
> +
>  	ret = q6v5_pds_attach(&pdev->dev, qproc->proxy_pds,
>  			      desc->proxy_pd_names);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to init power domains\n");
> -		goto free_rproc;
> +		goto detach_active_pds;
>  	}
>  	qproc->proxy_pd_count = ret;
> 
> @@ -1446,6 +1466,8 @@ static int q6v5_probe(struct platform_device 
> *pdev)
> 
>  detach_proxy_pds:
>  	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
> +detach_active_pds:
> +	q6v5_pds_detach(qproc, qproc->active_pds, qproc->active_pd_count);
>  free_rproc:
>  	rproc_free(rproc);
> 
> @@ -1463,6 +1485,7 @@ static int q6v5_remove(struct platform_device 
> *pdev)
>  	qcom_remove_smd_subdev(qproc->rproc, &qproc->smd_subdev);
>  	qcom_remove_ssr_subdev(qproc->rproc, &qproc->ssr_subdev);
> 
> +	q6v5_pds_detach(qproc, qproc->active_pds, qproc->active_pd_count);
>  	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
> 
>  	rproc_free(qproc->rproc);
> @@ -1489,6 +1512,10 @@ static const struct rproc_hexagon_res sdm845_mss 
> = {
>  			"mnoc_axi",
>  			NULL
>  	},
> +	.active_pd_names = (char*[]){
> +			"load_state",
> +			NULL
> +	},
>  	.proxy_pd_names = (char*[]){
>  			"cx",
>  			"mx",

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
