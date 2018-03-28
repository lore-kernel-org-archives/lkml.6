Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeC1Vey (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 17:34:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:49445 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752447AbeC1Vew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 17:34:52 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 29 Mar 2018 08:34:45 +1100
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rhashtable: allow a walk of the hash table without missing objects.
In-Reply-To: <20180328073023.GB17306@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718430.11435.5761213978298714527.stgit@noble> <20180327155118.GB14001@gondor.apana.org.au> <87po3p421q.fsf@notabene.neil.brown.name> <20180328060734.GB16291@gondor.apana.org.au> <87a7us4qje.fsf@notabene.neil.brown.name> <20180328073023.GB17306@gondor.apana.org.au>
Message-ID: <87zi2r3mve.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed, Mar 28 2018, Herbert Xu wrote:

> On Wed, Mar 28, 2018 at 06:17:57PM +1100, NeilBrown wrote:
>>
>> Sounds like over-kill to me.
>> It might be reasonable to have a CONFIG_DEBUG_RHASHTABLE which enables
>> extra to code to catch misuse, but I don't see the justification for
>> always performing these checks.
>> The DEBUG code could just scan the chain (usually quite short) to see if
>> the given element is present.  Of course it might have already been
>> rehashed to the next table, so you would to allow for that possibility -
>> probably check tbl->rehash.
>
> No this is not meant to debug users incorrectly using the cursor.
> This is a replacement of your continue interface by automatically
> validating the cursor.
>
> In fact we can make it even more reliable.  We can insert the walker
> right into the bucket chain, that way the walking will always be
> consistent.
>
> The only problem is that we need be able to differentiate between
> a walker, a normal object, and the end of the list.  I think it
> should be doable.

Yes, I think that could work.  The code to stop over a walker object
during an unlocked search wouldn't be straight forward and would need
careful analysis.

However about storing the hash chains in order by object address?
Then rhashtable_walk_start() can easily find it's place regardless of
whether the old object was still present or not, using <= on the
address.
"Insert" would need to record an insert location and insert there rather
than at the head of the chain.
I might try coding that.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq8CnUACgkQOeye3VZi
gbkCBA//Q2Ye65bKdqqdUVf0DSLWf/xWwBu8nzwhAG2UdW9VPuOCqrAn64bYk93J
mOKh6h6XOvOgrgARYZWRepWpzsTw6Yhrx7elc8D/bSMNo9qxb4huxs+8l0NCThS4
l4EBkslUZbF6Vmk0xPRzQTAqWWemAvQVY16qJRZUfBkL2tjnhQ+alNyM4xfZbmYy
6lQjulTtaMyXohNmAGMvYOmF2k05CLGhNCMFv1P+yX+ncGSvGMkgZQGhMuRzNlF+
nqGAGqJPE3Mf6io49h/WHaM0087fGnZUn0QS2wKDp/Pdly1+eKYqwLRbadn2X0t3
j3wrY08nOP2FlCOu0ZBCdoBGJztobx6u1xx6m+e+m+ov3HHsgxeg6YAxmz3F4YFq
fhFovrEDHF720D/5BYqzIov6eS4RRJl+5wq+hdzKMG7TZXZGJJXd77h9j5CXg5/f
Hy7yL2a/blMjUmwUAy0J5GFE0znxvSf5ME0K+5ZWPDCXzCxKMWbpV7lp2TR4RdOn
R3MUg4atvHnCx21xfRoNTGorIfgS+gcd8VzXtPO7Ap3VEfAu2Mt2DiO/w2sr2/tR
MK+t1YZs0D6fnlQ2Xq2E/MzI/eOqXbEqFqMqIb7kn8znfEsDaLxLPvP9QRIl5qvf
XypQ+GDzG78Ia+ejfzE+Nv2bSrJAHVaDvjTTJjfOd79vHzNR2cQ=
=Uq4N
-----END PGP SIGNATURE-----
--=-=-=--
