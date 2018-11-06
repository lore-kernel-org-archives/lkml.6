Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27F3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FCD20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FCD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbeKFScP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:32:15 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43461 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeKFScP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:32:15 -0500
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id C739B1C001D;
        Tue,  6 Nov 2018 09:07:57 +0000 (UTC)
Date:   Tue, 6 Nov 2018 10:07:56 +0100
From:   jacopo mondi <jacopo@jmondi.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] pinctrl: sh-pfc: r8a77965: Add VIN4 and VIN5
Message-ID: <20181106090756.GP20885@w540>
References: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUWP=zBfn8ff1PZ-f7WegQiYU7omGkAM-Fh1uNUxF2XNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ECF1u7dKBoUGhe3"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUWP=zBfn8ff1PZ-f7WegQiYU7omGkAM-Fh1uNUxF2XNQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ECF1u7dKBoUGhe3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Geert,

On Mon, Nov 05, 2018 at 06:19:22PM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
>
> On Mon, Oct 29, 2018 at 7:14 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> >    this two patches add supports for VIN4 and VIN5 interfaces to R-Car M3-N.
> >
> > On this SoC (and in the forthcoming support for E3 R8A77990) the VIN groups
> > could appear on different sets of pins, usually the 'a' and 'b' one.
> >
> > With the existing VIN_DATA_PIN_GROUP macro we have to specify group names as:
> >
> > VIN_DATA_PIN_GROUP(vin4_data_a, 8)
> >
> > which results in the group being named as "vin4_data_a_8" which is
> > un-consistent with the canonical group names (eg. "vin4_data8_a").
> >
> > This series adds a macro that allows to specify the group 'version' along with
> > the pin and mux numbers in patch [1/1]. I haven't been able to find a better
> > term than 'version' as 'group' was already taken. Suggestions welcome.
>
> Yeah, the datasheet also calls these groups :-(
> A possible alternative is to use "variant"?
>
> Or, what about avoiding the name issue by making the VIN_DATA_PIN_GROUP()
> macro varargs, and passing the "variant" as the (optional) third parameter?
> That way existing users work as a before, while you can also write e.g.
>
>     VIN_DATA_PIN_GROUP_VER(vin4_data, 8, _a),

Indeed.

Would something along the following lines fly for you?

#define VIN_DATA_PIN_GROUP(n, s, ...)					\
	{								\
		.name = #n#s#__VA_ARGS__,				\
		.pins = n##__VA_ARGS__##_pins.data##s,			\
		.mux = n##__VA_ARGS__##_mux.data##s,			\
		.nr_pins = ARRAY_SIZE(n##__VA_ARGS__##_pins.data##s),	\
	}

It can be used as:
VIN_DATA_PIN_GROUP(vin4_data, 8, _a),
VIN_DATA_PIN_GROUP(vin5_data, 8),

With your ack on this, I'll send v2.

Thanks
  j
>
> > As I cannot test VIN4 nor VIN5 on Salvator-XS as the parallel pins are not
> > wired, I made sure the macro creates correct names and fields not only by
> > compile testing it, but with a small C program [1] that replicates the VIN data
> > layout defined in the PFC module and access fields (and has helped me testing
> > more easily the preprocessor stringification/concatenation process).
> >
> > Final note: Simon, you took the E3 patches in your tree, and I expect them to
> > land on v4.20-rc1. They use the old macros, are follow up patches ok?)
>
> Which patches are using these macro names, and are in v4.20-rc1?
>
> BTW, "grep vin._data_[a-z][0-9] drivers/pinctrl/sh-pfc/*o" tells me we already
> have broken groups names on r8a7792, r8a7795, and r8a7796.
> Fortunately we have no known users of them, so they can be fixed.
>

On v4.20-rc1 the grep returns none for me :/
git grep v4.20-rc1 "vin._data_[a-z][0-9]" drivers/pinctrl/sh-pfc/

Thanks
   j

> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

--4ECF1u7dKBoUGhe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJb4VnsAAoJEHI0Bo8WoVY8k48P/1kM1SvF1uJqnu7GdAkYEbNP
42luyW2+tG45b0QGnsSUaHdrSdVAEXC5wiAmIPzSIPiK5z30a5TELGHXigjHtDH/
zgusVGXevyzPBiwiKZKSHsq7KZdoRwm5K+agQrAdxButprpzFOQGT2bh280waaEj
8eAlGo+iJZG3758w4vZxmc0UiiqNvXAmYRH1pPf6Na1u/G+fpX2u6J2vt5vR6UhH
51K67yojluSoX9em+YU3dooHt68A7aRoyczHkWbOaSIeyVnwt+s8RCsSO9GhiQDY
Y/yY+D4PF20VpdTXhW66JqhaURR3rhCrv+csk7B1uHKexnT0KAPkXRm93nHN9lY4
4vyMWJzj/bbPys/iG/WfoNk3R7quJb1sW6KhQtYBUC8rp+IM1EqUcFt/qd7n26me
vckl6aweQNLSxifs9qlfXd4ttFtvwlfzt7WbvxGLJ0FZC+Njjpn4TsPMrakIMofu
C3JCeeG82BvSq3W+2xC/pgjyMMS6gkdie86WS8kcrPHrJ+eqEhoEOodfN+at/Bvk
3ilVBQ5tZ9ILgpcOUXvVNzXYgRG4li8i37rVdpfJeuSs+4IfUEb+GNyIp9uigBen
xyVNSkjUpod76Ez1tOGjDXPotlumJaZ2wq6pKAA+g1KJ545FGRT766mkmDFaHYCn
tQmhaLlAXWO4S17zwNp/
=qSyo
-----END PGP SIGNATURE-----

--4ECF1u7dKBoUGhe3--
