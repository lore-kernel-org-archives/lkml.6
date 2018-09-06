Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F02C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643AF2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643AF2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeIFGo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:44:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27902 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725850AbeIFGo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:44:56 -0400
X-UUID: d56ad0fa1cb94cf39a93090d76cad5d3-20180906
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 541664349; Thu, 06 Sep 2018 10:11:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 6 Sep 2018 10:11:47 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 6 Sep 2018 10:11:47 +0800
Message-ID: <1536199907.4618.17.camel@mtksdaap41>
Subject: Re: [PATCH v2 04/13] drm/mediatek: add clock factor for different IC
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>
Date:   Thu, 6 Sep 2018 10:11:47 +0800
In-Reply-To: <20180905083146.14727-5-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
         <20180905083146.14727-5-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

One inline comment.

On Wed, 2018-09-05 at 16:31 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> different IC has different clock designed in HDMI, the factor for
> calculate clock should be different. Usinng the data in of_node
> to find this factor.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index df27107b1f0b..3758cfeb586b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -119,6 +119,7 @@ struct mtk_dpi_yc_limit {
>  };
>  
>  struct mtk_dpi_conf {
> +	unsigned int (*cal_factor)(int clock);
>  	const u32 reg_h_fre_con;
>  	bool edge_sel_en;
>  };
> @@ -458,16 +459,12 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	unsigned long pll_rate;
>  	unsigned int factor;
>  
> +	if (!dpi) {
> +		dev_err(dpi->dev, "invalid argument\n");
> +		return -EINVAL;
> +	}

I think this should not be in this patch, move to an independent patch.

Regards,
CK

>  	/* let pll_rate can fix the valid range of tvdpll (1G~2GHz) */
> -
> -	if (mode->clock <= 27000)
> -		factor = 3 << 4;
> -	else if (mode->clock <= 84000)
> -		factor = 3 << 3;
> -	else if (mode->clock <= 167000)
> -		factor = 3 << 2;
> -	else
> -		factor = 3 << 1;
> +	factor = dpi->conf->cal_factor(mode->clock);
>  	drm_display_mode_to_videomode(mode, &vm);
>  	pll_rate = vm.pixelclock * factor;
>  
> @@ -681,7 +678,20 @@ static const struct component_ops mtk_dpi_component_ops = {
>  	.unbind = mtk_dpi_unbind,
>  };
>  
> +static unsigned int mt8173_calculate_factor(int clock)
> +{
> +	if (clock <= 27000)
> +		return 3 << 4;
> +	else if (clock <= 84000)
> +		return 3 << 3;
> +	else if (clock <= 167000)
> +		return 3 << 2;
> +	else
> +		return 3 << 1;
> +}
> +
>  static const struct mtk_dpi_conf mt8173_conf = {
> +	.cal_factor = mt8173_calculate_factor,
>  	.reg_h_fre_con = 0xe0,
>  };
>  


