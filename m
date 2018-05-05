Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeEEVvD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 17:51:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:47214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbeEEVvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 17:51:02 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 06 May 2018 07:50:54 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] rhashtable: further improve stability of rhashtable_walk
In-Reply-To: <20180505094212.hpqjyv5ijibviuwh@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605438.18473.4797800779538116583.stgit@noble> <20180505094212.hpqjyv5ijibviuwh@gondor.apana.org.au>
Message-ID: <87vac1db5t.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, May 05 2018, Herbert Xu wrote:

> On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
>> If the sequence:
>>    obj =3D rhashtable_walk_next(iter);
>>    rhashtable_walk_stop(iter);
>>    rhashtable_remove_fast(ht, &obj->head, params);
>>    rhashtable_walk_start(iter);
>>=20
>>  races with another thread inserting or removing
>>  an object on the same hash chain, a subsequent
>>  rhashtable_walk_next() is not guaranteed to get the "next"
>>  object. It is possible that an object could be
>>  repeated, or missed.
>>=20
>>  This can be made more reliable by keeping the objects in a hash chain
>>  sorted by memory address.  A subsequent rhashtable_walk_next()
>>  call can reliably find the correct position in the list, and thus
>>  find the 'next' object.
>>=20
>>  It is not possible (certainly not so easy) to achieve this with an
>>  rhltable as keeping the hash chain in order is not so easy.  When the
>>  first object with a given key is removed, it is replaced in the chain
>>  with the next object with the same key, and the address of that
>>  object may not be correctly ordered.
>>  No current user of rhltable_walk_enter() calls
>>  rhashtable_walk_start() more than once, so no current code
>>  could benefit from a more reliable walk of rhltables.
>>=20
>>  This patch only attempts to improve walks for rhashtables.
>>  - a new object is always inserted after the last object with a
>>    smaller address, or at the start
>>  - when rhashtable_walk_start() is called, it records that 'p' is not
>>    'safe', meaning that it cannot be dereferenced.  The revalidation
>>    that was previously done here is moved to rhashtable_walk_next()
>>  - when rhashtable_walk_next() is called while p is not NULL and not
>>    safe, it walks the chain looking for the first object with an
>>    address greater than p and returns that.  If there is none, it moves
>>    to the next hash chain.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> I'm a bit torn on this.  On the hand this is definitely an improvement
> over the status quo.  On the other this does not work on rhltable and
> we do have a way of fixing it for both rhashtable and rhltable.

Do we?  How could we fix it for both rhashtable and rhltable?

Thanks,
NeilBrown


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlruJz4ACgkQOeye3VZi
gblVqA/9F7ZODtO/+GOk5akFPqS0M10RD4YyDXTAfbgj0s7tamZXDzXuFPa4VwAK
oLcLgcySX/kfrff6BLv1Z8Y2XqZQKo1cnpxlxf4uhUraoIWcawNARL21TXE/58c0
QVGJEBEofx1uVkifXH4cwuwyNdGbdNEOIVAIUCG71NLFWjiF1nO/xDQx5/RCM8IY
KlPRSAJI8dIY2JMhE5Gc8GvRyoQueR14ExUxb5Adc/LfamhBuDD+jWofshQgtKvn
fSFHOrNet0MpwdY7GRZMX+A3dphelJKZwQ3FCqXK2vsl/S1sge7tWJpMI6gUxb9M
A7eNe2H8FR4E42z8RhjyyplZ6tMA9LM9PCHqOI2tbGwLfwQcXzqF/ZLia7BYb50Y
hKBk+JcPMFwHuc33pJ1WhS5fIhQhAmn0gkcKIZb8fGmDcjAbWgks9QHBW51mBoMT
lle6mKZ5WQuHQyxzqmztdIMJTrHcq7xiGF0MtHyXhnVlOIwOMm7ID6M67iGeTjrR
8EeuPvynf/iRpQTywh3vchK5Q9WiqWh//ACdFbVFilBrrvXgUKYWx1NlAVXOJS00
A8+gqcdJ6skbi5+/sXp9Sb7ekgsHk4pwRCu4XIp4oanDdGxI8FkUvfm1SII6EqCZ
V+wZUayhgmzv0y3YlpwYEKvaGIlbAaNC0B/MgFfjhzA5m6cMiXI=
=S76l
-----END PGP SIGNATURE-----
--=-=-=--
