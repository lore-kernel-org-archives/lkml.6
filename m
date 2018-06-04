Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeFDDjA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 23:39:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:59146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbeFDDi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 23:38:58 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 04 Jun 2018 13:38:46 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 04/18] rhashtable: detect when object movement might have invalidated a lookup
In-Reply-To: <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au>
References: <152782754287.30340.4395718227884933670.stgit@noble> <152782824943.30340.8224535954517915320.stgit@noble> <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au>
Message-ID: <87k1rfp6ex.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 02 2018, Herbert Xu wrote:

> On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
>> Some users of rhashtable might need to change the key
>> of an object and move it to a different location in the table.
>> Other users might want to allocate objects using
>> SLAB_TYPESAFE_BY_RCU which can result in the same memory allocation
>> being used for a different (type-compatible) purpose and similarly
>> end up in a different hash-chain.
>>
>> To support these, we store a unique NULLS_MARKER at the end of
>> each chain, and when a search fails to find a match, we check
>> if the NULLS marker found was the expected one.  If not,
>> the search is repeated.
>>=20
>> The unique NULLS_MARKER is derived from the address of the
>> head of the chain.
>
> Yes I thinks makes a lot more sense than the existing rhashtable
> nulls code.  The current rhashtable nulls code harkens back to the
> time of the old rhashtable implementation where the same chain
> existed in two different tables and that is no longer the case.
>
>> If an object is removed and re-added to the same hash chain, we won't
>> notice by looking that the NULLS marker.  In this case we must be sure
>
> This is not currently required by TCP/UDP.  I'd rather not add
> extra constraints that aren't actually used.

I assume you are referring here to the change to insert at the head of
the chain, rather than at the end.
This is important for me to be able to use SLAB_TYPESAFE_BY_RCU
for the kmem_cache.  Without that, I need a new rcu-free callback
for every different kmem_cache.
When using SLAB_TYPESAFE_BY_RCU, there is no way to know where
a freed and re-allocated object might be used again - it could
be used in the same table with the same hash value.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsUtEYACgkQOeye3VZi
gbnJzw/9E3yArpPPJiNiuoT4TsqGwH2v2iO8Qd2lfOTp43Y2MPCmgsxGsstwT0Lr
SXlzelx1tjlhzTebWbDB3d/oHWBUMcEJKqqez+r0LFQq+qHIBjjgizi0R0mxBbfg
ADOPtzK7ONFG5/s8aYHb7OHhNO8cLE2mvHXhv1iu/EzxDqoI4xAtviI8EZegCGup
PQwMGFczxtX7kJ/c1ENqDxBQSWVGOjZQ5NvtlQYgoszIj28UuY7ln/4x9Fg3bMNv
bq4ZsBGod+rR/y+w7e3HG1/6rp6vbqlBS4thrqecD50nV3pNR36nLjJ4CaTqmzgZ
sDDohnjCa4UVtYl8JNiI7g7sRZYbejf4BLMq8cEowyvZZiMwxgWGolW8v/whOxp4
RYFcmaSfU9jP8njQOunkRUvT2JfNe9/Ab9dMwkC+HPK603JnV6BASHtC4bwZtyAM
afM5+0qD4o2kGxDYUDSD+XgRwGpV4w94IGdax/vtH3lTG3/utIJAV2TKaGmXpP4A
NGI4D8qjEWekICaX8+ZSOcMamFiOhvNtyPRaPdV2S0TOKOXmOlZiVlDwYK7iwLHd
OjJMfgduEHS9ACp1b/uvqpj1j4Tx0bOYzm+A+AUU2BJMiH3rZLzmVoAfDrm3HQFR
hgp36mVDVZUEh1tHTLbvAsyl0/1clpW7ZAy5Vic4yXxYOicwX7U=
=skn/
-----END PGP SIGNATURE-----
--=-=-=--
