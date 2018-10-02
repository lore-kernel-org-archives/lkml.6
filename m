Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD5CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FC420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/9ihYxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FC420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJBKbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:31:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36889 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeJBKbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:31:19 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so834948iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 20:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v9Eqvx1jsn/JeXURoYS+mFE1D6zTcDXe3g4w2LJnyB0=;
        b=S/9ihYxgcKbznyaedaPooWJ5vIMhEp0YOzzYXh1AP8Fbqhz+sDZxq78z5KCBgkZuVF
         i7JACpAfeOaUK/ttilsMhim0M/ZxKIhPN0TJgwgUCtWtR60emWi1+fJt8Z4sFd+EOv+K
         soJRIwgWbnk6T6EK31nxCtvCKCwt8how3t2QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v9Eqvx1jsn/JeXURoYS+mFE1D6zTcDXe3g4w2LJnyB0=;
        b=YHfBnZ3MQK0+BvRo6DQ0nWnudn4Xi0KICBCe5nizABg9mOPyyKxodlVBgkrrTLarH7
         M9ITBIbyl2EgcgTQSSogu67oAoVLCCB9TOdodaNclR3pRQIQ9Wb72T4I5KQFmAviYRur
         1DL6pvYzCIGXSegnC9TtFUWwE0ax69rqxFRvmNJsLVxr1jJUmExJmGSRetBA6Tsvyk1X
         EYmGQB/AfaXMbfgi1sQ4+fvsR8LCv3dGBSniwJE9yIGAmHzNOWnyG4g+EnzSza/mKr7d
         4RYM1lzbNa6TAq3qmX/2Y+NqvL7UsO3Cs5EqLoLwX5As1rIEM+5X04OEAWdMZLivquFC
         Ph0g==
X-Gm-Message-State: ABuFfohkTg3lMlrgCJE4Q1EmJBD95VrbHeg7oeVJP/W0AQAk5XrriVlb
        tSYJO2Rhp1CzNPx2WNmrXIs3Rg==
X-Google-Smtp-Source: ACcGV61ESlDmmSmv0HXidNoxQPXeEMFWk8miRwyKtZGZRghmQoGJspmiAcb43J0zJKuWFCsWj/0kcQ==
X-Received: by 2002:a62:cac4:: with SMTP id y65-v6mr14309812pfk.27.1538452213490;
        Mon, 01 Oct 2018 20:50:13 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q24-v6sm36869742pfi.165.2018.10.01.20.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 20:50:12 -0700 (PDT)
Date:   Mon, 1 Oct 2018 20:50:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH] pinctrl: msm: Actually use function 0 for gpio selection
Message-ID: <20181002035010.GB5008@tuxbook-pro>
References: <20181001214905.12149-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001214905.12149-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Oct 14:49 PDT 2018, Stephen Boyd wrote:

> This code needs to select function #0, which is the first int in the
> array of functions, not the number 0 which may or may not be the
> function for "GPIO mode" per the enum mapping. We were getting lucky on
> SDM845, where this was tested, because the function 0 matched the enum
> value for "GPIO mode". On other platforms, e.g. MSM8996, the gpio enum
> value is the last one in the list so this code doesn't work and we see a
> warning at boot. Fix it by grabbing the first element out of the array
> of functions.
> 
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Fixes: 1de7ddb3a15c ("pinctrl: msm: Mux out gpio function with gpio_request()")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Oops...

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 1684b2da09d5..b925b8feac95 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -188,7 +188,7 @@ static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
>  		return 0;
>  
>  	/* For now assume function 0 is GPIO because it always is */
> -	return msm_pinmux_set_mux(pctldev, 0, offset);
> +	return msm_pinmux_set_mux(pctldev, g->funcs[0], offset);
>  }
>  
>  static const struct pinmux_ops msm_pinmux_ops = {
> -- 
> Sent by a computer through tubes
> 
