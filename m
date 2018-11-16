Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB372086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULBGunRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB372086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeKQG2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:28:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32990 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeKQG2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:28:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so8428117pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 12:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/6W9X6SshvtP4mTEt321Jdsofs/SrUqZbXZWUI6/oCA=;
        b=ULBGunRhyk1iFMO109+7/m6ajmhPujWiIXc7surc7ooLp6EWZ0La8BIHSwE2izIznk
         V3c7tlu9DW6IpkanQ9/36HX0kHsy3PE8a+A4ywozvEYkWkmOaERuaopgEgazqgat1fIe
         XtpOmxPH9ZcMRXT5Cb6n3gkbZu1AZPExJlH6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/6W9X6SshvtP4mTEt321Jdsofs/SrUqZbXZWUI6/oCA=;
        b=s4j/JNWkid3rDhEeOt7zpthdqR4jO9vPahKUldt1gcpucaQ7W3JJyrg9M3gMxR4S21
         IP7d9cRryuyH2qg7RGgZZHej5xQhLICwqh0kS5CUuZaPSSvezieES5RNitblinJX0JrF
         6vEA7aRw0w6s2AWENQDRFVspj9Vm2e0UqWaCECwSBwjFT61d3qtlyWOwDf9yFzqbw6Kd
         jL05rPSC6PkZyr3vPKL7Brmga0GmupNjLhuaN7zlITWlgShcZAsfoSk8LR2IqpogdNjH
         3aaVoUuF0YCKOMQ2GOGq3Xzm2UZkPegf4UJ3cYyF/ZVNLtUEnfuMBvOTQ9LmL4/nV8+o
         cmnw==
X-Gm-Message-State: AGRZ1gJY7vmZ3o+kl6nvBZbSF0X7g5Nq5mMpeonK7S3m6GP7o/hbMqik
        7oDM+snhoB1JbGcb5WUyLQVI8g==
X-Google-Smtp-Source: AJdET5dzDRPUTTdnZ7Mi8JOzklYyxjjIuFoMySM94GnqR2ROFcdzcg1AvWwIoDF7YCTWox2+YlTs+Q==
X-Received: by 2002:a63:907:: with SMTP id 7-v6mr11157574pgj.121.1542399270131;
        Fri, 16 Nov 2018 12:14:30 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 4sm31918100pfq.10.2018.11.16.12.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 12:14:29 -0800 (PST)
Date:   Fri, 16 Nov 2018 12:14:24 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: msm: Add sleep pinctrl state transitions
Message-ID: <20181116201424.GQ10915@tuxbook-pro>
References: <20181116185853.128207-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116185853.128207-1-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16 Nov 10:58 PST 2018, Evan Green wrote:

> Add PM suspend callbacks to the msm core driver that select the
> sleep and default pinctrl states. Then wire those callbacks up
> in the sdm845 driver, for those boards that may have GPIO hogs
> that need to change state during suspend.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v2:
>  - Moved dev_pm_ops structure to pinctrl-msm [Bjorn]
> 
>  drivers/pinctrl/qcom/pinctrl-msm.c    | 19 +++++++++++++++++++
>  drivers/pinctrl/qcom/pinctrl-msm.h    |  2 ++
>  drivers/pinctrl/qcom/pinctrl-sdm845.c |  1 +
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 7c7d083e2c0dc..87cbebe217fd2 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1072,6 +1072,25 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
>  		}
>  }
>  
> +static int msm_pinctrl_suspend(struct device *dev)
> +{
> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
> +
> +	return pinctrl_force_sleep(pctrl->pctrl);
> +}
> +
> +static int msm_pinctrl_resume(struct device *dev)
> +{
> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
> +
> +	return pinctrl_force_default(pctrl->pctrl);
> +}
> +
> +SIMPLE_DEV_PM_OPS(msm_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
> +		  msm_pinctrl_resume);
> +
> +EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
> +
>  int msm_pinctrl_probe(struct platform_device *pdev,
>  		      const struct msm_pinctrl_soc_data *soc_data)
>  {
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index 29172fdf5882c..c12048e54a6f0 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -123,6 +123,8 @@ struct msm_pinctrl_soc_data {
>  	unsigned int ntiles;
>  };
>  
> +extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
> +
>  int msm_pinctrl_probe(struct platform_device *pdev,
>  		      const struct msm_pinctrl_soc_data *soc_data);
>  int msm_pinctrl_remove(struct platform_device *pdev);
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> index 2ab7a88857579..c97f20fca5fd3 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -1300,6 +1300,7 @@ static const struct of_device_id sdm845_pinctrl_of_match[] = {
>  static struct platform_driver sdm845_pinctrl_driver = {
>  	.driver = {
>  		.name = "sdm845-pinctrl",
> +		.pm = &msm_pinctrl_dev_pm_ops,
>  		.of_match_table = sdm845_pinctrl_of_match,
>  	},
>  	.probe = sdm845_pinctrl_probe,
> -- 
> 2.16.4
> 
