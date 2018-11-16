Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68282C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315082086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LJaYCu5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315082086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbeKQEpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:45:34 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34339 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeKQEpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:45:33 -0500
Received: by mail-ua1-f68.google.com with SMTP id z23so8392123uam.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 10:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BbP7AiyuH+uKDIwhg8JP7/ZbJYA8eASAq4y+bl9W/A=;
        b=LJaYCu5XSH5yf6pWi8Ea/Ci0mJ5AX2Y8Y8qSp50fjyBczz2KtQdED70To/xg2/SNvR
         GIkWS1OHQtnptqNPlbIHdG+ZwdPJTNvqAvNYe8CoWuRzZofD2TynuKIzUBdeOenM1izl
         PvY2Zx1VhVFHWUJtTiYYej8Xeg1zcNPDzYlng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BbP7AiyuH+uKDIwhg8JP7/ZbJYA8eASAq4y+bl9W/A=;
        b=eLhc7dG7Rcg8BL5/u3tq97WXTvasZaSsYfGC6o3sBWPSFwB5hUheKed/SmVN6U3tRS
         CwNygQKBmSHHL1BoOLPxNeLrz8rqK6GCaPx4zVPEqVoRhDouUZPdDMczcmnzW/m8cE0g
         cYtKliy1lcqqiufOL0NxSV2euq17OM6dGi7B7kmvBH62Lls6CT3Vnyh4008vCRFexCU+
         U8xXUcMKowqyQ/ajui4Z/P9Sj1h4wciZJ9+IEW2tcqoXcN9FGLW6q8GnHjRxCBGiucE6
         EX3yp7nld2UZgXgCoJnEPklkORfDxx8ub9RGbi43nCCMXsjjp+lFCKfjCR5BTZnRqjmo
         MEZQ==
X-Gm-Message-State: AGRZ1gJhPCNeVS8+egJP1H2HkHr5I1a0TQPFitIpyyQnxy9F1MKsW40R
        2/rPVdP+0uEMX2rDUYfg99ltC4gZYXk=
X-Google-Smtp-Source: AJdET5e1IKVAB8KsGCX8Gb/46HvVroKco30cKJEC+akLOUzwIBVcvJrERK8rO5zT5QCw7+y8cRDnhw==
X-Received: by 2002:a9f:2709:: with SMTP id a9mr3025578uaa.10.1542393122972;
        Fri, 16 Nov 2018 10:32:02 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id j95sm5332391uad.6.2018.11.16.10.32.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 10:32:02 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id y27so14325787vsi.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 10:32:02 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr4490119vsv.20.1542392650750;
 Fri, 16 Nov 2018 10:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20181116051719.23376-1-dbasehore@chromium.org>
 <CAD=FV=W7sYY5n609erPpTxux+0Efad_0YpPkoVZB14Kqm=baXA@mail.gmail.com> <CAGAzgsq7uF=E3dzhyCjK4gq09_UV_aZhQbyaTnz7yDY_ErQYKQ@mail.gmail.com>
In-Reply-To: <CAGAzgsq7uF=E3dzhyCjK4gq09_UV_aZhQbyaTnz7yDY_ErQYKQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Nov 2018 10:23:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XVDAjLt+VtxedHEma1FRrG0LuFZ2c7L5-MsdCZkgEcsw@mail.gmail.com>
Message-ID: <CAD=FV=XVDAjLt+VtxedHEma1FRrG0LuFZ2c7L5-MsdCZkgEcsw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399: Add xin32k clk
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, Tony Xie <tony.xie@rock-chips.com>,
        Chris <zyw@rock-chips.com>, ayaka@soulik.info,
        "nickey.yang" <nickey.yang@rock-chips.com>,
        =?UTF-8?B?6YOR6Iic5Lm+?= <zhengsq@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Brian Norris <briannorris@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 16, 2018 at 9:39 AM dbasehore . <dbasehore@chromium.org> wrote:
>
> On Fri, Nov 16, 2018 at 8:01 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Nov 15, 2018 at 9:17 PM Derek Basehore <dbasehore@chromium.org> wrote:
> > >
> > > This adds the xin32k clock to the RK3399 CPU. Even though it's not
> > > directly used, muxes will end up traversing the entire clk tree on
> > > calls to determine_rate if it doesn't exist.
> > >
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> >
> > nit: I would have expected ${SUBJECT} to have v2 in it somewhere.
> >
> >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > index 99e7f65c1779..3d09472978f8 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >
> > Aww crud.  I was at the airport yesterday and so I didn't notice that
> > you were touching rk3399, not rk3399-gru.  This belongs in the gru
> > device tree file, not in the top level rk3399.  As you have written
> > this it will break rk3399 boards that have an rk808 on them, AKA:
>
> Should this be moved to the rk3399.dtsi file? The RK3399 assumes that
> this clk exists (same as the 24MHz clk which is in rk3399.dtsi). While
> it can function without it defined, it really shouldn't. We can just
> assign the existing labels in the dts files you pointed out.

No, it should be in the board files.  Each board may produce the 32k
clock through a different component.  On gru-based devices we produce
the 32k clock through a silego part.  On some other ones we produce it
from rk808.

Technically you could say that we don't _truly_ need to model this
clock and we could have just inserted a dummy/fixed 32k clock in the
clk-rk3399.c file.  ...but we did model it so that means we should
probably model it semi-properly.

If a given board forgets to provide a 32k clock then that's a bug for
them like it was for us.

-Doug
