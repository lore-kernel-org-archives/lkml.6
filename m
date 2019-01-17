Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1920C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD8820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFJTc2ZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfAQG2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:28:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33763 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfAQG2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:28:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so3986477pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=it49WLHEA1GzTHs3Z8BztlHSPMPMqqjJh3zyQ6F6IVY=;
        b=OFJTc2ZW2OXMpVxSecxBuoozg0/vHavAPyNs43TQ3G6tx+43WIYV12OlMXK4Ha2gU/
         mPE8CkGI1nuybffQIAoS8HkNhncXmbRotyaTZwkkd6ZmhYk/kU/O3uZBDUeCow+NCaVz
         w8Iz0l5jQ+/GE3BYf26fQpt5MbYq+6i+Kl3Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=it49WLHEA1GzTHs3Z8BztlHSPMPMqqjJh3zyQ6F6IVY=;
        b=D+VrxrAn6JZN4IUyl4sAnSIomRDUhCYhAe9pME9a3c24c8/AsXsDcLCcfB2mMp6/Xf
         xbOq3KrLsiWaIyeiaafxA5EMdSpj3yTRkNkTjyPrLWHRaTQvdokw6j5pXtxIWJtl+6SD
         QQ5sOSREf/0xw5ByLwHA+Kvw4GuxFjTZCH9eFmf4uSa50UKk01YGJjn1HHbXIlh60EgJ
         SuOnsLl4NnHx/5g8k/Ugml7dJnACGjL3VfQ1d/xkbpLZyLWQ+uwrLu46uTXUmI6HtJPP
         7qRi/5lunXhh/1gP47pleplYKlz/pe831YM8Q0ju9ghmhqJwNjkx2RPRfzOQXwvzOveY
         mdUw==
X-Gm-Message-State: AJcUukdm7IudZgnysYEF2iASRq5mm/cFOussP199V8Ju+Nvv0Om3EeU2
        mqd4Wzo/G+A8+TrnG44bNyuRKA==
X-Google-Smtp-Source: ALg8bN4p+rF0kFpefxR+B19hWoQ347mPz/zaLWDA3qpjIA7wixr0D4u9JTrmkP2LAwU9dL/0zdEABw==
X-Received: by 2002:a63:5c22:: with SMTP id q34mr12269636pgb.417.1547706531679;
        Wed, 16 Jan 2019 22:28:51 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b4sm772074pgq.65.2019.01.16.22.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 22:28:51 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:28:10 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        vkoul@kernel.org, niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 07/13] clk: qcom: hfpll: register as clock provider
Message-ID: <20190117062810.GD25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-8-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545039990-19984-8-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> Make the output of the high frequency pll a clock provider.
> On the QCS404 this PLL controls cpu frequency scaling.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/clk/qcom/hfpll.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
> index 87b7f46..0ffed0d 100644
> --- a/drivers/clk/qcom/hfpll.c
> +++ b/drivers/clk/qcom/hfpll.c
> @@ -53,6 +53,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>  	struct regmap *regmap;
>  	struct clk_hfpll *h;
>  	struct clk *pclk;
> +	int ret;
>  	struct clk_init_data init = {
>  		.parent_names = (const char *[]){ "xo" },
>  		.num_parents = 1,
> @@ -87,7 +88,14 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>  	h->clkr.hw.init = &init;
>  	spin_lock_init(&h->lock);
>  
> -	return devm_clk_register_regmap(&pdev->dev, &h->clkr);
> +	ret = devm_clk_register_regmap(dev, &h->clkr);
> +	if (ret) {
> +		dev_err(dev, "failed to register regmap clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +					   &h->clkr.hw);
>  }
>  
>  static struct platform_driver qcom_hfpll_driver = {
> -- 
> 2.7.4
> 
