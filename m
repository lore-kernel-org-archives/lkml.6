Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7908EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AB3254D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AB3254D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbeGBGok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:44:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46133 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752767AbeGBGoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:44:37 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 98DBB207BE; Mon,  2 Jul 2018 08:44:34 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5427A203B4;
        Mon,  2 Jul 2018 08:44:34 +0200 (CEST)
Date:   Mon, 2 Jul 2018 08:44:33 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>, dedekind1@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 2/2] ubi: expose the volume CRC check skip flag
Message-ID: <20180702064433.kvxcacdhuenzk5j3@qschulz>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
 <382648641.QZzOm4Mo72@blindfold>
 <20180701223347.2cef133b@bbrezillon>
 <3709236.JAAyN4mQyL@blindfold>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="umuyord74gyaitbc"
Content-Disposition: inline
In-Reply-To: <3709236.JAAyN4mQyL@blindfold>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--umuyord74gyaitbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard, Boris,

On Sun, Jul 01, 2018 at 10:50:41PM +0200, Richard Weinberger wrote:
> Am Sonntag, 1. Juli 2018, 22:33:47 CEST schrieb Boris Brezillon:
> > On Sun, 01 Jul 2018 21:35:57 +0200
> > Richard Weinberger <richard@nod.at> wrote:
> >=20
> > > Quentin,
> > >=20
> > > Am Donnerstag, 28. Juni 2018, 09:40:53 CEST schrieb Quentin Schulz:
> > > > Now that we have the logic for skipping CRC check for static UBI vo=
lumes
> > > > in the core, let's expose it to users.
> > > >=20
> > > > This makes use of a padding byte in the volume description data
> > > > structure as a flag. This flag only tell for now whether we should =
skip
> > > > the CRC check of a volume.
> > > >=20
> > > > This checks the UBI volume for which we are trying to skip the CRC =
check
> > > > is static.
> > > >=20
> > > > Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > > > Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > ---
> > > >  drivers/mtd/ubi/cdev.c      |  4 ++++
> > > >  drivers/mtd/ubi/vmt.c       |  3 +++
> > > >  include/uapi/mtd/ubi-user.h | 16 ++++++++++++++--
> > > >  3 files changed, 21 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
> > > > index 45c3296..3eea1df 100644
> > > > --- a/drivers/mtd/ubi/cdev.c
> > > > +++ b/drivers/mtd/ubi/cdev.c
> > > > @@ -622,6 +622,10 @@ static int verify_mkvol_req(const struct ubi_d=
evice *ubi,
> > > >  	    req->vol_type !=3D UBI_STATIC_VOLUME)
> > > >  		goto bad;
> > > > =20
> > > > +	if (req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG &&
> >=20
> > Oops, missed that req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG check was
> > missing parens (checkpatch --strict should complain about that).
>=20
> Latest when building my local branch or in linux-next we had noticed.
> No need to worry.
> =20
> > > > +	    req->vol_type !=3D UBI_STATIC_VOLUME)
> > > > +		goto bad; =20
> > >=20
> > > We should also reject unknown flags here.
> >=20
> > I agree.

Should I send another version of my patches for it? Same for
parenthesis around the flags masking above?

Quentin

--umuyord74gyaitbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJbOcnNAAoJEIS4mnU+4PGjkQcP/ia7t3xzmpc5fWaU9F0h78g3
D7Q9OS6VLBcLpzdLiCpWaVvDTnfrKjr/YlBSvNOHwr3df7KCEstn6pqCyZUjYHbJ
f/NLenL+52hlLYnIqRIO35wh78gXx+xdTQ7vl8igmfwpFaboOvyOkuLR45lEYkWX
YA1GZyLNPUp+b+Pyqsyj5AfMbcrB2+hua7Gp3gGCG4j4NATNtzmXiVNaeJgKj0wB
BxB8O1gWKndVGcyX6K5PSxzTgU/DMvRPGTMB1PEM98UrxnDh3EYTdQGQsG00vapl
Xu77OxVetlHNjMHJ2jwRJXro49aKArPpBb9r8sBG9Olzg76mFs8fb0Pd+lRp3G/u
B/Zw5N7wYjTffFXxiHeAKMDW1W3SonrQi6xgIK/DNItW8ZJgby9sCphMO//o572p
KPclsVF43xfwRoH4Hj2VwEvSC09yNnjEr/AspO0hVRY+r2rqkwr2mUs0LpshYFj3
usWc5CeeTUleoKDrmjNQ1RTUjcdqnrBDFb2so30kfTeX9Fj0WUY35HT6BuwimsoR
V/6NYGuhXb26RnzG35/VTilNxPAHzwkjzBTMvA5QUH76TFRxPYWcsr7SDucYATgT
oWov77/B+n5UiTy5SaAnDDBtYE7hbdXv1yZrlWkXRdAm4fSmNirSDbSEfMifSroC
q5yeS9WO18+mFe2YWCbl
=mvqu
-----END PGP SIGNATURE-----

--umuyord74gyaitbc--
