Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FADC206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gtwN2KXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FADC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeK2Gsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:48:46 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37306 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeK2Gsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:48:46 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so6163913iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAa2ozWNSDa81AAI//mxNbLsV3jPxgp5M0hCY4SUpR4=;
        b=gtwN2KXmN5j/vdpOYtOiFou+I1Odk1VmsFA/fzrDlXZFLxo7DSsgm5mO6RSLlZBi3p
         2h2IKcCx9l2p/bmGNytJPvxsxjFpkRB7Mn/FFe1rxxaKA5PHECQq9W4hwEWTWHngeUZE
         3038QLhykp70I/EWg6FFtQt+CJuUxulx5QhWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAa2ozWNSDa81AAI//mxNbLsV3jPxgp5M0hCY4SUpR4=;
        b=hTwCUDiEwpcvk+Ln2M7xuHYVsWCQ22eqM+IQk59yO8oalL9/dFIkuux63k6ELwtsc8
         LYip7VhBgQ/TtUwDwu0tzLyOBw/m8jnaNZvzTHk8zz09Y4XjmNLchSiRZaTAZf252JXa
         /T11gYajSLUtApipexQxntk61pAXPtXaWRz+jYMsLWNeYBgYSCv/xyGldEawE6OYNfEx
         aA/RLoU1HZMLb8NMkcQBAZuCKuCOAzsZZrWhK+1Kr48bfSdRBmcOUgEjl86mu3s2TFZA
         99e91+aNJWJoIFq7+oDaAgpsCwZTDEOr9Dww2fuzBhbXhbSPNAYCCiXko5wuZ+N20DWP
         TOFw==
X-Gm-Message-State: AA+aEWYTX71LXbstSCp0ruxnoK2URQhJj94DhN5UztpdD96/dYF7c4O8
        D9p8R001+crI73t0mRvL/QBNMFSLc0de6uT4DgcE2g==
X-Google-Smtp-Source: AFSGD/VPbpbq7Ii42COZtS2wemUu7WzJLNco//3imA7ZJZdRaX08gD+72KcZIQtIUW/GI1TabcRQp78jh95NR90vguc=
X-Received: by 2002:a24:fe41:: with SMTP id w62mr4436394ith.23.1543434359668;
 Wed, 28 Nov 2018 11:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20181108161654.19888-1-eric@anholt.net> <20181108161654.19888-5-eric@anholt.net>
 <87ftw4y6rc.fsf@anholt.net>
In-Reply-To: <87ftw4y6rc.fsf@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Wed, 28 Nov 2018 19:45:47 +0000
Message-ID: <CAApk1dWrj3gvvOXAaU1e17Ec1+GpCccCb5pKwyrGUomwSQo5qg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/v3d: Add support for submitting jobs to the TFU.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        boris.brezillon@bootlin.com, daniel.vetter@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few comments below.
In particular I think USECOEF handling is a bit broken?
Otherwise looks good to me.

> I think one interesting question here is if TFU hangs (has it ever hung,
> in our experience?) do we want to reset the whole V3D, or is the reset
> flag in the TFU block enough?

We've never seen the TFU hang AFAIK.
Seems prudent to handle anyway; what you've done looks fine to me.
I wouldn't try to reset the TFU on its own. I don't know if that TFU
reset bit has ever been tested!

> > @@ -251,6 +256,7 @@ static const struct drm_ioctl_desc v3d_drm_ioctls[] = {
> >       DRM_IOCTL_DEF_DRV(V3D_MMAP_BO, v3d_mmap_bo_ioctl, DRM_RENDER_ALLOW),
> >       DRM_IOCTL_DEF_DRV(V3D_GET_PARAM, v3d_get_param_ioctl, DRM_RENDER_ALLOW),
> >       DRM_IOCTL_DEF_DRV(V3D_GET_BO_OFFSET, v3d_get_bo_offset_ioctl, DRM_RENDER_ALLOW),
> > +     DRM_IOCTL_DEF_DRV(V3D_SUBMIT_TFU, v3d_submit_tfu_ioctl, DRM_RENDER_ALLOW | DRM_AUTH),
> >  };

I would extend the comment above this block to note that DRM_AUTH is
currently required on SUBMIT_TFU because TFU commands are currently
not validated. (The TFU does not access memory via the GMP so I assume
we will want to explicitly validate commands instead?)

> >  static void
> >  v3d_unlock_bo_reservations(struct drm_device *dev,

dev not used? Wouldn't be needed by v3d_lock_bo_reservations either,
if it didn't need to be passed to unlock.

> > +static void
> > +v3d_tfu_job_cleanup(struct kref *ref)
> > +{
> > +     struct v3d_tfu_job *job = container_of(ref, struct v3d_tfu_job,
> > +                                            refcount);
> > +     struct v3d_dev *v3d = job->v3d;
> > +     unsigned int i;
> > +
> > +     dma_fence_put(job->in_fence);
> > +     dma_fence_put(job->done_fence);
> > +
> > +     for (i = 0; i < ARRAY_SIZE(job->bo); i++)
> > +             drm_gem_object_put_unlocked(&job->bo[i]->base);

This is a bit questionable. job->bo[i] may be NULL. &job->bo[i]->base
would work out as NULL too, but this strictly speaking invokes
undefined behaviour.

> > +#define V3D_TFU_INT_STS                                0x00438
> > +#define V3D_TFU_INT_SET                                0x0043c
> > +#define V3D_TFU_INT_CLR                                0x00440
> > +#define V3D_TFU_INT_MSK_STS                            0x00444
> > +#define V3D_TFU_INT_MSK_SET                            0x00448
> > +#define V3D_TFU_INT_MSK_CLR                            0x0044c
> > +#define V3D_TFU_INT_TFUC                               BIT(1)
> > +#define V3D_TFU_INT_TFUF                               BIT(0)

These just alias the HUB_CTL_INT registers.
They shouldn't be used.
I would probably avoid listing them here to avoid confusion.

> > +     if (job->args.coef[0] & V3D_TFU_COEF0_USECOEF) {
> > +             V3D_WRITE(V3D_TFU_COEF0, job->args.coef[0]);
> > +             V3D_WRITE(V3D_TFU_COEF1, job->args.coef[1]);
> > +             V3D_WRITE(V3D_TFU_COEF2, job->args.coef[2]);
> > +             V3D_WRITE(V3D_TFU_COEF3, job->args.coef[3]);
> > +     }

If USECOEF isn't set, still want to write COEF0 to clear the bit?

> > +#define DRM_IOCTL_V3D_SUBMIT_TFU          DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_SUBMIT_TFU, struct drm_v3d_submit_tfu)

Should this not be DRM_IOW? No data is returned to userspace in the
drm_v3d_submit_tfu struct AFAICT?

> > +     /* sync object to block on before submitting the TFU job.  Each TFU
> > +      * job will execute in the order submitted to its FD.  Synchronization
> > +      * against rendering jobs requires using sync objects.
> > +      */
> > +     __u32 in_sync;

"Submit" is used to mean two different things here. Maybe "before
submitting the TFU job" --> "before running the TFU job" to avoid
confusion?
