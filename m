Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeD3I2L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:28:11 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:39630 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752354AbeD3I1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:27:53 -0400
X-Google-Smtp-Source: AB8JxZpYEYIhgCGtrW8LwnbF9oy9BtDgJrdqxWGL5Ub8F2cYxJTBNbGuAwyDER98hUzmWdEKHn0+ew==
Date: Mon, 30 Apr 2018 10:27:50 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Wesley Terpstra <wesley@sifive.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: added new pwm-sifive driver
 documentation
Message-ID: <20180430082750.GI2484@ulmo>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-2-git-send-email-wesley@sifive.com>
 <20180429055417.GA10221@mithrandir>
 <CAMgXwTgN26aKaSuVdSj2TDUgbR7bAmy4TdtOuKj_QC0kNNbphg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Content-Disposition: inline
In-Reply-To: <CAMgXwTgN26aKaSuVdSj2TDUgbR7bAmy4TdtOuKj_QC0kNNbphg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 29, 2018 at 01:51:34PM -0700, Wesley Terpstra wrote:
> On Sat, Apr 28, 2018 at 10:54 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Fri, Apr 27, 2018 at 03:59:56PM -0700, Wesley W. Terpstra wrote:
> >> +Unlike most other PWM controllers, the SiFive PWM controller currentl=
y only
> >> +supports one period for all channels in the PWM. This is set globally=
 in DTS.
> >> +The period also has significant restrictions on the values it can ach=
ieve,
> >> +which the driver rounds to the nearest achievable frequency.
> >
> > How about you encode this in the driver rather than DT? We have several
> > drivers with similar restrictions and they usually allow the first PWM
> > channel to choose an arbitrary period and return an error if subsequent
> > channels request a period that can't be supported.
> >
> > I think something similar could work with that second restriction. Why
> > not return an error if the exact period can't be set? Or perhaps allow
> > some percentage of deviation.
>=20
> Interesting. There are two ways to use this PWM. In one mode you use
> all channels of the PWM as outputs. This is the mode the driver
> supports because the HiFive Unleashed board uses all channels
> connected to LEDs.
>=20
> In this case, the PWM period must always be a power-of-two reduction
> from the core bus clock frequency. The core bus clock frequency can
> vary. Therefore, even if the caller's frequency can be achieved at the
> time of the method call, it may not remain achievable. You might say
> this is a ridiculous PWM design, and I'd agree with you, but sadly
> this is what is found in these chips. So effectively, the only thing
> we can guarantee is that the period is within a multiple of sqrt(2)
> from the requested period, except even that is not true due to
> saturation restrictions that could push the period even further from
> what you ask.
>=20
> In the other mode (where you sacrifice one of the output channels),
> you have finer control of the period, but it still affects all
> channels. This mode might be a better fit for your proposed API,
> except that the driver would still be subject to saturation
> restrictions on the period. And those restrictions will change as the
> core bus frequency is changed, which means that again, even if your
> target period can be achieved (common to all channels) at invocation,
> it might not be achievable later.
>=20
> IMO the only real control this PWM can offer reliably is the duty
> cycle, which is why I've written it how I have.
>=20
> If you see a better solution to the above problems, I am open to
> suggestions.

I don't like the idea of specifying something in DT that is completely
approximate because it doesn't give users any kind of control over what
is considered acceptable. In some cases an approximation to within 10%
might be acceptable, in other cases users may only want to allow 5%. In
this case there's even no way to catch or report a deviation from the
desired value.

How about you allow users to specify a valid frequency range with
something like:

	frequency-range =3D <MIN MAX>;

or

	period-range =3D <MIN MAX>;

That would on one hand give users a way of specifying the valid range of
frequencies and give your driver enough data to reject a change if it'd
result in a frequency outside of the configured range. You would also
have the possibility to react if a change in core bus clock frequency
causes the PWM period to go out of range. I wonder if there's a
mechanism that allows the clock change to be prevented (via a PRE_CHANGE
notifier perhaps?), but if not at least you could disable the PWM if it
was fed with an invalid range.

Rob, any additional thoughts from you on this matter?

Thierry

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm04YACgkQ3SOs138+
s6HPNA/9Hck9+p2yppeTRjfr1CJ+Vy9PtFuxpAezhLRtzn0PWS65loEjwkTah9Qe
azYrsnHpRUNwr3B/IuxhZ3jqh93wd7wILV9bgLlYYc9iZ/Q1Ki7A/YT+FLvtEyjv
hg/aRzefPbjhDPqt3TsBt/by8eu7KNeAHheCd3pFGkZ9Hz0cWN9Z/HimknlvIAKg
myES7vJQjYm4g6k/YmKhfxI875HAMAvINaC09obsr3piFRloBb0odJ3YX4Wt913I
0kMn+qwZv2iChvZzVKkcoqSrXoWwyvvuRVEFYw0BrChwjOhyTefvsyD9/rsppTdv
mf25wHBSAIMC54Q2FgNBWpCkhFuAw3xMToOUt2rKyD13V6TxSZJe4cLoiQ53kNy/
bQ08alp16PEffHF/68K8slEI47t+dsZFmT2qll+OuAm85ntzNuc5w8y+LuG6hBjb
a3HlhkXD1k6WliU0GYb96xdRgwPkbhs9cpyup9SOQFZfjfInDpeRHGG+vwejZOBl
PuncyY/asviz2UkK7zS5IIkjAOgkS+TCyw+99/lgS2pECrubQ8TUgoSEg8tkqQDl
zFlJAt48BSvPKZHcJYEVNtOGQ5qeIw+Ns0G75OzXX7VO8jGHH5zI3se8fLcNrHWK
Irc2FCRc6NEh8AmjY8EL6lOrQ4xHDk3d4p4XvzHH/fxPNZkSUI8=
=e6AQ
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--
