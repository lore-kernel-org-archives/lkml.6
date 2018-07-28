Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A9C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 20:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437BE20878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 20:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Fdqbv8pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437BE20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbeG1VrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 17:47:14 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52742 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbeG1VrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 17:47:14 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8AD1391;
        Sat, 28 Jul 2018 22:19:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1532809172;
        bh=khjjzhamd+6LbLJdrLKmp+swQxpZ8dF3NPp67nE1qkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fdqbv8pigQaSIOrxpquW/tdP+w7uoFgjpQwxA86TUIvFSezunDnlxNbj9rigPSfC/
         ieqEQwesIFDA7O0wkwYPJd6F9rb5qCHfU2L1SgXbz4UBgerzzvRyVu8/4wHpC/nNvp
         K/HKwhl2tv0joh1lDs8E4M2bdTEkVGtKh2bg9b/E=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Vaishali Thakkar <vthakkar@vaishalithakkar.in>, airlied@linux.ie,
        Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
Date:   Sat, 28 Jul 2018 23:20:07 +0300
Message-ID: <10502231.oSnn9dME1M@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAFqt6zYy4GfQn0VQ5rfoygY+8M1RQYEv_BH-Jxmv6epoLj3xmw@mail.gmail.com>
References: <20180728154007.GA28426@jordon-HP-15-Notebook-PC> <CAK-LDbKqU4Yub5H0_6tRpED4DLN8D+XrsUaNT5SN9Oq0sEpBNg@mail.gmail.com> <CAFqt6zYy4GfQn0VQ5rfoygY+8M1RQYEv_BH-Jxmv6epoLj3xmw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

Thank you for the patch.

On Saturday, 28 July 2018 21:50:58 EEST Souptick Joarder wrote:
> On Sat, Jul 28, 2018 at 11:20 PM, Vaishali Thakkar wrote:
> > On Sat, Jul 28, 2018 at 9:10 PM, Souptick Joarder wrote:
> >> convert drm_atomic_helper_suspend/resume() to use
> >> drm_mode_config_helper_suspend/resume().
> > 
> > Hi Souptick,
> > 
> > Thanks for your patch.
> > 
> >> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> >> ---
> >> 
> >>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
> >>  1 file changed, 2 insertions(+), 19 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 02aee6c..288220f 100644
> >> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device
> >> *dev)
> >> 
> >>  static int rcar_du_pm_suspend(struct device *dev)
> >>  {
> >>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> >> -       struct drm_atomic_state *state;
> >> 
> >> -       drm_kms_helper_poll_disable(rcdu->ddev);
> >> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
> >> -
> >> -       state = drm_atomic_helper_suspend(rcdu->ddev);
> >> -       if (IS_ERR(state)) {
> >> -               drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> > 
> > I don't think we can use drm_mode_config_helper_(suspend/resume)
> > API here as this file uses CMA functions.
> 
> drm_fbdev_cma_set_suspend_unlocked() is wrapper function which
> invokes drm_fb_helper_set_suspend_unlocked().
> 
> Where the new API drm_mode_config_helper_suspend/resume() directly invokes
> drm_fb_helper_set_suspend_unlocked(). So it is safe to replace exiting
> code with API drm_mode_config_helper_suspend/resume().

I agree that they're functionally equivalent for now, but what if 
drm_fbdev_cma_set_suspend_unlocked() gets extended later ? This change risks 
introducing a breakage that could could unnoticed at that point. At the very 
least you should add a comment in drm_fbdev_cma_set_suspend_unlocked() to 
explain that any extension of the function should also address all drivers 
using drm_mode_config_helper_suspend() and drm_mode_config_helper_resume().

> > And from git grep it seems that there are very few drivers using it at the
> > moment, so not sure if introducing new API functions similar to 
> > drm_mode_config will make sense or not.
> 
> https://www.kernel.org/doc/html/latest/gpu/todo.html
> 
> It was picked up from TODO list after discussing with
> Daniel.
> 
> > Thanks.
> > 
> >> -               drm_kms_helper_poll_enable(rcdu->ddev);
> >> -               return PTR_ERR(state);
> >> -       }
> >> -
> >> -       rcdu->suspend_state = state;

Additionally, I think you can remove the suspend_state field from the rcdu 
structure.

> >> -       return 0;
> >> +       return drm_mode_config_helper_suspend(rcdu->ddev);
> >>  }
> >>  
> >>  static int rcar_du_pm_resume(struct device *dev)
> >>  {
> >>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> >> 
> >> -       drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
> >> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> >> -       drm_kms_helper_poll_enable(rcdu->ddev);
> >> -
> >> -       return 0;
> >> +       return drm_mode_config_helper_resume(rcdu->ddev);
> >>  }
> >>  #endif

-- 
Regards,

Laurent Pinchart



