Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0156DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9729220659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9729220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeIFKKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:10:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49674 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725880AbeIFKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:10:21 -0400
X-UUID: f80560a10989408f826dc4cac2addfb7-20180906
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1366531604; Thu, 06 Sep 2018 13:36:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 6 Sep 2018 13:36:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 6 Sep 2018 13:36:22 +0800
Message-ID: <1536212182.4618.36.camel@mtksdaap41>
Subject: Re: [PATCH v2 08/13] drm/mediatek: register hdmi codec more earlier
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
Date:   Thu, 6 Sep 2018 13:36:22 +0800
In-Reply-To: <20180905083146.14727-9-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
         <20180905083146.14727-9-bibby.hsieh@mediatek.com>
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

On Wed, 2018-09-05 at 16:31 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> sometimes hdmi reprobe due to encoder probe late,
> but audio dai probe earlier than hdmi. it would make
> audio dai cannot find the hdmi codec. we need to
> register hdmi codec earlier, and the base name which
> used in the register should be PLATFORM_DEVID_NONE,
> otherwise some audio dai dirver could not match it.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 7c022f3f53ec..2cb33098ec1a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1669,15 +1669,14 @@ static void mtk_hdmi_register_audio_driver(struct device *dev)
>  		.max_i2s_channels = 2,
>  		.i2s = 1,
>  	};
> -	struct platform_device *pdev;
> +	static struct platform_device *pdev;
>  
> -	pdev = platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
> -					     PLATFORM_DEVID_AUTO, &codec_data,
> -					     sizeof(codec_data));
> -	if (IS_ERR(pdev))
> +	if (!pdev) {
> +		pdev = platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
> +						     PLATFORM_DEVID_NONE,
> +						     &codec_data,
> +						     sizeof(codec_data));
> +		DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
> +	}

In the original code, it only register device but not unregister device.
This looks like a bug in hdmi driver. So we need to register and
unregister. You define a 'static' variable here would make
register/unregister asymmetric. And how do you make sure that hdmi
driver is probed before audio dai driver? By the device tree order?
Device tree older may vary for each SoC. I would like more general
solution to make sure that hdmi driver is probed before audio dai
driver. There are some method to make drivers probe in order, so try to
use the better method.

Regards,
CK

>  		return;
> -
> -	DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
>  }
>  
>  static int mtk_drm_hdmi_probe(struct platform_device *pdev)
> @@ -1691,6 +1690,7 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	hdmi->dev = dev;
> +	mtk_hdmi_register_audio_driver(dev);
>  
>  	ret = mtk_hdmi_dt_parse_pdata(hdmi, pdev);
>  	if (ret)
> @@ -1704,8 +1704,6 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	mtk_hdmi_register_audio_driver(dev);
> -
>  	hdmi->bridge.funcs = &mtk_hdmi_bridge_funcs;
>  	hdmi->bridge.of_node = pdev->dev.of_node;
>  	drm_bridge_add(&hdmi->bridge);


