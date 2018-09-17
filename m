Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8680DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342E2214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342E2214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeIRBGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:06:40 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:41673 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRBGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:06:39 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 1487520029;
        Mon, 17 Sep 2018 21:37:49 +0200 (CEST)
Date:   Mon, 17 Sep 2018 21:37:48 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Marek Vasut <marex@denx.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: Re: [RESEND 4/5] drm/mxsfb: Add PM_SLEEP support
Message-ID: <20180917193748.GA13165@ravnborg.org>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
 <7d661819825a36f4aebe412e7bed8fe24c7292ae.1535367027.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d661819825a36f4aebe412e7bed8fe24c7292ae.1535367027.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=8AirrxEcAAAA:8 a=or3rrLwTOfPTjjqw9IcA:9
        a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard.

On Mon, Aug 27, 2018 at 02:10:40PM +0300, Leonard Crestez wrote:
> Since power to the lcdif block can be lost on suspend implement
> PM_SLEEP_OPS using drm_mode_config_helper_suspend/resume to save/restore
> the current mode.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 68d79f5dc0d3..d797dfd40d98 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -416,17 +416,38 @@ static int mxsfb_remove(struct platform_device *pdev)
>  	drm_dev_unref(drm);
>  
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int mxsfb_suspend(struct device *dev)
> +{
> +       struct drm_device *drm = dev_get_drvdata(dev);
> +
> +       return drm_mode_config_helper_suspend(drm);
> +}
> +
> +static int mxsfb_resume(struct device *dev)
> +{
> +       struct drm_device *drm = dev_get_drvdata(dev);
> +
> +       return drm_mode_config_helper_resume(drm);
> +}
> +#endif

Other suspend/resume users skip the #ifdef and declare
the functions __maybe_unused
See for example arm/hdlcd_drv.c.

The resulting code is a bit simpler to read and you
have the added benefit that the suspend/resume functions
are always compiled so bit-rotting is less likely.

	Sam
