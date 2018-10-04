Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CBFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB5121477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ao3s0ptD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB5121477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeJDOkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:40:51 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34817 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJDOku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:40:50 -0400
Received: by mail-it1-f193.google.com with SMTP id p64-v6so12755596itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0RbPPS41UBtnDiTizk30rV9eGDIxFo5uQbwUddljNHo=;
        b=ao3s0ptD16X43V5M5FejOr2IwxAGlJ+IbJtdJaPIAhvZcXrHNr8H+l2UrN1TPPHz18
         FZBZWgj2P7sZ8/A1v/lphgMiVD2awEAANbreXkvErsv2scL6ZilzwxH1j9AhEpYkRM0y
         DoUTCR5SxdwhLEh8nIwmGrbEs2QgJRNypmKjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0RbPPS41UBtnDiTizk30rV9eGDIxFo5uQbwUddljNHo=;
        b=eCuvVwLRZBtzt1M81SV2eETQefzIT1n43ZGvjYHqS/uzkvds+zamGRWYx3oKxW7F4Y
         IIN5ZDmFcKQqub5Eppv1W/3lB/wJBAbU7jODQQAumSRjF47GC2h0LP0AnN3NKqCs7WEJ
         01UMpREYr46mhcMkOJXw7jomYSfnXxcshxFEH1IR69zAspE3CYzhYewt8NnL9jJ8RHgM
         YOsoJPfQliUraLE9Lk5A1eVubbKWqDrxoC5KeAoIJfUIvbAjFzhi543s3ev07j6NYhw2
         6nD93tmu9TdyOEm2h1W/Ou+CL19VkBjvKh4KsDj+oP8HtmAUFPruFLWMXM7/6ACKG5Qb
         xHUw==
X-Gm-Message-State: ABuFfoje81NcBWv3YmHwFTTNdzlaawE9sRqHeMgfV7sKGglzf9l11Kqq
        DOM6+sGLyBBhtK8eGDjWMcdkJFHq/MqTXbbEE8JNvQ==
X-Google-Smtp-Source: ACcGV63ox2kwQ37szmB3wy/r4dwitJQuTen2VO5y0zUwv8btrIKNJaAtWrWV2ge0FpmNjHV7X0Gq5cflb00xpCfQQUI=
X-Received: by 2002:a24:d857:: with SMTP id b84-v6mr4465468itg.77.1538639333098;
 Thu, 04 Oct 2018 00:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181002205836.2323084-1-arnd@arndb.de> <123f7e1c-8f2b-5797-de16-650ec01d0b24@tronnes.org>
 <20181003161326.GD31561@phenom.ffwll.local> <CAK8P3a1gKxXEthLvUxSxOrt6+1qzZE9Jba+vH_qFepv3KXba9g@mail.gmail.com>
In-Reply-To: <CAK8P3a1gKxXEthLvUxSxOrt6+1qzZE9Jba+vH_qFepv3KXba9g@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 4 Oct 2018 09:48:41 +0200
Message-ID: <CAKMK7uFn=u+04=HQvzkSNdE8_9p=3eX14-h=0nOJ7QKPJSrdmw@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: move 'legacyfb_depth' definition out of #ifdef
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dave Airlie <airlied@linux.ie>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 9:51 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Oct 3, 2018 at 6:13 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Oct 03, 2018 at 05:49:32PM +0200, Noralf Tr=C3=B8nnes wrote:
> > >
> > >
> > > Den 02.10.2018 22.58, skrev Arnd Bergmann:
> > > > The variable is now referenced unconditionally, but still
> > > > declared in an #ifdef:
> > > >
> > > > drivers/gpu/drm/imx/imx-drm-core.c: In function 'imx_drm_bind':
> > > > drivers/gpu/drm/imx/imx-drm-core.c:264:6: error: 'legacyfb_depth' u=
ndeclared (first use in this function); did you mean 'lockdep_depth'?
> > > >
> > > > Remove the #ifdef so it can always be accessed.
> > > >
> > > > Fixes: f53705fd9803 ("drm/imx: Use drm_fbdev_generic_setup()")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > >
> > > I've already applied the previous one you sent:
> > > https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D064b06bbf117f8=
b5e64a5143e970d5a1cf602fd6
> > >
> > > Not sure when it reaches linux-next now that we are past rc6.
> >
> > Only once we're past -rc1.
>
> Can we revert f53705fd9803 in linux-next then to prevent the regression f=
rom
> making it into 4.20?

Probably simpler to cherry pick the fix from drm-misc-next to
drm-misc-next-fixes. Noralf, can you pls do that?

Thanks, Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
