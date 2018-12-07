Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88674C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A03A20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHCOd3Uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A03A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLGGAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:00:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46033 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeLGGAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:00:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so1388699pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gOEz8za+f1Qdu5TNNNABj/d4XW2UNnVBLITWuEEwuXM=;
        b=HHCOd3Uv4r/l6aRUYxCrcbHsgYYdq1pVisxZQp2RK/ysyaVNNsK+JiVG0T2GOl0cNM
         7wJEQjOqQ36sXkU6g0shjzrJ9bu6bvsGKWXHNGZIjJS/Ewcuik32B4P99RuhzCmARQLQ
         559z6g1gP9MgqE3HDBG3kpOQjTcTjOiTEyOSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gOEz8za+f1Qdu5TNNNABj/d4XW2UNnVBLITWuEEwuXM=;
        b=rhKrMA4MnDrrk927mQXOJtLPnvaqM9+HjJ1XpoLKyDd1cjO8CptqsregGP+Wg0Ahbt
         Hffw8gD4IG7XY5nkrM0q69dmgYVbvC6JvZlU0fpzcC55bxBFQBSBH2a72IjP+xrwljoM
         cP2v5drMXzCO95sGUVOQIIbjnQ2GzE58F7x0WXh/eE5tdsPhQ3/Zm9lnMNjsL9rPn6CP
         DE3u+0C5cox5kEnHmKuNbSK+CKQS29vn6bGW/FvLtYGlWjMNF7DC7CjnpOirog+16zND
         1sC7AYx38QVny6L3C3xbYzYKgOYROGatk4LMenT1ZiEeH7Subsvs+kQ/knyAfaCwj9fQ
         k4sg==
X-Gm-Message-State: AA+aEWZfcuce0uTQK9WnfNI+mPNyazLTBm9RchWbu6+l/SWAiIRcvvol
        Fn6OzHnmaTUHczBEG31umEHdMA==
X-Google-Smtp-Source: AFSGD/UuN72icqXtS/4YPY0bX/uIN7J0K6D1+O0kwwXpe9Kkc5zpADXC+XjnMC5eouLWyfRt5z/KLQ==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr762499pgd.97.1544162433668;
        Thu, 06 Dec 2018 22:00:33 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b9sm2820076pfi.118.2018.12.06.22.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 22:00:32 -0800 (PST)
Date:   Thu, 6 Dec 2018 22:00:30 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Fix gpll0_out_main parent
Message-ID: <20181207060030.GI12886@minitux>
References: <20181207053749.24872-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207053749.24872-1-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Dec 21:37 PST 2018, Vinod Koul wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> gpll0_out_main parent is cxo so fix it.
> 
> Fixes: 652f1813c113 ("clk: qcom: gcc: Add global clock controller driver for QCS404")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/gcc-qcs404.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> index ef1b267cb058..64da032bb9ed 100644
> --- a/drivers/clk/qcom/gcc-qcs404.c
> +++ b/drivers/clk/qcom/gcc-qcs404.c
> @@ -297,7 +297,7 @@ static struct clk_alpha_pll gpll0_out_main = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gpll0_out_main",
>  			.parent_names = (const char *[])
> -					{ "gpll0_sleep_clk_src" },
> +					{ "cxo" },
>  			.num_parents = 1,
>  			.ops = &clk_alpha_pll_ops,
>  		},
> -- 
> 2.19.2
> 
