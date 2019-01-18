Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF98DC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8750320850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GTAvFPi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfARR6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:58:50 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38550 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfARR6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:58:50 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so8923686vsa.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbCm6Mjj+UOtI0js0KK3dAUMBdnMCn4ezggwRW382+A=;
        b=GTAvFPi0ABVBqlEqD+0tLwUNpHh+hRPu/bBtIH2iMnc6AuTFMqNT6ObwbTHVnvWnK9
         RV5X4xZ6OgzTcAOOvRAsR/0wU3IS31Q/XKNvMBcP40bM4m71a0HYqsu86iW5y6w24F3Q
         9QEhpF6KtOCZgkSKune1Jb+APVU1/5ycTrcAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbCm6Mjj+UOtI0js0KK3dAUMBdnMCn4ezggwRW382+A=;
        b=Lvf1MtK5ava4/SZV4ayFQipNOPgC+i/BRUfvfjKedXHSkfOFTQvyHma9g4z6C5ukVe
         ChgxUzhbr49oRdDUl/N0zwznmBHsZwvtTRtei+6pFHfJcnXviLeaqItUSTmOJFs/kS+t
         EfAVoPnrBSrowkc0+qay8vPwPaXKA5HkXaAgtoi5wOOV4O+8O+5/Aa7+vq5/c0eQ3Yjg
         gFGvKUj/rc+Ta4obESCHj/OxlVCJVF/SxIfJU4zAnvrvadYmiCx0+HqR8vtTuomuGD1u
         4I1L+/1G+4Xw5UUvlgbYixED5E0uM84SPZPzXb040VoNro9kS55ur3D04IHMmZ/gUBEZ
         eGjQ==
X-Gm-Message-State: AJcUukczq3luCGWwclkIFrGTNPuJuC1cXQ1iTJUzwuyICNTADiVxjYHp
        0ecvymK3E9/S9qIkHJ+ucok5qXfZPkQ=
X-Google-Smtp-Source: ALg8bN6i7Xa0cxucxQ0pKKgR+yLFJmM2QeWRZO6koJzfox5U14In22Zv7mp4X3iqYtV7jkoCCJdyWg==
X-Received: by 2002:a67:79d2:: with SMTP id u201mr8422188vsc.12.1547834328657;
        Fri, 18 Jan 2019 09:58:48 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id t133sm7094086vsc.8.2019.01.18.09.58.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:58:47 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id b74so8909906vsd.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:58:47 -0800 (PST)
X-Received: by 2002:a67:efd1:: with SMTP id s17mr8491468vsp.119.1547834326871;
 Fri, 18 Jan 2019 09:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20190109065922.231753-1-hsinyi@chromium.org>
In-Reply-To: <20190109065922.231753-1-hsinyi@chromium.org>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Fri, 18 Jan 2019 12:58:10 -0500
X-Gmail-Original-Message-ID: <CAOw6vb+a2SAq+=xfL9RZyA6R7zn-HYFQbDnDaK28TD8yrh+wLg@mail.gmail.com>
Message-ID: <CAOw6vb+a2SAq+=xfL9RZyA6R7zn-HYFQbDnDaK28TD8yrh+wLg@mail.gmail.com>
Subject: Re: [PATCH resend] drm/panel: panel-innolux: set display off in innolux_panel_unprepare
To:     "Hsin-Yi, Wang" <hsinyi@chromium.org>
Cc:     Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 1:59 AM Hsin-Yi, Wang <hsinyi@chromium.org> wrote:
>
> Move mipi_dsi_dcs_set_display_off() from innolux_panel_disable()
> to innolux_panel_unprepare(), so they are consistent with
> innolux_panel_enable() and innolux_panel_prepare().
>
> This also fixes some mode check and irq timeout issue in MTK dsi code.
>
> Since some dsi code (e.g. mtk_dsi) have following call trace:
> 1. drm_panel_disable(), which calls innolux_panel_disable()
> 2. switch to cmd mode
> 3. drm_panel_unprepare(), which calls innolux_panel_unprepare()
>
> However, mtk_dsi needs to be in cmd mode to be able to send commands
> (e.g. mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_enter_sleep_mode()),
> so we need these functions to be called after the switch to cmd mode happens,
> i.e. in innolux_panel_unprepare.
>
>
> Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
> Resend for review.
> ---
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> index ca4ae45dd307..8e5724b63f1f 100644
> --- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> +++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> @@ -70,18 +70,12 @@ static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
>  static int innolux_panel_disable(struct drm_panel *panel)
>  {
>         struct innolux_panel *innolux = to_innolux_panel(panel);
> -       int err;
>
>         if (!innolux->enabled)
>                 return 0;
>
>         backlight_disable(innolux->backlight);
>
> -       err = mipi_dsi_dcs_set_display_off(innolux->link);
> -       if (err < 0)
> -               DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> -                             err);
> -
>         innolux->enabled = false;
>
>         return 0;
> @@ -95,6 +89,11 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
>         if (!innolux->prepared)
>                 return 0;
>
> +       err = mipi_dsi_dcs_set_display_off(innolux->link);
> +       if (err < 0)
> +               DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> +                             err);
> +
>         err = mipi_dsi_dcs_enter_sleep_mode(innolux->link);
>         if (err < 0) {
>                 DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
> --
> 2.18.1
>
