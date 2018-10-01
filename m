Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6EFC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490AE2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZfOLmpxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490AE2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbeJAN2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:28:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33491 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeJAN2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:28:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id g26-v6so13163109edp.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ack1UwITI9TmKRYEW6T2SKcPzPtktow2A4KKoKeAVAI=;
        b=ZfOLmpxO3D4jBjBcOpADU06nAeXF3AvIy4Moe4pjSQZscBD/OE3y4nwiu8ZjYwJvcO
         WVw/JHi0YZTcCrnI1/S8q1ShuHeed7LzKznxSQnvOdfnjvWketBy9cNzmreoAtKDCzNu
         3MSmB52zDJSf6sfvy9GoKvHH3foUGn38RAGtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ack1UwITI9TmKRYEW6T2SKcPzPtktow2A4KKoKeAVAI=;
        b=hJX7cSKN4TK9CRPfac6SAAJtXt4c54tsk0HPSzJmanGnK1VxoL3620uwO2OAkNCtym
         ZG1gXZHjauhbsu+gpYascGTSdVjgJRj8tmqKZamP0elYXxglpeLZZhY7cIdVE8mf006R
         7jKZckw0pV3s/ZBgz/H5qHnos0tWXUB11GPWZaRKzVau3Ht6RtrqK2cLwjbJCI2QHkMm
         VnuTtO4PhOVPWtmnEWqFqcxY6OXPbHV5TJZ1N8G2FeveOjfNKy32ZxRM8anCJwoQjkiu
         5/gLl2CArcWJjDx4UbnKxHO7rX+d391SlCY4SKu2E1h4xlgXS6KByyBVakz2f6fR8kXw
         O44Q==
X-Gm-Message-State: ABuFfojAdNgd1zVeewRcy/EgeDw5PdAECBYGyrAspBi8bDAtu5uCzMsD
        29cP4Ide7eO5yQpizbTyeBIqqg==
X-Google-Smtp-Source: ACcGV633NOrjxcMzsjvw8xI8kpxwl/6PS8CSwskMnhTSSOQGdBQ3eLijiJglxuPMdlK+lj1Jih2n8g==
X-Received: by 2002:a17:906:6315:: with SMTP id p21-v6mr13035368ejk.135.1538376743715;
        Sun, 30 Sep 2018 23:52:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c16-v6sm4455383eds.97.2018.09.30.23.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 23:52:22 -0700 (PDT)
Date:   Mon, 1 Oct 2018 08:52:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20181001065220.GE11082@phenom.ffwll.local>
Mail-Followup-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20180918163903.GA11172@jordon-HP-15-Notebook-PC>
 <CAFqt6zZno+Q6NY6iOXr8utE3W56+Pd5KboqdOKZjj7Z_jBZDuw@mail.gmail.com>
 <1672691.6TUgGLsHUb@avalon>
 <20809880.gF2CxujBy3@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20809880.gF2CxujBy3@avalon>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 06:30:35PM +0300, Laurent Pinchart wrote:
> Hi Souptick,
> 
> On Friday, 28 September 2018 18:05:18 EEST Laurent Pinchart wrote:
> > On Thursday, 27 September 2018 09:34:18 EEST Souptick Joarder wrote:
> > > On Tue, Sep 18, 2018 at 10:05 PM Souptick Joarder wrote:
> > >> convert drm_atomic_helper_suspend/resume() to use
> > >> drm_mode_config_helper_suspend/resume().
> > >> 
> > >> remove suspend_state field from the rcar_du_device
> > >> structure as it is no more required.
> > >> 
> > >> With this conversion, also drm_fbdev_cma_set_suspend_unlocked()
> > >> will left with no consumer. So this function can be removed.
> > >> 
> > >> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > 
> > > Laurent, any comment on this patch ??
> > 
> > Sorry for the delay, and thanks for pinging me.
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Should I apply this to my tree or do you plan to merge it through drm-misc
> > as it touches drm_fb_cma_helper.c ?
> 
> I just realized that the same patch got supplied by Noralf Trønnes nearly a 
> year ago, and was later superseded by https://patchwork.freedesktop.org/patch/
> 247861/. I think we should thus apply Noralf's patches instead (once he sends 
> v4 out).

I don't think Noralf is still actively working on this, he's busy with the
fbdev emulation stuff. Probably better if you pick up one of the existing
ones, than waiting another year or so :-)

Cheers, Daniel

> 
> > >> ---
> > >> 
> > >>  drivers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
> > >>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
> > >>  drivers/gpu/drm/rcar-du/rcar_du_drv.h |  1 -
> > >>  include/drm/drm_fb_cma_helper.h       |  2 --
> > >>  4 files changed, 2 insertions(+), 40 deletions(-)
> > >> 
> > >> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c
> > >> b/drivers/gpu/drm/drm_fb_cma_helper.c index 47e0e2f..96efc88 100644
> > >> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> > >> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> > >> @@ -224,21 +224,3 @@ void drm_fbdev_cma_hotplug_event(struct
> > >> drm_fbdev_cma *fbdev_cma)
> > >>                 drm_fb_helper_hotplug_event(&fbdev_cma->fb_helper);
> > >>  }
> > >>  EXPORT_SYMBOL_GPL(drm_fbdev_cma_hotplug_event);
> > >> 
> > >> -
> > >> -/**
> > >> - * drm_fbdev_cma_set_suspend_unlocked - wrapper around
> > >> - *
> > >> drm_fb_helper_set_suspend_unlocked
> > >> - * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
> > >> - * @state: desired state, zero to resume, non-zero to suspend
> > >> - *
> > >> - * Calls drm_fb_helper_set_suspend, which is a wrapper around
> > >> - * fb_set_suspend implemented by fbdev core.
> > >> - */
> > >> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma
> > >> *fbdev_cma,
> > >> -                                       bool state)
> > >> -{
> > >> -       if (fbdev_cma)
> > >> -              
> > >> drm_fb_helper_set_suspend_unlocked(&fbdev_cma->fb_helper,
> > >> -                                                  state);
> > >> -}
> > >> -EXPORT_SYMBOL(drm_fbdev_cma_set_suspend_unlocked);
> > >> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > >> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 02aee6c..288220f 100644
> > >> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > >> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > >> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device
> > >> *dev)
> > >> 
> > >>  static int rcar_du_pm_suspend(struct device *dev)
> > >>  {
> > >>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> > >> -       struct drm_atomic_state *state;
> > >> 
> > >> -       drm_kms_helper_poll_disable(rcdu->ddev);
> > >> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
> > >> -
> > >> -       state = drm_atomic_helper_suspend(rcdu->ddev);
> > >> -       if (IS_ERR(state)) {
> > >> -               drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> > >> -               drm_kms_helper_poll_enable(rcdu->ddev);
> > >> -               return PTR_ERR(state);
> > >> -       }
> > >> -
> > >> -       rcdu->suspend_state = state;
> > >> -
> > >> -       return 0;
> > >> +       return drm_mode_config_helper_suspend(rcdu->ddev);
> > >>  }
> > >>  
> > >>  static int rcar_du_pm_resume(struct device *dev)
> > >>  {
> > >>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> > >> 
> > >> -       drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
> > >> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> > >> -       drm_kms_helper_poll_enable(rcdu->ddev);
> > >> -
> > >> -       return 0;
> > >> +       return drm_mode_config_helper_resume(rcdu->ddev);
> > >>  }
> > >>  #endif
> > >> 
> > >> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > >> b/drivers/gpu/drm/rcar-du/rcar_du_drv.h index b3a25e8..ff25c8d 100644
> > >> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > >> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > >> @@ -78,7 +78,6 @@ struct rcar_du_device {
> > >>         struct drm_device *ddev;
> > >>         struct drm_fbdev_cma *fbdev;
> > >> 
> > >> -       struct drm_atomic_state *suspend_state;
> > >> 
> > >>         struct rcar_du_crtc crtcs[RCAR_DU_MAX_CRTCS];
> > >>         unsigned int num_crtcs;
> > >> diff --git a/include/drm/drm_fb_cma_helper.h
> > >> b/include/drm/drm_fb_cma_helper.h index 4a65f0d..8dbbe1e 100644
> > >> --- a/include/drm/drm_fb_cma_helper.h
> > >> +++ b/include/drm/drm_fb_cma_helper.h
> > >> @@ -26,8 +26,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct
> > >> drm_device *dev,
> > >> 
> > >>  void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
> > >>  void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
> > >> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma
> > >> *fbdev_cma,
> > >> -                                       bool state);
> > >> 
> > >>  struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct
> > >>  drm_framebuffer *fb,
> > >>         unsigned int plane);
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
