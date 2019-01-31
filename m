Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C35CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C660620B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="askHYVdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfAaUH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:07:26 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45026 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfAaUHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:07:25 -0500
Received: by mail-yb1-f195.google.com with SMTP id k189so1815696yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 12:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JqGyq9owmf0ny2t5ItEDue6rqJ3d7AFmxUpUgXeaeQE=;
        b=askHYVdzGJrAKR3bRpLPDCZ3CNGfRDxDfJCDDcS18y7MDeI8irtKLUAhIUYc10x71J
         CEB9JI3THJ/SSP89xWonUeEciauPfWPkeYjfKc8ymUTBZp/e2uFAhBqciFg1e19Xyl88
         wkHEF/37BaFzLJ/QPM7o0xd0WdnvxLI0ANfhdK3POkYtvgM4gK2U5iaC5/t3lb1hK0ql
         eoc9GixdjpMVYCvPfnjTbsVqJQvdlDeFzcPXelEWxd8fjQfhDDpcOwYuCDNYmkWjzBEr
         0p/TBiGt+qDO7W6cT6a4Itc8LkkYf0MaDrkF0J6BWzsUwEOaaFbBUuJonCXG/Y5ebkTO
         ll9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JqGyq9owmf0ny2t5ItEDue6rqJ3d7AFmxUpUgXeaeQE=;
        b=b7z+YIzAd8md8Skya61Z7m3ryIaORzqFsA1qntn/yHlqFENFW1lCcFlzSiTgn6C+QU
         VZkmtKdaP95odpjFXhCO1OjMvHecdJW6EoP9rRLxIgxpA9wwUI9NcHQPYzEaoIeviPq7
         t09HQuXzWUyS54wk0aWNFcE8EMPPQfja+LVI/eLUEyiFlCC3fkB6s37mnCmKcnO7niyo
         PgNTMsd0+p/1PpZXvYsDo4y+y3UM9DjFllVVo+Z2sBiQ4NVs0hixO3CkV6VWqW6KP/Vn
         YnnaNLAXiwE31QjmveIxMmENxRlOOh356Zo8zGKJRKtAKBP6xQNOelgbAFz93k7Ch3fe
         zxTA==
X-Gm-Message-State: AJcUukczKvZZMO5pwXJwOK15+CIHlZJJ8FgqmfXGW+CnNYCpvS90BoXu
        UU+6uuflLmDbWAF+y+uPuiYo4w==
X-Google-Smtp-Source: ALg8bN4QrI6MJLJG/DS5/IaToN8RlQ646LcKYCeIZy/g9TnEW3TULyRoZ1112/OmOBxnVvwsvRliVA==
X-Received: by 2002:a25:a3c1:: with SMTP id e59mr34209373ybi.96.1548965244384;
        Thu, 31 Jan 2019 12:07:24 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id b144sm3297343ywa.33.2019.01.31.12.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 12:07:23 -0800 (PST)
Date:   Thu, 31 Jan 2019 15:07:23 -0500
From:   Sean Paul <sean@poorly.run>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/19] drm/panel: drmP.h removal and DRM_DEV*
Message-ID: <20190131200723.GZ114153@art_vandelay>
References: <20190131192619.9763-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131192619.9763-1-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 08:26:00PM +0100, Sam Ravnborg wrote:
> Hi Thierry et al.
> 
> While reviewing a number of new panel drivers there was a
> certain pattern in the feedback:
> - the now deprecated drmP.h file was used
> - dev_err() and friends was used
> 
> This patch-set address the above items in the panel
> drivers in drm/panel/
> The hope is that new panel drivers will no longer inherit bad
> patterns from the existing drivers.
> 
> The use of DRM_DEV* is not accepted by everyone, so this conversion
> was split up in smaller bits.
> If some drivers do not want to use DRM_DEV* then just drop the relevant patch.
> 
> All patches are build tested on x86/arm.
> 
> The DRM_DEV* patches depends on the drmP.h removal.
> 
> One extra patch sneaked in "panel-innolux: drop unused variable"
> This is a fix for an unused variable and was added to flush my panel patches.
> 
> Note: Waiting for key storage (for gpg key) before I start the process getting
> commit rights, so I rely on someone else (Thierry?) to commit this.
> 
> Patches are made on top of drm-misc-next as of a few days ago.
> 
> Comments welcome!

Hey Sam,
Thanks for the patchset, this will make dmesg grepping easier! One comment, and
you're going to hate me for it: Why use DRM_DEV* instead of DRM_*?

When I introduced DRM_DEV, it was to cover the case where there are multiple
instances of the same driver (ie: dual-channel mipi, multiple crtcs, etc). I
suppose that _could_ happen in the panel space, but it seems more unlikely than
not.

It's quite possible I'm overthinking this, but just something I figured I would
point out. Either way, I think this is an improvement over dev_*.

Sean

> 
> 	Sam
> 
> Sam Ravnborg (19):
>       drm/panel: drop drmP.h usage
>       drm/panel: panel-innolux: drop unused variable
>       drm/panel: samsung: use DRM_DEV*
>       drm/panel: arm-versatile: use DRM_DEV*
>       drm/panel: truly: use DRM_DEV*
>       drm/panel: sitronix: use DRM_DEV*
>       drm/panel: ilitek: use DRM_DEV*
>       drm/panel: innolux: use DRM_DEV*
>       drm/panel: jdi: use DRM_DEV*
>       drm/panel: lg: use DRM_DEV*
>       drm/panel: lvds: use DRM_DEV*
>       drm/panel: olimex: use DRM_DEV*
>       drm/panel: orisetech: use DRM_DEV*
>       drm/panel: panasonic: use DRM_DEV*
>       drm/panel: raspberrypi: use DRM_DEV*
>       drm/panel: raydium: use DRM_DEV*
>       drm/panel: seiko: use DRM_DEV*
>       drm/panel: sharp: use DRM_DEV*
>       drm/panel: simple: use DRM_DEV*
> 
>  drivers/gpu/drm/panel/panel-arm-versatile.c        | 21 +++--
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c       | 97 ++++++++++++----------
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      | 14 ++--
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c      | 17 ++--
>  drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     | 66 ++++++++-------
>  drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c |  4 +-
>  drivers/gpu/drm/panel/panel-lg-lg4573.c            | 25 +++---
>  drivers/gpu/drm/panel/panel-lvds.c                 | 39 +++++----
>  drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c | 28 ++++---
>  drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   | 15 ++--
>  .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   | 19 +++--
>  .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  | 25 +++---
>  drivers/gpu/drm/panel/panel-raydium-rm68200.c      | 11 ++-
>  drivers/gpu/drm/panel/panel-samsung-ld9040.c       | 18 ++--
>  drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      | 21 +++--
>  drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   | 15 ++--
>  drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      | 32 ++++---
>  drivers/gpu/drm/panel/panel-seiko-43wvf1g.c        | 18 ++--
>  drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c    | 66 ++++++++++-----
>  drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    | 27 +++---
>  drivers/gpu/drm/panel/panel-simple.c               | 22 +++--
>  drivers/gpu/drm/panel/panel-sitronix-st7789v.c     | 16 ++--
>  drivers/gpu/drm/panel/panel-truly-nt35597.c        | 10 ++-
>  23 files changed, 375 insertions(+), 251 deletions(-)

-- 
Sean Paul, Software Engineer, Google / Chromium OS
