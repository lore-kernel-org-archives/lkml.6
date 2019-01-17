Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DC4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0131720856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNL/kO9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfAQGd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:33:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35300 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfAQGdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:33:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so3993201pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aqC+vB4fSjRN90IibQ7rlURw1TMhvABYquzwyDXgypA=;
        b=NNL/kO9CdzEPti7SThDJKLv7Yq+SCVjXCEv003EZOStG3hNTBpZfyr6YP2iPuGFqD/
         MOLr/6bfHbUk+HqbJjIer6QZDxP24yIvm4NpTf1EcEBIYGpOX2Mr2QPcU/pAWw0rRUpB
         B8K5bFtba6YWPktyH7QWTfPTRL38b8zQRjZ2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aqC+vB4fSjRN90IibQ7rlURw1TMhvABYquzwyDXgypA=;
        b=lab7VYtK66igIWmzzuAxySEIP4vCey0NIB4gWC8ChVghpX9dsAholPAeE5ryADzgtm
         /iyHd/YxA4Dtg2xhX5B5dQFC6GsRONvZ7JlTnUSambhVQEh3u9YH9uu6NsfPea1OcthY
         jiqz7Id8kSexIVvgmOKk6ktSNHoQvdRNt/aWwz6/0gQpjx8xqtbHLRfuZ0cKasUsSmll
         gykK+E51Z9ihsTr+GO8ppvjYeCCue1l93rHRH7lypDJqQ8vVZXbL8/s/ehKEVXF5zceN
         l716yLRnFDXuS1Ke/4FNnzU/AoKJ43B1Aro8xxDBzzZj3Qyg72C+Kfih5DxOogr/lEBo
         4+fg==
X-Gm-Message-State: AJcUukdTcdk9VFESx0HRv32x6LtamrS8SHw4pMzd2NgnbtiNdXyvauHE
        tEmKsx+wE+BnDIG0kxlg52jzew==
X-Google-Smtp-Source: ALg8bN6ggp1MCPExQs+vQQxL2bvJB70+5pOHGn4EVdYjBbSFbcYTmWXyX/5SrPW/Mj7UW3le2dfSgQ==
X-Received: by 2002:a62:fb07:: with SMTP id x7mr13619330pfm.71.1547706833568;
        Wed, 16 Jan 2019 22:33:53 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b4sm793210pgq.65.2019.01.16.22.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 22:33:52 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:33:12 -0800
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
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Message-ID: <20190117063312.GE25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:

> When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
> to keep the software model of the clock in line with reality, the
> framework transverses the clock tree and disables those clocks that
> were enabled by the firmware but have not been enabled by any device
> driver.
> 
> If CPUFREQ is enabled, early during the system boot, it might attempt
> to change the CPU frequency ("set_rate"). If the HFPLL is selected as
> a provider, it will then change the rate for this clock.
> 
> As boot continues, clk_disable_unused_subtree will run. Since it wont
> find a valid counter (enable_count) for a clock that is actually
> enabled it will attempt to disable it which will cause the CPU to
> stop. Notice that in this driver, calls to check whether the clock is
> enabled are routed via the is_enabled callback which queries the
> hardware.
> 

With the CPUFREQ referencing the CPU clock driver, that has decided to
run off this clock, why is it not refcounted?

Regards,
Bjorn

> The following commit, rather than marking the clock critical and
> forcing the clock to be always enabled, addresses the above scenario
> making sure the clock is not disabled but it continues to rely on the
> firmware to enable the clock.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/clk/qcom/hfpll.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
> index 0ffed0d..9d92f5d 100644
> --- a/drivers/clk/qcom/hfpll.c
> +++ b/drivers/clk/qcom/hfpll.c
> @@ -58,6 +58,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>  		.parent_names = (const char *[]){ "xo" },
>  		.num_parents = 1,
>  		.ops = &clk_ops_hfpll,
> +		.flags = CLK_IGNORE_UNUSED,
>  	};
>  
>  	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
> -- 
> 2.7.4
> 
