Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7633FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DC220652
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeLaRZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:25:59 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60412 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeLaRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 12:25:58 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5B473808AC; Mon, 31 Dec 2018 18:25:52 +0100 (CET)
Date:   Mon, 31 Dec 2018 18:25:56 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kjlu@umn.edu, pakki001@umn.edu,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] base: fix a missing check of clk_prepare
Message-ID: <20181231172556.GA14092@amd>
References: <20181226024700.72318-1-kjlu@umn.edu>
 <CAJZ5v0iK+ASbadEjj+9vgCV+1ycjp8Hs2GbEmT3dGSqjLVGbPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iK+ASbadEjj+9vgCV+1ycjp8Hs2GbEmT3dGSqjLVGbPA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-12-26 10:37:54, Rafael J. Wysocki wrote:
> On Wed, Dec 26, 2018 at 3:47 AM Kangjie Lu <kjlu@umn.edu> wrote:
> >
> > clk_prepare() could fail, so let's check its status, and if it fails,
> > issue an error message.
> >
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> >  drivers/base/power/clock_ops.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_=
ops.c
> > index 5a42ae4078c2..cb6144fb24e2 100644
> > --- a/drivers/base/power/clock_ops.c
> > +++ b/drivers/base/power/clock_ops.c
> > @@ -65,7 +65,9 @@ static void pm_clk_acquire(struct device *dev, struct=
 pm_clock_entry *ce)
> >         if (IS_ERR(ce->clk)) {
> >                 ce->status =3D PCE_STATUS_ERROR;
> >         } else {
> > -               clk_prepare(ce->clk);
> > +               if (clk_prepare(ce->clk))
> > +                       dev_err(dev, "clk_prepare failed.\n");
>=20
> I'm not sure that this is useful.  The code continues regardless of
> the error anyway and it should at least set ce->status to
> PCE_STATUS_ERROR in the failing case.

Maybe this is not complete fix, but dev_err() is preferable to silent
failure.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwqUSQACgkQMOfwapXb+vKKrgCfYSVPtLVt99EJ8U1NSzV5LWrF
UJ0AnjHov6Mrph7fjED8UpzRu6CewMHV
=V+B0
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
