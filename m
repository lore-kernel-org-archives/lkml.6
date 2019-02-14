Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9CAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602F0218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="SvbiZZcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440009AbfBNUlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:41:53 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45247 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439997AbfBNUlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:41:52 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so8439379qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bfhMe4+CXmiRvcRAWCgmu+lJrINccOKJUvPTFhOLBBs=;
        b=SvbiZZcHAyPGRvhJFgSrREz6TnE+MdP0JuuYGnbGh4+zvhV0RjA7cTtkZ20cYZ82JE
         0VEYrcdvf7yMRaBAvZ+SAXzPt5VxD7cdla0msyXIPFO7pLosJM5MWMeO6MSBwcLS0+s9
         XkorF9y+L7Hx4OBesiPWx1XqaYcxDcE99+MF5nyzGjda+D3tNkZt91zeeOwF9Dbl573e
         B6qqosK3jjCqgYYRlfv17tPbJsYde7HxZSBStrND6l/cHDDimLkhodN+Bblz3gof2ffI
         UvSRYJP6GG7NhFps+mwSKQH8qgEHqnNEC1vUFONx4Xlzl/C8cQiMlYk2ujtHndb2d34m
         89Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bfhMe4+CXmiRvcRAWCgmu+lJrINccOKJUvPTFhOLBBs=;
        b=X6W1klGPQ6vjEhqKMv1ShyYQOjU9bc8xxAjP6UvK4seauR3XOp2DMGqB1pgZ2VxcLS
         pTgd9n7yeYcUsIXwDAKG4r7fYydxEwh2gd7ALIS+f7X142m7zXrvV86TOhIf+A9F6aiB
         bhhwQXy21F8eHUsSbezdPNk4g+gnK4fEJdzkCXAZu2SJ/UnQse35g6U5OiGTmQe1S5o3
         j3jlcSMeNKd1ebKkPKXaWK35fPxIHhkZ5ACJ1k16OnOpZhMXSUxJV7iaiPzo8G5dOpSf
         NOOgoguj8EWM3yb6v9M43dEE+XgxLx1+XfbH6ioVAnbGphW9JwzdO6dimqoDddv32Vrt
         3xBw==
X-Gm-Message-State: AHQUAuYo2P04EnnGlmoNocSk9cgDD+PWEuRFss5xEHEFKmQjtn0iXk/+
        z5tHubYBJB+g9TWab8Ff/HAMUw==
X-Google-Smtp-Source: AHgI3Iakb2Tf6qSZJRnBXTFOEa1K25tnKUD4oeuL9riHvph1ITK9hHdsJars1BTxxfnGkCfryhi1Og==
X-Received: by 2002:ac8:22d4:: with SMTP id g20mr4779016qta.50.1550176911125;
        Thu, 14 Feb 2019 12:41:51 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id t123sm1825880qkd.95.2019.02.14.12.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:41:50 -0800 (PST)
Date:   Thu, 14 Feb 2019 15:41:49 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [PATCH] drm/mediatek: add mt8183 dpi support
Message-ID: <20190214204149.GO114153@art_vandelay>
References: <20190211045059.11821-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211045059.11821-1-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:50:59PM +0800, Jitao Shi wrote:
> MT8183 sample on rising and falling edge. It can reduce half data io.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 62a9d47df948..610c23334047 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -117,6 +117,7 @@ struct mtk_dpi_conf {
>  	unsigned int (*cal_factor)(int clock);
>  	u32 reg_h_fre_con;
>  	bool edge_sel_en;
> +	bool dual_edge;
>  };
>  
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> @@ -353,6 +354,13 @@ static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
>  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
>  }
>  
> +static void mtk_dpi_enable_dual_edge(struct mtk_dpi *dpi)
> +{
> +	mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE,
> +		     DDR_EN | DDR_4PHASE);
> +	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, EDGE_SEL, EDGE_SEL);
> +}
> +
>  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
>  					enum mtk_dpi_out_color_format format)
>  {
> @@ -509,6 +517,8 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	mtk_dpi_config_color_format(dpi, dpi->color_format);
>  	mtk_dpi_config_2n_h_fre(dpi);
>  	mtk_dpi_config_disable_edge(dpi);
> +	if (dpi->conf->dual_edge)
> +		mtk_dpi_enable_dual_edge(dpi);
>  	mtk_dpi_sw_reset(dpi, false);
>  
>  	return 0;
> @@ -671,6 +681,16 @@ static unsigned int mt2701_calculate_factor(int clock)
>  		return 2;
>  }
>  
> +static unsigned int mt8183_calculate_factor(int clock)
> +{
> +	if (clock <= 27000)
> +		return 8;
> +	else if (clock <= 167000)
> +		return 4;
> +	else
> +		return 2;
> +}
> +
>  static const struct mtk_dpi_conf mt8173_conf = {
>  	.cal_factor = mt8173_calculate_factor,
>  	.reg_h_fre_con = 0xe0,
> @@ -682,6 +702,12 @@ static const struct mtk_dpi_conf mt2701_conf = {
>  	.edge_sel_en = true,
>  };
>  
> +static const struct mtk_dpi_conf mt8183_conf = {
> +	.cal_factor = mt8183_calculate_factor,
> +	.reg_h_fre_con = 0xe0,
> +	.dual_edge = true,
> +};
> +
>  static int mtk_dpi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -777,6 +803,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
>  	{ .compatible = "mediatek,mt8173-dpi",
>  	  .data = &mt8173_conf,
>  	},
> +	{ .compatible = "mediatek,mt8183-dpi",

Do you need to add this compatible value to the dt binding? If you can do as CK
suggested, maybe you don't need this at all (and mt8183 can use the mt8173
compatible string in the dt).

Sean

> +	  .data = &mt8183_conf,
> +	},
>  	{ },
>  };
>  
> -- 
> 2.12.5
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
