Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43597C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5812420882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5812420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJHRKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:10:51 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41704 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJHRKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:10:50 -0400
Received: by mail-ua1-f68.google.com with SMTP id m7so6934206uao.8;
        Mon, 08 Oct 2018 02:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6jr2tRKMs36+7Alx1KBuI6wS+Y6ADm1Usg6phWcPT8=;
        b=cY7ZEwzlQaCQbnzKexEXlLX4yI7C7fmOnzVswhQhLEQUv5ej8nSPOyKvjfB8674Jfa
         m8bM2rHzEkCeT/ZhjYGVLN1XiM64NEANy4sFB81QCl5UeFJPuXG9Df4KY/3HrG8jUunq
         GsegkGxCCE8KGaTZY2MRdWtBN8Qb9Xkz2tmAkQlWuKtnan7wSIwAbw7LtNQvuCIKzFEk
         HEeUQCDJrvoOuZt5YoYUKWvOnOHYIwkA3xGQgQw/U7ZhLjjNwWdcojqm8U4I9jk1JU2z
         M+XcEGrwj9keffRnQ4Sgm0vfeik/6bx+17b055yfhJgZTS7sbjOBcUJ3P8C7AV6o+pTH
         Z1sA==
X-Gm-Message-State: ABuFfoioz2VeqPx0zYahSW5a8V20kkkpUgdm2hw2x42Z1GOHlQ9zb7g7
        wyKBVeV4WrM1JhBDduvqNUpKbtuI1oc954cH3zo=
X-Google-Smtp-Source: ACcGV63gNsVITpsKZ/LZdmgQ5Sb3hwd1jrDQ6QW/wLgb/NhST/gimpM0diJO8iYyqqXuxoscTWJGMKCzgdrMHqFTzsc=
X-Received: by 2002:a9f:35f1:: with SMTP id u46-v6mr9017756uad.20.1538992795760;
 Mon, 08 Oct 2018 02:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180927180038.24599-1-geert+renesas@glider.be>
 <1538648094.14153.8.camel@pengutronix.de> <CAMuHMdV_qb8qDFJ1VT6FYYkHK73tjbp2hOUShaOEhezPWg+VDg@mail.gmail.com>
 <CAMuHMdUC3dGRnMCsX3HjmGgb0-vLSNXKXRiiAS+TzW72_uM+LQ@mail.gmail.com> <1538752564.3545.37.camel@pengutronix.de>
In-Reply-To: <1538752564.3545.37.camel@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 11:59:42 +0200
Message-ID: <CAMuHMdXFbYkD_Lou0wW__0-8ZPj3cKuJ6it_0hpPwzNU0Zeq3g@mail.gmail.com>
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

On Fri, Oct 5, 2018 at 5:16 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Fri, 2018-10-05 at 14:31 +0200, Geert Uytterhoeven wrote:
> [...]
> > > > > +                     eq = (args2.np == args.np &&
> > > > > +                           args2.args_count == args.args_count &&
> > > > > +                           !memcmp(args2.args, args.args,
> > > > > +                                   args.args_count * sizeof(args.args[0])));
> > >
> > > As there's at least one other function in -next that compares of_phandle_args,
> > > I will add a helper of_phandle_args_eq().
> > >
> > > > > +                     of_node_put(args2.np);
> > > > > +                     if (eq)
> > > >
> > > > Emitting a loud warning here could be very helpful if it contains
> > > > both the reset controller node and the reset index, as well as the
> >
> > Actually on DT-based systems, the index is a driver-specific
> > implementation detail, and may differ from the actual reset specifier in DT.
> > E.g. on R-Car systems, DT uses a human-readable representation matching
> > the datasheet, while internally, the driver uses a packed representation.
> > Hence printing the index may confuse the user.
> >
> > For lookup-based systems, this is different.
>
> Correct. I'm so used to #reset-cells = <1>, it's hard to remember the
> exceptions. So let's not try to print indices or args.
>
> > > > consumer nodes: node and node2.
> > >
> > > Indeed, will do, also for lookup resets.
> > >
> > > We already have of_print_phandle_args(), but that is a bit inflexible.
> > > Adding support for "%pOFa" looks like the modern thing to do.
> >
> > Scrap that: of_phandle_args is not derived from a device_node, so %pOFa
> > is not appropriate (and would crash instead of fall back to a pointer before
> > %pOFa support is implemented). And without more users, it doesn't make much
> > sense to go for a new type (e.g. "%pOA")...
> >
> > Actually, printing the full reset specifier is not needed. A message like
> >
> >     /soc/pwm@e6e31000 and /soc/pwm@e6e30000 share a reset on
> > /soc/clock-controller@e6150000
> >
> > should give sufficient clue to the user.
>
> Yes. You could also pass con_id into __of_reset_is_exclusive and print
> that. It would be nice to indicate which consumer requested exclusive
> access.

con_id is used for lookup-based resets only?

But the value passed there is the "id" parameter of
reset_control_get_exclusive().  However, that is not the consumer name,
and usually NULL.

I'm afraid the only way to know the consumer is to print a backtrace with
WARN()?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
