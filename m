Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2353AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4D420645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nIhD2XX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4D420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJBQsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:48:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40326 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:48:05 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BCB57B7F;
        Tue,  2 Oct 2018 12:05:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538474734;
        bh=T1m9qReArjdzu/gT/PvWRp9Ej0V6qc/h5NHTJKbh7UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nIhD2XX3X2N9GogC09gaI4y8WJNXIet+3ckvAYCu69baNW8f19qM8yXX7vyiBNzFB
         hxQHDL6LvaRIb0ufgbSTSkV7cu+cFzX/YeEMKcQX0g+6i5imN/U71wMjNKTym7qSHE
         9+lF9zhG/HB2WZHZMNYknwhvQtbKvuOzad8zD6/c=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Peter Wu <peter@lekensteyn.nl>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] qxl: fix null-pointer crash during suspend
Date:   Tue, 02 Oct 2018 13:05:50 +0300
Message-ID: <1688275.zophSNHJ2k@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181002081422.GH11082@phenom.ffwll.local>
References: <20180904202747.14968-1-peter@lekensteyn.nl> <20181002081422.GH11082@phenom.ffwll.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tuesday, 2 October 2018 11:14:22 EEST Daniel Vetter wrote:
> On Tue, Sep 04, 2018 at 10:27:47PM +0200, Peter Wu wrote:
> > "crtc->helper_private" is not initialized by the QXL driver and thus the
> 
> This is still initialized, it's the ->disable that goes boom. At least the
> call to drm_crtc_helper_add is still there. The ->disable was removed in:
> 
> commit 64581714b58bc3e16ede8dc37a025c3aa0e0eef1
> Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date:   Fri Jun 30 12:36:45 2017 +0300
> 
>     drm: Convert atomic drivers from CRTC .disable() to .atomic_disable()
> 
> Fixes: 64581714b58b ("drm: Convert atomic drivers from CRTC .disable() to
> .atomic_disable()") Cc: <stable@vger.kernel.org> # v4.14+
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I'll let Gerd pick this one up, after some testing. Also adding Laurent.

Sorry for breaking it :-( Please let me know if there's something I can do to 
help.

> > "crtc_funcs->disable" call would crash (resulting in suspend failure).
> > Fix this by converting the suspend/resume functions to use the
> > drm_mode_config_helper_* helpers.
> > 
> > Tested system sleep with QEMU 3.0 using "echo mem > /sys/power/state".
> > 
> > During suspend the following message is visible from QEMU:
> >     spice/server/display-channel.c:2425:display_channel_validate_surface:
> >     canvas address is 0x7fd05da68308 for 0 (and is NULL)
> >     spice/server/display-channel.c:2426:display_channel_validate_surface:
> >     failed on 0> 
> > This seems to be triggered by QXL_IO_NOTIFY_CMD after
> > QXL_IO_DESTROY_PRIMARY_ASYNC, but aside from the warning things still
> > seem to work (tested with both the GTK and -spice options).
> > 
> > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> > ---
> > Hi,
> > 
> > I found this issue while trying to suspend a VM that uses QXL. In order to
> > see the stack trace over serial, boot with no_console_suspend. Searching
> > for "qxl_drm_freeze" showed one recent report from Alan:
> > https://lkml.kernel.org/r/891e334c-cf19-032c-b996-59ac166fcde1@gmail.com
> > 
> > Kind regards,
> > Peter
> > ---
> > 
> >  drivers/gpu/drm/qxl/qxl_drv.c | 26 +++++---------------------
> >  1 file changed, 5 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > index 2445e75cf7ea..d00f45eed03c 100644
> > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > @@ -136,20 +136,11 @@ static int qxl_drm_freeze(struct drm_device *dev)
> > 
> >  {
> >  
> >  	struct pci_dev *pdev = dev->pdev;
> >  	struct qxl_device *qdev = dev->dev_private;
> > 
> > -	struct drm_crtc *crtc;
> > -
> > -	drm_kms_helper_poll_disable(dev);
> > -
> > -	console_lock();
> > -	qxl_fbdev_set_suspend(qdev, 1);
> > -	console_unlock();
> > +	int ret;
> > 
> > -	/* unpin the front buffers */
> > -	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> > -		const struct drm_crtc_helper_funcs *crtc_funcs = crtc-
>helper_private;
> > -		if (crtc->enabled)
> > -			(*crtc_funcs->disable)(crtc);
> > -	}
> > +	ret = drm_mode_config_helper_suspend(dev);
> > +	if (ret)
> > +		return ret;
> > 
> >  	qxl_destroy_monitors_object(qdev);
> >  	qxl_surf_evict(qdev);
> > 
> > @@ -175,14 +166,7 @@ static int qxl_drm_resume(struct drm_device *dev,
> > bool thaw)> 
> >  	}
> >  	
> >  	qxl_create_monitors_object(qdev);
> > 
> > -	drm_helper_resume_force_mode(dev);
> > -
> > -	console_lock();
> > -	qxl_fbdev_set_suspend(qdev, 0);
> > -	console_unlock();
> > -
> > -	drm_kms_helper_poll_enable(dev);
> > -	return 0;
> > +	return drm_mode_config_helper_resume(dev);
> > 
> >  }
> >  
> >  static int qxl_pm_suspend(struct device *dev)


-- 
Regards,

Laurent Pinchart



