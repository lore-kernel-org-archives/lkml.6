Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DEBC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE9D20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Whrgcppt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE9D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeFTJSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:18:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50394 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbeFTJRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:17:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so4797690wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sqkIlXndxs3O1MWutX6a2+i4Okp1YoZBFCnTYsNDi7A=;
        b=Whrgcppt2PrRTrTjgnRQf2ngQEsfp6jxKvl0BL8OfmQvoU+i96po3xu8VQY6lqLwg5
         roFtBhXi53H3Pygo8bJUsC3bHs5bdUHwj3zkj3hoRZThL9KF+bOm1UohPoOiKnZ5Sp6V
         JvDvkY1FD1GrGubnZpiknUJw0IgBTljm25tM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sqkIlXndxs3O1MWutX6a2+i4Okp1YoZBFCnTYsNDi7A=;
        b=VF0Tt85Txkpzw44WTCfdREs9nAlWwgOVtgf1xw0yHVHvoOsg1C9yo41CknJ4z12alU
         jPVbBEWGdVDF+z13N2Ab5bZfO67u3ujA4Sp+A5IbCaP0RPejRBqiG99QuSmHumGM2jUC
         eDw/a7fkSt7uLwT9lhjWyjgmHUT3xIcop3MnWxTFAb5zgOcEF8mA4ReaPlaryada1CNw
         YVjtw0JZbyuGWVogilgvWnDdiHgUE4uAfnCUzKNej6sOy155q7fNHWTw2v+gYWmfS+U9
         X7FXWuSzOY/ZIWwAVnMJDlR0HcVX+mOgXYgggYWB0sR3//rjMOntZnYZ0YudP1YxuqAa
         xOrg==
X-Gm-Message-State: APt69E0PAXxjwivTr112LvAYlbjF0W5B5newDtoJ6Kg3p3et3kSCxAD8
        TR1pr+0j2g2by9XPQYNsd9+BK7xS
X-Google-Smtp-Source: ADUXVKKF1NxRYIjn5lU6Tg5RMJeZ+ktLq/TstszHW5P/+YkWn7Bf1tY3ytkwqDE102GsXoA8+uqbWA==
X-Received: by 2002:aa7:c486:: with SMTP id m6-v6mr17985488edq.266.1529486273154;
        Wed, 20 Jun 2018 02:17:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:9802:bb08:74d1:12e1])
        by smtp.gmail.com with ESMTPSA id 2-v6sm1058119edz.67.2018.06.20.02.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 02:17:52 -0700 (PDT)
Date:   Wed, 20 Jun 2018 11:17:50 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alexandru Gheorghe <Alexandru_Gheorghe@mentor.com>,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-media@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] drm: Add generic colorkey properties
Message-ID: <20180620091750.GD7186@phenom.ffwll.local>
Mail-Followup-To: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alexandru Gheorghe <Alexandru_Gheorghe@mentor.com>,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-media@vger.kernel.org
References: <20180526155623.12610-1-digetx@gmail.com>
 <20180526155623.12610-2-digetx@gmail.com>
 <20180528131501.GK23723@intel.com>
 <efba1801-5b00-1fa1-45df-a5d3a2e3d63a@gmail.com>
 <20180529071103.GL23723@intel.com>
 <20180619174011.GJ17671@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180619174011.GJ17671@n2100.armlinux.org.uk>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 06:40:12PM +0100, Russell King - ARM Linux wrote:
> On Tue, May 29, 2018 at 10:11:03AM +0300, Ville Syrjälä wrote:
> > On Tue, May 29, 2018 at 02:48:22AM +0300, Dmitry Osipenko wrote:
> > > Though maybe "color components replacement" and "replacement with a complete
> > > transparency" could be factored out into a specific color keying modes.
> > 
> > Yes. I've never seen those in any hardware. In fact I'm wondering where
> > is the userspace for all these complex modes? Ie. should we even bother
> > with them at this time?
> 
> Such hardware does exist - here's what Armada 510 supports (and is
> supported via armada-drm):
> 
> Color Key Mode
> 0 = Disable: Disable color key function.
> 1 = EnableY: Video Y color key is enabled.
> 2 = EnableU: Video U color key is enabled.
> 3 = EnableRGB: Graphic RGB color key is enabled.
> 4 = EnableV: Video V color key is enabled.
> 5 = EnableR: Graphic R color key is enabled.
> 6 = EnableG: Graphic G color key is enabled.
> 7 = EnableB: Graphic B color key is enabled.
> 
> The description of how the colour keying works isn't particularly good,
> which is rather unfortunate, but basically, there's three 32-bit
> registers named LCD_SPU_COLORKEY_Y, LCD_SPU_COLORKEY_U and
> LCD_SPU_COLORKEY_V.
> 
> When a graphic mode is selected, then:
>  LCD_SPU_COLORKEY_Y is the R or B component depending on the red/blue swap
>  LCD_SPU_COLORKEY_U is the G component
>  LCD_SPU_COLORKEY_V is the B or R component according to the swap
> 
> 31:24 is the high bound for the component (inclusive)
> 23:16 is the low bound for the component (inclusive)
> 15:8  is the replacement value for the component
>  7:0  is the alpha value - seems to only be for LCD_SPU_COLORKEY_Y and
> 	ignored in the other registers when in RGB mode, but I've not
> 	fully tested this.  I suspect it's used with the single-channel
> 	colour keying modes.
> 
> The colour key stage provides an alpha value to the next stage - which
> is alpha blending between the graphic (primary) plane and video
> (overlay) plane.  Zero gives overlay only, 255 gives graphic only.
> 
> So, it's possible to use an 0x0101fe (RGB) colour key, and have it
> appear as "black" on the screen if you disable the overlay plane,
> rather than the unsightly bright blue.
> 
> One point to make though is about what userspace expects _today_ from
> overlay.  VLC, for example, expects overlay to be colour keyed, so it
> can display its full-screen controller when the user moves the mouse.
> I don't believe it explicitly sets up colour keying, but just expects
> it to be there and functional.  It _is_ rather necessary when you
> consider that overlay via the Xvideo extension is supposed to be
> "drawn" into the specified drawable, which may be a mapped window
> partially obscured by other mapped windows.
> 
> Maybe if the kernel DRM components doesn't want to do that, it'd be
> something that an Xorg DDX would have to default-enable to ensure
> that existing applications and expected Xorg behaviour doesn't break.

Yes -modesetting (or whichever other driver) would need to set up the
properties correctly for Xvideo color keying. Since default assumption for
all other (generic) compositors is that planes won't do any color keying
in the boot-up state.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
