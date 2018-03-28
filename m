Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeC1HSI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:18:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:33723 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751070AbeC1HSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:18:06 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 28 Mar 2018 18:17:57 +1100
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rhashtable: allow a walk of the hash table without missing objects.
In-Reply-To: <20180328060734.GB16291@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718430.11435.5761213978298714527.stgit@noble> <20180327155118.GB14001@gondor.apana.org.au> <87po3p421q.fsf@notabene.neil.brown.name> <20180328060734.GB16291@gondor.apana.org.au>
Message-ID: <87a7us4qje.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28 2018, Herbert Xu wrote:

> On Wed, Mar 28, 2018 at 08:54:41AM +1100, NeilBrown wrote:
>>
>> Possibly.
>> I particularly want the interface to require that you pass the
>> previously returned object to _continue. That makes it easy to see that
>> the object is still being used.  If someone changes to code to delete
>> the object before the _continue, there should be a strong hint that it
>> won't work.
>>=20
>> Maybe it would be better to make it a WARN_ON()
>>=20
>>   if (!obj || WARN_ON(iter->p !=3D obj))
>>          iter->p =3D NULL;
>
> This doesn't really protect against the case where obj is removed.
> All it proves is that the user saved a copy of obj which we already
> did anyway.

True.  We ultimately need to trust the user not to do something silly.
We can do little things to help catch obvious errors though.  That was
my intent with the WARN_ON.

>
> To detect an actual removal you'd need to traverse the list.

Yes.  You could reset ->skip to zero and search for the given object.
That feels a bit like excess hand-holding to me, but probably wouldn't
be too expensive.  It only happens when you need to drop out of RCU, and
in that case you are probably already doing something expensive.

>
> I have another idea: we could save insert the walkers into the
> hash table chain at the end, essentially as a hidden list.  We
> can mark it with a flag like rht_marker so that normal traversal
> doesn't see it.
>
> That way the removal code can simply traverse that list and inform
> them that the iterator is invalid.

Sounds like over-kill to me.
It might be reasonable to have a CONFIG_DEBUG_RHASHTABLE which enables
extra to code to catch misuse, but I don't see the justification for
always performing these checks.
The DEBUG code could just scan the chain (usually quite short) to see if
the given element is present.  Of course it might have already been
rehashed to the next table, so you would to allow for that possibility -
probably check tbl->rehash.

Thanks,
NeilBrown

>
> Cheers,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq7QaUACgkQOeye3VZi
gblURA//ULaa2os6nqoB6tj8fHS41EFPAVIgyiPd+AssADhEdhITSHPN71oUPver
2nvABm2dRHrFsBPoLXQoqayFD/rehOIUCDPTL1u3lWuwSXjeYxBf1og7d2z57ry1
nluVjj1ZX26eaaJKtwsetoRTt084lASHq9RmDn4toG4vsfaTaW7GCrdIQET+hcNk
ijqAMdXk3TGCedq2qyeoYhUxGctOOm+Rm3ed6BJMjjIm+Ol63BobB6CSthDDZHW2
Id9gC5e+Ecp8qrOrEh4v12c5erW6pumRKc5tppJ7+ZPHCg5w6vQclUxuly0w9UXp
2Nxu/dYGa6f4oqh/YmRLPAQ5YlcMG9d67jK9xNMKAZQJYmtElgm1DvaYSHbhv+IU
RmAzWUNUsuaxxQ8TZTh0qRYk/OnJfWzXCjFUXi7uuNAvlqRRVPnvMoadNp4Ot4+6
edTTO05f3BHCLPgP3m0DvhzuT+3gnKvhgzKg701fTQbWc8sy5BV7ZfypvKcQ4FXU
6IPwC/t9ey2VaG+CHx9laPCPA/o3z3vtSsTLKMZIN+F+bsWqXNfGtGNobLWy+nhw
67DgZpGHOSBABbM76dp4OskUSOi+R3pHFz0PdkYQ060Lq0/12ISLw9liSXy5ewk5
6dcMaXtr9UsiVbyJDg82UAXwJv1oOPvsHnMm6TGQDRAAFxuV8Jc=
=wylA
-----END PGP SIGNATURE-----
--=-=-=--
