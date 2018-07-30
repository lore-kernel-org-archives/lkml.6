Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB37C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8037220870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8037220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeG3F0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 01:26:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50303 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725858AbeG3F0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 01:26:13 -0400
X-UUID: 13b2ba26e6d745d59ee17daf084aec5d-20180730
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 737174457; Mon, 30 Jul 2018 11:53:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 30 Jul 2018 11:53:06 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 30 Jul 2018 11:53:06 +0800
Message-ID: <1532922786.3723.1.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: Convert drm_atomic_helper_suspend/resume()
From:   CK Hu <ck.hu@mediatek.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     <p.zabel@pengutronix.de>, <airlied@linux.ie>,
        <matthias.bgg@gmail.com>, <ajitn.linux@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Mon, 30 Jul 2018 11:53:06 +0800
In-Reply-To: <20180728133845.GA15261@jordon-HP-15-Notebook-PC>
References: <20180728133845.GA15261@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Souptick:

On Sat, 2018-07-28 at 19:08 +0530, Souptick Joarder wrote:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index a2ca90f..1fcda2de 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -520,29 +520,24 @@ static int mtk_drm_sys_suspend(struct device *dev)
>  {
>  	struct mtk_drm_private *private = dev_get_drvdata(dev);
>  	struct drm_device *drm = private->drm;
> +	int ret;
>  
> -	drm_kms_helper_poll_disable(drm);
> -
> -	private->suspend_state = drm_atomic_helper_suspend(drm);
> -	if (IS_ERR(private->suspend_state)) {
> -		drm_kms_helper_poll_enable(drm);
> -		return PTR_ERR(private->suspend_state);
> -	}
> -
> +	ret = drm_mode_config_helper_suspend(drm);
>  	DRM_DEBUG_DRIVER("mtk_drm_sys_suspend\n");
> -	return 0;
> +
> +	return ret;
>  }
>  
>  static int mtk_drm_sys_resume(struct device *dev)
>  {
>  	struct mtk_drm_private *private = dev_get_drvdata(dev);
>  	struct drm_device *drm = private->drm;
> +	int ret;
>  
> -	drm_atomic_helper_resume(drm, private->suspend_state);
> -	drm_kms_helper_poll_enable(drm);
> -
> +	ret = drm_mode_config_helper_resume(drm);
>  	DRM_DEBUG_DRIVER("mtk_drm_sys_resume\n");
> -	return 0;
> +
> +	return ret;
>  }
>  #endif
>  


