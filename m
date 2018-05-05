Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEEVsa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 17:48:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:47120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751767AbeEEVs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 17:48:28 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 06 May 2018 07:48:20 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] rhashtable: fix race in nested_table_alloc()
In-Reply-To: <20180505092907.2qa3scf6bzvubmtt@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605432.18473.11813271279255176724.stgit@noble> <20180505092907.2qa3scf6bzvubmtt@gondor.apana.org.au>
Message-ID: <871sepepuj.fsf@notabene.neil.brown.name>
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
>> If two threads run nested_table_alloc() at the same time
>> they could both allocate a new table.
>> Best case is that one of them will never be freed, leaking memory.
>> Worst case is hat entry get stored there before it leaks,
>> and the are lost from the table.
>>=20
>> So use cmpxchg to detect the race and free the unused table.
>>=20
>> Fixes: da20420f83ea ("rhashtable: Add nested tables")
>> Cc: stable@vger.kernel.org # 4.11+
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> What about the spinlock that's meant to be held around this
> operation?

The spinlock protects 2 or more buckets.  The nested table contains at
least 512 buckets, maybe more.
It is quite possible for two insertions into 2 different buckets to both
get their spinlock and both try to instantiate the same nested table.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlruJqQACgkQOeye3VZi
gbncaw//dHfQNoKtso8SIK8DEzqWAxTaFg/l8aifrgNi6xjs4mG0CJJekQtGIN16
JbE5uXo7Z2bLOQ/GXa+g3JUMyTy+zNCKKar3F6XLtVvPz8WSqyNxPDI0W9YDmrgA
xXfKzJZaS/rdBM4KDA0JPNlya3bP/n3Ga89F8XvD5tARs3DEG3VgM0w9dQt0fRko
59Egn9D6rFPZAzLqmqmqc3YhfLsW8ignG2lInl9qRao9U0pmOQNHeKYUFBlA0iFy
Z7LDYr1fzOlDMyQ3ByeZmRtvtpGpy1YBULSEFxjJc1Y7YtNuxr1kvmHDAJcQRIQN
C2eajctoCCZyKcgGvUqlOlUVYHh9Ek1BqcBHah/hMGJVdU9CjDzYcxIkuRQNpczt
IqekiwAiAn4eeoH1FVLAEM1H2a2r1WfFm5ytpji0NYsqyn5jETKwiFQCSbdgAs+O
WfZMjA4kRj1eNu7oVeJAYIXVDCCMA5nE2nIyyT66aQl3v0dK8DTMocI6HPPBixso
/pWAQ5+jG0rThFa4DrMonY1Mi50Yjl5k8xm2QXIjPr2MDboiUD26JyJ4wJkej9CD
w6AeHjMoLg17+9UcAZUZuh9ArvTicQoQbuNYOHYbuTHC//b7pXu6Uf7GQ+BS531B
51pkLMsTg8BSdk5LSmAJjtz//p3/xbkv0kKUjb3rPEBv9JVtewE=
=FdAp
-----END PGP SIGNATURE-----
--=-=-=--
