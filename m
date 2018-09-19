Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F2EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8096320877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8096320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbeISVDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:03:05 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35894 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbeISVDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:03:04 -0400
Received: by mail-ua1-f68.google.com with SMTP id c12-v6so2896955uan.3;
        Wed, 19 Sep 2018 08:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bzCGkVd39At+MGe+7aOEJN+Y+LPa4xi/cvqsXaOG6E=;
        b=N7HXu6VY6MLta7r8MYBD0uYu9BnGNWYzIGSOtYhSWrQCBzPwNF7Mz5usSQrwpbT72b
         IYHp/llhGfaTrDjZV5I4UW7flhSWNKxIu0K187R/vD8t2UHhRTVAD3Vn9QUbviiskarJ
         mXEOCva1SzZgJ62uZL2u5U51fGkrogb7XM4fbE5EeER08F5roDXtpk//bQF4qdDHpFux
         xb08x5xiZ1HK8yj+HuvQeN4brn70ia0R4KgNHoYwgStobUlqqpjhMu0yF+eUO36ORORU
         2lwi8Uh4IjV+paImAlzRFRGHi+k3IfHQXddA9294aw6Kghw5zC+J3oGpIeftU9ZdOj3c
         HUBQ==
X-Gm-Message-State: APzg51C5KPz1AiNYCHc7SNiXMBk/kgBokaQkbnPQgs+aftMsdsKrM20l
        kaim9OcbiOtad9k+FIfn9wE+v2umVO0wU2NAl0/NCA==
X-Google-Smtp-Source: ANB0Vdb22xVrla422VxEHsZWh9fis4o2KH14gjVFg17XceHqElU82ElhFupc0Z7J0KR/ti8OQ0xyt88QoLvswMp+iOM=
X-Received: by 2002:ab0:60c6:: with SMTP id g6-v6mr11256133uam.41.1537370677817;
 Wed, 19 Sep 2018 08:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180917163955.19023-1-geert+renesas@glider.be>
 <20180917163955.19023-2-geert+renesas@glider.be> <1537369098.6816.6.camel@pengutronix.de>
In-Reply-To: <1537369098.6816.6.camel@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Sep 2018 17:24:25 +0200
Message-ID: <CAMuHMdWSO6JcBRmmpwCPz0u-85ZC3ffZkNbdd8DjokJT2opAtw@mail.gmail.com>
Subject: Re: [PATCH/RFC v4 1/2] reset: Add support for dedicated reset controls
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

CC Mark & Rob (DT)

On Wed, Sep 19, 2018 at 4:58 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Mon, 2018-09-17 at 18:39 +0200, Geert Uytterhoeven wrote:
> > In some SoCs multiple hardware blocks may share a reset control.
> > The existing reset control API for shared resets will only assert such a
> > reset when the drivers for all hardware blocks agree.
> > The existing exclusive reset control API still allows to assert such a
> > reset, but that impacts all other hardware blocks sharing the reset.
>
> I consider requesting exclusive access to a shared reset line a misuse
> of the API. Are there such cases? Can they be fixed?

I guess there are plenty.  Whether a line is shared or dedicated depends
on SoC integration.

The issue is that a driver requesting exclusive access has no way to know
if the reset line is dedicated to its device or not.  If no other
driver requested
the reset control (most drivers don't use reset controls), it will succeed.

> > Sometimes a driver needs to reset a specific hardware block, and be 100%
> > sure it has no impact on other hardware blocks.  This is e.g. the case
> > for virtualization with device pass-through, where the host wants to
> > reset any exported device before and after exporting it for use by the
> > guest, for isolation.
> >
> > Hence a new flag for dedicated resets is added to the internal methods,
> > with a new public reset_control_get_dedicated() method, to obtain an
> > exclusive handle to a reset that is dedicated to one specific hardware
> > block.
>
> I'm not sure a new flag is necessary, this is what exclusive resets
> should be.

So perhaps the check should be done for the existing exclusive resets
instead, without adding a new flag?

> Also I fear there will be confusion about the difference between
> exclusive (refering to the reset control) and dedicated (refering to
> the reset line) reset controls.

Indeed, exclusive has multiple meanings here:
  1. Exclusive vs. shared access to the reset control,
  2. Reset line is dedicated to a single device, or shared with multiple
     devices.

If we can simplify (exclusive == dedicated, 1.shared == 2.shared), life
can become simpler.

> >   - I think __device_reset() should call __reset_control_get() with
> >     dedicated=true.  However, that will impact existing users,
>
> Which ones? And how?

I didn't actually check which drivers.
If a reset is not dedicated, device_reset{,_optional}() will suddenly
start to fail if
a reset turns out to be not dedicated.
Well, currently the device will be reset multiple times, so people would
already have noticed...

> >   - Should a different error than -EINVAL be returned on failure?
> > ---
> >  drivers/reset/core.c  | 76 ++++++++++++++++++++++++++++++++++++++-----
> >  include/linux/reset.h | 60 ++++++++++++++++++++++------------
> >  2 files changed, 107 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > index 225e34c56b94a2e3..5bc4eeca70c0fcc2 100644
> > --- a/drivers/reset/core.c
> > +++ b/drivers/reset/core.c
> > @@ -459,9 +459,38 @@ static void __reset_control_put_internal(struct reset_control *rstc)
> >       kref_put(&rstc->refcnt, __reset_control_release);
> >  }
> >
> > +static bool __of_reset_is_dedicated(const struct device_node *node,
> > +                                 const struct of_phandle_args args)
> > +{
> > +     struct of_phandle_args args2;
> > +     struct device_node *node2;
> > +     int index, ret;
> > +
> > +     for_each_node_with_property(node2, "resets") {
> > +             if (node == node2)
> > +                     continue;
> > +
> > +             for (index = 0; ; index++) {
> > +                     ret = of_parse_phandle_with_args(node2, "resets",
> > +                                                      "#reset-cells", index,
> > +                                                      &args2);
> > +                     if (ret)
> > +                             break;
> > +
> > +                     if (args2.np == args.np &&
> > +                         args2.args_count == args.args_count &&
> > +                         !memcmp(args2.args, args.args,
> > +                                 args.args_count * sizeof(args.args[0])))
> > +                             return false;
> > +             }
> > +     }
> > +
> > +     return true;
> > +}
>
> I want to hear the device tree maintainers' opinion about this.
> I'd very much like to have such a check for exclusive resets, but my
> understanding is that we are not allowed to make the assumption that
> other nodes' "reset" properties follow the common reset signal device
> tree bindings.
>
> Maybe this is something that should be checked in a device tree
> validation step?

We already have SoCs where reset lines are shared among multiple on-chip
devices. So dtc validation won't work, and a runtime check is needed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
