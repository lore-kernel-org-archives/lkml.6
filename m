Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C562BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 01:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5A92083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 01:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5A92083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIAFhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 01:37:14 -0400
Received: from shelob.surriel.com ([96.67.55.147]:54310 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeIAFhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 01:37:14 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fvugq-000898-3z; Fri, 31 Aug 2018 21:27:04 -0400
Message-ID: <68c883be3b4562970cef76c574e2e345e0d514e6.camel@surriel.com>
Subject: Re: [PATCH] mm: slowly shrink slabs with a relatively small number
 of objects
From:   Rik van Riel <riel@surriel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 31 Aug 2018 21:27:03 -0400
In-Reply-To: <20180831213138.GA9159@tower.DHCP.thefacebook.com>
References: <20180831203450.2536-1-guro@fb.com>
         <3b05579f964cca1d44551913f1a9ee79d96f198e.camel@surriel.com>
         <20180831213138.GA9159@tower.DHCP.thefacebook.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3/ubquztSqUU4YdQHWI2"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3/ubquztSqUU4YdQHWI2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-08-31 at 14:31 -0700, Roman Gushchin wrote:
> On Fri, Aug 31, 2018 at 05:15:39PM -0400, Rik van Riel wrote:
> > On Fri, 2018-08-31 at 13:34 -0700, Roman Gushchin wrote:
> >=20
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index fa2c150ab7b9..c910cf6bf606 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -476,6 +476,10 @@ static unsigned long do_shrink_slab(struct
> > > shrink_control *shrinkctl,
> > >  	delta =3D freeable >> priority;
> > >  	delta *=3D 4;
> > >  	do_div(delta, shrinker->seeks);
> > > +
> > > +	if (delta =3D=3D 0 && freeable > 0)
> > > +		delta =3D min(freeable, batch_size);
> > > +
> > >  	total_scan +=3D delta;
> > >  	if (total_scan < 0) {
> > >  		pr_err("shrink_slab: %pF negative objects to delete
> > > nr=3D%ld\n",
> >=20
> > I agree that we need to shrink slabs with fewer than
> > 4096 objects, but do we want to put more pressure on
> > a slab the moment it drops below 4096 than we applied
> > when it had just over 4096 objects on it?
> >=20
> > With this patch, a slab with 5000 objects on it will
> > get 1 item scanned, while a slab with 4000 objects on
> > it will see shrinker->batch or SHRINK_BATCH objects
> > scanned every time.
> >=20
> > I don't know if this would cause any issues, just
> > something to ponder.
>=20
> Hm, fair enough. So, basically we can always do
>=20
>     delta =3D max(delta, min(freeable, batch_size));
>=20
> Does it look better?

Yeah, that looks fine to me.

That will read to small cgroups having small caches
reclaimed relatively more quickly than large caches
getting reclaimed, but small caches should also be
faster to refill once they are needed again, so it
is probably fine.

--=20
All Rights Reversed.

--=-3/ubquztSqUU4YdQHWI2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluJ6ucACgkQznnekoTE
3oPKyQf+MxHOnVs6t4PZLXi0UsLb/iVrpKqFJmOeMFpXlBV9SL+JtNNRynMahji6
Jf2R4XiQ+l83xdynzaawtTXfPb5bUSkyYXqpgXSYkul7whLIJqVvD7PmN77BLugs
siPBZp/rfoOJHCae7wazEJb3f3xa0420d5EViVTHLrTGnRJS9raWAFtGJr8wR+dK
c5PMVPSOJAFgAKwDb00SUSj/DiMa9hgZsp0joVxxr+ofkpabFIr3/5JOcyuaZLo7
3Mw6J9hgCML5LZA3WzBEdsAQormFOG2JZZvNW/ipbIMXJpyapSVKlZ9qCwH6IIt9
MoxJLSKdtF/0N5cih5kR9xUwDR23yQ==
=ogZz
-----END PGP SIGNATURE-----

--=-3/ubquztSqUU4YdQHWI2--

