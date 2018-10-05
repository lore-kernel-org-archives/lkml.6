Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB090C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CF3206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CF3206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeJETak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:30:40 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45655 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeJETaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:30:39 -0400
Received: by mail-vs1-f65.google.com with SMTP id g201so7336537vsd.12;
        Fri, 05 Oct 2018 05:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5rUsP8L3JK+JqoGeoh5AW8lYTXeyeFpov2xYCwIwbs=;
        b=fAw4DupHSK22PVQ79NDWmKTIuEibDUZfQ1nXrmOK5NusES/O9qbKV1k+sDHpxcdrkb
         3nO4ByDobTIONeOo/ga1Hysm2egOfEztRYTzs4TcNtxGm3S6oHJTbyftU94F+sEjreui
         rEz/sYVd0cZ9sifnddWQP19kIqsFcWqcfIj8LZJiuMXZICj3kglJMxHaLZzrTYJBCBmx
         oWKQQJB3z5bnlEGTD1bqltKeK+bJ77Qe2w5s3AwlFmS+y5NFGegLbYuOoPU3djS8UGw2
         g5i94HDlqN/KdRIsphXb0XmLlMQZgBEDLEXSlz93tmfaB1pxuq75zGkwA//PyNOTQYME
         i7Lg==
X-Gm-Message-State: ABuFfog38Qmorvnrn3Hfj+EcCciQufs50b+nZ5T+uUM1KDavNIOUOoIW
        jA3zgoYIxcAXaUc4ApShgd0x5WU05soHrKjTInI=
X-Google-Smtp-Source: ACcGV60vX8eOnJ7n3T/TFwLmZ4FInA88GvgOE9ILTTH0VdPL5J5DKhktB1cqVn509EYYuG1nlFeqeGAu5pEQohT8Phk=
X-Received: by 2002:a67:843:: with SMTP id 64mr1504932vsi.166.1538742727519;
 Fri, 05 Oct 2018 05:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180927180038.24599-1-geert+renesas@glider.be>
 <1538648094.14153.8.camel@pengutronix.de> <CAMuHMdV_qb8qDFJ1VT6FYYkHK73tjbp2hOUShaOEhezPWg+VDg@mail.gmail.com>
In-Reply-To: <CAMuHMdV_qb8qDFJ1VT6FYYkHK73tjbp2hOUShaOEhezPWg+VDg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 5 Oct 2018 14:31:55 +0200
Message-ID: <CAMuHMdUC3dGRnMCsX3HjmGgb0-vLSNXKXRiiAS+TzW72_uM+LQ@mail.gmail.com>
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

On Fri, Oct 5, 2018 at 10:55 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 4, 2018 at 12:15 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Thank you for the patch. I'd still like to hear the device tree
> > maintainers' (added to Cc:) opinion on parsing the whole DT for "resets"
> > phandle properties to find shared resets like this.
> >
> > On Thu, 2018-09-27 at 20:00 +0200, Geert Uytterhoeven wrote:
> > > In some SoCs multiple hardware blocks may share a reset control.
> > > The reset control API for shared resets will only assert such a reset
> > > when the drivers for all hardware blocks agree.
> > > The exclusive reset control API still allows to assert such a reset, but
> > > that impacts all other hardware blocks sharing the reset.
> > >
> > > While the kernel doc comments clearly state that the API for shared
> > > resets applies to reset controls which are shared between hardware
> > > blocks, the exact meaning of exclusive resets is not documented.
> > > Fix the semantic ambiguity with respect to exclusive access vs.
> > > exclusive reset lines by:
> > >   1. Clarifying that exclusive resets really are intended for use with
> > >      reset controls which are dedicated to a single hardware block,
> > >   2. Ensuring that obtaining an exclusive reset control will fail if the
> > >      reset is shared by multiple hardware blocks, for both DT-based and
> > >      lookup-based reset controls.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > This is v2 of "[RFC] reset: Add support for dedicated reset controls":
> > >   - Fix wrong variable in __reset_is_dedicated() loop,
> > >   - Add missing of_node_put() in __of_reset_is_dedicated(),
> > >   - Document that exclusive reset controls imply they are dedicated to a
> > >     single hardware block,
> > >   - Drop new dedicated flag and new API reset_control_get_dedicated(),
> > >     as exclusive already implies dedicated,
> > >   - Rename {__of_,}reset_is_dedicated() to {__of_,}reset_is_exclusive(),
> > >   - Reword description.
> > >
> > > Note: Exclusive lookup-based reset controls were not tested.
> > > ---
> > >  drivers/reset/core.c  | 58 +++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/reset.h |  5 +++-
> > >  2 files changed, 62 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > > index 225e34c56b94a2e3..2f5b61226c7964eb 100644
> > > --- a/drivers/reset/core.c
> > > +++ b/drivers/reset/core.c
> > > @@ -459,6 +459,38 @@ static void __reset_control_put_internal(struct reset_control *rstc)
> > >       kref_put(&rstc->refcnt, __reset_control_release);
> > >  }
> > >
> > > +static bool __of_reset_is_exclusive(const struct device_node *node,
> > > +                                 const struct of_phandle_args args)
>
> Oops, this should take *args, not args.
>
> > > +{
> > > +     struct of_phandle_args args2;
> > > +     struct device_node *node2;
> > > +     int index, ret;
> > > +     bool eq;
> >
> > I suppose it is very unlikely to get false positives where an arbitrary
> > node contains a "resets" property that looks like a proper phandle to an
> > actual reset-controller node.
> > Are we allowed though to scan the whole tree for "resets" properties
> > regardless of the nodes' bindings or compatible properties like this?
>
> Given "resets" is a more-or-less standard property, I'd say yes.
> Especially given of_parse_phandle_with_args() does verify that the target
> node has #reset-cells, and that the number of parameters matches that.
>
> > > +     for_each_node_with_property(node2, "resets") {
> > > +             if (node == node2)
> > > +                     continue;
> > > +
> > > +             for (index = 0; ; index++) {
> > > +                     ret = of_parse_phandle_with_args(node2, "resets",
> > > +                                                      "#reset-cells", index,
> > > +                                                      &args2);
> > > +                     if (ret)
> > > +                             break;
> > > +
> > > +                     eq = (args2.np == args.np &&
> > > +                           args2.args_count == args.args_count &&
> > > +                           !memcmp(args2.args, args.args,
> > > +                                   args.args_count * sizeof(args.args[0])));
>
> As there's at least one other function in -next that compares of_phandle_args,
> I will add a helper of_phandle_args_eq().
>
> > > +                     of_node_put(args2.np);
> > > +                     if (eq)
> >
> > Emitting a loud warning here could be very helpful if it contains
> > both the reset controller node and the reset index, as well as the

Actually on DT-based systems, the index is a driver-specific
implementation detail, and may differ from the actual reset specifier in DT.
E.g. on R-Car systems, DT uses a human-readable representation matching
the datasheet, while internally, the driver uses a packed representation.
Hence printing the index may confuse the user.

For lookup-based systems, this is different.

> > consumer nodes: node and node2.
>
> Indeed, will do, also for lookup resets.
>
> We already have of_print_phandle_args(), but that is a bit inflexible.
> Adding support for "%pOFa" looks like the modern thing to do.

Scrap that: of_phandle_args is not derived from a device_node, so %pOFa
is not appropriate (and would crash instead of fall back to a pointer before
%pOFa support is implemented). And without more users, it doesn't make much
sense to go for a new type (e.g. "%pOA")...

Actually, printing the full reset specifier is not needed. A message like

    /soc/pwm@e6e31000 and /soc/pwm@e6e30000 share a reset on
/soc/clock-controller@e6150000

should give sufficient clue to the user.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
