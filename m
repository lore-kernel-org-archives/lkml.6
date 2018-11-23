Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650F7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA8A20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA8A20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503237AbeKWVAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:00:02 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41329 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503239AbeKWVAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:00:02 -0500
Received: by mail-ua1-f67.google.com with SMTP id z24so3934415ual.8;
        Fri, 23 Nov 2018 02:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wS1oOfUETQckjM9OqKNEwS4Qu8JP8M8400QpDgM8kFY=;
        b=ez5/zFNBNWhvZcmNFt9aSlor82EOkOiIcPhWusONrNR6UViaZuAnLmRjvZmE1WVXYd
         ty8TvgBpEAQAVLEldb0GduuhmMScCbERkfH0/R/Kx0ubhxIKU7UMoWTOwQeYPJfwiFmg
         /iufpfTNxDzz+n9pQh6GqJsxP2Fybra6wuoNBIRkFfDEKouWS6GmhPNJxjU2iebQcEcZ
         WStACGdNaMOuFiCpnFAwf0YbZ0z+X9OKtp/ycSrrv4Bk7UW2PO/gFqk8XGHQP6GhSJEl
         3rrIV8+kN3nJW7PGklE4flsqDlKc/u0OpH3U2H+H+bT3S1pqLoz+SDy+n37TNDly17T3
         z1Ew==
X-Gm-Message-State: AA+aEWZTqHpUtXBeIwR6L/nz+Rkzs/2zQ3wfEij77w6UrvEUnSMoFJU8
        fDI5MsZE1uMjqAErK2kQvlPvrRq6E4z5nOZiCgk=
X-Google-Smtp-Source: AFSGD/VH1+yX84UkEccV3G/LcfErlposKHHx4ERhhJp72+odIPs3tZpkGlGXxgfEbXSYzS2fmJsKx072pRjwOFvtENo=
X-Received: by 2002:ab0:465:: with SMTP id 92mr6300976uav.28.1542968181915;
 Fri, 23 Nov 2018 02:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20181119161838.10610-1-phil.edworthy@renesas.com>
 <CAMuHMdU2ski3S4FhD5kOhtzxvpin8M5MoYwK7X5gqYZ+HoL0DA@mail.gmail.com> <TY1PR01MB1769DE254148618373F2918CF5D40@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1769DE254148618373F2918CF5D40@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Nov 2018 11:16:09 +0100
Message-ID: <CAMuHMdUUjoUmA2R8=PXp-hvYvowb3L-dnP6EDcGkLZJG344Yug@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Fri, Nov 23, 2018 at 11:07 AM Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> On 23 November 2018 09:41 Geert Uytterhoeven wrote:
> > Subject: Re: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
> > On Mon, Nov 19, 2018 at 5:18 PM Phil Edworthy wrote:
> > > This fixes the check for unused mdio bus setting and the following
> > > static checker warning:
> > >  drivers/pinctrl/pinctrl-rzn1.c:198 rzn1_pinctrl_mdio_select()
> > >  warn: always true condition '(ipctl->mdio_func[mdio] >= 0) => (0-u32max
> > >= 0)'
> > >
> > > It also fixes the return var when calling of_get_child_count()
> >
> > I think this should be a separate patch.
> Ok, I'll split them.

Thanks!

> > BTW, I have a question about rzn1_pinctrl_mdio_select():
> >
> > static void rzn1_pinctrl_mdio_select(struct rzn1_pinctrl *ipctl, int mdio,
> >                                      u32 func) {
> >         if (ipctl->mdio_func[mdio] >= 0 && ipctl->mdio_func[mdio] != func)
> >                 dev_warn(ipctl->dev, "conflicting setting for mdio%d!\n", mdio);
> >         ipctl->mdio_func[mdio] = func;
> >
> >         dev_dbg(ipctl->dev, "setting mdio%d to %u\n", mdio, func);
> >
> >         writel(func, &ipctl->lev2->l2_mdio[mdio]); }
> >
> > The check warns the user if it overrides an already initialized MDIO function
> > with a different value.
> > However, there is no method to uninitialize (reset to -1) mdio_func[], to
> > avoid getting the warning.
> >
> > For a use case, I was thinking about a DT overlay that would cause the MDIO
> > function to be initialized on loading, and needs to uninitialize the MDIO
> > function on removing.
> >
> > Perhaps that is very unlikely or even impossible, given the function of the
> > pins controlled by the MDIO function?
> I hadn't considered that DT overlay possibility...
> Since this MDIO muxing selects one of several different IP blocks as the
> MDIO master, I guess it could happen. However, this is pretty unlikely!
>
> I can't see any way via the pinctrl_ops or pinconf_ops to 'undo' a pin
> setting, how would this work?

Actually the pinctrl core wouldn't undo the configuration on DT overlay unload,
but would just do the new configuration when loading the new DT overlay.
Hence that would print the warning, but work regardless.
Only for GPIOs there would be an undo step (freeing the requested GPIO).

> If a DT overlay causes remove() then probe() to be called again, the driver
> resets mdio_func[] in probe(), so it'll work.

Typically a DT overlay would only control I/O devices, not the actual pinctrl
device, so the pin controller driver's .probe() wouldn't be called.

But I agree it's unlikely and rare, and would still work. And probably you do
want to keep the warning.  DT overlays are still experimental, as there's no
upstream support for loading a random DT overlay at runtime.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
