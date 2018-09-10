Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BBEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDA220833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aR1xp6l6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDA220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbeIJTS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:18:57 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:32856 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeIJTS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:18:57 -0400
Received: by mail-ua1-f68.google.com with SMTP id i4-v6so17521189uak.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CVxtbyv1lsxbgfGIveYFgHaTxuUQzigPQSvJIX/mXsk=;
        b=aR1xp6l60Zty8Vrm0hbPLW0ksMoi9YFuFhg4GsEwHM9R10JNGasyuoxvU7mN19S+fU
         bOx2iMb3y7yfHLto2aZdLTiv0+3Pl5Zhs2usu3tmi9hqVFj0P5ExTFjxBmwRrhdfrKCB
         25ycdnK1Vja5PgiwfQlBqM4yC5krco+2sSUjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CVxtbyv1lsxbgfGIveYFgHaTxuUQzigPQSvJIX/mXsk=;
        b=b2tCpAqnM8pXhqjVQpyF4WvyZnIrmrt6aps1TxEx6BSjMPUphejdhYu/gwjKB3HXAQ
         YmTXWsj6MqzD7umrbmJ3TfYspVWNmaMFIgeZ8ExHVrmkdiLcS8Jg19hLLt3oAA1bO5vt
         AFeepNImT9YV4TQ0m+VEMH8Gi5E3Zwha9ctz+ductj4GBJF4GrXYnxztOVTf+HziWBpI
         O2gl6gUT7wzY2Qgd8FPt3d3zdA787LXYfztmpK5Qhc+gOrmYJQL56RrCDAEbwsWoJ8OH
         UqoQjhmnaUUz9AtdZS1/YRM32dC0h3+SoY9EGCHHBV+uO+pSbuENWUr2cRSX1KWlmrsp
         MKxg==
X-Gm-Message-State: APzg51AwKXb12FlEUKFQuo1O04nPFZWJkWmyqQGF5/FyTXPWiQL6Hdd+
        0LrZo93Vb1QXXQMIgIOxd660zMn15B4=
X-Google-Smtp-Source: ANB0VdZIJ512QRvBbjV3Tbj+3JfbbeBHXysbhuAfgMtdCxYvtD+tIXQsqJjU/iEzg1dTgPuCpwbgVg==
X-Received: by 2002:a67:5e82:: with SMTP id s124-v6mr3511083vsb.105.1536589475430;
        Mon, 10 Sep 2018 07:24:35 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id j75-v6sm3510050vke.27.2018.09.10.07.24.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 07:24:34 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id m26-v6so17520771uap.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:24:34 -0700 (PDT)
X-Received: by 2002:ab0:4c6c:: with SMTP id d44-v6mr7162423uag.102.1536589473399;
 Mon, 10 Sep 2018 07:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180420115001.161745-1-lndmrk@chromium.org> <20180528142711.142466-1-lndmrk@chromium.org>
In-Reply-To: <20180528142711.142466-1-lndmrk@chromium.org>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Mon, 10 Sep 2018 10:23:53 -0400
X-Gmail-Original-Message-ID: <CAOw6vb+3Y5bL+P8VqFuCmkpPYyySBtMzXc2dUOS88Hqz_8-B6g@mail.gmail.com>
Message-ID: <CAOw6vb+3Y5bL+P8VqFuCmkpPYyySBtMzXc2dUOS88Hqz_8-B6g@mail.gmail.com>
Subject: Re: [PATCH v2] drm: udl: Destroy framebuffer only if it was initialized
To:     lndmrk@chromium.org
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <stephane.marchesin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 10:27 AM Emil Lundmark <lndmrk@chromium.org> wrote:
>
> This fixes a NULL pointer dereference that can happen if the UDL
> driver is unloaded before the framebuffer is initialized. This can
> happen e.g. if the USB device is unplugged right after it was plugged
> in.
>
> As explained by St=C3=A9phane Marchesin:
>
> It happens when fbdev is disabled (which is the case for Chrome OS).
> Even though intialization of the fbdev part is optional (it's done in
> udlfb_create which is the callback for fb_probe()), the teardown isn't
> optional (udl_driver_unload -> udl_fbdev_cleanup ->
> udl_fbdev_destroy).
>
> Note that udl_fbdev_cleanup *tries* to be conditional (you can see it
> does if (!udl->fbdev)) but that doesn't work, because udl->fbdev is
> always set during udl_fbdev_init.
>
> Suggested-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Emil Lundmark <lndmrk@chromium.org>

Many apologies, Emil, I completely dropped the ball on this one. I've
just applied it to -misc-fixes.

Sean


> ---
> Changes in v2:
> - Updated commit message with explanation from St=C3=A9phane Marchesin
>
>  drivers/gpu/drm/udl/udl_fb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
> index 2ebdc6d5a76e..5754e37f741b 100644
> --- a/drivers/gpu/drm/udl/udl_fb.c
> +++ b/drivers/gpu/drm/udl/udl_fb.c
> @@ -426,9 +426,11 @@ static void udl_fbdev_destroy(struct drm_device *dev=
,
>  {
>         drm_fb_helper_unregister_fbi(&ufbdev->helper);
>         drm_fb_helper_fini(&ufbdev->helper);
> -       drm_framebuffer_unregister_private(&ufbdev->ufb.base);
> -       drm_framebuffer_cleanup(&ufbdev->ufb.base);
> -       drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
> +       if (ufbdev->ufb.obj) {
> +               drm_framebuffer_unregister_private(&ufbdev->ufb.base);
> +               drm_framebuffer_cleanup(&ufbdev->ufb.base);
> +               drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
> +       }
>  }
>
>  int udl_fbdev_init(struct drm_device *dev)
> --
> 2.17.0.921.gf22659ad46-goog
>
