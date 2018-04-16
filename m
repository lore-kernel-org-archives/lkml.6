Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDPPH1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:07:27 -0400
Received: from shelob.surriel.com ([96.67.55.147]:49166 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeDPPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:07:26 -0400
Message-ID: <1523891242.27555.9.camel@surriel.com>
Subject: Re: [PATCH] mm: allow to decrease swap.max below actual swap usage
From: Rik van Riel <riel@surriel.com>
To: Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Shaohua Li <shli@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com
Date: Mon, 16 Apr 2018 11:07:22 -0400
In-Reply-To: <20180416013902.GD1911913@devbig577.frc2.facebook.com>
References: <20180412132705.30316-1-guro@fb.com>
         <20180416013902.GD1911913@devbig577.frc2.facebook.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tBA0idIUGrNb7kCfECyR"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tBA0idIUGrNb7kCfECyR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-04-15 at 18:39 -0700, Tejun Heo wrote:
> Hello, Roman.
>=20
> The reclaim behavior is a bit worrisome.
>=20
> * It disables an entire swap area while reclaim is in progress.  Most
>   systems only have one swap area, so this would disable allocating
>   new swap area for everyone.

That could easily cause OOM kills on systems.

I prefer Tejun's simple approach, of having
the system slowly reduce swap use below the
new maximum limit.

> * The reclaim seems very inefficient.  IIUC, it has to read every
> swap
>   page to see whether the page belongs to the target memcg and for
>   each matching page, which involves walking page mm's and page
>   tables.

One of my Outreachy interns, Kelley Nielsen,
worked on making swap reclaim more efficient
by scanning the virtual address space of
processes.

Unfortunately, we ran into some unforseen
issues with that approach that we never managed
to sort out :(

> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
--=-tBA0idIUGrNb7kCfECyR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlrUvCoACgkQznnekoTE
3oP/Bwf+Nc+IRCKzX3QEdvTpUJOaiAFrdGROFUtrGHvZSc9qSvdN+z6TMsCUi6r6
FnXQf1Uf0TRve+ASaJq7O69vpGQTpdhWPQimB1U+aE/JsNmOqAbxwOfsj7fMrkbA
NjsP69KQ8/lAoDEP5ZdZda8VAPm5+psbqj+wagvTTP5IiVAUN/56iafSgHZ+3zmU
NPsEfjXSDUrn7TwoNhTAdM55E5fCgZoUTuajhO6nsROlEqH5k/P+L/o2FPmdUYd2
CzCuKoWprBjrf8MAmX8W0a90DtWiu7q5MKeAwVfEh29OO+kf1w5hVXhBKHf0BVUX
Z4K0PBihXKOZMhzCTq8+IU83zeFeFw==
=YMrS
-----END PGP SIGNATURE-----

--=-tBA0idIUGrNb7kCfECyR--
