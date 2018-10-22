Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179D4C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A1D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gPXr14jB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A1D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeJWFM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:12:56 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39956 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeJWFM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:12:56 -0400
Received: by mail-vs1-f65.google.com with SMTP id y195so14788668vsc.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsBrLalD4hq3yQ+n4ws2zMU0C5XNdPuOJLMsyH1hpbQ=;
        b=gPXr14jB+w1PtKI0gis5ErSWEoVQFnPJBlU0vMlxPvd3M/er0C+M9sa9IQR9Z6mjW6
         apAZekJ69HbI1oIE6lLtfmq7qYKuPgBs80WmgxBXs1PdnjhjAYihP3vrP7RtqkMznRjh
         UWu/wJT/AbMDIs84ZZbveG+kfrkWE+2XztzA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsBrLalD4hq3yQ+n4ws2zMU0C5XNdPuOJLMsyH1hpbQ=;
        b=aFdwMdmeU6NlRVRT2ARO64/0wOVhIMEV1b6amROHrQ4twCjMS3RCJR6M7ZCue4HSmC
         Kh76kcdzmjYiHv0a5JUn9X4hnSX+oxN8GOamH4wU0RN4hJ4PEdx3tOWco7H7oXXw2vbu
         8bMinJJDFtPVNk+0vMSeHIAHtz/Y4H/etRjyctSNeCuSjlnrRPzeJ7nFOYbjU0YEpBmu
         JTd4+488xt8FXa1n3c9XhD58IfjE0iP+D0LT9yqrudHwHlI+rIDz2isGHuk+lR3ZiKcw
         GqFkMhIShnm0RWrvHXojh/S2ATYdT0y9W4b7tNl3EbhfKQ2CutzhyaKvSwd5BhPupE/V
         vYig==
X-Gm-Message-State: ABuFfoi7BdJFCwU/vKsR54Ujl92glIwcvWoVw5YqJIBsa051MDOMGpkY
        LBdL0kCX6YBHDYb2+LP5tk+4l1IevsA=
X-Google-Smtp-Source: ACcGV61arO5cIjRuEpjneuVlJ+VKvelJlIyJaEF9yWrw52cq8wqNPlwaRPWKdfko1HAbZDmZZSBm5A==
X-Received: by 2002:a67:65c3:: with SMTP id z186mr20389665vsb.54.1540241568363;
        Mon, 22 Oct 2018 13:52:48 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id c189-v6sm10247285vka.22.2018.10.22.13.52.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:52:48 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id c10so30578843vsk.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:52:47 -0700 (PDT)
X-Received: by 2002:a67:b20e:: with SMTP id b14mr18870284vsf.121.1540241567458;
 Mon, 22 Oct 2018 13:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181019201940.138179-1-dianders@chromium.org> <7337055.Mnli2TfP4b@avalon>
In-Reply-To: <7337055.Mnli2TfP4b@avalon>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Oct 2018 13:52:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W8AeOJfOKOZoWgqeZE1f-cdef43NKJgspdNgnG8+vNKA@mail.gmail.com>
Message-ID: <CAD=FV=W8AeOJfOKOZoWgqeZE1f-cdef43NKJgspdNgnG8+vNKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: sn65dsi86: Add panel-hpd-delay
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sandeep Panda <spanda@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        ryandcase@chromium.org, Andrzej Hajda <a.hajda@samsung.com>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 21, 2018 at 2:07 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Douglas,
>
> Thank you for the patch.
>
> On Friday, 19 October 2018 23:19:39 EEST Douglas Anderson wrote:
> > The timing diagram of some eDP panels says that you're supposed to
> > wait for HPD to be asserted before the aux channel is operational.
> >
> > In some cases, however, it's better to just hardcode the max delay
> > instead of trying to use HPD.  Why?
> >
> > The sn65dsi86 datasheet says that it only reports the debounced
> > HPD signal to software.  It will tell software about HPD assertion
> > as quickly as 100 ms after it's asserted, but sometimes it might
> > take 400 ms because it's timed with a very inaccurate ring
> > oscillator.  In practice it was measured at 200 ms on at least
> > one system.
> >
> > On a particular panel, HPD was asserted 84 ms after power was given.
> > This same panel specified that HPD would always be asserted within
> > 200 ms of applying power.  Thus on this panel with the measured
> > 84 ms to assert HPD + the 200 ms measured debounce we'd wait 284 ms
> > which is 84 ms longer than just hardcoding the sleep.
> >
> > Let's allow boards to explicitly choose the hardcoded delay by adding
> > a device tree attribute for it.  A few notes:
> > a) This delay can't easily be in the panel bindings because the delay
> >    wouldn't actually be needed if the same panel were hooked somewhere
> >    else (someplace with more sane HPD behavior).
>
> The delay shouldn't be handled in the panel driver, but I think it's still a
> property of the panel, and should thus be specified in the panel DT node. The
> panel driver should parse it from DT (or, if the panel driver knows about the
> specific panel model, just hardcode it), and then report it to the bridge
> driver which can then decide, based on its knowledge if the bridge internal
> HPD processing delays, to just wait for a fixed delay or use regular HPD
> handling.

OK, that's fair.

I looked a little at trying to add this but it seems like it's a
pretty specific use case and to communicate between the panel and the
bridge I believe I'd need to add a bunch of members and/or functions
into the drm_connector structures that nobody would use except this
one case.  I also still need to add a device tree attribute to the
panel to say that HPD shouldn't be used.

Before I go about doing that, I have another idea that maybe you'd be
OK with.  I've written up patches for it to hopefully make it easier
to see what it looks like.  Instead of adding the device tree
attribute for "don't use HPD" to the bridge, I can just add that to
the panel.  The panel knows that if HPD isn't connected that it will
need to insert a delay.  No abstraction violations and no need to even
communicate to the bridge.  So basically anyone using this panel w/
this bridge chip should know that HPD isn't useful and not bother
hooking it up and then set this property.  ...and in fact, on most of
our boards HPD isn't actually connected.  We just started connecting
it on some of them to see if it was the best way to fix this delay...

Patches can be found at:

https://lore.kernel.org/patchwork/patch/1002547/
[1/6] dt-bindings: drm/panel: simple: Add no-hpd property

https://lore.kernel.org/patchwork/patch/1002548/
[2/6] drm/panel: simple: Support panels with HPD where HPD isn't connected

https://lore.kernel.org/patchwork/patch/1002552/
[3/6] drm/panel: simple: Add "no-hpd" delay for Innolux TV123WAM

https://lore.kernel.org/patchwork/patch/1002549/
[4/6] drm/bridge: ti-sn65dsi86: Remove the mystery delay

https://lore.kernel.org/patchwork/patch/1002551/
[5/6] drm/panel: simple: Innolux TV123WAM is actually P120ZDG-BF1

https://lore.kernel.org/patchwork/patch/1002550/
[6/6] dt-bindings: drm/panel: simple: Innolux TV123WAM is actually P120ZDG-BF1


Thanks!

-Doug
