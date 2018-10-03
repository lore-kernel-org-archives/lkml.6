Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4977C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963FD213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963FD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeJCQbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:31:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40861 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeJCQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:31:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id j62-v6so4717515edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 02:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rd4sANpTizAb/5FOdSl0MGyVOfOwV9/0FzJKj4bOhV4=;
        b=dPdumNiLBlXS7oh+32P7lfmMhQi72GNzJVjrL38Ie7x+cwXI/JfX4tovVObYcFy4AC
         L1muk/388DLE4gjqCT/sdZQtkKn098UGLMFkpgrB/tFFTNtCRFPCI8P8ujgLTmR1TyEd
         6COngJmaEWUMOmXnevWvDpMyoZDV93C3Sk6HynOTJZH8YhNTo9a3tXnAYOP6Lx3tk7gT
         VAnVg1f8E8jB3A0OXcUCyEAzWu0k5n6/7E3ro5qsDMSRTm9jFMLR6cWR76uPI6UxqrxG
         i8TeR3CscbEwresYGAHgcgFON/RQrmDthFte9wPQc+k8iYHnT1eMJyjxA2mA7F1IDcnj
         2tzA==
X-Gm-Message-State: ABuFfojK/UeVyTrEQlg4jN2U4Vh6kUYM/KT32WEyCEWlaAc9JOcu5nAP
        oX82UK3IN9inShsuaxvVnVXbH4udw20=
X-Google-Smtp-Source: ACcGV60DuIynhq0KsSvzmCdtCH6d8LRynpyEPURezxwhN+LZeRpy7F8TiIqkBLal7FQ0YfhA2QIbbA==
X-Received: by 2002:a17:906:2da9:: with SMTP id g9-v6mr1032812eji.67.1538559806052;
        Wed, 03 Oct 2018 02:43:26 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id p13-v6sm197841ejg.42.2018.10.03.02.43.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 02:43:25 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 143-v6so5016304wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 02:43:25 -0700 (PDT)
X-Received: by 2002:a1c:1d6:: with SMTP id 205-v6mr861846wmb.151.1538559805143;
 Wed, 03 Oct 2018 02:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181001093612.GA13672@mwanda> <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
In-Reply-To: <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 3 Oct 2018 17:43:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v64z+j=ywU8n210Zw+97n=Ff4rVdUwNR9nbKO-hMD3nJcQ@mail.gmail.com>
Message-ID: <CAGb2v64z+j=ywU8n210Zw+97n=Ff4rVdUwNR9nbKO-hMD3nJcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/sun4i: tcon: fix check of tcon->panel null pointer
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 5:59 AM Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
>
> At the moment, the check of tcon->panel to be valid is wrong. IS_ERR()
> has been used, but that macro doesn't check if tcon->panel pointer is
> null or not, but check if tcon->panel is between -1 and -4095(MAX_ERRNO).
>
> Remove IS_ERR() from tcon->panel checking and let "if (tcon->panel)" as
> condition to check if it's a pointer not null.

There's actually more than one occurance of this error:

drivers/gpu/drm/sun4i/sun4i_lvds.c:     if (!IS_ERR(tcon->panel)) {
drivers/gpu/drm/sun4i/sun4i_lvds.c:     if (!IS_ERR(tcon->panel)) {
drivers/gpu/drm/sun4i/sun4i_rgb.c:      if (!IS_ERR(tcon->panel)) {
drivers/gpu/drm/sun4i/sun4i_rgb.c:      if (!IS_ERR(tcon->panel)) {

These four are responsible for enabling and disabling the panel.

drivers/gpu/drm/sun4i/sun4i_tcon.c:     if (!IS_ERR(tcon->panel)) {

All this looks like it was left over from commit ebc9446135671 ("drm: convert
drivers to use drm_of_find_panel_or_bridge"). We have checks against tcon->panel
in several places and not all of them were converted.

ChenYu

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index c78cd35a1294..e4b3bd0307ef 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -555,7 +555,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>          * Following code is a way to avoid quirks all around TCON
>          * and DOTCLOCK drivers.
>          */
> -       if (!IS_ERR(tcon->panel)) {
> +       if (tcon->panel) {
>                 struct drm_panel *panel = tcon->panel;
>                 struct drm_connector *connector = panel->connector;
>                 struct drm_display_info display_info = connector->display_info;
> --
> 2.17.1
>
