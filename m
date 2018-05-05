Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeEEWBB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 18:01:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:47585 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeEEWA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 18:00:57 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 06 May 2018 08:00:49 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20180505094117.pl7b6bbk6mtyri6d@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605444.18473.9591316658457316578.stgit@noble> <20180505094117.pl7b6bbk6mtyri6d@gondor.apana.org.au>
Message-ID: <87sh75dapa.fsf@notabene.neil.brown.name>
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
>> rhashtable_try_insert() currently hold a lock on the bucket in
>> the first table, while also locking buckets in subsequent tables.
>> This is unnecessary and looks like a hold-over from some earlier
>> version of the implementation.
>>=20
>> As insert and remove always lock a bucket in each table in turn, and
>> as insert only inserts in the final table, there cannot be any races
>> that are not covered by simply locking a bucket in each table in turn.
>>=20
>> When an insert call reaches that last table it can be sure that there
>> is no match entry in any other table as it has searched them all, and
>> insertion never happens anywhere but in the last table.  The fact that
>> code tests for the existence of future_tbl while holding a lock on
>> the relevant bucket ensures that two threads inserting the same key
>> will make compatible decisions about which is the "last" table.
>>=20
>> This simplifies the code and allows the ->rehash field to be
>> discarded.
>> We still need a way to ensure that a dead bucket_table is never
>> re-linked by rhashtable_walk_stop().  This can be achieved by
>> setting the ->size to 1.  This still allows lookup code to work (and
>> correctly not find anything) but can never happen on an active bucket
>> table (as the minimum size is 4).
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> I'm not convinced this is safe.  There can be multiple tables
> in existence.  Unless you hold the lock on the first table, what
> is to stop two parallel inserters each from inserting into their
> "last" tables which may not be the same table?

The insert function must (and does) take the lock on the bucket before
testing if there is a "next" table.
If one inserter finds that it has locked the "last" table (because there
is no next) and successfully inserts, then the other inserter cannot
have locked that table yet, else it would have inserted.  When it does,
it will find what the first inserter inserted.=20

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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlruKZEACgkQOeye3VZi
gbkLShAAkWzZFmCM0fZVPaahGN4YV3gnD0+umc7IDvvVj50Nxhbzfz7D6UyIgaOs
g8VuAvxiQwofvg6xU+hAWZr3ao4YGqh+ok4dxk5CcZkiU+bsQ8/lJHcuBKAt2xPd
ZodYKB+Zwov9eMYV3vPaq8xyJwmqnVQK9wapwIu2NsZqUsDDjg1ezaWAtVEpjs09
/2qRJ24qcLQSd7IqbwSI1cpzcOcwyzCHBMIHZ2DtWbjgkgx9ofO61s4+e+TQD2IA
kf4t862YmTCz4ekq1uSlThqgtMnFo+6LUxfUANdd2cgVILsHz7JXYdmG75ZlsduQ
DhPPnWQ/MVbQejGxhejQ//SqPz7oNRjK2tpIqfjnCWVzPIKgjtwAaKehW7g0jVoZ
ElzGqqw8PNpxSHvg7xwVvy4RggU8mSYzBRlwrBKTUHGAKOKmrEi6xrPx4i1uf2XT
E3Vn0F5oDUoGBZjXaWn91UlmuFtg9gcVaPK5XTX/veaQrEGRcydDl09uw14Sbai3
aPFfXS8yexo6hEBz1Zca0MLEcpR0u2JpJ3bLbKsbUWgzXozpM90Qw9QQq8a13+sb
tHHYYlcwcnit3OSuzS46at3IU+jMkt3Bc+UCPJ2/6okikiYg9TfxsC0s58h70mXn
ckRSV5NU4AVjFGqy61WJD/agm0GlR9FJ6iut9p0Xvmu2Pq5TgHA=
=D4ym
-----END PGP SIGNATURE-----
--=-=-=--
