Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA89C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B797D2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfBKNYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:24:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49505 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfBKNYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:24:09 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A1BF080501; Mon, 11 Feb 2019 14:24:00 +0100 (CET)
Date:   Mon, 11 Feb 2019 14:24:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kjlu@umn.edu, pakki001@umn.edu,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] base: fix a missing check of clk_prepare
Message-ID: <20190211132406.GB11067@amd>
References: <20181226024700.72318-1-kjlu@umn.edu>
 <CAJZ5v0iK+ASbadEjj+9vgCV+1ycjp8Hs2GbEmT3dGSqjLVGbPA@mail.gmail.com>
 <20181231172556.GA14092@amd>
 <CAJZ5v0hOKXkZbpchv9+23uTgZyeq_3oQHznPKR3-+X43JakGeg@mail.gmail.com>
 <20190101202119.GA13097@amd>
 <CAJZ5v0iJCaCju7sgCF9u7PYxmHF0jQDy95_QEVt8q+R2NX5zAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iJCaCju7sgCF9u7PYxmHF0jQDy95_QEVt8q+R2NX5zAA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-01-01 22:05:39, Rafael J. Wysocki wrote:
> On Tue, Jan 1, 2019 at 9:21 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > On Tue 2019-01-01 21:13:01, Rafael J. Wysocki wrote:
> > > On Mon, Dec 31, 2018 at 6:25 PM Pavel Machek <pavel@ucw.cz> wrote:
> > > >
> > > > On Wed 2018-12-26 10:37:54, Rafael J. Wysocki wrote:
> > > > > On Wed, Dec 26, 2018 at 3:47 AM Kangjie Lu <kjlu@umn.edu> wrote:
> > > > > >
> > > > > > clk_prepare() could fail, so let's check its status, and if it =
fails,
> > > > > > issue an error message.
> > > > > >
> > > > > > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > > > > > ---
> > > > > >  drivers/base/power/clock_ops.c | 4 +++-
> > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/powe=
r/clock_ops.c
> > > > > > index 5a42ae4078c2..cb6144fb24e2 100644
> > > > > > --- a/drivers/base/power/clock_ops.c
> > > > > > +++ b/drivers/base/power/clock_ops.c
> > > > > > @@ -65,7 +65,9 @@ static void pm_clk_acquire(struct device *dev=
, struct pm_clock_entry *ce)
> > > > > >         if (IS_ERR(ce->clk)) {
> > > > > >                 ce->status =3D PCE_STATUS_ERROR;
> > > > > >         } else {
> > > > > > -               clk_prepare(ce->clk);
> > > > > > +               if (clk_prepare(ce->clk))
> > > > > > +                       dev_err(dev, "clk_prepare failed.\n");
> > > > >
> > > > > I'm not sure that this is useful.  The code continues regardless =
of
> > > > > the error anyway and it should at least set ce->status to
> > > > > PCE_STATUS_ERROR in the failing case.
> > > >
> > > > Maybe this is not complete fix, but dev_err() is preferable to sile=
nt
> > > > failure.
> > >
> > > Preferable to you I suppose?
> >
> > Preferable to the poor person trying to figure out why his machine
> > does not work?
>=20
> Not really, unless that person knows what the message means.
>=20
> Honestly, what would you do if you saw that message?

Grep it in the kernel sources. Having something to grep for
(vs. machine that fails to work properly) is quite important.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxhd3YACgkQMOfwapXb+vKzLwCffEdNUlOcZCUYak6EBr4/f/6G
IF4AoJiVgIYSQSyZqeIcHTmllY4ulRhZ
=KhsR
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
