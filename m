Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036DDC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDFA20840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JE+nrg5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDFA20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbeKJREt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 12:04:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42535 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbeKJREs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 12:04:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id t6-v6so1940745plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 23:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w/nMg+wMmODTpWImT5aetcZhSijqT8B/aUSQKYa61tU=;
        b=JE+nrg5rplIlAp+u9uG5M0kqqG4lBmbTTg6Du2sDfSxAQOtukV2H2X9syJJ5h2ZMCe
         cBpQZ5fmjIVF7itBvGc/wA3akvF2CyHj6+vvPx1bW+OhpRMX00Jqg3EJKjnAl9W1bWlC
         /tLn+vQN9+pV/K8XEjxPo6/l6dT4HryfIixkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w/nMg+wMmODTpWImT5aetcZhSijqT8B/aUSQKYa61tU=;
        b=HtH/Mp4uAB+BP7u2S81j8vl0b0Ll8p3F1ODR8lxndVPap+nuz3vRhTsH9fI5z55HTG
         549MHHY+8g2nN2pKLhNNov1Ek6CPZOs7CoN6e4bej42Z8am35lZNG8qFE+l4OOtQldao
         N32aT5r0xped1+97UHUL9YWeOmshRsA7QKG91IsFKMJ1/zxjrwiwu+NZpA1EJ5eIrZjz
         UmEdf5QSJUbp4CUV34cLnLoCrMUkwzWmG8oXTt1fuS+8fPnsCLaxaO2yBKu+J8A/1fLm
         vq5LC0WwK/cCDsos/GaiMy46PISgBPrq1XgXIyIbB2xcp6dDqGy8nByQZOK9B5FcNLDQ
         rS8g==
X-Gm-Message-State: AGRZ1gL5aO4ITTSrdfezbd65AV4d0GzirJs4Ch+dSCciZZSm/hct8T3x
        wd0/85X6zrt3uTrgMryWW2eYkA==
X-Google-Smtp-Source: AJdET5dgUxCs6vY5DHv2u0FyRalPAH0BDRQKbv24xZDzc4mjSG+IkYqeZXJyNnYBvPeKLhIU2O8vsw==
X-Received: by 2002:a17:902:6a87:: with SMTP id n7-v6mr8937547plk.86.1541834448608;
        Fri, 09 Nov 2018 23:20:48 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b18-v6sm8399144pgg.88.2018.11.09.23.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 23:20:47 -0800 (PST)
Date:   Fri, 9 Nov 2018 23:20:45 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] pinctrl: msm: Add sleep pinctrl state transitions
Message-ID: <20181110072045.GB4373@minitux>
References: <20181109222835.60607-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109222835.60607-1-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Nov 14:28 PST 2018, Evan Green wrote:

> Add PM suspend callbacks to the msm core driver that select the
> sleep and default pinctrl states. Then wire those callbacks up
> in the sdm845 driver, for those boards that may have GPIO hogs
> that need to change state during suspend.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
>  drivers/pinctrl/qcom/pinctrl-msm.c    | 16 ++++++++++++++++
>  drivers/pinctrl/qcom/pinctrl-msm.h    |  2 ++
>  drivers/pinctrl/qcom/pinctrl-sdm845.c |  4 ++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 7c7d083e2c0dc..d505d0a50f0a5 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1072,6 +1072,22 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
>  		}
>  }
>  
> +int msm_pinctrl_suspend(struct device *dev)
> +{
> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
> +
> +	return pinctrl_force_sleep(pctrl->pctrl);
> +}
> +EXPORT_SYMBOL(msm_pinctrl_suspend);
> +
> +int msm_pinctrl_resume(struct device *dev)
> +{
> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
> +
> +	return pinctrl_force_default(pctrl->pctrl);
> +}
> +EXPORT_SYMBOL(msm_pinctrl_resume);
> +
>  int msm_pinctrl_probe(struct platform_device *pdev,
>  		      const struct msm_pinctrl_soc_data *soc_data)
>  {
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index 29172fdf5882c..e163ca600ecd3 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -123,6 +123,8 @@ struct msm_pinctrl_soc_data {
>  	unsigned int ntiles;
>  };
>  
> +int msm_pinctrl_suspend(struct device *dev);
> +int msm_pinctrl_resume(struct device *dev);
>  int msm_pinctrl_probe(struct platform_device *pdev,
>  		      const struct msm_pinctrl_soc_data *soc_data);
>  int msm_pinctrl_remove(struct platform_device *pdev);
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> index 2ab7a88857579..a3ac9cbeabad1 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -1287,6 +1287,9 @@ static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
>  	.ngpios = 150,
>  };
>  
> +static SIMPLE_DEV_PM_OPS(sdm845_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
> +			 msm_pinctrl_resume);

I don't expect this to differ between the various platforms, so how
about moving it to pinctrl-msm?

Regards,
Bjorn

> +
>  static int sdm845_pinctrl_probe(struct platform_device *pdev)
>  {
>  	return msm_pinctrl_probe(pdev, &sdm845_pinctrl);
> @@ -1300,6 +1303,7 @@ static const struct of_device_id sdm845_pinctrl_of_match[] = {
>  static struct platform_driver sdm845_pinctrl_driver = {
>  	.driver = {
>  		.name = "sdm845-pinctrl",
> +		.pm = &sdm845_pinctrl_dev_pm_ops,
>  		.of_match_table = sdm845_pinctrl_of_match,
>  	},
>  	.probe = sdm845_pinctrl_probe,
> -- 
> 2.16.4
> 
