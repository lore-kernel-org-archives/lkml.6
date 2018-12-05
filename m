Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD7DC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F202081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fPRfJWgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F202081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeLEDBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:01:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43264 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEDBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:01:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so8305142pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 19:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aEyY2esnyy3IdaqIe/pCkfAfBQQ+yS1skDDXIsiASBg=;
        b=fPRfJWgH91RF32pw2dmnn27m3zpx6owVHFQui45eJMX1jMGAhSBZ0fsJyzhg5DH9lM
         DyHrpAy+ec2vsjZsS9x22FKyxGzEenc/U0an3poJ5J0LOiofAWJQFyN7mEwX1wFB0pbS
         o8j6kXn9NK3Lg8xZ5cpUpTXWPQmbFX4bhNlDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aEyY2esnyy3IdaqIe/pCkfAfBQQ+yS1skDDXIsiASBg=;
        b=XYapipg/Qt6N5w5E3W1D3Hu1kADwtopTXJVR99V95qnPTMz126HODqlZjrtB/Nk3YN
         TvBvDbZh6aH2ZlXg9c6QYzAFDz9wI/H0CqfBISoCN36tf8a77QAqJOQ/lbcVvbgHGC2m
         jcgbSP8/246ayvc2LadBqJhC1KNPaek0hJOv40E30CpFENDxo9NbBo9EvqL/kfagV0it
         e0rw5zQcQMQsxkDVPhRQrTsKCYTzxsVu5BJHZ2jFZVznt9ZkPCnpW7QchcN3plsAGp0r
         +vGNDYbzk6oiCSrYJJTV5H7Qw8TicRWk7fZorspU8eOV/E7xZFqT4RljtlKuqH6oikg9
         mzdA==
X-Gm-Message-State: AA+aEWaBP6yK5CpcAwnyv1Y96l+NcU+emYkunuj2P0kqFWEmyp2rGRUI
        HXK9/Rn5mUlExtqzjbBU//HRW16UkV8=
X-Google-Smtp-Source: AFSGD/XSwmlai3435j4LMDh4RpazXp5z1sB/LeQV8MEZzzAu7rcB2THMXvd5e9HxJlcCOVzSeUu4QA==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr18603161pfh.228.1543978899435;
        Tue, 04 Dec 2018 19:01:39 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id l64sm22327815pge.73.2018.12.04.19.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 19:01:37 -0800 (PST)
Date:   Tue, 4 Dec 2018 19:01:34 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: Allow driver to be shutdown on reboot/kexec
Message-ID: <20181205030127.GA200921@google.com>
References: <20180805124807.18169-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805124807.18169-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ others

Hi,

On Sun, Aug 05, 2018 at 01:48:07PM +0100, Marc Zyngier wrote:
> Leaving the DRM driver enabled on reboot or kexec has the annoying
> effect of leaving the display generating transactions whilst the
> IOMMU has been shut down.
> 
> In turn, the IOMMU driver (which shares its interrupt line with
> the VOP) starts warning either on shutdown or when entering the
> secondary kernel in the kexec case (nothing is expected on that
> front).
> 
> A cheap way of ensuring that things are nicely shut down is to
> register a shutdown callback in the platform driver.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

This patch made it into 4.20-rc1 as well as -stable, and it has caused
regressions for me, on the Kevin and Scarlet [1] RK3399 platforms. On
shutdown/reboot, I see this:

[   94.742559] WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x1c4/0x294
...
[   94.775904] CPU: 4 PID: 2035 Comm: reboot Tainted: G        W         4.20.0-rc5+ #83
[   94.784651] Hardware name: Google Scarlet (DT)
[   94.789611] pstate: 20000005 (nzCv daif -PAN -UAO)
[   94.794959] pc : drm_mode_config_cleanup+0x1c4/0x294
[   94.800500] lr : drm_mode_config_cleanup+0x108/0x294
...
[   94.898683] Call trace:
[   94.901410]  drm_mode_config_cleanup+0x1c4/0x294
[   94.906565]  rockchip_drm_unbind+0x4c/0x8c
[   94.911138]  component_master_del+0x88/0xb8
[   94.915807]  rockchip_drm_platform_remove+0x2c/0x44
[   94.921243]  rockchip_drm_platform_shutdown+0x20/0x2c
[   94.926881]  platform_drv_shutdown+0x2c/0x38
[   94.931647]  device_shutdown+0x164/0x1b8
[   94.936016]  kernel_restart_prepare+0x40/0x48
[   94.940878]  kernel_restart+0x20/0x68
[   94.944964]  __se_sys_reboot+0x1ac/0x204
[   94.949331]  __arm64_sys_reboot+0x2c/0x38
[   94.953806]  el0_svc_common+0xa4/0xec
[   94.957891]  el0_svc_compat_handler+0x30/0x3c
[   94.962753]  el0_svc_compat+0x8/0x18
[   94.966740] ---[ end trace b9ba2e701f4fb233 ]---
[   95.255169] Memory manager not clean during takedown.
[   95.260824] WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mm.c:950 drm_mm_takedown+0x34/0x44
...
[   95.292314] CPU: 4 PID: 2035 Comm: reboot Tainted: G        W         4.20.0-rc5+ #83
[   95.301061] Hardware name: Google Scarlet (DT)
[   95.306020] pstate: 60000005 (nZCv daif -PAN -UAO)
[   95.311369] pc : drm_mm_takedown+0x34/0x44
[   95.315940] lr : drm_mm_takedown+0x34/0x44
...
[   95.415857]  drm_mm_takedown+0x34/0x44
[   95.420042]  rockchip_drm_unbind+0x64/0x8c
[   95.424613]  component_master_del+0x88/0xb8
[   95.429283]  rockchip_drm_platform_remove+0x2c/0x44
[   95.434728]  rockchip_drm_platform_shutdown+0x20/0x2c
[   95.440360]  platform_drv_shutdown+0x2c/0x38
[   95.445127]  device_shutdown+0x164/0x1b8
[   95.449504]  kernel_restart_prepare+0x40/0x48
[   95.454358]  kernel_restart+0x20/0x68
[   95.458436]  __se_sys_reboot+0x1ac/0x204
[   95.462812]  __arm64_sys_reboot+0x2c/0x38
[   95.467287]  el0_svc_common+0xa4/0xec
[   95.471373]  el0_svc_compat_handler+0x30/0x3c
[   95.476235]  el0_svc_compat+0x8/0x18
[   95.480215] ---[ end trace b9ba2e701f4fb234 ]---

It's especially bad on -stable kernels, where I believe the remove()
paths were even worse. This triggers a variety of OOPSes, and it's not
clear if those are simply because of backports (e.g., RK3399 did not
have support in 4.4.y, but our downstream has merged all sorts of
backports to make it work).

Anyway, the above warnings occur on v4.20-rc, which I think is
justification enough for a revert.

I plan to submit a revert which I hope can go to 4.20 as well as
-stable. I'd hope the remove()/shutdown() paths should be fixed before
this gets applied again, and that it does not get shipped to -stable
kernels.

Brian

[1] Technically Scarlet needed a few patches from -next to work at all,
    but Kevin is a similar platform that has been working for several
    releases.

>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index f814d37b1db2..05368fa4f956 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -442,6 +442,11 @@ static int rockchip_drm_platform_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void rockchip_drm_platform_shutdown(struct platform_device *pdev)
> +{
> +	rockchip_drm_platform_remove(pdev);
> +}
> +
>  static const struct of_device_id rockchip_drm_dt_ids[] = {
>  	{ .compatible = "rockchip,display-subsystem", },
>  	{ /* sentinel */ },
> @@ -451,6 +456,7 @@ MODULE_DEVICE_TABLE(of, rockchip_drm_dt_ids);
>  static struct platform_driver rockchip_drm_platform_driver = {
>  	.probe = rockchip_drm_platform_probe,
>  	.remove = rockchip_drm_platform_remove,
> +	.shutdown = rockchip_drm_platform_shutdown,
>  	.driver = {
>  		.name = "rockchip-drm",
>  		.of_match_table = rockchip_drm_dt_ids,
