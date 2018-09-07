Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9534C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3C4206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAfYyQJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3C4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeIGLuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:50:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40430 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeIGLuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:50:12 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so18696088ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkF8E2VsUzQjSNqMUrGSd3sx4tM1uQQBJT/Yw1PuEBg=;
        b=LAfYyQJx6ikwJw3/0OQTCebufYCL9E9oMo9O3HL4NP6irjhLsMhb9qIgRMP/Ck0RkX
         06nlMSASWOsiBJTwYEcVI+VSpTTF/2aVVz+5EwVsf8KitkppMlWLBhPX12m6/aJ3f53q
         iVU2o2HaEC21dpahtDxKqxa+NbIQveuReClrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkF8E2VsUzQjSNqMUrGSd3sx4tM1uQQBJT/Yw1PuEBg=;
        b=jxt7N6VRvgHoStiNH5RjRj/IeJ7yYNwyb0B68ilOCGapmRgPjGW1J0c6E5KAO+w30I
         TrCqh2GCob+PDIgbB3VZL1laxakG84WEBnhw+wLZixAABEkyqOZ1uitVTdqubPEiteV6
         o/JsTJ0dyLA9UWfkZpuJwo46t8NDMcDAZK4vLLdi7Mjt0l4Wa6yCe+FT2tJiIzcsl8bt
         2a3JhgK9QrCHBkUprq2Pg3JKfOvQ54Hs1mKshbKQGC0ROZIbk85+OSPZOfam81wdKEJt
         5T7Ix5bnTWSZgoPq1RswZqZkTyN87sO4OMh4+TijHHCJcYjDnsWzOmLo/NTqiGDGSZos
         mMnw==
X-Gm-Message-State: APzg51B9Cr7jDhCuGV2OvMpI7B4iM98jr1YMankqfGvZoBg/DW4qKTmz
        aldgUXTmRLhdGXJcBeqm0DNReSf39WXc0nlp/POnpg==
X-Google-Smtp-Source: ANB0VdYIUybykWhSJuKnNmw6nf+cMF+dLGvog5MLVxXDvZmrjvIRcAefUfFtLykx2lImztpe41ISRPY3U/ilTAXWoS8=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr5386999itk.62.1536304240101;
 Fri, 07 Sep 2018 00:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180905052113.21262-1-stefan@agner.ch> <4035252.QuWadVx7pr@avalon>
 <1569297.pdEFdpi3HS@avalon> <a00c1650b69ba85bed7ae39b81a0c40f@agner.ch>
 <CACRpkdbw0VjkHYcUpox+DorRG0oRdPARL4ShgPfV2eFaUF_w0g@mail.gmail.com> <b1cb586397a4cd444c33dd83d72fa544@agner.ch>
In-Reply-To: <b1cb586397a4cd444c33dd83d72fa544@agner.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Sep 2018 09:10:27 +0200
Message-ID: <CACRpkdaUuWUHZgT0b64hMNZm3oy=7rece3H0p5VVe4d8jpFRaw@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
To:     Stefan Agner <stefan@agner.ch>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        max.krummenacher@toradex.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 10:25 PM Stefan Agner <stefan@agner.ch> wrote:

> Ok, I read a bit up on the history of bridge timing, especially:
> https://www.spinics.net/lists/dri-devel/msg155618.html
>
> IMHO, this got overengineered. For displays we do not need all that
> setup/sample delay timing information, and much longer cables are in
> use. So why is all that needed for bridges?

I also avoided the overhead of creating this abstraction initially.

But after doing it I have this Stockholm syndrome that I start
liking what Laurent told me to do.

> For Linus case, the THS8134(A/B) data sheet I found (revised March 2010)
> clearly states:
> Clock input. A rising edge on CLK latches RPr0-7, GY0-7, BPb0-7.
>
> So we need to drive on negative edge, hence DRM_BUS_FLAG_PIXDATA_NEGEDGE
> should be used, which makes the pl111 driver setting TIM2_IPC:
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0121d/index.html

That is easy to say, but if I just set that up in code, even with a good
comment it is hard for the next reader to understand what is going
on. The central question will be, why does PL111 need to do this
but not R-Car though they are using the same bridge?

So this elaborate model gives a better transfer of abstract concepts
to whoever needs to touch that code next. The code is not just
logic, but also our map of the world and the documentation of our
problem space.

Donald Knuth has this idea about literate programming which even
turns the documentation/implementation process around. We are
not there, not even remotely, but IMO the more complex the problem.
the more we need to convey our thinking, not just our solution.

Yours,
Linus Walleij
