Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B27C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB567222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BJxmEkrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfBOThW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:37:22 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40361 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbfBOThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:37:21 -0500
Received: by mail-it1-f195.google.com with SMTP id i2so26084697ite.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOSC8ZzkPCXB6WyoycrO9I7WjBSurknF8CSDyuQMuwQ=;
        b=BJxmEkrKTtLBxqiiTZTRpxbFj2xyLTKbacgro11C4Az8g6PqUfCPE6CF+pLWKWSuCj
         YLA8+2qWfO0d1ctKZDB8Pn8wIDyAb3mTs2Wq+W8RJDXmXveKfKz5Ts6ARAUgay5WGSWD
         Q+foTz6lzgWxhDNHg/RooLL2k84x/LiOTLyT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOSC8ZzkPCXB6WyoycrO9I7WjBSurknF8CSDyuQMuwQ=;
        b=ZGwIwS4INhd+Ev31j/5mZ0WCDci2jkaiVGvw+BS9yI3mrnXyJDtdp6lUEVi4C8dndB
         Kllpivuva5+N0xvabXLktDB1Y8YxwOdMaruyXC0hfK96YLE5WSk1CzH97iEoN4m2WF16
         TKLjmQcIfF++tXhIG012olkAQTp3sFyV7O1uUKg4hIu2e36ZuLKTYFDVphCLOc+GQ62k
         6c6OKhuz4XZrJejOeOelhMUy8UrGtmVIsc1LETSpO5OYfwbpnJnt4RbFPEsqGzE0/tEv
         nvFa0PpdAWqIjsGiOIIjpcqHwPiGz0wd8Wr3Ho4VXC6Pj1L6FhkN7pSTC4V34AczpGSz
         XKEQ==
X-Gm-Message-State: AHQUAubglOLy2yr0B1S8p3KzNRY0d9WLd0z+6ho6otTAewK3DmzLvZ32
        vkTD/V+SuRSiX3gMnywdWSNb7dAMp9gVnIP/hq7hAw==
X-Google-Smtp-Source: AHgI3IYTObnlggwGkTQ2WRCe9gBMEsne4EQK/lC5WAFH1qcM9/jUub3W+2pb7FqZ30CUIWXx2uIZTMtxqfsSJB4Qis4=
X-Received: by 2002:a6b:b790:: with SMTP id h138mr6264910iof.114.1550259440391;
 Fri, 15 Feb 2019 11:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20190214192544.7314-1-jagan@amarulasolutions.com> <20190214192544.7314-8-jagan@amarulasolutions.com>
In-Reply-To: <20190214192544.7314-8-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 16 Feb 2019 01:07:08 +0530
Message-ID: <CAMty3ZDqnVBkcT5kiKf-pKGccEuQR0xtBXBgB2-_XFXkRKi+_A@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] drm/sun4i: sun6i_mipi_dsi: Refactor vertical video
 start delay
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 12:56 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Vertical video start delay is computed by excluding vertical porch
> value from total vertical timings, but the current driver excluding
> vertical porch along with vertical sync values from total vertical
> timings resulting wrong start delay.
>
> This patch trying to update the video start delay by subtracting
> vertical porch from vertical total, on the other hand it added 1
> extra start_delay line for TCON based on the Allwinner BSP reference.
>
> BSP code form BPI-M64-bsp is computing video start delay as
> (from linux-sunxi/
> drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
>
> u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
>    - panel->lcd_y - (panel->lcd_vbp)
> => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
>                              - panel->lcd_y - panel->lcd_vbp
> => timmings->ver_front_porch
>
> So, update the start delay computation accordingly.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index a08dfdcbe9e8..31cf9c58e98d 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -358,7 +358,24 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
>  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
>                                            struct drm_display_mode *mode)
>  {
> -       return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
> +       u32 vfp, start_delay;
> +
> +       /* vertical front porch */
> +       vfp = mode->vsync_start - mode->vdisplay;
> +
> +       /* start_delay = vertical total - vertical front porch */
> +       start_delay = mode->vtotal - vfp;
> +
> +       /* add extra 1 delay line for TCON, as per Allwinner BSP */
> +       start_delay = 1;

This has to be += 1;

Typo change while re-basing, I will fix this in next version.
