Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6569BC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1C92085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LjKpRfuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1C92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbeKFK1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:27:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40292 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbeKFK1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:27:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id x2-v6so1191077pfm.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 17:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g+snwBo8ag6BDr74ywAd3k5kRlUVBbIn0FaoX6zyQIM=;
        b=LjKpRfuWxoDRTVy65Jj8FZLGPzdX1tY5vOyiD76Rd/4FDwFDhg29MBA1jGNnRx8JLj
         urNjr9jkLM+InIC9vFQXnd3VDNVdX+0711bIWkqbBodOWEI8hwtsG8TRKORIxwDJRwXK
         9ofOuq+ZVlV3f9FrROc68oQAcs/+xbrtumfdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g+snwBo8ag6BDr74ywAd3k5kRlUVBbIn0FaoX6zyQIM=;
        b=KZW5Igntk6pXe/YXTqvVtMQIZV60WyjONu7nASSotVJbk/ZDzfn9YP719IEk5jlAer
         Gy5D9zcGES+STDz4MzoDtsJC3NmghDQzNa7sPDkgWS8UrOcixnFZeHul+0EROkMXtcS6
         lob2NlK/5uNKvE5f/InL2Fkj7rw7DLpgFneLBLmYHkpjJtqCJgx7p0I/M22VKKNCtG97
         fF4hWwZ9VKUDQvIHbQkHa/K2B60F3EL0HVHg4en3MTWmChb5KKSE71gkKWq96MA4bEQh
         +f18lA4ydkHb7S2zwWkK/mEezwNxzpglEt3/aVOLf4+lBRNy/DWviQ8CXsTRZqf/vWN0
         NpJg==
X-Gm-Message-State: AGRZ1gKee4Sp45hcz2oEMMlKMN40K+zUEJucHwSVPTUHu9LfApwFw/b9
        GBZgSzM+PzsEb/elBbav7B+CIw==
X-Google-Smtp-Source: AJdET5eab04e60Y7H4S/MGBtBSZ7d2r83CgytSWfNz6auUguaNbwLujZhUQG/51x/lKd08XTMXL+6Q==
X-Received: by 2002:a63:1765:: with SMTP id 37-v6mr22253058pgx.131.1541466310312;
        Mon, 05 Nov 2018 17:05:10 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d24-v6sm31199826pfe.40.2018.11.05.17.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 17:05:09 -0800 (PST)
Date:   Mon, 5 Nov 2018 17:05:07 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 2/2] clk: qcom: Support 'protected-clocks' property
Message-ID: <20181106010507.GY2523@minitux>
References: <20181105194011.43770-1-swboyd@chromium.org>
 <20181105194011.43770-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105194011.43770-3-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 11:40 PST 2018, Stephen Boyd wrote:

> Certain firmware configurations "protect" clks and cause the entire
> system to reboot when a non-secure OS such as Linux tries to read or
> write protected clk registers. But other firmware configurations allow
> reading or writing the same registers, and they may actually require
> that the OS use the otherwise locked down clks. Support the
> 'protected-clocks' property by never registering these protected clks
> with the common clk framework. This way, when firmware is protecting
> these clks we won't have the chance to ever read or write these
> registers and take down the entire system.
> 
> Cc: Taniya Das <tdas@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/common.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index db9b2471ac40..0a48ed56833b 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -191,6 +191,22 @@ int qcom_cc_register_sleep_clk(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(qcom_cc_register_sleep_clk);
>  
> +/* Drop 'protected-clocks' from the list of clocks to register */
> +static void qcom_cc_drop_protected(struct device *dev, struct qcom_cc *cc)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct property *prop;
> +	const __be32 *p;
> +	u32 i;
> +
> +	of_property_for_each_u32(np, "protected-clocks", prop, p, i) {
> +		if (i >= cc->num_rclks)
> +			continue;
> +
> +		cc->rclks[i] = NULL;
> +	}
> +}
> +
>  static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
>  					 void *data)
>  {
> @@ -251,6 +267,8 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>  	cc->rclks = rclks;
>  	cc->num_rclks = num_clks;
>  
> +	qcom_cc_drop_protected(dev, cc);
> +
>  	for (i = 0; i < num_clks; i++) {
>  		if (!rclks[i])
>  			continue;
> -- 
> Sent by a computer through tubes
> 
