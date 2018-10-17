Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6239CECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0785C2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kPkSqZ/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0785C2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeJQUmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:42:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43704 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQUmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:42:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id 12-v6so16326027qkj.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rlvjyT4RDSRSK7K194CZkR5U78bnfbGhZKEi7vR2Q/w=;
        b=kPkSqZ/M8Hp5NkWb7+4wuPKr+J0Fa2xOD/puTrNWVehN9gEG3kC2/lXU+yCHpvtAdN
         bqteeilfkZtl0+Nibgy2+UigkJ5rj+GYmCPwp49hCQIom4TPeDuoIR6B1s1SzmY+zfS1
         5yeeVHS46cZlzyzulPTPPfHEcZ9s1uS8YfZLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rlvjyT4RDSRSK7K194CZkR5U78bnfbGhZKEi7vR2Q/w=;
        b=jtSmpIue+8GZFxHomAmRAJaMqlTtmgGFYCqhhTzskzG2gE2eesxyY54iMNQXTlDkFE
         TtF0zbAHF9k+G4dBEdkbv3r9q1FNhr324MF08/FV8RQgXVmHBFx+2sO2E1SKpE3bcXol
         oYM6eNionszuBd8TBl4HXY6zztiLQSSxcQU/mln5VRgmklG6KpRJMhYmHi2k0YfE0mL7
         wJQQgy5ULYBo4T1WNeE5KpT2gSF8NL8iWBcLs0IbJS/ZMpHcdVDZZgfErF+1zreCOm0x
         VZp9NBACos7eZIhRWDEmDQulGfiXkGJu1oLegPqwJQf6fTCz+GliTmT6F6pRQHKo8xSV
         zqgA==
X-Gm-Message-State: ABuFfohTvh6+XldZHyTPzEY4QjEN6FGYIFi3gsDvReUDep9/Hic3HSXj
        OtoavYRt+mPpILoY9e8KvkGfDtONvkON++kDJIsHtA==
X-Google-Smtp-Source: ACcGV63QNBG0C+pyhPJJGadZYmUMjFaT+fAKsb2l1AEnYDRwlp56EkFQukkLqC9PmNpIqUCIcUNgRbN0VXWAtvYqFO4=
X-Received: by 2002:a37:93c3:: with SMTP id v186-v6mr24275095qkd.186.1539780436060;
 Wed, 17 Oct 2018 05:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
 <20181016123541.GW31561@phenom.ffwll.local> <20181017124315.khhlykapxnug6ej6@smtp.gmail.com>
In-Reply-To: <20181017124315.khhlykapxnug6ej6@smtp.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 17 Oct 2018 14:47:04 +0200
Message-ID: <CAKMK7uF0ucof6gwAiY1SSp5oHt3BZ18Jkui5ugvkZc4u-NOJoA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 2:43 PM Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
>
> Hi,
>
> First of all, thanks to all for the reviewers and feedbacks.
>
> On 10/16, Daniel Vetter wrote:
> > On Mon, Oct 15, 2018 at 02:05:29PM -0300, Rodrigo Siqueira wrote:
> > > For historical reason, the function drm_wait_vblank_ioctl always retu=
rn
> > > -EINVAL if something gets wrong. This scenario limits the flexibility
> > > for the userspace make detailed verification of the problem and take
> > > some action. In particular, the validation of =E2=80=9Cif (!dev->irq_=
enabled)=E2=80=9D
> > > in the drm_wait_vblank_ioctl is responsible for checking if the drive=
r
> > > support vblank or not. If the driver does not support VBlank, the
> > > function drm_wait_vblank_ioctl returns EINVAL which does not represen=
t
> > > the real issue; this patch changes this behavior by return EOPNOTSUPP=
.
> > > Additionally, some operations are unsupported by this function, and
> > > returns EINVAL; this patch also changes the return value to EOPNOTSUP=
P
> > > in this case. Lastly, the function drm_wait_vblank_ioctl is invoked b=
y
> > > libdrm, which is used by many compositors; because of this, it is
> > > important to check if this change breaks any compositor. In this sens=
e,
> > > the following projects were examined:
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
> > > Change since V1:
> > >  Daniel Vetter and Chris Wilson
> > >  - Replace ENOTTY by EOPNOTSUPP
> > >  - Return EINVAL if the parameters are wrong
> > >
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> >
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > Can you pls also let intel-gfx-ci test this patch? You just need to
> > include intel-gfx@lists.freedesktop.org in your recipient list.
>
> I did know about intel-gfx-ci, really nice:)
>
> Should I CC this mailing list if I send patches to the DRM core, amdgpu,
> i915, vc4, vgem, and virtio-gpu? I suppose that IGT is running on the
> CI, right?

It's only intel gpus (well and one special amd one) running igt on a
_lot_ of different machines.

> Another question, do I need to send a V3 with intel-gfx-ci?

If the patch-set is unchanged people use the "FOR CI" subject prefix
when resending, instead of incrementing the version number.

> > For merging, since you plan to stick around doing kms stuff a bit: Want
> > commit rights for drm-misc?
> >
> > https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html
>
> Yes, I want :)
> I will need some guidance, in the beginning, to get confident about the
> processes. If you can help me with this, I will be glad to play around
> with 'dim' and the merging tasks.

Sure, just ping me on irc. First you need a freedesktop.org ssh account:

https://www.freedesktop.org/wiki/AccountRequests/

You need to request access to the drm-misc group. Once you have the
bugzilla, pls ping me so I can ack it.

Thanks, Daniel

>
> Best Regards
>
> > Cheers, Daniel
> >
> > > ---
> > >  drivers/gpu/drm/drm_vblank.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblan=
k.c
> > > index 98e091175921..80f5a3bb427e 100644
> > > --- a/drivers/gpu/drm/drm_vblank.c
> > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > @@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *=
dev, void *data,
> > >     unsigned int flags, pipe, high_pipe;
> > >
> > >     if (!dev->irq_enabled)
> > > -           return -EINVAL;
> > > +           return -EOPNOTSUPP;
> > >
> > >     if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > > -           return -EINVAL;
> > > +           return -EOPNOTSUPP;
> > >
> > >     if (vblwait->request.type &
> > >         ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> > > --
> > > 2.19.1
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
> https://twitter.com/siqueirajordao
> Graduate Student
> Department of Computer Science
> University of S=C3=A3o Paulo
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
