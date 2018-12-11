Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4E0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7302082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7302082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeLKPfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:35:08 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45554 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbeLKPfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:35:07 -0500
Received: from p5b127a5a.dip0.t-ipconnect.de ([91.18.122.90] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gWk3P-0006zm-U2; Tue, 11 Dec 2018 16:34:35 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Sandy Huang <hjc@rock-chips.com>, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sean Paul <seanpaul@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH for-4.20] Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"
Date:   Tue, 11 Dec 2018 16:34:35 +0100
Message-ID: <2584922.nx44hha6lV@phil>
In-Reply-To: <20181205181657.177703-1-briannorris@chromium.org>
References: <20181205181657.177703-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. Dezember 2018, 19:16:57 CET schrieb Brian Norris:
> This reverts commit 7f3ef5dedb146e3d5063b6845781ad1bb59b92b5.
> 
> It causes new warnings [1] on shutdown when running the Google Kevin or
> Scarlet (RK3399) boards under Chrome OS. Presumably our usage of DRM is
> different than what Marc and Heiko test.
> 
> We're looking at a different approach (e.g., [2]) to replace this, but
> IMO the revert should be taken first, as it already propagated to
> -stable.
> 
> [1] Report here:
> http://lkml.kernel.org/lkml/20181205030127.GA200921@google.com
> 
> WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x1c4/0x294
> ...
>  Call trace:
>   drm_mode_config_cleanup+0x1c4/0x294
>   rockchip_drm_unbind+0x4c/0x8c
>   component_master_del+0x88/0xb8
>   rockchip_drm_platform_remove+0x2c/0x44
>   rockchip_drm_platform_shutdown+0x20/0x2c
>   platform_drv_shutdown+0x2c/0x38
>   device_shutdown+0x164/0x1b8
>   kernel_restart_prepare+0x40/0x48
>   kernel_restart+0x20/0x68
> ...
>  Memory manager not clean during takedown.
>  WARNING: CPU: 4 PID: 2035 at drivers/gpu/drm/drm_mm.c:950 drm_mm_takedown+0x34/0x44
> ...
>   drm_mm_takedown+0x34/0x44
>   rockchip_drm_unbind+0x64/0x8c
>   component_master_del+0x88/0xb8
>   rockchip_drm_platform_remove+0x2c/0x44
>   rockchip_drm_platform_shutdown+0x20/0x2c
>   platform_drv_shutdown+0x2c/0x38
>   device_shutdown+0x164/0x1b8
>   kernel_restart_prepare+0x40/0x48
>   kernel_restart+0x20/0x68
> ...
> 
> [2] https://patchwork.kernel.org/patch/10556151/
>     https://www.spinics.net/lists/linux-rockchip/msg21342.html
>     [PATCH] drm/rockchip: shutdown drm subsystem on shutdown
> 
> Fixes: 7f3ef5dedb14 ("drm/rockchip: Allow driver to be shutdown on reboot/kexec")
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Vicente Bergas <vicencb@gmail.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@chromium.org>

So, I've applied this revert to drm-misc-fixes now, so it should still
land in 4.20-rc.

I'll resurrect Vicentes patch for a later regular inclusion as well,
but with more testing involved.


Heiko


