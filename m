Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1B1C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C42820851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJt291Tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C42820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeLLWHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:07:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40200 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeLLWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:07:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so14772150lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zsIWNaEiH2SIBQCe9cb4zFF9OLssza3sDlBi2ZTnrPQ=;
        b=PJt291TrL7Ph8fz9bqURDeW1ohH2/eLQj/iL5OT4mxycZn8kXucIcR8rahZygKuDhj
         Chfd0DwLcPP4DEsvYbPwYHdkcfr9VxL9KXawVn33EEGQsYn5GLREmPG1Y41zVx8NonwY
         3vCeiTYAxbBRkd0wBhnC7ACe81cg4tdzTTvT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zsIWNaEiH2SIBQCe9cb4zFF9OLssza3sDlBi2ZTnrPQ=;
        b=Cwgd44ZDOv7xMe2bvvrcirSOo6yeIfiwgQ+L4IeBOwd4lRt8Ka8MMEGAZ/kUit9kQe
         viQ3G/Pc7tjB6avC5z5n42xtXWkXYGQzfA8/53ZSwrO5sLKME5TNog1Mb7rI+m7tutqd
         8EDGB/M3aWAuSmFEpJ+Zb1pBBeCQq51JOOXCrkWABnGOwBEiUfkCnMmUZOsLl5Hr5m8J
         M4NVPc2aIS6GvJvEBPNamhAlH93cimFBXXamXwPCyw6Rke85N2hjL0WuV0/f9BibA6Om
         0lxU1nAIEh3toSY1h1U/BWsYuk8PO66D20GTo6nkaPrDUaDPJKx8ouD0aMRhdCFx+Pql
         PmxQ==
X-Gm-Message-State: AA+aEWYm4hS472KBmS5pMaIWP1AbRuieggZOie+CTR80S9pQcpAaGpre
        VSSwuM/LEeMN/oP2tOl6CkNuWQ==
X-Google-Smtp-Source: AFSGD/VeqTWNxniKvU7kr1z84yLRjro2gawy1eaf7qB2VN3LGNlLeufZTeQB+No/FaiSQUNVpn46Xg==
X-Received: by 2002:a19:c203:: with SMTP id l3mr1337714lfc.113.1544652440420;
        Wed, 12 Dec 2018 14:07:20 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id 12-v6sm537ljs.29.2018.12.12.14.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:07:19 -0800 (PST)
Date:   Wed, 12 Dec 2018 23:07:17 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/8] drm/msm/dsi: 28nm PHY: Get ref clock from the DT
Message-ID: <20181212220717.GA16710@centauri.lan>
References: <20181204224234.62619-1-mka@chromium.org>
 <20181204224234.62619-4-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204224234.62619-4-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:42:29PM -0800, Matthias Kaehlcke wrote:
> Get the ref clock of the PHY from the device tree instead of
> hardcoding its name and rate.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v4:
> - always use parent rate in dsi_pll_28nm_clk_set_rate() and
>    dsi_pll_28nm_clk_recalc_rate()
> - pass name of VCO ref clock to pll_28nm_register() instead of
>   storing it in a struct field
> - updated commit message
> 
> Changes in v3:
> - use default name and rate if the ref clock is not specified
>   in the DT
> - store vco_ref_clk_name instead of vco_ref_clk
> - dsi_pll_28nm_clk_set_rate: changed data type of ref_clk_rate to
>   unsigned long
> - fixed check for EPROBE_DEFER
> - renamed VCO_REF_CLK_RATE to VCO_REF_CLK_DEFAULT_RATE
> 
> Changes in v2:
> - patch added to the series
> ---
>  drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c | 36 +++++++++++++++-------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
> index 26e3a01a99c2b..7777340b03e8d 100644
> --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
> +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
> @@ -40,7 +40,6 @@
>  
>  #define NUM_PROVIDED_CLKS		2
>  
> -#define VCO_REF_CLK_RATE		19200000
>  #define VCO_MIN_RATE			350000000
>  #define VCO_MAX_RATE			750000000
>  
> @@ -166,17 +165,17 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>  	pll_write(base + REG_DSI_28nm_PHY_PLL_LPFC1_CFG, 0x70);
>  	pll_write(base + REG_DSI_28nm_PHY_PLL_LPFC2_CFG, 0x15);
>  
> -	rem = rate % VCO_REF_CLK_RATE;
> +	rem = rate % parent_rate;
>  	if (rem) {
>  		refclk_cfg = DSI_28nm_PHY_PLL_REFCLK_CFG_DBLR;
>  		frac_n_mode = 1;
> -		div_fbx1000 = rate / (VCO_REF_CLK_RATE / 500);
> -		gen_vco_clk = div_fbx1000 * (VCO_REF_CLK_RATE / 500);
> +		div_fbx1000 = rate / (parent_rate / 500);
> +		gen_vco_clk = div_fbx1000 * (parent_rate / 500);
>  	} else {
>  		refclk_cfg = 0x0;
>  		frac_n_mode = 0;
> -		div_fbx1000 = rate / (VCO_REF_CLK_RATE / 1000);
> -		gen_vco_clk = div_fbx1000 * (VCO_REF_CLK_RATE / 1000);
> +		div_fbx1000 = rate / (parent_rate / 1000);
> +		gen_vco_clk = div_fbx1000 * (parent_rate / 1000);
>  	}
>  
>  	DBG("refclk_cfg = %d", refclk_cfg);
> @@ -265,7 +264,7 @@ static unsigned long dsi_pll_28nm_clk_recalc_rate(struct clk_hw *hw,
>  	void __iomem *base = pll_28nm->mmio;
>  	u32 sdm0, doubler, sdm_byp_div;
>  	u32 sdm_dc_off, sdm_freq_seed, sdm2, sdm3;
> -	u32 ref_clk = VCO_REF_CLK_RATE;
> +	u32 ref_clk = parent_rate;
>  	unsigned long vco_rate;
>  
>  	VERB("parent_rate=%lu", parent_rate);
> @@ -273,7 +272,7 @@ static unsigned long dsi_pll_28nm_clk_recalc_rate(struct clk_hw *hw,
>  	/* Check to see if the ref clk doubler is enabled */
>  	doubler = pll_read(base + REG_DSI_28nm_PHY_PLL_REFCLK_CFG) &
>  			DSI_28nm_PHY_PLL_REFCLK_CFG_DBLR;
> -	ref_clk += (doubler * VCO_REF_CLK_RATE);
> +	ref_clk += (doubler * ref_clk);
>  
>  	/* see if it is integer mode or sdm mode */
>  	sdm0 = pll_read(base + REG_DSI_28nm_PHY_PLL_SDM_CFG0);
> @@ -514,11 +513,12 @@ static void dsi_pll_28nm_destroy(struct msm_dsi_pll *pll)
>  	pll_28nm->clk_data.clk_num = 0;
>  }
>  
> -static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm)
> +static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm,
> +			     const char *ref_clk_name)
>  {
>  	char clk_name[32], parent1[32], parent2[32], vco_name[32];
>  	struct clk_init_data vco_init = {
> -		.parent_names = (const char *[]){ "xo" },
> +		.parent_names = &ref_clk_name,
>  		.num_parents = 1,
>  		.name = vco_name,
>  		.flags = CLK_IGNORE_UNUSED,
> @@ -593,6 +593,8 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_init(struct platform_device *pdev,
>  {
>  	struct dsi_pll_28nm *pll_28nm;
>  	struct msm_dsi_pll *pll;
> +	struct clk *vco_ref_clk;
> +	const char *vco_ref_clk_name;
>  	int ret;
>  
>  	if (!pdev)
> @@ -605,6 +607,18 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_init(struct platform_device *pdev,
>  	pll_28nm->pdev = pdev;
>  	pll_28nm->id = id;
>  
> +	vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
> +	if (!IS_ERR(vco_ref_clk)) {
> +		vco_ref_clk_name = __clk_get_name(vco_ref_clk);
> +	} else {
> +		ret = PTR_ERR(vco_ref_clk);
> +		if (ret == -EPROBE_DEFER)
> +			ERR_PTR(ret);

It looks like you are missing the return keyword here.

> +
> +		dev_warn(&pdev->dev, "'ref' clock is not specified, using default name\n");
> +		vco_ref_clk_name = "xo";
> +	}
> +
>  	pll_28nm->mmio = msm_ioremap(pdev, "dsi_pll", "DSI_PLL");
>  	if (IS_ERR_OR_NULL(pll_28nm->mmio)) {
>  		dev_err(&pdev->dev, "%s: failed to map pll base\n", __func__);
> @@ -637,7 +651,7 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_init(struct platform_device *pdev,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	ret = pll_28nm_register(pll_28nm);
> +	ret = pll_28nm_register(pll_28nm, vco_ref_clk_name);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register PLL: %d\n", ret);
>  		return ERR_PTR(ret);
> -- 
> 2.20.0.rc1.387.gf8505762e3-goog
> 
