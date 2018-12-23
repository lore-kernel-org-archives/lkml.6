Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A02C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 14:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B2F2184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 14:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="cJmkKUJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeLWN4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 08:56:01 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:33666 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLWN4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 08:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=/zCb4irDvh4U99oxlMnhdzYukA3Ah2MHqRO/sIp0QxM=;
        b=cJmkKUJqo2quQNiTqTcE53AP1kcwgIdPg661snUTX5XmMdxaZSSQ08Wm8wm9az4+AJzsj/YHS8D6sFPV32OYQr5MQ9/P9DZQN1atBymK2Y2aUNeFIOy1m9y615rk9Nfh8XPhGl0CcY98b+6/RmQjmWKluQvUWzKPSHKDjE8m+DkteFhgrzKZzBXFgMGrPwyivNbmxLK7V2hjzCFxErEIlA1ZaeaLH7GYnb1F19VTXafy9TQIZ9LMqeINSWB+VZsiOn9kj7oXycZbgPMjB0POWaah+VE25ffCcERyH8u1C6RZ0eVn2bHwOGDTr4geq4hHUjaF8F5wzoKtyvWHTIM4TQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:65010 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gb4EZ-0008Ol-Ea; Sun, 23 Dec 2018 14:55:59 +0100
Subject: Re: [PATCH] drm/fb-helper: fix leaks in error path of
 drm_fb_helper_fbdev_setup
To:     Peter Wu <peter@lekensteyn.nl>, dri-devel@lists.freedesktop.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rong.a.chen@intel.com, kraxel@redhat.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        lkp@01.org
References: <20181223004315.GA11455@al>
 <20181223005507.28328-1-peter@lekensteyn.nl>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <ad4be2e7-b53c-97b5-7029-83f4017e4643@tronnes.org>
Date:   Sun, 23 Dec 2018 14:55:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181223005507.28328-1-peter@lekensteyn.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 23.12.2018 01.55, skrev Peter Wu:
> After drm_fb_helper_fbdev_setup calls drm_fb_helper_init,
> "dev->fb_helper" will be initialized (and thus drm_fb_helper_fini will
> have some effect). After that, drm_fb_helper_initial_config is called
> which may call the "fb_probe" driver callback.
> 
> This driver callback may call drm_fb_helper_defio_init (as is done by
> drm_fb_helper_generic_probe) or set a framebuffer (as is done by bochs)
> as documented. These are normally cleaned up on exit by
> drm_fb_helper_fbdev_teardown which also calls drm_fb_helper_fini.
> 
> If an error occurs after "fb_probe", but before setup is complete, then
> calling just drm_fb_helper_fini will leak resources. This was triggered
> by df2052cc922 ("bochs: convert to drm_fb_helper_fbdev_setup/teardown"):
> 
>      [   50.008030] bochsdrmfb: enable CONFIG_FB_LITTLE_ENDIAN to support this framebuffer
>      [   50.009436] bochs-drm 0000:00:02.0: [drm:drm_fb_helper_fbdev_setup] *ERROR* fbdev: Failed to set configuration (ret=-38)
>      [   50.011456] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 2
>      [   50.013604] WARNING: CPU: 1 PID: 1 at drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x280/0x2a0
>      [   50.016175] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 4.20.0-rc7 #1
>      [   50.017732] EIP: drm_mode_config_cleanup+0x280/0x2a0
>      ...
>      [   50.023155] Call Trace:
>      [   50.023155]  ? bochs_kms_fini+0x1e/0x30
>      [   50.023155]  ? bochs_unload+0x18/0x40
> 
> This can be reproduced with QEMU and CONFIG_FB_LITTLE_ENDIAN=n.
> 
> Link: https://lkml.kernel.org/r/20181221083226.GI23332@shao2-debian
> Link: https://lkml.kernel.org/r/20181223004315.GA11455@al
> Fixes: 8741216396b2 ("drm/fb-helper: Add drm_fb_helper_fbdev_setup/teardown()")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Cc: Noralf Trønnes <noralf@tronnes.org>
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> ---
>   drivers/gpu/drm/drm_fb_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 9d64f874f965..432e0f3b9267 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -2860,7 +2860,7 @@ int drm_fb_helper_fbdev_setup(struct drm_device *dev,
>   	return 0;
>   
>   err_drm_fb_helper_fini:
> -	drm_fb_helper_fini(fb_helper);
> +	drm_fb_helper_fbdev_teardown(dev);

This change will break the error path for drm_fbdev_generic_setup()
because drm_fb_helper_generic_probe() cleans up on error but doesn't
clear drm_fb_helper->fb resulting in a double drm_framebuffer_remove().

My assumption has been that the drm_fb_helper_funcs->fb_probe callback
cleans up its resources on error. Clearly this is not the case for 
bochs, so my take on this is that bochsfb_create() needs to clean up on 
error.

Gerd has a patchset that switches bochs over to the generic fbdev
emulation, but ofc that doesn't help with 4.20:
https://patchwork.freedesktop.org/series/54269/

Noralf.

>   
>   	return ret;
>   }
> 
