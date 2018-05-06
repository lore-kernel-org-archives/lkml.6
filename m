Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEFWYv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 18:24:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:38442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbeEFWYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 18:24:50 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 07 May 2018 08:24:41 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20180506052000.7yehd5lke3smccoj@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605444.18473.9591316658457316578.stgit@noble> <20180505094117.pl7b6bbk6mtyri6d@gondor.apana.org.au> <87sh75dapa.fsf@notabene.neil.brown.name> <20180506052000.7yehd5lke3smccoj@gondor.apana.org.au>
Message-ID: <878t8wcthy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, May 06 2018, Herbert Xu wrote:

> On Sun, May 06, 2018 at 08:00:49AM +1000, NeilBrown wrote:
>>
>> The insert function must (and does) take the lock on the bucket before
>> testing if there is a "next" table.
>> If one inserter finds that it has locked the "last" table (because there
>> is no next) and successfully inserts, then the other inserter cannot
>> have locked that table yet, else it would have inserted.  When it does,
>> it will find what the first inserter inserted.=20
>
> If you release the lock to the first table then it may be deleted
> by the resize thread.  Hence the other inserter may not have even
> started from the same place.

This is true, but I don't see how it is relevant.
At some point, each thread will find that the table they have just
locked for their search key, has a NULL 'future_tbl' pointer.
At the point, the thread can know that the key is not in any table,
and that no other thread can add the key until the lock is released.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrvgKkACgkQOeye3VZi
gbkLDw//TvMvimllwjiXIkjbhl3hsROMlfyq1cKaTx7iWNo65CbDfHKCmdu/DbPB
BufXaX1tDZ+pe1WwnongVRboVXFHWg2g8N0Do0p+pxNe50y9dUjQbVeIS5fZeYuf
akD+RwPScdJudBBDP01ppYzm2QWKa/kxRoLtqE1tMXUJDQ8F4JNaDxKTLs/ZvRK8
VWHX0i5qxmzFKmychTKU7nd2HVO3rSCVEhi5qU0Yl/N0Fkbrxg4rjxTTi+IQlalq
4GNHJtFaiWW/p5tcyvl+Za9lVZ5DRA4sQYwp/gP5FKU0r64ozjQBJ70mMANXiu+8
gsHNltzoyERsuUaFEfIdHF0X3R6OJLD8b5Gs6iQgdKscd6B0HrOetdYQD30MWAaz
Frlo4fjfrMfH/WBeTkAava0M2UYNH77klz2TUP0D9lD8NHrgDY6dJs7gGkcxfNr/
uz3CYfHScFveqAsMBiMSfrXcuvQWVsvqKHnkIyexiMyM5eabSYfLEqtE8x9dfekb
iQ/foXVNxJXqlVwJfPKQZbrEsvvbnfhhFy+g6gBOeU6j3huSUe/x1BXfe1nCm7i2
usQJ0JSaGnBzb0nGK13DayLZ9a0QVNkPG1CrUd4qKBksWv1e23XZVsI9bN6smp4P
GETvFBcP+wdq+6cQ/9SNxC92LOwxFb+8CvQmOeyEpAaA+BU7uFA=
=6wNb
-----END PGP SIGNATURE-----
--=-=-=--
