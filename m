Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1EFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310CA21534
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310CA21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbeHMT7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:59:20 -0400
Received: from foss.arm.com ([217.140.101.70]:34340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbeHMT7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:59:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 880C07A9;
        Mon, 13 Aug 2018 10:16:13 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34B763F73C;
        Mon, 13 Aug 2018 10:16:13 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 84040680B67; Mon, 13 Aug 2018 18:16:11 +0100 (BST)
Date:   Mon, 13 Aug 2018 18:16:11 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>, malidp@foss.arm.com,
        airlied@linux.ie, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] drm: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180813171611.GE907@e110455-lin.cambridge.arm.com>
References: <20180730190137.GA25420@jordon-HP-15-Notebook-PC>
 <20180731103440.GD17455@e110455-lin.cambridge.arm.com>
 <CAFqt6zbEur=h4pRxs-XNZhTbtwQMdbwwOLmiFDQmhNDVx3msJA@mail.gmail.com>
 <CAFqt6zYUN3XRsbhAgp8Lne9j1KTr5Ub0P+WrtLwOOfFPFRHFsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqt6zYUN3XRsbhAgp8Lne9j1KTr5Ub0P+WrtLwOOfFPFRHFsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 03:25:24PM +0530, Souptick Joarder wrote:
> On Wed, Aug 1, 2018 at 12:11 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > On Tue, Jul 31, 2018 at 4:04 PM, Liviu Dudau <liviu.dudau@arm.com> wrote:
> >> Hi Souptick,
> >>
> >> On Tue, Jul 31, 2018 at 12:31:37AM +0530, Souptick Joarder wrote:
> >>> convert drm_atomic_helper_suspend/resume() to use
> >>> drm_mode_config_helper_suspend/resume().
> >>>
> >>> With this conversion, drm_fbdev_cma_set_suspend_unlocked()
> >>> will left with no consumer. So this function can be removed.
> >>>
> >>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> >>> ---
> >>>  drivers/gpu/drm/arm/hdlcd_drv.c       | 26 ++------------------------
> >>>  drivers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
> >>>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
> >>>  include/drm/drm_fb_cma_helper.h       |  2 --
> >>>  4 files changed, 4 insertions(+), 63 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> >>> index feaa8bc..4e617e0 100644
> >>> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> >>> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> >>> @@ -427,37 +427,15 @@ static int hdlcd_remove(struct platform_device *pdev)
> >>>  static int __maybe_unused hdlcd_pm_suspend(struct device *dev)
> >>>  {
> >>>       struct drm_device *drm = dev_get_drvdata(dev);
> >>> -     struct hdlcd_drm_private *hdlcd = drm ? drm->dev_private : NULL;
> >>>
> >>> -     if (!hdlcd)
> >>> -             return 0;
> >>> -
> >>> -     drm_kms_helper_poll_disable(drm);
> >>> -     drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 1);
> >>> -
> >>> -     hdlcd->state = drm_atomic_helper_suspend(drm);
> >>> -     if (IS_ERR(hdlcd->state)) {
> >>> -             drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 0);
> >>> -             drm_kms_helper_poll_enable(drm);
> >>> -             return PTR_ERR(hdlcd->state);
> >>> -     }
> >>> -
> >>> -     return 0;
> >>> +     return drm_mode_config_helper_suspend(drm);
> >>>  }
> >>>
> >>>  static int __maybe_unused hdlcd_pm_resume(struct device *dev)
> >>>  {
> >>>       struct drm_device *drm = dev_get_drvdata(dev);
> >>> -     struct hdlcd_drm_private *hdlcd = drm ? drm->dev_private : NULL;
> >>> -
> >>> -     if (!hdlcd)
> >>> -             return 0;
> >>>
> >>> -     drm_atomic_helper_resume(drm, hdlcd->state);
> >>> -     drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 0);
> >>> -     drm_kms_helper_poll_enable(drm);
> >>> -
> >>> -     return 0;
> >>> +     return drm_mode_config_helper_resume(drm);
> >>>  }
> >>
> >> This patch is similar to the one Noralf Trønnes submitted, and his is
> >> also cleaning up the state variable in hdlcd_drm_private. The patch has
> >> been queued as commit f69d9686e5d9 in git://linux-arm.org/linux-ld.git
> >> for-upstream/hdlcd and I will send a pull request today for it.
> >>
> >> Best regards,
> >> Liviu
> >
> > unable to clone this repository.
> > can you please post the patchwork link ?

Sorry, I was on holiday until today.

> 
> Liviu, is commit f69d9686e5d9 in
> git://linux-arm.org/linux-ld.gitfor-upstream/hdlcd
> contains only changes in drivers/gpu/drm/arm/hdlcd_drv.c driver ??

That's right, that tree only deals with HDLCD changes. The rest of the
patch is up to you to upstream into drm-misc.

Best regards,
Liviu


> 
> >
> >>
> >>>
> >>>  static SIMPLE_DEV_PM_OPS(hdlcd_pm_ops, hdlcd_pm_suspend, hdlcd_pm_resume);
> >>> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> >>> index 186d00a..f604a84 100644
> >>> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> >>> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> >>> @@ -529,21 +529,3 @@ void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state)
> >>>               drm_fb_helper_set_suspend(&fbdev_cma->fb_helper, state);
> >>>  }
> >>>  EXPORT_SYMBOL(drm_fbdev_cma_set_suspend);
> >>> -
> >>> -/**
> >>> - * drm_fbdev_cma_set_suspend_unlocked - wrapper around
> >>> - *                                      drm_fb_helper_set_suspend_unlocked
> >>> - * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
> >>> - * @state: desired state, zero to resume, non-zero to suspend
> >>> - *
> >>> - * Calls drm_fb_helper_set_suspend, which is a wrapper around
> >>> - * fb_set_suspend implemented by fbdev core.
> >>> - */
> >>> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
> >>> -                                     bool state)
> >>> -{
> >>> -     if (fbdev_cma)
> >>> -             drm_fb_helper_set_suspend_unlocked(&fbdev_cma->fb_helper,
> >>> -                                                state);
> >>> -}
> >>> -EXPORT_SYMBOL(drm_fbdev_cma_set_suspend_unlocked);
> >>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >>> index 02aee6c..288220f 100644
> >>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >>> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device *dev)
> >>>  static int rcar_du_pm_suspend(struct device *dev)
> >>>  {
> >>>       struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> >>> -     struct drm_atomic_state *state;
> >>>
> >>> -     drm_kms_helper_poll_disable(rcdu->ddev);
> >>> -     drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
> >>> -
> >>> -     state = drm_atomic_helper_suspend(rcdu->ddev);
> >>> -     if (IS_ERR(state)) {
> >>> -             drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> >>> -             drm_kms_helper_poll_enable(rcdu->ddev);
> >>> -             return PTR_ERR(state);
> >>> -     }
> >>> -
> >>> -     rcdu->suspend_state = state;
> >>> -
> >>> -     return 0;
> >>> +     return drm_mode_config_helper_suspend(rcdu->ddev);
> >>>  }
> >>>
> >>>  static int rcar_du_pm_resume(struct device *dev)
> >>>  {
> >>>       struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> >>>
> >>> -     drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
> >>> -     drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> >>> -     drm_kms_helper_poll_enable(rcdu->ddev);
> >>> -
> >>> -     return 0;
> >>> +     return drm_mode_config_helper_resume(rcdu->ddev);
> >>>  }
> >>>  #endif
> >>>
> >>> diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_helper.h
> >>> index d532f88a..15c4569 100644
> >>> --- a/include/drm/drm_fb_cma_helper.h
> >>> +++ b/include/drm/drm_fb_cma_helper.h
> >>> @@ -33,8 +33,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device *dev,
> >>>  void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
> >>>  void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
> >>>  void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state);
> >>> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
> >>> -                                     bool state);
> >>>
> >>>  struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer *fb,
> >>>       unsigned int plane);
> >>> --
> >>> 1.9.1
> >>>
> >>
> >> --
> >> ====================
> >> | I would like to |
> >> | fix the world,  |
> >> | but they're not |
> >> | giving me the   |
> >>  \ source code!  /
> >>   ---------------
> >>     ¯\_(ツ)_/¯

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
