Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ABEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434462152E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="de/l1u48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434462152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeH0Gr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:47:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41338 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeH0Gr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:47:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so6141351pfk.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 20:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7j5Xil8wzfC7pDWizB4i+j9yZsZ36G0W6x6Dz1oh7Ak=;
        b=de/l1u48y/YIuZez0CzRhy4RvAWfkOxuCkeZOAt54V/nWISavWXfHicXY3tVAYFnke
         L6ziqHhEpaC70SYErQBlK8vZsbrjOCghxFWskkLM0mjpRn+MhCGWe46ccWnkv2srvdfk
         kth0oxvUjD9GiLF7jGmeFjQw6PrL2S72eA0Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7j5Xil8wzfC7pDWizB4i+j9yZsZ36G0W6x6Dz1oh7Ak=;
        b=AAoNJsq1UkNBppbbMhzw2I1Xq5w9TrBUtKnk3aiKkOMX15FgJZh5BnswvA05ppOFrL
         wJrCfk6tt3+Vlb0axAobQWbW/Z0U0aLha68//9oC5/bb7oEzLKZ9TbPKdlD0b4qcXqCv
         MJPxNSB/iOt4CL8V4IRDMu0wXBP8d5NOujjrx+bnOis7xd1chAhLclXKHXqwHMN+u40i
         b8Z+Gzmm9k1CbEWPc+S6bTiouRRcKxbLObvf8N9jNrJM/UX+GFPnxjmrPIo7P+RenXz4
         FPtpiZRiHn2k1a+iXQFAmHbwJDnyO4D4lHInvn2UIokfxLAmr8ESM4e+E3lyA4WVuZL1
         b3Ng==
X-Gm-Message-State: APzg51DT87fiR8sWKWQeGfOdkH3Ms9J2JdQ1xUJOq55SphZTO/UZd5f4
        yFwYypXpCzIMDTQaoPiwJkYODg==
X-Google-Smtp-Source: ANB0VdaKj5TaX3EGxhc8tXHUEbz5jafgv2VAqLOLJG/KY4Gq/a2u5D8an9z+p18xzd6AdfV7qEZAkQ==
X-Received: by 2002:a62:1192:: with SMTP id 18-v6mr12426670pfr.54.1535338969538;
        Sun, 26 Aug 2018 20:02:49 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l84-v6sm26008391pfg.3.2018.08.26.20.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Aug 2018 20:02:48 -0700 (PDT)
Date:   Sun, 26 Aug 2018 20:06:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/3] pinctrl: msm: Mux out gpio function with
 gpio_request()
Message-ID: <20180827030628.GI3048@tuxbook-pro>
References: <20180816200648.90458-1-swboyd@chromium.org>
 <20180816200648.90458-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816200648.90458-3-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Aug 13:06 PDT 2018, Stephen Boyd wrote:

> We rely on devices to use pinmuxing configurations in DT to select the
> GPIO function (function 0) if they're going to use the gpio in GPIO
> mode. Let's simplify things for driver authors by implementing
> gpio_request_enable() for this pinctrl driver to mux out the GPIO
> function when the gpio is use from gpiolib.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 5d72ffad32c2..793504057ad0 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -176,11 +176,27 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
>  	return 0;
>  }
>  
> +static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
> +				   struct pinctrl_gpio_range *range,
> +				   unsigned offset)
> +{
> +	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> +	const struct msm_pingroup *g = &pctrl->soc->groups[offset];
> +
> +	/* No funcs? Probably ACPI so can't do anything here */
> +	if (!g->nfuncs)
> +		return 0;
> +
> +	/* For now assume function 0 is GPIO because it always is */
> +	return msm_pinmux_set_mux(pctldev, 0, offset);
> +}
> +
>  static const struct pinmux_ops msm_pinmux_ops = {
>  	.request		= msm_pinmux_request,
>  	.get_functions_count	= msm_get_functions_count,
>  	.get_function_name	= msm_get_function_name,
>  	.get_function_groups	= msm_get_function_groups,
> +	.gpio_request_enable	= msm_pinmux_request_gpio,
>  	.set_mux		= msm_pinmux_set_mux,
>  };
>  
> -- 
> Sent by a computer through tubes
> 
