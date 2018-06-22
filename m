Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD9FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D311423D9C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D311423D9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbeFVGEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:04:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:41620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbeFVGEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:04:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8A9A8AC06;
        Fri, 22 Jun 2018 06:04:40 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Date:   Fri, 22 Jun 2018 16:04:29 +1000
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, mhocko@kernel.org,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/4] lib/rhashtable: simplify bucket_table_alloc()
In-Reply-To: <20180621212825.3059-2-dave@stgolabs.net>
References: <20180621212825.3059-1-dave@stgolabs.net> <20180621212825.3059-2-dave@stgolabs.net>
Message-ID: <87sh5fbbma.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21 2018, Davidlohr Bueso wrote:

> As of ce91f6ee5 (mm: kvmalloc does not fallback to vmalloc for incompatib=
le gfp flag),
> we can simplify the caller and trust kvzalloc() to just do the right thin=
g.

Hi,
 it isn't clear to me that this is true.
 With this change we lose __GFP_NOWARN and __GFP_NORETRY.
 I doubt the NORETRY is particularly important as this is if it
 isn't GFP_KERNEL, then it is GFP_ATOMIC which doesn't retry anyway.
 However I cannot see why this patch won't result in warnings when the
 kzalloc() fails.
 What am I missing?

Thanks,
NeilBrown


>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  lib/rhashtable.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 9427b5766134..26c9cd8a985a 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -175,10 +175,7 @@ static struct bucket_table *bucket_table_alloc(struc=
t rhashtable *ht,
>  	int i;
>=20=20
>  	size =3D sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
> -	if (gfp !=3D GFP_KERNEL)
> -		tbl =3D kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
> -	else
> -		tbl =3D kvzalloc(size, gfp);
> +	tbl =3D kvzalloc(size, gfp);
>=20=20
>  	size =3D nbuckets;
>=20=20
> --=20
> 2.16.4

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsskW4ACgkQOeye3VZi
gbn7zg//fU8eWByU5G8DUvjNQb8M8sQr9j9WeuCp+qdY5tY+x/XvrMjDS/VV/bTL
oz4Dn5xOTMRTWwIemTbZjmtFnTrWlcq9+41RfFt6q5olObhRz8YP61Wh8PJ8Fw/a
L8PobNEZEtOjyM6+2tzyQfVDLpE2DExP5LGHrFsyO8DW3H5ySr3PsXzPIgQ0Gr4l
NYaBZu3RJ5s6jyH4qqfWvc/6Uhsb0gDYbGZsFqMzIY7Tus6zekWOEzDhIWTa7lDd
p7m4qNbIob8Qe9DyeCtMYOzNsvghNnGo1I3tX/2776kRGyC569Rh8/UcVBGih6No
egx76xidljBL3kCUimOWDCwC/twrZCu2e7WMrib/bhjXnyak4UnZdMnYkgZdEevF
dehDM7q+8Er8Vk9aGGZcVzWWcVae9F3anINuE/5ubgciKqhgazovTSU2HcfxZskd
kyBoxNII+5raSG1X+pur8obZ62hts1pvtaxTvfTcqULfdH3E+425vzSGLLi/DB7M
n79PvrxrbPGJghqadPUuhZU9PwU6YnJYpjvUxRFwb5/1YmQhKpmK3/3levhiPGRb
fCg41lm/NpuCgqgxxosFiuc6kA8JCPuAe9lrrqQqI97xOnW1ulxZYvTTgOHzgVn2
wzvIWVst23cvTqCDlWPcFMWxG6cmG1KpW0VgNxn9AtsmiwS7BM4=
=Juyg
-----END PGP SIGNATURE-----
--=-=-=--
