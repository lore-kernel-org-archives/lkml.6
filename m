Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC4DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1369920869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FrIGheyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1369920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbeKFUh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:37:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36676 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:37:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id x2-v6so10155916eds.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 03:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wI+hRQrHO6ppi4lNw20EE6k+GMmoTPE9RhuGCgvInyw=;
        b=FrIGheyqOMf040ZcQZMYzCPbbGQPxo5wOgNpV6A2saoSRjLDMtnOGdvU6RugLE/w7e
         DV922lHE2eZVpIvGk1EGcyQai7uh5n6kU50yosNnQ4sORI6kF+XWu8jdgzeNhAtqNJ9X
         OQ3gTGFr54fxyozYtbW+q22fe5YqcgD7k0Lz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=wI+hRQrHO6ppi4lNw20EE6k+GMmoTPE9RhuGCgvInyw=;
        b=PFwRhss6QF4ncCmZvkROGRrQFO/mawhv4GaevLmOopHqkvxeuoZYScw481nY1IYDTg
         4yIGTGZxXmdOySmiCGPE71PXWfc4lLI9sm/WI9I+4iDv4P7Jbcjn1fcpxSzyIoKlaY2p
         LtqXXKpzAPPLmSdQNgQ3yFt/WXW8jQhzb2zOtJIA4NehsogGqwjPcpBz7ChOdFRofO1A
         fBFnRoRt85bKPGnqDgFdySRv+3QoD36q0Gq+wRacnoo0iPaF21PFkZvEmtcJV0iiNiCZ
         1Tro4vvN/GnRgMmJfcd3xc8hy7nO4E0O3d/ifODiWOu/7B5C4b6d8jf4vFYhPOdXqixW
         +F0A==
X-Gm-Message-State: AGRZ1gLt++NOFsg5gStGu1FhHUWYF7TDZ2LCssbRGbOzMY8F+lp6XStP
        c+hPNNVL4ye4ql00BGimb7Z7VQp8ACI=
X-Google-Smtp-Source: AJdET5d6G9P61X2nLvYe8ose+2BEUmG3pIpMaQKB9kWLnt1UmmHk5UWw/52qnxast0G8lbB8i14sMQ==
X-Received: by 2002:a50:8fa1:: with SMTP id y30-v6mr2667628edy.131.1541502793379;
        Tue, 06 Nov 2018 03:13:13 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x28-v6sm777253edx.1.2018.11.06.03.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 03:13:12 -0800 (PST)
Date:   Tue, 6 Nov 2018 12:13:10 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] drm/meson: Add support for Overlay and OSD Plane
 scaling
Message-ID: <20181106111310.GP21967@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 10:39:59AM +0100, Neil Armstrong wrote:
> This serie adds support for :
> - Overlay Plane blended with the primary plane, we can describe as "behind"
> - Primary Plane up-scaling up to 5x factor to support the OSD plane being
>   upscaled from 1920x1080 when the display mode is set as 3840x2160.
> 
> These patches depends on the "drm/meson: Allow using optional canvas provider"
> patchset from Maxime Jourdan at [1]
> 
> [1] https://patchwork.kernel.org/project/linux-amlogic/list/?series=38355
> 
> Neil Armstrong (3):
>   drm/meson: Support Overlay plane for video rendering
>   drm/meson: move OSD scaler management into plane atomic update
>   drm/meson: Add primary plane scaling

Got bored, read a bit your patch series. Two things I've noticed:
- We need to drop the crtc_state argument from
  drm_atomic_helper_check_plane_state(), some drivers (not meson) do
  really funny stuff with this.

- I think your osd1_commit = true update is racy with the interrupt
  handler checking it. Needs at least a few memory barriers. Since helpers
  guarantee that you can't overtake a preceending update (you do the
  vblank handling after the updating) that should be ok, except you arm
  the vblank before setting up registers, so this might race too.

Anyway all unrelated, so feel free to smash an

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

on the entire series.

Cheers, Daniel

> 
>  drivers/gpu/drm/meson/Makefile          |   2 +-
>  drivers/gpu/drm/meson/meson_canvas.c    |   7 +-
>  drivers/gpu/drm/meson/meson_canvas.h    |  11 +-
>  drivers/gpu/drm/meson/meson_crtc.c      | 251 +++++++++++++-
>  drivers/gpu/drm/meson/meson_drv.c       |  29 +-
>  drivers/gpu/drm/meson/meson_drv.h       |  62 ++++
>  drivers/gpu/drm/meson/meson_overlay.c   | 586 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/meson/meson_overlay.h   |  14 +
>  drivers/gpu/drm/meson/meson_plane.c     | 177 ++++++++--
>  drivers/gpu/drm/meson/meson_registers.h |   3 +
>  drivers/gpu/drm/meson/meson_viu.c       |  15 +
>  drivers/gpu/drm/meson/meson_vpp.c       |  90 +++--
>  12 files changed, 1156 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.c
>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.h
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
