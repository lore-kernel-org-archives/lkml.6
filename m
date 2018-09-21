Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B990C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA33821547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA33821547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbeIUUR4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:17:56 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:55275 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389657AbeIUUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:17:56 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 13849725-1500050 
        for multiple; Fri, 21 Sep 2018 15:28:40 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "Chenfeng \(puck\)" <puck.chen@hisilicon.com>,
        "Liuxinliang \(Matthew Liu\)" <z.liuxinliang@hisilicon.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        John Garry <john.garry@huawei.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <e8f99d84-422f-f79f-f207-e9658b190800@huawei.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        daniel.vetter@ffwll.ch
References: <d390c2df-64f6-484e-e48f-953e88cc4501@huawei.com>
 <40ead141-6d9d-31bf-4b62-639b31db9793@huawei.com>
 <5BA48650.7050505@hisilicon.com>
 <e8f99d84-422f-f79f-f207-e9658b190800@huawei.com>
Message-ID: <153754012047.21139.481244931312769112@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: Bug report: HiBMC crash
Date:   Fri, 21 Sep 2018 15:28:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting John Garry (2018-09-21 09:11:19)
> On 21/09/2018 06:49, Liuxinliang (Matthew Liu) wrote:
> > Hi John,
> > Thank you for reporting bug.
> > I am now using 4.18.7. I haven't found this issue yet.
> > I will try linux-next and figure out what's wrong with it.
> >
> > Thanks,
> > Xinliang
> >
> >
> 
> As mentioned in internal mail, the issue may be that the surface 
> depth/bpp we were using the in the driver was previously invalid, but 
> code has since been added in v4.19 to reject this. Specifically it looks 
> like this patch:
> 
> commit 70109354fed232dfce8fb2c7cadf635acbe03e19
> Author: Chris Wilson <chris@chris-wilson.co.uk>
> Date:   Wed Sep 5 16:31:16 2018 +0100
> 
>      drm: Reject unknown legacy bpp and depth for drm_mode_addfb ioctl


diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
index b92595c477ef..f3e7f41e6781 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
@@ -71,7 +71,6 @@ static int hibmc_drm_fb_create(struct drm_fb_helper *helper,
        DRM_DEBUG_DRIVER("surface width(%d), height(%d) and bpp(%d)\n",
                         sizes->surface_width, sizes->surface_height,
                         sizes->surface_bpp);
-       sizes->surface_depth = 32;

        bytes_per_pixel = DIV_ROUND_UP(sizes->surface_bpp, 8);

@@ -192,7 +191,6 @@ int hibmc_fbdev_init(struct hibmc_drm_private *priv)
                return -ENOMEM;
        }

-       priv->fbdev = hifbdev;
        drm_fb_helper_prepare(priv->dev, &hifbdev->helper,
                              &hibmc_fbdev_helper_funcs);

@@ -246,6 +244,7 @@ int hibmc_fbdev_init(struct hibmc_drm_private *priv)
                         fix->ypanstep, fix->ywrapstep, fix->line_length,
                         fix->accel, fix->capabilities);

+       priv->fbdev = hifbdev;
        return 0;

 fini:

Apply chunks 2&3 first to confirm they fix the GPF.
-Chris
