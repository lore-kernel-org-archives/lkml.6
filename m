Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DD3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970D820858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970D820858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeJHS7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:59:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34660 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJHS7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:59:25 -0400
Received: by mail-vs1-f65.google.com with SMTP id v12-v6so11226573vsc.1;
        Mon, 08 Oct 2018 04:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLdUIi+rQub6SR4LMPtZC6BcrbfY7zgUV5uEsg6xII8=;
        b=DTzrFDKpKvwgQ9QM/TFdNq2tD8K536gCIh/tPOYGsdLCrjkTFoilCTYCbyPgslKUAH
         pA6d7EKNmKWqssFIkcr/pSl/E+ZqSSPmJJpQR4aEri55a6Q7vOpxF0HsccOVN6Uoewc6
         DLGSDZVhMSBQkeXJRXWUyomm6B2zwLYwXOJ42bUhdTdNwvTPXj2Bqu1T8EEoHO1f693/
         spxiNpj6IZCTastsfmdw8LchhGUlIXHtjjrS6dsmtY1FsLEWbqOs7NtdgHA/OQ5CPsgY
         9Acljfegcy1uZspQCRVwmUHrjo6Gp2YnA7/cMqO0TD7F1qtNuSHbTnlEqRVoQfh6Zbhm
         1OKA==
X-Gm-Message-State: ABuFfogHnmEtbT0Xw+9gCrkoHQqSS6U9qUOMhP935WFWmDJHserwhkyl
        sPK49MheCrxs3FlaGA1g73kFTgNwvFY+ys6dQ6VYfbFp
X-Google-Smtp-Source: ACcGV63sfOxI8C1zKLUbmFD38wCTnXl9tWOfx4RJst5h/mziULwsVwmvg7qxWFaOHaWbv/XwXz31Uf5tqFCD5ixxLp0=
X-Received: by 2002:a67:843:: with SMTP id 64mr5699088vsi.166.1538999283337;
 Mon, 08 Oct 2018 04:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180927180038.24599-1-geert+renesas@glider.be>
 <1538648094.14153.8.camel@pengutronix.de> <CAMuHMdV_qb8qDFJ1VT6FYYkHK73tjbp2hOUShaOEhezPWg+VDg@mail.gmail.com>
 <CAMuHMdUC3dGRnMCsX3HjmGgb0-vLSNXKXRiiAS+TzW72_uM+LQ@mail.gmail.com>
 <1538752564.3545.37.camel@pengutronix.de> <CAMuHMdXFbYkD_Lou0wW__0-8ZPj3cKuJ6it_0hpPwzNU0Zeq3g@mail.gmail.com>
 <1538996273.11512.13.camel@pengutronix.de>
In-Reply-To: <1538996273.11512.13.camel@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 13:47:51 +0200
Message-ID: <CAMuHMdV3yt7S9sKgEuy7vJsCqSCfm8caNSNLwLVX4H8pNxpOzA@mail.gmail.com>
Subject: Re: [PATCH v2] reset: Exclusive resets must be dedicated to a single
 hardware block
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Mon, Oct 8, 2018 at 12:57 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Mon, 2018-10-08 at 11:59 +0200, Geert Uytterhoeven wrote:
> > On Fri, Oct 5, 2018 at 5:16 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > > On Fri, 2018-10-05 at 14:31 +0200, Geert Uytterhoeven wrote:
> > > [...]
> > > > > > > +                     eq = (args2.np == args.np &&
> > > > > > > +                           args2.args_count == args.args_count &&
> > > > > > > +                           !memcmp(args2.args, args.args,
> > > > > > > +                                   args.args_count * sizeof(args.args[0])));
> > > > >
> > > > > As there's at least one other function in -next that compares of_phandle_args,
> > > > > I will add a helper of_phandle_args_eq().
> > > > >
> > > > > > > +                     of_node_put(args2.np);
> > > > > > > +                     if (eq)
> > > > > >
> > > > > > Emitting a loud warning here could be very helpful if it contains
> > > > > > both the reset controller node and the reset index, as well as the
> > > >
> > > > Actually on DT-based systems, the index is a driver-specific
> > > > implementation detail, and may differ from the actual reset specifier in DT.
> > > > E.g. on R-Car systems, DT uses a human-readable representation matching
> > > > the datasheet, while internally, the driver uses a packed representation.
> > > > Hence printing the index may confuse the user.
> > > >
> > > > For lookup-based systems, this is different.
> > >
> > > Correct. I'm so used to #reset-cells = <1>, it's hard to remember the
> > > exceptions. So let's not try to print indices or args.
> > >
> > > > > > consumer nodes: node and node2.
> > > > >
> > > > > Indeed, will do, also for lookup resets.
> > > > >
> > > > > We already have of_print_phandle_args(), but that is a bit inflexible.
> > > > > Adding support for "%pOFa" looks like the modern thing to do.
> > > >
> > > > Scrap that: of_phandle_args is not derived from a device_node, so %pOFa
> > > > is not appropriate (and would crash instead of fall back to a pointer before
> > > > %pOFa support is implemented). And without more users, it doesn't make much
> > > > sense to go for a new type (e.g. "%pOA")...
> > > >
> > > > Actually, printing the full reset specifier is not needed. A message like
> > > >
> > > >     /soc/pwm@e6e31000 and /soc/pwm@e6e30000 share a reset on
> > > > /soc/clock-controller@e6150000
> > > >
> > > > should give sufficient clue to the user.
> > >
> > > Yes. You could also pass con_id into __of_reset_is_exclusive and print
> > > that. It would be nice to indicate which consumer requested exclusive
> > > access.
> >
> > con_id is used for lookup-based resets only?
> >
> > But the value passed there is the "id" parameter of
> > reset_control_get_exclusive().
>
> Sorry, I did mean the id parameter in the __of_reset_control_get case.

OK.

> > However, that is not the consumer name,
>
> It is the name of the reset signal from point of view of the consumer.
> It specifies, via its position in the reset-names property, which of
> potentially multiple reset phandles in the resets property is the one
> causing the conflict.
>
> > and usually NULL.
>
> In which case the resets property usually only contains one phandle, so
> it is not needed to determine the conflicting reset control.

For a device-specific driver knowing about all resets, that is indeed the case.
For the generic case (e.g. my vfio-platform use case), it just wants to reset
the device, and thus passes NULL.

Perhaps I should use devm_reset_control_array_get_exclusive() instead of
reset_control_get_exclusive(), to assert all resets?

However, that makes the detection of shared resets more tricky, as it needs
to consider all combinations. Currently e.g.
    resets = <&rst1> <&rst2>;
and
    resets = <&rst2> <&rst1>;
is not detected as reset sharing...

As device_reset() also uses the first reset only, I'll keep it that way...

> > I'm afraid the only way to know the consumer is to print a backtrace with
> > WARN()?
>
> I'm just suggesting to augment the warning message with the reset id, if
> available. For example:
>
>     /soc/pwm@e6e31000 requests exclusive control over reset "pwm"
>     shared with /soc/pwm@e6e30000 on /soc/clock-controller@e6150000

Thanks, consider it done for next version.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
