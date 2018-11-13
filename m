Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12097C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72C52243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FU/5tsB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72C52243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbeKMMqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:46:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38103 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbeKMMqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:46:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id v76-v6so2438219pfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 18:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oT1hUpNPL7ChT4bWwvAqa+cFPfLJQhcjlzEWpQA7db8=;
        b=FU/5tsB9+W5hZD3tDk9a9WOByX80jjqyWxXCTIkedAO+Be10CoOCWGh31SkTE9JgM5
         c5PsTmEIkpbqWRCE/rmx8yLa82kG7n1qu+ZYg8Wl0YMVajyvGYIROi9ec5MU3rEe0ZaO
         4+30ArK9zM4ni08+auAU9kHcz3APitfSqem3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oT1hUpNPL7ChT4bWwvAqa+cFPfLJQhcjlzEWpQA7db8=;
        b=NY22v3xIc8mx72cLdKyyf0pNPAhWbueMCO6BpqTii+L2Nc2Y8P+FL5I9HIdt27kqhV
         oSdIK9NKxw051SIz9y+6U2wfU9iAh1J247BCRClVM8I95g+bepKt+9Y8bdAsaecnHWm4
         UJqEE2FbPg5qlhR2Eg+2UVbBW7rsewSlpDDXOMGj7/M3hzOzOQF20OJlTCaWN7CdBkxX
         alYb8belcCuil+ONI1Y0qloLSFQ4c42lb8xxdZ/xR+zW5kv7rVEag+e7VOUXoouRrDKM
         1wobqZ0QlwZObK5zDWnnS8Tcwsw3HPAZ96KZpVToukImov8i/Cc0plNlp+spoYO3WFjX
         Lahg==
X-Gm-Message-State: AGRZ1gLD/23M5jqx05kxuVz7e9XLBS/SSy17ppHITBDdHRqF4fDq11mB
        WJXc69CSgqz9IQy77IvqroJMPw==
X-Google-Smtp-Source: AJdET5eSJULhXc45ukkXee2Ccr0rKYyfLZNgZi5rW76WYU06lYkG4kyLeMl9NLuBQKWTYzp7NuJWwA==
X-Received: by 2002:a62:5210:: with SMTP id g16-v6mr3335866pfb.256.1542077415088;
        Mon, 12 Nov 2018 18:50:15 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g15sm1084734pfj.131.2018.11.12.18.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 18:50:14 -0800 (PST)
Date:   Mon, 12 Nov 2018 18:50:12 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: sdm660: Set tile property for pingroups
Message-ID: <20181113025012.GD10088@minitux>
References: <20181112202553.1410-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112202553.1410-1-ctatlor97@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12 Nov 12:25 PST 2018, Craig Tatlor wrote:

> This was missed when tiles support was added in a revison and
> causes the driver to fail to load.
> 
> Fixes: 9cf0c526bc58 ("pinctrl: qcom: Add sdm660 pinctrl driver")
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---

Sorry for not spotting this in my previous review.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

>  drivers/pinctrl/qcom/pinctrl-sdm660.c | 28 ++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm660.c b/drivers/pinctrl/qcom/pinctrl-sdm660.c
> index 6838b38555a1..1bfb0ae6b387 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm660.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm660.c
> @@ -33,7 +33,7 @@ enum {
>  	}
>  
>  
> -#define PINGROUP(id, base, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
> +#define PINGROUP(id, _tile, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
>  	{					        \
>  		.name = "gpio" #id,			\
>  		.pins = gpio##id##_pins,		\
> @@ -51,11 +51,12 @@ enum {
>  			msm_mux_##f9			\
>  		},				        \
>  		.nfuncs = 10,				\
> -		.ctl_reg = base + REG_SIZE * id,	\
> -		.io_reg = base + 0x4 + REG_SIZE * id,		\
> -		.intr_cfg_reg = base + 0x8 + REG_SIZE * id,		\
> -		.intr_status_reg = base + 0xc + REG_SIZE * id,	\
> -		.intr_target_reg = base + 0x8 + REG_SIZE * id,	\
> +		.ctl_reg = REG_SIZE * id,		\
> +		.io_reg = 0x4 + REG_SIZE * id,		\
> +		.intr_cfg_reg = 0x8 + REG_SIZE * id,	\
> +		.intr_status_reg = 0xc + REG_SIZE * id,	\
> +		.intr_target_reg = 0x8 + REG_SIZE * id,	\
> +		.tile = _tile,			\
>  		.mux_bit = 2,			\
>  		.pull_bit = 0,			\
>  		.drv_bit = 6,			\
> @@ -82,6 +83,7 @@ enum {
>  		.intr_cfg_reg = 0,			\
>  		.intr_status_reg = 0,			\
>  		.intr_target_reg = 0,			\
> +		.tile = NORTH,				\
>  		.mux_bit = -1,				\
>  		.pull_bit = pull,			\
>  		.drv_bit = drv,				\
> @@ -1397,13 +1399,13 @@ static const struct msm_pingroup sdm660_groups[] = {
>  	PINGROUP(111, SOUTH, _, _, _, _, _, _, _, _, _),
>  	PINGROUP(112, SOUTH, _, _, _, _, _, _, _, _, _),
>  	PINGROUP(113, SOUTH, _, _, _, _, _, _, _, _, _),
> -	SDC_QDSD_PINGROUP(sdc1_clk, 0x99a000, 13, 6),
> -	SDC_QDSD_PINGROUP(sdc1_cmd, 0x99a000, 11, 3),
> -	SDC_QDSD_PINGROUP(sdc1_data, 0x99a000, 9, 0),
> -	SDC_QDSD_PINGROUP(sdc2_clk, 0x99b000, 14, 6),
> -	SDC_QDSD_PINGROUP(sdc2_cmd, 0x99b000, 11, 3),
> -	SDC_QDSD_PINGROUP(sdc2_data, 0x99b000, 9, 0),
> -	SDC_QDSD_PINGROUP(sdc1_rclk, 0x99a000, 15, 0),
> +	SDC_QDSD_PINGROUP(sdc1_clk, 0x9a000, 13, 6),
> +	SDC_QDSD_PINGROUP(sdc1_cmd, 0x9a000, 11, 3),
> +	SDC_QDSD_PINGROUP(sdc1_data, 0x9a000, 9, 0),
> +	SDC_QDSD_PINGROUP(sdc2_clk, 0x9b000, 14, 6),
> +	SDC_QDSD_PINGROUP(sdc2_cmd, 0x9b000, 11, 3),
> +	SDC_QDSD_PINGROUP(sdc2_data, 0x9b000, 9, 0),
> +	SDC_QDSD_PINGROUP(sdc1_rclk, 0x9a000, 15, 0),
>  };
>  
>  static const struct msm_pinctrl_soc_data sdm660_pinctrl = {
> -- 
> 2.19.1
> 
