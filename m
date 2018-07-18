Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A1CECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E68B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E68B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbeGRDpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:45:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37402 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731225AbeGRDpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:45:19 -0400
X-UUID: 9425e4b59815430d9393495179132829-20180718
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2037952199; Wed, 18 Jul 2018 11:04:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 18 Jul 2018 11:04:17 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 18 Jul 2018 11:04:17 +0800
Message-ID: <1531883057.8953.87.camel@mtkswgap22>
Subject: Re: [resend PATCH v4 5/5] drm: mediatek: Omit warning on probe
 defers
From:   Sean Wang <sean.wang@mediatek.com>
To:     <matthias.bgg@kernel.org>
CC:     <ulrich.hecht+renesas@gmail.com>,
        <laurent.pinchart@ideasonboard.com>, <ck.hu@mediatek.com>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <lee.jones@linaro.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <mchehab@kernel.org>, <rdunlap@infradead.org>,
        <pi-cheng.chen@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux@armlinux.org.uk>, <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <mbrugger@suse.com>
Date:   Wed, 18 Jul 2018 11:04:17 +0800
In-Reply-To: <20180717220328.792-6-matthias.bgg@kernel.org>
References: <20180717220328.792-1-matthias.bgg@kernel.org>
         <20180717220328.792-6-matthias.bgg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 00:03 +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> It can happen that the clock drivers wasn't probed before the
> ddp driver gets invoked. The driver used to omit a warning
> that the driver failed to get the clocks. Omit this error on
> the defered probe path.
> 

so if we list drm device as a child device of mmsys we don't need the
patch, and that make more sense.

> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Acked-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index bafc5c77c4fb..6b399348a2dc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -374,7 +374,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
>  
>  	ddp->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(ddp->clk)) {
> -		dev_err(dev, "Failed to get clock\n");
> +		if (PTR_ERR(ddp->clk) != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get clock\n");
>  		return PTR_ERR(ddp->clk);
>  	}
>  


