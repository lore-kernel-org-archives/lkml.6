Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD362C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A0320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="svWs2FPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbeLQL2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:28:53 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:43086 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeLQL2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:28:53 -0500
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C2F659;
        Mon, 17 Dec 2018 12:28:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545046131;
        bh=Gcxzaq/RltJoCYn4zF6OkAEbEuXMHudDw+/sJm9w+z4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=svWs2FPD4Dv5Bh3AAfqKw9QuAxGpusmQYlB4e16MV5wmjWB3f0NcfxAzlGV0jkaJb
         QN6D5LKEG3x9bD9xsttCKy9XB7H/IC9+I+0HuzWxUeoTFFcKVCgTgQtSPyOjIcmRxY
         6JiTdRJwym4GO8wiZvk6X/5wnhn9dZIVB4yeILik=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH -next] drm/shmob: Fix return value check in
 shmob_drm_probe
To:     YueHaibing <yuehaibing@huawei.com>,
        laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20181217091830.32624-1-yuehaibing@huawei.com>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <279140cd-2719-9828-7399-99848411ed51@ideasonboard.com>
Date:   Mon, 17 Dec 2018 11:28:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217091830.32624-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YeuHaibing,

On 17/12/2018 09:18, YueHaibing wrote:
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 

This looks correct to me.

I wonder if this failure pattern occurs a lot in the kernel.

I wonder if we have a cocci-check for this ?
It seems the closest we have is scripts/coccinelle/null/eno.cocci.

Perhaps that could be extended sometime to check these globally.

> Fixes: 8f1597c8f1a5 ("drm: shmobile: Perform initialization/cleanup at probe/remove time")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> index 8554102..f2cfd16 100644
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
> 

