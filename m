Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65028C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD2B206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD2B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIEOAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:00:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3178 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbeIEOAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:00:07 -0400
X-UUID: 0550cc6cfa364de2a2f43299af822a85-20180905
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1605574464; Wed, 05 Sep 2018 17:30:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 5 Sep 2018 17:30:35 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 5 Sep 2018 17:30:35 +0800
Message-ID: <1536139835.11913.3.camel@mtksdaap41>
Subject: Re: [PATCH v2 01/13] drm/mediatek: add refcount for DPI power on/off
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
Date:   Wed, 5 Sep 2018 17:30:35 +0800
In-Reply-To: <20180905083146.14727-2-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
         <20180905083146.14727-2-bibby.hsieh@mediatek.com>
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

This looks reasonable, but why MT8173 doesn't need this patch? So
describe more about why MT7623 need this patch. If this is caused by
latest DRM core flow change, I think we should treat this patch
independent with MT7623.

Regards,
CK

On Wed, 2018-09-05 at 16:31 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> add refcount for DPI power on/off to protect the flow
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 6c0ea39d5739..d9373e67d328 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -77,6 +77,7 @@ struct mtk_dpi {
>  	enum mtk_dpi_out_bit_num bit_num;
>  	enum mtk_dpi_out_channel_swap channel_swap;
>  	bool power_sta;
> +	int refcount;
>  	u8 power_ctl;
>  };
>  
> @@ -369,6 +370,12 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
>  
>  static void mtk_dpi_power_off(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
>  {
> +	if (WARN_ON(dpi->refcount == 0))
> +		return;
> +
> +	if (--dpi->refcount != 0)
> +		return;
> +
>  	dpi->power_ctl &= ~pctl;
>  
>  	if ((dpi->power_ctl & DPI_POWER_START) ||
> @@ -388,14 +395,17 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
>  {
>  	int ret;
>  
> +	if (++dpi->refcount != 1)
> +		return 0;
> +
>  	dpi->power_ctl |= pctl;
>  
>  	if (!(dpi->power_ctl & DPI_POWER_START) &&
>  	    !(dpi->power_ctl & DPI_POWER_ENABLE))
> -		return 0;
> +		goto err_refcount;
>  
>  	if (dpi->power_sta)
> -		return 0;
> +		goto err_refcount;
>  
>  	ret = clk_prepare_enable(dpi->engine_clk);
>  	if (ret) {
> @@ -417,6 +427,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
>  	clk_disable_unprepare(dpi->engine_clk);
>  err_eng:
>  	dpi->power_ctl &= ~pctl;
> +err_refcount:
> +	dpi->refcount--;
>  	return ret;
>  }
>  


