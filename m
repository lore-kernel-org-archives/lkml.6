Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42972C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C462081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C462081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeLIWu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:50:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:56730 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbeLIWu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:50:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A18C5ACD2;
        Sun,  9 Dec 2018 22:50:56 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon, 10 Dec 2018 09:50:43 +1100
Cc:     Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rhashtable: further improve stability of rhashtable_walk
In-Reply-To: <20181207053943.7zacyn5uvqkfnfoi@gondor.apana.org.au>
References: <153086101070.2825.6850140624411927465.stgit@noble> <153086109256.2825.15329014177598382684.stgit@noble> <87zhtkeimx.fsf@notabene.neil.brown.name> <20181207053943.7zacyn5uvqkfnfoi@gondor.apana.org.au>
Message-ID: <87k1kico1o.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07 2018, Herbert Xu wrote:

> On Wed, Dec 05, 2018 at 02:51:02PM +1100, NeilBrown wrote:
>>=20
>> If the sequence:
>>    obj =3D rhashtable_walk_next(iter);
>>    rhashtable_walk_stop(iter);
>>    rhashtable_remove_fast(ht, &obj->head, params);
>>    rhashtable_walk_start(iter);
>>=20
>>  races with another thread inserting or removing
>>  an object on the same hash chain, a subsequent
>>  rhashtable_walk_next() is not guaranteed to get the "next"
>>  object. It is possible that an object could be
>>  repeated, or missed.
>>=20
>>  This can be made more reliable by keeping the objects in a hash chain
>>  sorted by memory address.  A subsequent rhashtable_walk_next()
>>  call can reliably find the correct position in the list, and thus
>>  find the 'next' object.
>>=20
>>  It is not possible to take this approach with an rhltable as keeping
>>  the hash chain in order is not so easy.  When the first object with a
>>  given key is removed, it is replaced in the chain with the next
>>  object with the same key, and the address of that object may not be
>>  correctly ordered.
>>  I have not yet found any way to achieve the same stability
>>  with rhltables, that doesn't have a major impact on lookup
>>  or insert.  No code currently in Linux would benefit from
>>  such extra stability.
>>=20
>>  With this patch:
>>  - a new object is always inserted after the last object with a
>>    smaller address, or at the start.
>>  - when rhashtable_walk_start() is called, it records that 'p' is not
>>    'safe', meaning that it cannot be dereferenced.  The revalidation
>>    that was previously done here is moved to rhashtable_walk_next()
>>  - when rhashtable_walk_next() is called while p is not NULL and not
>>    safe, it walks the chain looking for the first object with an
>>    address greater than p and returns that.  If there is none, it moves
>>    to the next hash chain.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>=20
>> This is a resend of a patch that I sent back in July.  I couldn't
>> applied then because it assumed another rhashtable patch which hadn't
>> landed yet - it now has.
>
> I thought we had agreed to drop this because nobody needs it
> currently and it doesn't handle rhlist?

Hi Herbert,
 I think it was agreed that I would not pursue features that were only
 of use to out-of-tree code, but I don't think that applies here.  This
 is not a feature, this is a quality-of-implementation improvement.
 There are users in the kernel today which use
   rhashtable_walk_stop()/rhashtable_walk_start()
 to drop out of RCU protection for periods during the walk.
 Any such user might miss seeing an object that has been in the table
 for a while - sure that is less than optimal, and should be fixed if
 the cost is small.

 There are currently no rhlist users which use stop/start to drop out
 of RCU, so there is no clear value in fixing that case, or cost in not
 fixing it.

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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwNnEkACgkQOeye3VZi
gbmlcw/+ISsgWh2pLN5zi0zlPyCtmS9HBgLVORMI7x4A1ukG+XN7bwMKJYYFVlwM
5h5uJy74UREnkyosscX06yjQpc35Xd0vYUbHsdp3IhrMEmWDdjw/aZ1/kKN81XAy
/aCfBgbNqckEiahfgBOrCakMmkkRYW3O80FKLccp2ROqTYB7k1kinWPi+WWH3VLo
TUEfxvJ5F+/tpANsu6SjoARJyEC1arkb+ZVIGON7nmkU6F8z++CA8J7zwnhCUv82
1ronoV1YsKB5i8qRu//QRnDaJtMeMrAApKZcaqY5SihvuKqu61CE/+yPKoMtrhtX
SNShhjsrcaOAUVcRtzJ4Ed05WKJJXIqa9N1Mc1EVoOdD/BdkWqhDgtmOt8lFXbFN
HWf1g9B3czA5m33/+lU8tqfk3VZCFRu8/TXOXbM4CdZN1qSFbthHcvSZtEsBKyP4
+G0TXB/gMR0dmxeaZ6IUthWbjQRhVEHHVHtxfkIrAFdCCUVxbttQFwHvJKjf1otO
amcTtxu65SYOb822I7UQTJbrTvYaf5TQLBBN5ro+hWQ5vTYXYKAHDlqIZqK+SAAa
p2LBp0eRel2xF+iOZEdyoDyVEAVGP8o6+48ZGvGuEHN4fzk31WzDnIBtkhE4uNkg
3OSyIEiiDn5VvAkebnuooS6d4CuD3ENMSK0lzh0AjlpWjA9gqM4=
=Z99R
-----END PGP SIGNATURE-----
--=-=-=--
