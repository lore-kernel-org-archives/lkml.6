Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE42BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B50820870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQePg2zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbfAaEvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:51:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35004 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfAaEvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:51:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so929165plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 20:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XHC0Bz6E+CrzvTkgMAAZA+InJvh48V1B7QNKRM28EFY=;
        b=UQePg2zdTP/bbD+RY/CXcUIQcYFekwpNS2cCAomREJNn8Ni2Nbc92ykLGYUqnfU+zQ
         2mZvRIz1S3swoDb1IWq6xO9g6W6r5VJM+6Rf5bR4WXjKS6gumZw9J0qKGWN6Y24q3Mq2
         9YKl6Vbx4XMSiNGcI4hMVdVIeOMkQ2wBNofYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XHC0Bz6E+CrzvTkgMAAZA+InJvh48V1B7QNKRM28EFY=;
        b=uUlYP+1zyKAk5r/dm6KvS7Ma5xnAGws6ggxFj+ydW+h4eChE3hSbgRJX68WSkyEJtG
         SrOkQvB6bNY/XP5ad71VG10LY6D8nlYa8lF0QyT6Q37vBD6khP2b5ST6SoVkyiyFj4es
         zI8wx57NMeQT+ucb0juhwM0Kf/LoSct/LneY1vN75wLOuTzQEq0y2hN11Q6L8y2TEcKX
         csLNY0skzlSxSs3vKBXAx5Ynkyf3orsxeWOadpzywrzL8PVbeg+TXbjyn+qh/IYyo+hy
         O/r1bMjMtpaTmBJNPplD+eqQy9jFV/v0nai3TksI3IT5SABxr+4lrUTABfJNavXzv1o+
         UScA==
X-Gm-Message-State: AJcUukdUEq0TW9qnQFSHjFhYHTrLJwJ3FT844qZoQjX3kixFrp2ypaKx
        HicJRab0ujjKG/EteX/ZHcjzUA==
X-Google-Smtp-Source: ALg8bN5Rc8FO7XvhCoh7duJ8VSdjyuKUbeZtgavMh3ufG02gJFhlup0TJiM54gR7fzdpMeOF1KDGZg==
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr34050070pll.54.1548910303325;
        Wed, 30 Jan 2019 20:51:43 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b13sm6336049pfj.66.2019.01.30.20.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 20:51:42 -0800 (PST)
Date:   Wed, 30 Jan 2019 20:51:28 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v5 08/10] remoteproc: q6v5-mss: Active powerdomain for
 SDM845
Message-ID: <20190131045128.GO31596@builder>
References: <20190131003933.11436-1-bjorn.andersson@linaro.org>
 <20190131003933.11436-9-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131003933.11436-9-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30 Jan 16:39 PST 2019, Bjorn Andersson wrote:

> The SDM845 MSS needs the load_state powerdomain voted for during the
> duration of the MSS being powered on, to let the AOSS know that it may
> not perform certain power save measures. So vote for this.
> 
> Tested-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 

Applied

> Changes since v4:
> - None
> 
> Changes since v3:
> - None
> 
>  drivers/remoteproc/qcom_q6v5_mss.c | 31 ++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index c32c63e351a0..e30f5486fd20 100644
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
> +	ret = q6v5_pds_enable(qproc, qproc->active_pds, qproc->active_pd_count);
> +	if (ret < 0) {
> +		dev_err(qproc->dev, "failed to enable active power domains\n");
> +		goto disable_irqs;
> +	}
> +
>  	ret = q6v5_pds_enable(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
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
>  	/* In case of failure or coredump scenario where reclaiming MBA memory
>  	 * could not happen reclaim it here.
> @@ -1412,11 +1424,19 @@ static int q6v5_probe(struct platform_device *pdev)
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
> @@ -1452,6 +1472,8 @@ static int q6v5_probe(struct platform_device *pdev)
>  
>  detach_proxy_pds:
>  	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
> +detach_active_pds:
> +	q6v5_pds_detach(qproc, qproc->active_pds, qproc->active_pd_count);
>  free_rproc:
>  	rproc_free(rproc);
>  
> @@ -1469,6 +1491,7 @@ static int q6v5_remove(struct platform_device *pdev)
>  	qcom_remove_smd_subdev(qproc->rproc, &qproc->smd_subdev);
>  	qcom_remove_ssr_subdev(qproc->rproc, &qproc->ssr_subdev);
>  
> +	q6v5_pds_detach(qproc, qproc->active_pds, qproc->active_pd_count);
>  	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
>  
>  	rproc_free(qproc->rproc);
> @@ -1495,6 +1518,10 @@ static const struct rproc_hexagon_res sdm845_mss = {
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
> -- 
> 2.18.0
> 
