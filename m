Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeDRXIQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 19:08:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:46795 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752726AbeDRXIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 19:08:15 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 19 Apr 2018 09:08:07 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] rhashtable: add rhashtable_walk_prev()
In-Reply-To: <20180418143501.kzvknyvgnjo7v75k@gondor.apana.org.au>
References: <152403346237.16895.8767189357062722046.stgit2@noble> <152403402206.16895.14563720960374849428.stgit2@noble> <20180418143501.kzvknyvgnjo7v75k@gondor.apana.org.au>
Message-ID: <87bmegqfjc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18 2018, Herbert Xu wrote:

> On Wed, Apr 18, 2018 at 04:47:02PM +1000, NeilBrown wrote:
>> rhashtable_walk_prev() returns the object returned by
>> the previous rhashtable_walk_next(), providing it is still in the
>> table (or was during this grace period).
>> This works even if rhashtable_walk_stop() and rhashtable_talk_start()
>> have been called since the last rhashtable_walk_next().
>>=20
>> If there have been no calls to rhashtable_walk_next(), or if the
>> object is gone from the table, then NULL is returned.
>>=20
>> This can usefully be used in a seq_file ->start() function.
>> If the pos is the same as was returned by the last ->next() call,
>> then rhashtable_walk_prev() can be used to re-establish the
>> current location in the table.  If it returns NULL, then
>> rhashtable_walk_next() should be used.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> Can you explain the need for this function and its difference
> from the existing rhashtable_walk_peek?

The need is essentially the same as the need for
rhashtable_walk_peek().  The difference is that the actual behaviour can
be documented briefly (and so understood easily) without enumerating
multiple special cases.
rhashtable_walk_peek() is much the same as
 rhashtable_walk_prev() ?: rhashtable_walk_next()

The need arises when you need to "stop" a walk and then restart at the
same object, not the next one. i.e. the last object returned before the
"stop" wasn't acted on.
This happens with seq_file if the buffer space for ->show() is not
sufficient to format an object.  In the case, seq_file will stop() the
iteration, make more space available (either by flushing or by
reallocing) and will start again at the same location.
If the seq_file client stored the rhashtable_iter in the seq_file
private data, it can use rhasthable_walk_prev() to recover its position
if that object is still in the hash table.  If it isn't still present,
rhashtable_walk_next() can be used to get the next one.  In some cases
it can be useful for the client to know whether it got the previous one
or not.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrXz9cACgkQOeye3VZi
gblmdRAAgHUJEfz7xTYAwAaUBTotrYr7/C8vplf4Zca5rq2I5uGKWeK+UP/Cl1aY
ptXPKsJP6dMd88WxM+zoc3jfYhRghdIbN4WvtyH/gfSwBB0k1bZCLUnG8P/+WFmI
fabsl2SjzJY8EXrGZ+SdyUoxJphKhtODyXfEexuKoR0SPf0QVhSomVFoAR2EQ+DJ
COnu3peMHt00yjxF+BmfDZmbwqg36CzJt14aiQkC1tzy/lsYpjfbfedAWMYLQKDD
v+I9aGunfUmxk3LzTQud8uvtHnchwzzRd+EgIaXiX1AfnabusBr4WxsBbstx3e96
zqgPESnnBpP208+0alCU2lzwhAw0jtj11IIiAmP6mDy7loP1YgfSRng4dB+2xZo3
gp3RCw1qJR5T81M5cv6gCKn8/kgjSd37Ybf6ckdjjFTf4UL+QldWtfdd6ld+RH84
aJf9mbOeMWYrfbW/iGyjETZHFpRsgcZzOczt/vFNkA9+fm5S4RhEY8LpWXZY8lpL
0nYXhYlGN5tPb6JrqplS0u8moRlELGvYYdpp13MVKPrkOkf7e5UGgVLwzWCHEn7d
gCteafEjCKsD1FiFzJeKtPrthg1my56EF+g2l3ghS2CWmRt+9u8aia+U+KUBl9lv
2DifwxzkwZaLVxPBzPctJxQ0pvhLAbQMjt9E/QjXEDfBpTNUIVs=
=iV+U
-----END PGP SIGNATURE-----
--=-=-=--
