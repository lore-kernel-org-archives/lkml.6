Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeC0Vyu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:54:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:57334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbeC0Vyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:54:49 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 28 Mar 2018 08:54:41 +1100
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rhashtable: allow a walk of the hash table without missing objects.
In-Reply-To: <20180327155118.GB14001@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718430.11435.5761213978298714527.stgit@noble> <20180327155118.GB14001@gondor.apana.org.au>
Message-ID: <87po3p421q.fsf@notabene.neil.brown.name>
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
>>
>> -int rhashtable_walk_start_check(struct rhashtable_iter *iter)
>> +int rhashtable_walk_start_continue(struct rhashtable_iter *iter, struct=
 rhash_head *obj)
>>  	__acquires(RCU)
>>  {
>>  	struct rhashtable *ht =3D iter->ht;
>>=20=20
>>  	rcu_read_lock();
>>=20=20
>> +	if (!obj || iter->p !=3D obj)
>> +		iter->p =3D NULL;
>
> Why bother with this check at all? Couldn't we make it so that
> if you call continue then you continue with the cursor otherwise
> you set it to NULL as we currently do.

Possibly.
I particularly want the interface to require that you pass the
previously returned object to _continue. That makes it easy to see that
the object is still being used.  If someone changes to code to delete
the object before the _continue, there should be a strong hint that it
won't work.

Maybe it would be better to make it a WARN_ON()

  if (!obj || WARN_ON(iter->p !=3D obj))
         iter->p =3D NULL;

??

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq6vaEACgkQOeye3VZi
gblolQ/+MmIv8vbAOUCHJl9b4pfAEaw4gHRzkiGyxxFRmlGc3nNzbDBDIe+bWOdf
sQv0D/S/trAQYVjRXzJPMX+6P/9XnZ2Ec3XwaQBLvYBa60rcNBibJViE3nTm45/9
FnODiKj3Xu84SoSEu6ioOshPOJ7lWyMVmWefYtbTqkW1Goh907XSq1/+z6xJaEFo
vZV0Y+F9jS8V4vqiV4lEs+6JC7PvgwjsuizdCnVQWWWrMlVouFedlfgDP/yaA3jF
mz+k+cbvJ18wlgfIDHiS0FC6G/voDAJAThYv4S30zjDafud0r1f1ZN2LE7xM6/z5
40BHgy9YlU6GL75MH+8Oj6lQaBx6C7sKBV+luoNnBA1XasviJ9LfjMlwEFTqpljI
M1JLafNMNbKQ4A7J9ghYlPO/djCBnSVl6sBl03+gVtIp1i/ZSZl6IhjYTX6WnOVw
x5JnhEoCVVtqKeqtJzYI1jIR/zV3n+tpmsSbhsf3BqgjS9r0NRqO8L8xpFrcXnPx
CjQemlkr3B3ZAJ/OlB43aQ9fHhEZdrRTmeKcTmC+4H7M7PQwUZPUnnDnAQ4JcLsl
n7mZGiD/ys+8ApDFkWRyhdwdPC7XvbNyo/JZ7KuGPdoINvbWofLnUtag6USQ6fLy
y0AlpqRbky5cZK/ALJ0YtFWoqGwX7VeyTEkiJ1LxsOKbQ9740iw=
=eE1d
-----END PGP SIGNATURE-----
--=-=-=--
