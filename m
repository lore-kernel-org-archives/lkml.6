Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DDBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF91B2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfA1UeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:34:07 -0500
Received: from shelob.surriel.com ([96.67.55.147]:43018 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA1UeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:34:07 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1goDbX-0007BA-AU; Mon, 28 Jan 2019 15:34:03 -0500
Message-ID: <d4e9359fdb3817bbc2b2c7cea368f8fd0dc7da62.camel@surriel.com>
Subject: Re: [PATCH] mm,slab,vmscan: accumulate gradual pressure on small
 slabs
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Chris Mason <clm@fb.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>
Date:   Mon, 28 Jan 2019 15:34:03 -0500
In-Reply-To: <20190128121028.8ef4c19dd3fd1d60d2e3284c@linux-foundation.org>
References: <20190128143535.7767c397@imladris.surriel.com>
         <20190128115424.df3f4647023e9e43e75afe67@linux-foundation.org>
         <8ddf2ea674711f373062f4e056dd14fb81c5a2fe.camel@surriel.com>
         <20190128121028.8ef4c19dd3fd1d60d2e3284c@linux-foundation.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rjs2+VELR5ryBMzF0Fbr"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rjs2+VELR5ryBMzF0Fbr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-01-28 at 12:10 -0800, Andrew Morton wrote:
> On Mon, 28 Jan 2019 15:03:28 -0500 Rik van Riel <riel@surriel.com>
> wrote:
>=20
> > On Mon, 2019-01-28 at 11:54 -0800, Andrew Morton wrote:
> > > On Mon, 28 Jan 2019 14:35:35 -0500 Rik van Riel <riel@surriel.com
> > > >
> > > wrote:
> > >=20
> > > > memory.
> > > >  	 */
> > > > -	delta =3D max_t(unsigned long long, delta, min(freeable,
> > > > batch_size));
> > > > +	if (!delta) {
> > > > +		shrinker->small_scan +=3D freeable;
> > > > +
> > > > +		delta =3D shrinker->small_scan >> priority;
> > > > +		shrinker->small_scan -=3D delta << priority;

When delta is a non-zero number, we subtract (delta << priority)
from shrinker->small_scan.

That should happen every time delta >=3D (1<<priority), which is
4096 for DEF_PRIORITY.

> > > > +
> > > > +		delta *=3D 4;
> > > > +		do_div(delta, shrinker->seeks);
> > >=20
> > > What prevents shrinker->small_scan from over- or underflowing
> > > over
> > > time?
> >=20
> > We only go into this code path if
> > delta >> DEF_PRIORITY is zero.
> >=20
> > That is, freeable is smaller than 4096.
> >=20
>=20
> I'm still not understanding.  If `freeable' always has a value of
> (say)
> 1, we'll eventually overflow shrinker->small_scan?  Or at least, it's
> unobvious why this cannot happen.
--=20
All Rights Reversed.

--=-rjs2+VELR5ryBMzF0Fbr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlxPZzsACgkQznnekoTE
3oOmVwf/Y6GZfr1jizlPlmJ8N8/biC88i2jgOJ0lcwGiQayXBu5E3OdH66QhVzi8
RfXbwYurPgoS27JZUmDc1aRuxj6Ueb6YyeJ3pAM4G4pa4TVTM/yoTp9h1JVGFiGK
+82nTKdbHtiRabzwGoE0bHx/DriKGNEKzHEus6ikrj2SSCa7rFJ//3MEIBKnVoT/
ua3diiob0opvUrVD1oU+Qr87yQtG/Fh4CgS4CF+oTCsZspNsRTXknqWHVyF7S0W6
i/LasJK4iTZ5toDtTcBeqYJS9VpbEK1UiAw6LSzJoE+Js2Qkr4CX3euBe6fvszdd
XJ0O8eEdqfG/oDytFji+LSmEeRu0sQ==
=VeYE
-----END PGP SIGNATURE-----

--=-rjs2+VELR5ryBMzF0Fbr--

