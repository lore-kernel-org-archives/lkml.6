Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B55ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1241420880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1241420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lynxeye.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbeGWWAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:00:50 -0400
Received: from ns.lynxeye.de ([87.118.118.114]:43089 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388069AbeGWWAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:00:50 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2018 18:00:49 EDT
Received: by lynxeye.de (Postfix, from userid 501)
        id 602B2E7421F; Mon, 23 Jul 2018 22:49:17 +0200 (CEST)
Received: from tellur.fritz.box (a89-183-99-194.net-htp.de [89.183.99.194])
        by lynxeye.de (Postfix) with ESMTPSA id D7FAFE7414D;
        Mon, 23 Jul 2018 22:49:15 +0200 (CEST)
Message-ID: <228cdf6fe37298223d77b52fd4cdb821b0da7d11.camel@lynxeye.de>
Subject: Re: [PATCH] drm/tegra: hdmi: probe deferral error reporting
From:   Lucas Stach <dev@lynxeye.de>
To:     Marcel Ziswiler <marcel@ziswiler.com>, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Mon, 23 Jul 2018 22:49:15 +0200
In-Reply-To: <20180720075515.26852-1-marcel@ziswiler.com>
References: <20180720075515.26852-1-marcel@ziswiler.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 20.07.2018, 09:55 +0200 schrieb Marcel Ziswiler:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Actually report the error code from devm_regulator_get() which may as
> well just be a probe deferral.

This is still noisy, so while you are changing this I would prefer if
this wouldn't print the error message if it's a simple probe deferral.

Suppressing the log message in that case gets us much cleaner kernel
logs, where real errors stand out.

Regards,
Lucas

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  drivers/gpu/drm/tegra/hdmi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
> index 0082468f703c..94c182dbb6d0 100644
> --- a/drivers/gpu/drm/tegra/hdmi.c
> +++ b/drivers/gpu/drm/tegra/hdmi.c
> @@ -1693,14 +1693,16 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
>  
>  	hdmi->hdmi = devm_regulator_get(&pdev->dev, "hdmi");
>  	if (IS_ERR(hdmi->hdmi)) {
> -		dev_err(&pdev->dev, "failed to get HDMI regulator\n");
> -		return PTR_ERR(hdmi->hdmi);
> +		err = PTR_ERR(hdmi->hdmi);
> +		dev_err(&pdev->dev, "failed to get HDMI regulator: %d\n", err);
> +		return err;
>  	}
>  
>  	hdmi->pll = devm_regulator_get(&pdev->dev, "pll");
>  	if (IS_ERR(hdmi->pll)) {
> -		dev_err(&pdev->dev, "failed to get PLL regulator\n");
> -		return PTR_ERR(hdmi->pll);
> +		err = PTR_ERR(hdmi->pll);
> +		dev_err(&pdev->dev, "failed to get PLL regulator: %d\n", err);
> +		return err;
>  	}
>  
>  	hdmi->vdd = devm_regulator_get(&pdev->dev, "vdd");
