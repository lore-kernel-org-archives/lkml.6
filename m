Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4CAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D023A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VBfoVLn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfAVTDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:03:31 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40942 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfAVTDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wf/rKSuusv0ihWfps4SO0VkLLnHhuqA0sgqKtU2oFPo=; b=VBfoVLn0o3oqbmKUjLhsVuutl
        qpUkoL8v4mLEokZBEMgP5ADNYU4zJRUwEYEIBBIgdWNdkq2iy4vuEZBRXJSWhBLkABhRNl3yV4mGr
        K0INRDiZSg8lMTpr4Ql2zh1or7TMpMWl0bV3JK+QbU29jOxA4yGs5Lm1O9YjMrB7FC1mk=;
Received: from e5254000004ec.dyn.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46186 helo=shell.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gm1KT-00063G-UT; Tue, 22 Jan 2019 19:03:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gm1KT-0001vT-6B; Tue, 22 Jan 2019 19:03:21 +0000
Date:   Tue, 22 Jan 2019 19:03:21 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/armada: replace the simple-framebuffer
Message-ID: <20190122190320.3lfi7ff7oxmnxymj@e5254000004ec.dyn.armlinux.org.uk>
References: <20190121060157.549544-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121060157.549544-1-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 07:01:57AM +0100, Lubomir Rintel wrote:
> If there's a simple-framebuffer carried over from boot firmware, it's going
> to stop working once we setup the LCDC for use via DRM. Kick it off from
> the hardware.

Applied, thanks.

> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/gpu/drm/armada/armada_drv.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> index fa31589b4fc0..9fcf88c91758 100644
> --- a/drivers/gpu/drm/armada/armada_drv.c
> +++ b/drivers/gpu/drm/armada/armada_drv.c
> @@ -100,6 +100,17 @@ static int armada_drm_bind(struct device *dev)
>  		return ret;
>  	}
>  
> +	/* Remove early framebuffers */
> +	ret = drm_fb_helper_remove_conflicting_framebuffers(NULL,
> +							    "armada-drm-fb",
> +							    false);
> +	if (ret) {
> +		dev_err(dev, "[" DRM_NAME ":%s] can't kick out simple-fb: %d\n",
> +			__func__, ret);
> +		kfree(priv);
> +		return ret;
> +	}
> +
>  	priv->drm.dev_private = priv;
>  
>  	dev_set_drvdata(dev, &priv->drm);
> -- 
> 2.20.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
