Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeEHBOW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:14:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:55995 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753746AbeEHBOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:14:21 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 08 May 2018 11:14:09 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] rhashtable: remove nulls_base and related code.
In-Reply-To: <20180507092748.yqqldkwkxkynaaju@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605427.18473.12277050439942480863.stgit@noble> <20180505091208.tnsxi6hdpjn456yz@gondor.apana.org.au> <877eoheqc2.fsf@notabene.neil.brown.name> <20180507092748.yqqldkwkxkynaaju@gondor.apana.org.au>
Message-ID: <87tvrjaqzi.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, May 07 2018, Herbert Xu wrote:

> On Sun, May 06, 2018 at 07:37:49AM +1000, NeilBrown wrote:
>>=20
>> I can see no evidence that this is required for anything, as it isn't
>> use and I'm fairly sure that in it's current form - it cannot be used.
>
> Search for nulls in net/ipv4.  This is definitely used throughout
> the network stack.  As the aim is to convert as many existing hash
> tables to rhashtable as possible, we want to keep this.

Yes, I'm sure that nulls lists are very useful and I can see them used
in net/ipv4 (and I would like to use them myself).  I don't want to
remove the nulls list concept from rhashtable, and my patch doesn't do
that.

It just removes nulls_base (as the subject says) and stops setting any
particular value in the nulls pointer, because the value is currently
never tested.

The point of nulls lists is, as I'm sure you know, to detect if an
object was moved to a different chain and to restart the search in that
case.
This means that on an unsuccessful search, we need to test
get_nulls_value() of the tail pointer.
Several times in net/ipv4/inet_hashtables.c (for example) we see code
like:

	/*
	 * if the nulls value we got at the end of this lookup is
	 * not the expected one, we must restart lookup.
	 * We probably met an item that was moved to another chain.
	 */
	if (get_nulls_value(node) !=3D slot)
		goto begin;

which does exactly that.  This test-and-restart cannot be done by a
caller to rhashtable_lookup_fast() as the caller doesn't even get to
the tail nulls.
It would need to be done in rhashtable.[ch].
If you like, I can make this functionality work rather than just
removing the useless parts.

I would change INIT_RHT_NULLS_HEAD() to return to be
#define INIT_RHT_NULLS_HEAD(ptr, ht, hash) \
	((ptr) =3D (void*)NULLS_MARKER(((unsigned long)ptr)>>1)

Then when __rhashtable_lookup() comes to the end of the chain
without finding anything it would do something like
  if (get_nulls_value(he)<<1 =3D=3D (unsigned long)head)
    goto restart;

where 'head' is the head of the list that we would have saved at the
start.

i.e. instead of using a nulls_base and limiting the size of the hash, we
store the address of the bucket in the nulls.

In my mind that should be a separate patch.  First remove the unused,
harmful code.  Then add code to provide useful functionality.  But
I can put the two together in one patch if you would prefer that.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrw+eIACgkQOeye3VZi
gbnbDw//VVbXvvSrfnLao1KB4KIBVYeiXs+qv2yB4TrX9getDIkSQG9djzVO+nvl
SD2vBipVc3EOYEvrNEqG04P1smCXz2iVA8L19BN4tWh5W+VUAhDfPx0skV2TWpdT
rBvEeG1FwOQlF9yxIVJeO6jb6Q91TBR8gjlGsqS980ROsvqWrDTzCwIc35gVOQSD
v2e7iQII6BhW7oTr6nlSnQRgKoJ9ST6ILWS/ccD1qoJcrWtcK+Tl91HwZnZs/7yJ
DBwBGWt8TdAcO/3jI6SVik5fxAHziemh1CiFLoEz93Eg2Q9uDP48/CRCpNrvkryW
sSBpYlUsXzno8WzWH4TazYfr69vWovoWInrg5sQ3Hc2nk+mS+sE+us+HhydYESUh
oFQF7xPZNl6d+LaD4v9OJsiCtTD4rQBQbt09DtRdorl7rUj98QEEiyHx/kkkx1uI
gvZU7+0WGMPhbloq63Q7I4vNODcxuDUIeVvxf3kNrVkTLAPQu+r8s1oQ+nzrXrR3
sMoeLGzWoFlxNe6N2r0r6N8I4Dd4Lk93PstAfNlOL/lkZOVZz4snIhimrB4AZjSm
AsnNFAxPaHnCHmCOFsaG/HBweW8eFxKZpct9V2hLcld/7PF/dY6lQcitReaEebld
0KH581cv4CTIW0+d3dMe3jzivehROeCgngDVFjW9g7BFKdQgvMA=
=2A0Q
-----END PGP SIGNATURE-----
--=-=-=--
