Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA530C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F72420874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YbQlSi1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbeLQVfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:35:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54434 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeLQVfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:35:51 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7CC35578;
        Mon, 17 Dec 2018 22:35:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545082548;
        bh=4wWQguZTH64ul54ihIES52sipHfoOpklZgNMg+Ugyx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbQlSi1kjxDVc6JupUFRTNg/Mgv5XS6PBRH1ZzijojaEx7lm1LvsRb4KaCU5lIEWV
         5uFpJgAARsFMbh8JnORLMLSusI14NKBb+4/hgb0Qi5v/GoLTecpZ5hsw3wh29PqNWn
         SyXX2SoSSy1ePHezjq6g/zzaISMn8w+K6xt310qs=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/shmob: Fix return value check in shmob_drm_probe
Date:   Mon, 17 Dec 2018 23:36:39 +0200
Message-ID: <14731722.nqiV3L9y3F@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181217091830.32624-1-yuehaibing@huawei.com>
References: <20181217091830.32624-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

Thank you for the patch.

On Monday, 17 December 2018 11:18:30 EET YueHaibing wrote:
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Fixes: 8f1597c8f1a5 ("drm: shmobile: Perform initialization/cleanup at
> probe/remove time")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> b/drivers/gpu/drm/shmobile/shmob_drm_drv.c index 8554102..f2cfd16 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> @@ -229,8 +229,8 @@ static int shmob_drm_probe(struct platform_device *pdev)
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sdev->mmio = devm_ioremap_resource(&pdev->dev, res);
> -	if (sdev->mmio == NULL)
> -		return -ENOMEM;
> +	if (IS_ERR(sdev->mmio))
> +		return PTR_ERR(sdev->mmio);
> 
>  	ret = shmob_drm_setup_clocks(sdev, pdata->clk_source);
>  	if (ret < 0)

-- 
Regards,

Laurent Pinchart



