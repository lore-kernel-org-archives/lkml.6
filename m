Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753602AbeEHAXv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:23:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:53610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbeEHAXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:23:49 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 08 May 2018 10:23:38 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20180507092939.vhps3uf2vdckf7ky@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605444.18473.9591316658457316578.stgit@noble> <20180505094117.pl7b6bbk6mtyri6d@gondor.apana.org.au> <87sh75dapa.fsf@notabene.neil.brown.name> <20180506052000.7yehd5lke3smccoj@gondor.apana.org.au> <878t8wcthy.fsf@notabene.neil.brown.name> <20180507092939.vhps3uf2vdckf7ky@gondor.apana.org.au>
Message-ID: <87zi1batbp.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, May 07 2018, Herbert Xu wrote:

> On Mon, May 07, 2018 at 08:24:41AM +1000, NeilBrown wrote:
>>
>> This is true, but I don't see how it is relevant.
>> At some point, each thread will find that the table they have just
>> locked for their search key, has a NULL 'future_tbl' pointer.
>> At the point, the thread can know that the key is not in any table,
>> and that no other thread can add the key until the lock is released.
>
> The updating of future_tbl is not synchronised with insert threads.
> Therefore it is entirely possible that two inserters end up on
> different tables as their "latest" table.  This must not be allowed
> to occur.

I disagree.
Certainly the update of future_tbl is not synchronised with insert
threads.
However there is only a single update to any given future_tbl (from NULL
to non-NULL) and two insert threads for the same key will see that
update in a synchronized way as they look at it while holding the bucket
lock for that key.
It is certainly true if that two inserters can end up on different
tables as their "latest" table, but that doesn't result in a problem.
e.g. T1 might see A as the latest table, and T2 might see B where
  A.future_tbl == B
In that case, T2 must have examined A (under the lock) *after* T1
examined A, and so will have seen if T1 inserted anything.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrw7gsACgkQOeye3VZi
gbmBzw//X1KQS5G9LvbrFDUzBUVfmXsAQ/Bf5CppcRHPSmVQH5xS9EZAAWkB0iCJ
2VKUzqvLJrbXfEAd7cJi1Cqk7Eh98wBfnH/Vs4ISPmxA3Tx3OnB6FSankPnDVqaX
gX7OJ/lFVIzRzTHJnSOBZzIlfN1dIvZCsVH0s7P/SUyM8qVmAhIPyQgCTwkqs+ew
S57OxpC7ergNeqEhzpIYQL/6NMhvmVXmvrFwWwwZxRRXRwbnuDqCrp9rfhzA9ZIf
Oh2hjq3XWOwl699azL+yl442cPv6PUw/toV/cuS3UJw1f/BO3kj9K/DsB9gE8xUg
/tpTR1PrDTrtVeetr/oFOl381SqpT+rGqOD/VGfC0ZI4jKtaOXS5iVh8QbN2hiH1
FKMe9kYSeAE5jk//ijow4S+V/py1N0zPtbK3ezWT63FAImPIvWp36/u7U/jZK9Mq
7tYwfE7z8sTdejsbpaGtWnVZdw08pD3HrNXX68NumR4pkNMBuzgV+HgWlODrAnQy
VmGW2Ine/1qIWYikOf6IZT3An+YHkQTjiT+k2OWqMPV4iylR0UfCf0ukXT7QsizY
tHy6aRoIq6Yhxhdi73YMHXCboNA8taBxNeErVSrPKu1I6FJR9uucsplvMyyMD7U3
8C9enk7elMd6h4uSzfj38d/P5+t54d4adZL1IY/NREEb5exmWcA=
=LXEE
-----END PGP SIGNATURE-----
--=-=-=--
