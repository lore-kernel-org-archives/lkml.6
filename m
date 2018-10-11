Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F22C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F442087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eR1sSpec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F442087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeJKQEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:04:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32970 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:04:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id h13-v6so7473356edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Kw1LF5tD5rxGhDP2RzfzQC8MbUK5ux1QNSzTZN4cPGM=;
        b=eR1sSpecg8vbs0DbwGRSrOfOzASjmapk0RnDGd49f3MJuqIn2W4KGMdyuF7DyNmiZC
         edsnvWRsvjEZcnRWUpXNcZZva/ueB6FrQHSFvPoxzOmPJ8imfjqVhjtjM9ix8/tzGVVB
         NZkMNupKe7Xdw02zKxNOIVvFlOvzgknvRhfqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Kw1LF5tD5rxGhDP2RzfzQC8MbUK5ux1QNSzTZN4cPGM=;
        b=dXRB5AA1h4k83iMjQYOrlA+awQfs0L0GUrimvORKAWwK+SCc5Evg9c2pr6tkIxH0jc
         1VmDab4IfUGfOqa98fjZngsAlP9O12TXp5DA+CJbVN3I6CvK1oKYsid/HcAexKRdEuZr
         JarXC7KZTMasUkyLfaGoJwVPvZTF15BPWjUhj6axHi5nm7Lz2YbdM+G0oTOhGgRx6hYL
         blzJ899SFlAXa6GVLXJrYBcAhJ9vk2ecNwz+29JPzwK3T+InSZLNIfmVA4dnMYNT54B3
         RkFXOCY6DYpWjXxvSZSg1Q0cwmQkWY9qSVRBGjQ36P5p0/hIdtoBjTj6A5TWdkEJ/l0n
         MAlQ==
X-Gm-Message-State: ABuFfoh/ljRwNQgnL1d+5TzhotFNaiip+N/aAQMnE6VJ9M6Sgl2gxo8C
        rRS/1y4FssEC9GhV7uHKowcFgg==
X-Google-Smtp-Source: ACcGV62tCNjchN19J0cnFhoxcC4XLOeY4f3jxwp0d9Qp24LTi1J4mMgF23u5Hv5VhDcyhgfVJkdyuw==
X-Received: by 2002:a50:a1c6:: with SMTP id 64-v6mr1410558edk.88.1539247103998;
        Thu, 11 Oct 2018 01:38:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e5-v6sm4638865ejc.47.2018.10.11.01.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 01:38:21 -0700 (PDT)
Date:   Thu, 11 Oct 2018 10:38:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20181011083818.GW31561@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181008145220.p34dllgsiw6rlpod@smtp.gmail.com>
 <153901080237.31254.10116385737520796385@skylake-alporthouse-com>
 <20181008165213.vejfqe6ohiejeeq2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181008165213.vejfqe6ohiejeeq2@smtp.gmail.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 01:52:13PM -0300, Rodrigo Siqueira wrote:
> On 10/08, Chris Wilson wrote:
> > Quoting Rodrigo Siqueira (2018-10-08 15:52:20)
> > > For historical reason, the function drm_wait_vblank_ioctl always return
> > > -EINVAL if something gets wrong. This scenario limits the flexibility
> > > for the userspace make detailed verification of the problem and take
> > > some action. In particular, the validation of “if (!dev->irq_enabled)”
> > > in the drm_wait_vblank_ioctl is responsible for checking if the driver
> > > support vblank or not. If the driver does not support VBlank, the
> > > function drm_wait_vblank_ioctl returns EINVAL which does not represent
> > > the real issue; this patch changes this behavior by return ENOTTY
> > > (Inappropriate ioctl for device). Additionally, some operations are
> > > unsupported by this function, and returns EINVAL; this patch changes the
> > > return value to EOPNOTSUPP (Operation not supported). Lastly, the
> > > function drm_wait_vblank_ioctl is invoked by libdrm, which is used by
> > > many compositors; because of this, it is important to check if this
> > > change breaks any compositor. In this sense, the following projects were
> > > examined:
> > > 
> > > * Drm-hwcomposer
> > > * Kwin
> > > * Sway
> > > * Wlroots
> > > * Wayland-core
> > > * Weston
> > > * Xorg (67 different drivers)
> > > 
> > > For each repository the verification happened in three steps:
> > > 
> > > * Update the main branch
> > > * Look for any occurrence "drmWaitVBlank" with the command:
> > >   git grep -n "drmWaitVBlank"
> > > * Look in the git history of the project with the command:
> > >   git log -SdrmWaitVBlank
> > > 
> > > Finally, none of the above projects validate the use of EINVAL which
> > > make safe, at least for these projects, to change the return values.
> > > 
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > ---
> > >  drivers/gpu/drm/drm_vblank.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > > index 98e091175921..88ec6fb49afb 100644
> > > --- a/drivers/gpu/drm/drm_vblank.c
> > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > @@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> > >         unsigned int flags, pipe, high_pipe;
> > >  
> > >         if (!dev->irq_enabled)
> > > -               return -EINVAL;
> > > +               return -ENOTTY;
> > 
> > Arguable.
> 
> Hi Chris, thanks for your review :)
> 
> Originally, I noticed that DRM does not provide a mechanism for checking
> if VBlank is supported or not by the driver. IMHO return ENOTTY can be
> useful for virtual drivers and some specific devices; the userspace can
> take this information and infer some information about the device,
> consequently, handling different scenarios. This issue was raised when I
> was working to implement the virtual mode in the VKMS (no vblank) and
> tried to patch IGT to handle modules that do not support Vblank.
> Finally, I believe that  ENOTTY precisely describes the condition
> "if (!dev->irq_enabled)". Make sense?

I Chris' recent series to do the same for all kms ioctls we've generally
agreed on EOPNOTSUPP as the errno for "this feature isn't supported on
this driver". And ENOTTY for the "I have no idea what this ioctl even is"
kind of stuff.

So I'm leaning towards EOPNOTSUPP here.
> 
> > >  
> > >         if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > > -               return -EINVAL;
> > 
> > User error -> einval.
> 
> Here, my primary motivation to add EOPNOTSUPP came from the comment in
> _DRM_VBLANK_SIGNAL, which says:
> 
> _DRM_VBLANK_SIGNAL = 0x40000000 /**< Send signal instead of blocking, unsupported */
> 
> Then I thought that EOPNOTSUPP could better describe this situation.

I think either is an ok choice. EINVAL since afaik upstream never
supported this flag, so it's not different from any other flag with on
meaning - just another userspace programming bug.

> > > +               return -EOPNOTSUPP;
> > >  
> > >         if (vblwait->request.type &
> > >             ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> > > @@ -1545,7 +1545,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> > >                           vblwait->request.type,
> > >                           (_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> > >                            _DRM_VBLANK_HIGH_CRTC_MASK));
> > > -               return -EINVAL;
> > > +               return -EOPNOTSUPP;
> > 
> > User error -> einval.
> 
> About this one, you are right. Sorry, I misunderstood that part of the
> code.

Agreed, EINVAL.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
