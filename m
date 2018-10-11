Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C48C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BE62085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jAajullw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BE62085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJKPpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:45:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45243 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKPpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:45:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id v18-v6so7386421edq.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XXbQdRWIM7oIZdbHEPWEzUgTaKPforkwJGHSqMObcBI=;
        b=jAajullwXqBUS2gBoL24EEyoyFVLqpyut3TB7MRKPrsBRtlMZU245sBtNX+uyuk0F9
         Yzs0ymFksrkLsKcIrDv5Y71ipGWyfRJQduVlap/p6wWHXz6x2TKXCQMspq9ubB19KUMm
         cWb+Xd0+M0ZHBIFWRZd+xHn7sK2HBemXnvDFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XXbQdRWIM7oIZdbHEPWEzUgTaKPforkwJGHSqMObcBI=;
        b=n7Rq9fFSmMQtbpIqU8DIeEN3AguVV8rscYRCkck36w9fz3qFOSJnECMVspEsDji9nU
         t8lpFHV7uIQdsMeAOwO8lDEb503sfxu7JRsuvxFHMfkZkK/vrBmbaEUVNal4MU0SsdWa
         DyTTF/v1Yj9BV4+LsLNpj6KrN4x1hIKoylGCMDijjkhpf64Qs9zC99fX9fiYxdU3c58m
         GHpLq0dUZ/dLRnUq+Do/O/xnKi+1ynSO+zrMIU6rYPE00igS3geox3xkEJZfU1FHICb+
         PRKtjHK3jipXt40xOBZDgR1OdSmgvvOvFUsvD+W5vSFXGvDrEvhmEeCyBQOqgOMl2mpF
         /HgA==
X-Gm-Message-State: ABuFfogmYYcmcOgIbwV4AEmGLKSnBhx4hFQ0LV/gqlovrJFHVZ7BhGEC
        cdU+CZqCWjmqzUZ1DEszBAgpgQI7vU4=
X-Google-Smtp-Source: ACcGV61BADPDvbie1CClg3MQuUtk4kRLz7j4QPSHeLrGT9Alt6qeASivdf4kverem13LkyGWnmzMEQ==
X-Received: by 2002:a17:906:e1ce:: with SMTP id gp14-v6mr1074675ejb.221.1539245936450;
        Thu, 11 Oct 2018 01:18:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v21-v6sm2249996eja.62.2018.10.11.01.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 01:18:52 -0700 (PDT)
Date:   Thu, 11 Oct 2018 10:18:49 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     noralf@tronnes.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20181011081849.GR31561@phenom.ffwll.local>
Mail-Followup-To: Souptick Joarder <jrdr.linux@gmail.com>,
        noralf@tronnes.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20180918163903.GA11172@jordon-HP-15-Notebook-PC>
 <20809880.gF2CxujBy3@avalon>
 <20181001065220.GE11082@phenom.ffwll.local>
 <26527911.hs5tlrnKDc@avalon>
 <042a6076-62e2-c029-2a09-f1123d9ac403@tronnes.org>
 <CAFqt6zZ9vZ8qDpockDyUgqxJxA-d6ajyufzBUCPzKkxv0Vnu_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqt6zZ9vZ8qDpockDyUgqxJxA-d6ajyufzBUCPzKkxv0Vnu_Q@mail.gmail.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:57:52PM +0530, Souptick Joarder wrote:
> Hi Laurent,
> On Mon, Oct 1, 2018 at 6:12 PM Noralf Trønnes <noralf@tronnes.org> wrote:
> >
> >
> > Den 01.10.2018 13.56, skrev Laurent Pinchart:
> > > Hi Daniel,
> > >
> > > On Monday, 1 October 2018 09:52:20 EEST Daniel Vetter wrote:
> > >> On Fri, Sep 28, 2018 at 06:30:35PM +0300, Laurent Pinchart wrote:
> > >>> On Friday, 28 September 2018 18:05:18 EEST Laurent Pinchart wrote:
> > >>>> On Thursday, 27 September 2018 09:34:18 EEST Souptick Joarder wrote:
> > >>>>> On Tue, Sep 18, 2018 at 10:05 PM Souptick Joarder wrote:
> > >>>>>> convert drm_atomic_helper_suspend/resume() to use
> > >>>>>> drm_mode_config_helper_suspend/resume().
> > >>>>>>
> > >>>>>> remove suspend_state field from the rcar_du_device
> > >>>>>> structure as it is no more required.
> > >>>>>>
> > >>>>>> With this conversion, also drm_fbdev_cma_set_suspend_unlocked()
> > >>>>>> will left with no consumer. So this function can be removed.
> > >>>>>>
> > >>>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > >>>>> Laurent, any comment on this patch ??
> > >>>> Sorry for the delay, and thanks for pinging me.
> > >>>>
> > >>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >>>>
> > >>>> Should I apply this to my tree or do you plan to merge it through
> > >>>> drm-misc
> > >>>> as it touches drm_fb_cma_helper.c ?
> > >>> I just realized that the same patch got supplied by Noralf Trønnes nearly
> > >>> a
> > >>> year ago, and was later superseded by
> > >>> https://patchwork.freedesktop.org/patch/247861/. I think we should thus
> > >>> apply Noralf's patches instead (once he sends v4 out).
> > >> I don't think Noralf is still actively working on this, he's busy with the
> > >> fbdev emulation stuff. Probably better if you pick up one of the existing
> > >> ones, than waiting another year or so :-)
> > > Isn't https://patchwork.freedesktop.org/patch/247861/ part of the fbdev
> > > emulation stuff ? That patch series is from less than a month ago, so I
> > > thought it was actively developed.
> > >
> > > Let's ask him. Noralf, any comment ? :-)
> >
> > I see now that I've caused some confusion here.
> >
> > I did some refactoring of the fbdev stuff in the CMA helper last year.
> > In the last series of that work there is this patch:
> >
> > [v3,07/11] drm/rcar-du: Use drm_mode_config_helper_suspend/resume()
> > https://patchwork.freedesktop.org/patch/192414/
> >
> > During Christmas I got the idea that maybe it was possible to use a dumb
> > buffer to do generic fbdev emulation. That work took me 6 months before a
> > solution using a general internal DRM client was hammered out. By the
> > time I started to convert drivers I had forgotten about that patch.
> >
> > When I wrote the patch (#247861) to convert rcar to the generic fbdev, I
> > just bundled up the suspend/resume change with the fbdev conversion.
> > Laurent and Sam commented on that bundling, so I said that I would split
> > it up in the next version.
> >
> > All that being said, I think that this patch should be applied and I'll
> > just rebase the rcar fbdev conversion patch on top of that.
> > It's the easiest for me at least :-)
> >
> Any conclusion on this patch ? :-)

Laurent should pick it up and apply to his rcar-du tree I think. We can
also stuff it into drm-misc as a fallback.
-Daniel

> 
> ers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
> > >>>>>>   drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
> > >>>>>>   drivers/gpu/drm/rcar-du/rcar_du_drv.h |  1 -
> > >>>>>>   include/drm/drm_fb_cma_helper.h       |  2 --
> > >>>>>>   4 files changed, 2 insertions(+), 40 deletions(-)
> > >>>>>>
> > >>>>>> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c
> > >>>>>> b/drivers/gpu/drm/drm_fb_cma_helper.c index 47e0e2f..96efc88 100644
> > >>>>>> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> > >>>>>> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> > >>>>>> @@ -224,21 +224,3 @@ void drm_fbdev_cma_hotplug_event(struct
> > >>>>>> drm_fbdev_cma *fbdev_cma)
> > >>>>>>
> > >>>>>>                  drm_fb_helper_hotplug_event(&fbdev_cma->fb_helper);
> > >>>>>>
> > >>>>>>   }
> > >>>>>>   EXPORT_SYMBOL_GPL(drm_fbdev_cma_hotplug_event);
> > >>>>>>
> > >>>>>> -
> > >>>>>> -/**
> > >>>>>> - * drm_fbdev_cma_set_suspend_unlocked - wrapper around
> > >>>>>> - *
> > >>>>>> drm_fb_helper_set_suspend_unlocked
> > >>>>>> - * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
> > >>>>>> - * @state: desired state, zero to resume, non-zero to suspend
> > >>>>>> - *
> > >>>>>> - * Calls drm_fb_helper_set_suspend, which is a wrapper around
> > >>>>>> - * fb_set_suspend implemented by fbdev core.
> > >>>>>> - */
> > >>>>>> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma
> > >>>>>> *fbdev_cma,
> > >>>>>> -                                       bool state)
> > >>>>>> -{
> > >>>>>> -       if (fbdev_cma)
> > >>>>>> -
> > >>>>>> drm_fb_helper_set_suspend_unlocked(&fbdev_cma->fb_helper,
> > >>>>>> -                                                  state);
> > >>>>>> -}
> > >>>>>> -EXPORT_SYMBOL(drm_fbdev_cma_set_suspend_unlocked);
> > >>>>>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > >>>>>> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 02aee6c..288220f 100644
> > >>>>>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > >>>>>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > >>>>>> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device
> > >>>>>> *dev)
> > >>>>>>
> > >>>>>>   static int rcar_du_pm_suspend(struct device *dev)
> > >>>>>>   {
> > >>>>>>
> > >>>>>>          struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> > >>>>>>
> > >>>>>> -       struct drm_atomic_state *state;
> > >>>>>>
> > >>>>>> -       drm_kms_helper_poll_disable(rcdu->ddev);
> > >>>>>> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
> > >>>>>> -
> > >>>>>> -       state = drm_atomic_helper_suspend(rcdu->ddev);
> > >>>>>> -       if (IS_ERR(state)) {
> > >>>>>> -               drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev,
> > >>>>>> false);
> > >>>>>> -               drm_kms_helper_poll_enable(rcdu->ddev);
> > >>>>>> -               return PTR_ERR(state);
> > >>>>>> -       }
> > >>>>>> -
> > >>>>>> -       rcdu->suspend_state = state;
> > >>>>>> -
> > >>>>>> -       return 0;
> > >>>>>> +       return drm_mode_config_helper_suspend(rcdu->ddev);
> > >>>>>>
> > >>>>>>   }
> > >>>>>>
> > >>>>>>   static int rcar_du_pm_resume(struct device *dev)
> > >>>>>>   {
> > >>>>>>
> > >>>>>>          struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> > >>>>>>
> > >>>>>> -       drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
> > >>>>>> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> > >>>>>> -       drm_kms_helper_poll_enable(rcdu->ddev);
> > >>>>>> -
> > >>>>>> -       return 0;
> > >>>>>> +       return drm_mode_config_helper_resume(rcdu->ddev);
> > >>>>>>
> > >>>>>>   }
> > >>>>>>   #endif
> > >>>>>>
> > >>>>>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > >>>>>> b/drivers/gpu/drm/rcar-du/rcar_du_drv.h index b3a25e8..ff25c8d 100644
> > >>>>>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > >>>>>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > >>>>>> @@ -78,7 +78,6 @@ struct rcar_du_device {
> > >>>>>>
> > >>>>>>          struct drm_device *ddev;
> > >>>>>>          struct drm_fbdev_cma *fbdev;
> > >>>>>>
> > >>>>>> -       struct drm_atomic_state *suspend_state;
> > >>>>>>
> > >>>>>>          struct rcar_du_crtc crtcs[RCAR_DU_MAX_CRTCS];
> > >>>>>>          unsigned int num_crtcs;
> > >>>>>>
> > >>>>>> diff --git a/include/drm/drm_fb_cma_helper.h
> > >>>>>> b/include/drm/drm_fb_cma_helper.h index 4a65f0d..8dbbe1e 100644
> > >>>>>> --- a/include/drm/drm_fb_cma_helper.h
> > >>>>>> +++ b/include/drm/drm_fb_cma_helper.h
> > >>>>>> @@ -26,8 +26,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct
> > >>>>>> drm_device *dev,
> > >>>>>>
> > >>>>>>   void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
> > >>>>>>   void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
> > >>>>>>
> > >>>>>> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma
> > >>>>>> *fbdev_cma,
> > >>>>>> -                                       bool state);
> > >>>>>>
> > >>>>>>   struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct
> > >>>>>>   drm_framebuffer *fb,
> > >>>>>>
> > >>>>>>          unsigned int plane);
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
