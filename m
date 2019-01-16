Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11EDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF53420896
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbfAPGhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:37:39 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45127 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388010AbfAPGhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:37:39 -0500
X-UUID: 466dfa097e55467385e91c2588dca683-20190116
X-UUID: 466dfa097e55467385e91c2588dca683-20190116
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1566480008; Wed, 16 Jan 2019 14:37:33 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 14:37:25 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 14:37:25 +0800
Message-ID: <1547620645.5335.3.camel@mtksdaap41>
Subject: Re: [PATCH 3/9] drm/mediatek: using different flags of clk for HDMI
 phy
From:   CK Hu <ck.hu@mediatek.com>
To:     chunhui dai <chunhui.dai@mediatek.com>
CC:     --to=Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <jamesjj.liao@mediatek.com>,
        <jitao.shi@mediatek.com>
Date:   Wed, 16 Jan 2019 14:37:25 +0800
In-Reply-To: <1546585439-30455-4-git-send-email-chunhui.dai@mediatek.com>
References: <1546585439-30455-1-git-send-email-chunhui.dai@mediatek.com>
         <1546585439-30455-4-git-send-email-chunhui.dai@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chunhui:

On Fri, 2019-01-04 at 15:03 +0800, chunhui dai wrote:
> The parent rate of hdmi phy had set by DPI driver.

The difference of DPI driver in MT8173 and MT2701 is

static const struct mtk_dpi_conf mt8173_conf = {
	.cal_factor = mt8173_calculate_factor,
	.reg_h_fre_con = 0xe0,
};

static const struct mtk_dpi_conf mt2701_conf = {
	.cal_factor = mt2701_calculate_factor,
	.reg_h_fre_con = 0xb0,
	.edge_sel_en = true,
};

Which one influence the phy setting?

Regards,
CK

> We should not set or change the parent rate of MT2701 hdmi phy,
> as a result we should remove the flags of "CLK_SET_RATE_PARENT"
> from the clock of MT2701 hdmi phy.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 13 +++++--------
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  1 +
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c |  1 +
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  1 +
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> index 79e737d..c0a9cf5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -109,13 +109,11 @@ static int mtk_hdmi_phy_power_off(struct phy *phy)
>  		return NULL;
>  }
>  
> -static void mtk_hdmi_phy_clk_get_ops(struct mtk_hdmi_phy *hdmi_phy,
> -				     const struct clk_ops **ops)
> +static void mtk_hdmi_phy_clk_get_data(struct mtk_hdmi_phy *hdmi_phy,
> +				     struct clk_init_data *clk_init)
>  {
> -	if (hdmi_phy && hdmi_phy->conf && hdmi_phy->conf->hdmi_phy_clk_ops)
> -		*ops = hdmi_phy->conf->hdmi_phy_clk_ops;
> -	else
> -		dev_err(hdmi_phy->dev, "Failed to get clk ops of phy\n");
> +	clk_init->flags = hdmi_phy->conf->flags;
> +	clk_init->ops = hdmi_phy->conf->hdmi_phy_clk_ops;
>  }
>  
>  static int mtk_hdmi_phy_probe(struct platform_device *pdev)
> @@ -128,7 +126,6 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
>  	struct clk_init_data clk_init = {
>  		.num_parents = 1,
>  		.parent_names = (const char * const *)&ref_clk_name,
> -		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	};
>  
>  	struct phy *phy;
> @@ -166,7 +163,7 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
>  	hdmi_phy->dev = dev;
>  	hdmi_phy->conf =
>  		(struct mtk_hdmi_phy_conf *)of_device_get_match_data(dev);
> -	mtk_hdmi_phy_clk_get_ops(hdmi_phy, &clk_init.ops);
> +	mtk_hdmi_phy_clk_get_data(hdmi_phy, &clk_init);
>  	hdmi_phy->pll_hw.init = &clk_init;
>  	hdmi_phy->pll = devm_clk_register(dev, &hdmi_phy->pll_hw);
>  	if (IS_ERR(hdmi_phy->pll)) {
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> index fdad8b1..446e2ac 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -21,6 +21,7 @@
>  
>  struct mtk_hdmi_phy_conf {
>  	bool tz_disabled;
> +	unsigned long flags;
>  	const struct clk_ops *hdmi_phy_clk_ops;
>  	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
>  	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index 68b124f..a28a32d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -248,6 +248,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
>  
>  struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf = {
>  	.tz_disabled = true,
> +	.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_GATE,
>  	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
>  	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
>  	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> index cb23c1e..63dde42 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> @@ -317,6 +317,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
>  }
>  
>  struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf = {
> +	.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>  	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
>  	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
>  	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,


