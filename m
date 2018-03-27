Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeC0Veb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:34:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:54022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbeC0Ve3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:34:29 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 28 Mar 2018 08:34:19 +1100
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] rhashtable: support guaranteed successful insertion.
In-Reply-To: <20180327155610.GD14001@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718434.11435.6551477417902631683.stgit@noble> <20180327155610.GD14001@gondor.apana.org.au>
Message-ID: <87y3id42zo.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27 2018, Herbert Xu wrote:

> On Tue, Mar 27, 2018 at 10:33:04AM +1100, NeilBrown wrote:
>> The current rhashtable will fail an insertion if the hashtable
>> it "too full", one of:
>>  - table already has 2^31 elements (-E2BIG)
>>  - a max_size was specified and table already has that
>>    many elements (rounded up to power of 2) (-E2BIG)
>>  - a single chain has more than 16 elements (-EBUSY)
>>  - table has more elements than the current table size,
>>    and allocating a new table fails (-ENOMEM)
>>  - a new page needed to be allocated for a nested table,
>>    and the memory allocation failed (-ENOMEM).
>>=20
>> A traditional hash table does not have a concept of "too full", and
>> insertion only fails if the key already exists.  Many users of hash
>> tables have separate means of limiting the total number of entries,
>> and are not susceptible to an attack which could cause unusually large
>> hash chains.  For those users, the need to check for errors when
>> inserting objects to an rhashtable is an unnecessary burden and hence
>> a potential source of bugs (as these failures are likely to be rare).
>
> Did you actually encounter an insertion failure? The current code
> should never fail an insertion until you actually run ouf memory.
> That is unless you're using rhashtable when you should be using
> rhlist instead.

It is easy to get an -EBUSY insertion failure when .disable_count is
enabled, and I did get that.  Blindly propagating that up caused lustre
to get terribly confused - not too surprising really.

Even if I didn't seem errors in practive, if the interface can return an
error, then I need to check for the error and really should test that
handling each error works correctly.  It is much easier to write
reliable code when errors cannot happen, so I'd rather have that option.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq6uNsACgkQOeye3VZi
gbkoRA/9FR1eT6z4NUj1YbDVyUfZUKROfMiIk3s5TFS0yrgk6LSxqvpJshjgEw5z
SwBj4s0u7Rb6cwJzYDLrF6bGN6Plh3gMgeftofjyn7u0DjS70JsgN6gOe6QGEX9R
f7285QHAH1m3YFJn402Y+J0BdgSPL8ZZLZ1QY4bIfPKBOd3I/JTBCfMUwjy2/Utk
78/ul8cdFyt0xzNCb4zs0GZTB8VdCk3rLzaYm/IyUGP8BVGw4HAqOhCmnMu0lcNv
4/8NzMOoc2IJOh+kF8B5fMs8bDknvqoiX3DYWuAQuRJJGDm2YQoS2lhQXk2DFdhc
PXdqLPtQAdM3nywIKWWXgc3SwuHkCSiSw+irYVmFpuJ7wwS8rToWOH+9bgdk1Htu
F+8shb/MVq/GqlkSLMsiIm3XbuC1uXsHzJK2kjA/fUufXEAVtKdPVDjS4TQKTRjM
XaHYiH9DNXoQc4E6MRRhawgen2vMkbtEwdD/SjqBjNo2uln/mRFfhy/ya9uI36Rl
l/sOYn4ymSkT63VyV46LfT+rMALoqv3IA9KS1Hx1BPpW1PT69Ry8zlbsorK/f50a
I0AFsurfKxRRBDU72VpTUwgP3tpVgs4xHQcrbqI53uIMyg3s5rDerYw7WSteLnyk
sf0Vo/edHOMGP0W5eLn5XheVxcUgGkEfgkSF+ENKHGbfkJuVTb0=
=5Aze
-----END PGP SIGNATURE-----
--=-=-=--
