Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D693CC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B147F2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfAJBr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:47:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:62127 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726458AbfAJBr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:47:28 -0500
X-UUID: 7d82fd3530094ad19b3ed55a243ce952-20190110
X-UUID: 7d82fd3530094ad19b3ed55a243ce952-20190110
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 407359008; Thu, 10 Jan 2019 09:47:17 +0800
Received: from MTKMBS06N1.mediatek.inc (172.21.101.129) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 09:47:10 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 09:47:09 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 09:47:09 +0800
Message-ID: <1547084829.27684.8.camel@mtksdaap41>
Subject: Re: [PATCH 1/9] drm/mediatek: recalculate hdmi phy clock of MT2701
 by querying hardware
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
Date:   Thu, 10 Jan 2019 09:47:09 +0800
In-Reply-To: <1546585439-30455-2-git-send-email-chunhui.dai@mediatek.com>
References: <1546585439-30455-1-git-send-email-chunhui.dai@mediatek.com>
         <1546585439-30455-2-git-send-email-chunhui.dai@mediatek.com>
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
> Recalculate the rate of this clock, by querying hardware.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        |  7 ++--
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  3 +-
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 49 ++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  8 +++++
>  4 files changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> index 4ef9c57..79e737d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -29,12 +29,11 @@ long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  	return rate;
>  }
>  
> -unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> -				       unsigned long parent_rate)
> +u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset)
>  {
> -	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	void __iomem *reg = hdmi_phy->regs + offset;
>  
> -	return hdmi_phy->pll_rate;
> +	return readl(reg);

reg is used only once, so

return readl(hdmi_phy->regs + offset);

>  }
>  
>  void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> index f39b1fc..fdad8b1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -41,6 +41,7 @@ struct mtk_hdmi_phy {
>  	unsigned int ibias_up;
>  };
>  
> +u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset);
>  void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  			     u32 bits);
>  void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
> @@ -50,8 +51,6 @@ void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
>  struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
>  long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  			     unsigned long *parent_rate);
> -unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> -				       unsigned long parent_rate);
>  
>  extern struct platform_driver mtk_hdmi_phy_driver;
>  extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index fcc42dc..b5ed6b7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -153,6 +153,55 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  			  RG_HDMITX_DRV_IBIAS_MASK);
>  	return 0;
>  }
> +static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> +				       unsigned long parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	unsigned long out_rate, val;
> +
> +	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON6)
> +			& RG_HTPLL_PREDIV_MASK) >> RG_HTPLL_PREDIV;
> +	switch (val) {
> +	case 0x00:
> +		out_rate = parent_rate;
> +		break;
> +	case 0x01:
> +		out_rate = parent_rate / 2;
> +		break;
> +	default:
> +		out_rate = parent_rate / 4;
> +		break;

If the val would not be 3, maybe out_rate could be calculate as

out_rate >>= val;

> +	}
> +
> +	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON6)
> +			& RG_HTPLL_FBKDIV_MASK) >> RG_HTPLL_FBKDIV;
> +	out_rate = out_rate * (val + 1) * 2;

out_rate *= (val + 1) * 2;

> +	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON2)
> +			& RG_HDMITX_TX_POSDIV_MASK) >> RG_HDMITX_TX_POSDIV;
> +	switch (val) {
> +	case 0x00:
> +		out_rate = out_rate;
> +		break;
> +	case 0x01:
> +		out_rate = out_rate / 2;
> +		break;
> +	case 0x02:
> +		out_rate = out_rate / 4;
> +		break;
> +	case 0x03:
> +		out_rate = out_rate / 8;
> +		break;
> +	default:
> +		break;
> +	}

out_rate >>= val;

Regards,
CK

> +
> +	if (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON2) & RG_HDMITX_EN_TX_POSDIV)
> +		out_rate = out_rate / 5;
> +
> +	hdmi_phy->pll_rate = out_rate;
> +
> +	return hdmi_phy->pll_rate;
> +}
>  
>  static const struct clk_ops mtk_hdmi_phy_pll_ops = {
>  	.prepare = mtk_hdmi_pll_prepare,
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> index ed5916b..cb23c1e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> @@ -285,6 +285,14 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return 0;
>  }
>  
> +static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> +				       unsigned long parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +
> +	return hdmi_phy->pll_rate;
> +}
> +
>  static const struct clk_ops mtk_hdmi_phy_pll_ops = {
>  	.prepare = mtk_hdmi_pll_prepare,
>  	.unprepare = mtk_hdmi_pll_unprepare,


