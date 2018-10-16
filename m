Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70132C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BD42089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Q9cLjCYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BD42089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJQA3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:29:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36155 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJQA3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:29:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id c26-v6so21998300edt.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OGbpf6VY1dRc7YQGUwrKOJ0hbw3rVdNYxq4/XpQZ8o0=;
        b=Q9cLjCYw1S/ef6UKh25jQMjhy8qgP7DsVB3g1Y2/rnLWxFL/or/T9YvhqTjfMQxn4R
         SY7Q68k7OaAISAysMFOQfP1i5nNUP3VIt5FZ2WS+JKcFkzMXRMDNuQcYdXUFS/QY6kbS
         BbqQZR1Yu5rTAhyoV4C9SZuje0zi57Qo3AUyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OGbpf6VY1dRc7YQGUwrKOJ0hbw3rVdNYxq4/XpQZ8o0=;
        b=h7L8Y9v4xZE7UaV31hsxrL5QjerzDdJCVK91laUn8nhYx+0gNod7+dphi8sNlH1XEP
         KNIu6AkQ8GhAM9PgivuM5BVSqPdjqVi4k855k8zCrw2atXA4g0/02+oosfYWfGYHVmxE
         ff3hH1wX7YkcBK3mX8jt5TSexyO3w8Hl37ca/DGcxSPRdVsW/i5IKakgg0dcvcFePERf
         htGsBog0mDZ8b6VJqYzj35ACBjko9a0tOvYoeRCRczUAU2SOhTSham9/snu84gHf5OTy
         t+NpkDtlpV1sgLRsR48PNMQENeH8CUqbCjsMyH84jnPVeymqD1FZ1sQNgcUSyXHdtmiP
         pZjA==
X-Gm-Message-State: ABuFfoiMtgPTmcvFzJxHVZj7d2vbq5NCmIPfgeFd1g41FEu49ICtvB2G
        0l65OBLbXdCW+6bvwcghLJhcng==
X-Google-Smtp-Source: ACcGV62ts3Uy5/cKZpqd67aT5SKSm7laF375T2Yu9QEyX+UCVaeqVHO4jC54Axoek744VPv/KGH6iA==
X-Received: by 2002:a50:b68b:: with SMTP id d11-v6mr31309579ede.283.1539707914705;
        Tue, 16 Oct 2018 09:38:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m11sm5217425edv.90.2018.10.16.09.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 09:38:33 -0700 (PDT)
Date:   Tue, 16 Oct 2018 18:38:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20181016163831.GA31561@phenom.ffwll.local>
Mail-Followup-To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
 <57b40f9f-24d2-27de-4895-5a76ff267643@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57b40f9f-24d2-27de-4895-5a76ff267643@linux.intel.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:36:20PM +0200, Maarten Lankhorst wrote:
> Op 15-10-18 om 19:05 schreef Rodrigo Siqueira:
> > For historical reason, the function drm_wait_vblank_ioctl always return
> > -EINVAL if something gets wrong. This scenario limits the flexibility
> > for the userspace make detailed verification of the problem and take
> > some action. In particular, the validation of “if (!dev->irq_enabled)”
> > in the drm_wait_vblank_ioctl is responsible for checking if the driver
> > support vblank or not. If the driver does not support VBlank, the
> > function drm_wait_vblank_ioctl returns EINVAL which does not represent
> > the real issue; this patch changes this behavior by return EOPNOTSUPP.
> > Additionally, some operations are unsupported by this function, and
> > returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> > in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> > libdrm, which is used by many compositors; because of this, it is
> > important to check if this change breaks any compositor. In this sense,
> > the following projects were examined:
> >
> > * Drm-hwcomposer
> > * Kwin
> > * Sway
> > * Wlroots
> > * Wayland-core
> > * Weston
> > * Xorg (67 different drivers)
> >
> > For each repository the verification happened in three steps:
> >
> > * Update the main branch
> > * Look for any occurrence "drmWaitVBlank" with the command:
> >   git grep -n "drmWaitVBlank"
> > * Look in the git history of the project with the command:
> >   git log -SdrmWaitVBlank
> >
> > Finally, none of the above projects validate the use of EINVAL which
> > make safe, at least for these projects, to change the return values.
> >
> > Change since V1:
> >  Daniel Vetter and Chris Wilson
> >  - Replace ENOTTY by EOPNOTSUPP
> >  - Return EINVAL if the parameters are wrong
> >
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_vblank.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > index 98e091175921..80f5a3bb427e 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> >  	unsigned int flags, pipe, high_pipe;
> >  
> >  	if (!dev->irq_enabled)
> > -		return -EINVAL;
> > +		return -EOPNOTSUPP;
> Change to -EIO?
> 
> If userspace would ever print this out, it would print the following
> confusing message to userspace:
> "Operation not supported on transport endpoint"

You're a bit late, EOPNOTSUPP is not established already in upstream for
this. And -EIO is taken already for "the gpu is dead".

> >  
> >  	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > -		return -EINVAL;
> > +		return -EOPNOTSUPP;
> I would keep this -EINVAL, tbh and making it part of the below if statement..

We discussed this, it's different: This here is an ioctl flag that's no
longer supported, the below is just an invalid request. Hence different
errno.

I think you missed a bit with your bikeshed :-)
-Daniel

> >  	if (vblwait->request.type &
> >  	    ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> 
> Cheers,
> 
> Maarten
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
