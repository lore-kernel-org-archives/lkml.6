Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70024C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ECD2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfA1UDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:03:33 -0500
Received: from shelob.surriel.com ([96.67.55.147]:42936 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1UDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:03:33 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1goD7w-0006yz-Lt; Mon, 28 Jan 2019 15:03:28 -0500
Message-ID: <8ddf2ea674711f373062f4e056dd14fb81c5a2fe.camel@surriel.com>
Subject: Re: [PATCH] mm,slab,vmscan: accumulate gradual pressure on small
 slabs
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Chris Mason <clm@fb.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>
Date:   Mon, 28 Jan 2019 15:03:28 -0500
In-Reply-To: <20190128115424.df3f4647023e9e43e75afe67@linux-foundation.org>
References: <20190128143535.7767c397@imladris.surriel.com>
         <20190128115424.df3f4647023e9e43e75afe67@linux-foundation.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nGE8UQknFPEiL8nfsYnb"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nGE8UQknFPEiL8nfsYnb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-01-28 at 11:54 -0800, Andrew Morton wrote:
> On Mon, 28 Jan 2019 14:35:35 -0500 Rik van Riel <riel@surriel.com>
> wrote:
>=20
> >  	/*
> >  	 * Make sure we apply some minimal pressure on default priority
> > -	 * even on small cgroups. Stale objects are not only consuming
> > memory
> > +	 * even on small cgroups, by accumulating pressure across
> > multiple
> > +	 * slab shrinker runs. Stale objects are not only consuming
> > memory
> >  	 * by themselves, but can also hold a reference to a dying
> > cgroup,
> >  	 * preventing it from being reclaimed. A dying cgroup with all
> >  	 * corresponding structures like per-cpu stats and kmem caches
> >  	 * can be really big, so it may lead to a significant waste of
> > memory.
> >  	 */
> > -	delta =3D max_t(unsigned long long, delta, min(freeable,
> > batch_size));
> > +	if (!delta) {
> > +		shrinker->small_scan +=3D freeable;
> > +
> > +		delta =3D shrinker->small_scan >> priority;
> > +		shrinker->small_scan -=3D delta << priority;
> > +
> > +		delta *=3D 4;
> > +		do_div(delta, shrinker->seeks);
>=20
> What prevents shrinker->small_scan from over- or underflowing over
> time?

We only go into this code path if
delta >> DEF_PRIORITY is zero.

That is, freeable is smaller than 4096.

> I'll add this:

> whitespace fixes, per Roman

Awesome, thank you!

--=20
All Rights Reversed.

--=-nGE8UQknFPEiL8nfsYnb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlxPYBAACgkQznnekoTE
3oN05AgAngaeuhkjCHuyhq8zG04YT0jvQFZoWcNexTYi/rVLmxraUqdOJhpgIvFl
YMidQJwFi1448jznIdXf3/dgyvbu5JI+JoyhwlfmLv8wyHGWo59AfSkCT8bAPKR5
qHFY0TQCoOM/QyIW5Qeew5iHjNxceZfLvXNQVlt02jPoR5ysBWC9mudPYHAcTggZ
4fH8MkS8ukd8ykvx+WbEoO8GzTQrqwcc8bvPsl+mq7I+H2V6J1JhzQON3BSYZnNG
1SWKuzYdAYP6pxUXYweEl2YkTm4KtNgcxLPF3T8h99Gwa1/Nb9SvWSp6oZB4s9UD
SWeY7MLKfnBK5aox7F+ilHrcYJrMfw==
=O2ss
-----END PGP SIGNATURE-----

--=-nGE8UQknFPEiL8nfsYnb--

