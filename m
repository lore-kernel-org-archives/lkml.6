Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeEFWCX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 18:02:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:36748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeEFWCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 18:02:20 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 07 May 2018 08:02:12 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] rhashtable: fix race in nested_table_alloc()
In-Reply-To: <20180506051859.w7evarps5jdcplz6@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605432.18473.11813271279255176724.stgit@noble> <20180505092907.2qa3scf6bzvubmtt@gondor.apana.org.au> <871sepepuj.fsf@notabene.neil.brown.name> <20180506051859.w7evarps5jdcplz6@gondor.apana.org.au>
Message-ID: <87efiocujf.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sun, May 06 2018, Herbert Xu wrote:

> On Sun, May 06, 2018 at 07:48:20AM +1000, NeilBrown wrote:
>>
>> The spinlock protects 2 or more buckets.  The nested table contains at
>> least 512 buckets, maybe more.
>> It is quite possible for two insertions into 2 different buckets to both
>> get their spinlock and both try to instantiate the same nested table.
>
> I think you missed the fact that when we use nested tables the spin
> lock table is limited to just a single page and hence corresponds
> to the first level in the nested table.  Therefore it's always safe.

Yes I had missed that - thanks for pointing it out.
In fact the lock table is limited to the number of nested_tables
in the second level.
And it is the same low-order bits that choose both the lock
and the set of nested tables.
So there isn't a bug here.  So we don't need this patch. (I still like
it though - it seems more obviously correct).

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrve2QACgkQOeye3VZi
gbkMCxAAm2hfOMPSiAjkEAZQZQjATdTzoAAw070cBg453zjC3PDFn5ULoci06ZMF
CBJBEsZ82Dsh0N0jwV6XxsCuwhfWSNkTIDkKzB9uBOAA/biVZan0SQCWKP0a1UQc
GLoEDBzKGDuxbuwTlr1fAUC4xj/oO8jgFVMtVItMculpnO0QCWFpPMWFnHhGsACf
2T0NmJalDkcEU55NVY6h7pqMKPd3Lo+pEXI9jMoX8C+Nn58bCwuWcR7fZNNncF7e
W6gcu33QIZqN99VzTZV+cqQSz537gVp5wpR9YAhDuyziYZ80JZi17dOf8/lks5FJ
GGoU+D0wKJAy8MvjHu854Xw8ZD5mSCOvmVuCSoIXH5l4kdl0UBRNUhp4I3+/UeOt
pJ4/rPdwk+KDZ2BlfR/gcAvaMcmsVcy0bCuW1xMjQ+uklxqvniJWeuH32Mal5vqU
GvCGlTpNl8zZmnqiu5dbQ6afn9gFXX1aFidpMX/ResrU6nhotavrAyII/lu4QLK+
G/HKv0+j16W3yANR1grFK89JoBgprVUVewYy5yNKXruLi8stsONtq36G2SqFv1B8
DRcDUxHCEdoSGcWHTht+WX4i4HzpVY5knDPNuhSiyAhDG1XUfk+K4P4ldiJh52p2
U5iZp6CzHFiZjJzIBcjQEBRcCkw705GabbdiCACEPgOycK+Zs1A=
=j0az
-----END PGP SIGNATURE-----
--=-=-=--
