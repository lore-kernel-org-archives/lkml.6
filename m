Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E07ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C4420873
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C4420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeGPBsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:48:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727091AbeGPBsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:48:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2A3DFADB4;
        Mon, 16 Jul 2018 01:23:54 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon, 16 Jul 2018 11:23:43 +1000
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH - revised] rhashtable: detect when object movement might have invalidated a lookup
In-Reply-To: <20180716005134.q4rfkfn3m5zzwt62@gondor.apana.org.au>
References: <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au> <87k1q8yh70.fsf@notabene.neil.brown.name> <20180711.224658.2077863065492745521.davem@davemloft.net> <20180711.224801.1129067473269289703.davem@davemloft.net> <87fu0kt5m0.fsf@notabene.neil.brown.name> <20180716005134.q4rfkfn3m5zzwt62@gondor.apana.org.au>
Message-ID: <874lh0t1ls.fsf@notabene.neil.brown.name>
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

On Mon, Jul 16 2018, Herbert Xu wrote:

> On Mon, Jul 16, 2018 at 09:57:11AM +1000, NeilBrown wrote:
>>=20
>> Some users of rhashtable might need to change the key
>> of an object and move it to a different location in the table.
>> Other users might want to allocate objects using
>> SLAB_TYPESAFE_BY_RCU which can result in the same memory allocation
>> being used for a different (type-compatible) purpose and similarly
>> end up in a different hash-chain.
>>=20
>> To support these, we store a unique NULLS_MARKER at the end of
>> each chain, and when a search fails to find a match, we check
>> if the NULLS marker found was the expected one.  If not,
>> the search is repeated.
>>=20
>> The unique NULLS_MARKER is derived from the address of the
>> head of the chain.
>>=20
>> If an object is removed and re-added to the same hash chain, we won't
>> notice by looking that the NULLS marker.  In this case we must be sure
>> that it was not re-added *after* its original location, or a lookup may
>> incorrectly fail.  The easiest solution is to ensure it is inserted at
>> the start of the chain.  insert_slow() already does that,
>> insert_fast() does not.  So this patch changes insert_fast to always
>> insert at the head of the chain.
>>=20
>> Note that such a user must do their own double-checking of
>> the object found by rhashtable_lookup_fast() after ensuring
>> mutual exclusion which anything that might change the key, such as
>> successfully taking a new reference.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> I still don't understand why we need this feature.  The only
> existing user of this (which currently doesn't use rhashtable)
> does not readd the reused entry to the same table.  IOW the flow
> is always from table A to table B.  After which the entry will
> be properly freed rather than reused.
>
> So who is going to use this?

I want it so I can use SLAB_TYPESAFE_BY_RCU slab caches in lustre.
lustre isn't in mainline any more so I cannot point at the code but the
concept is simple.
Without this, you need to use rcu_free to free any object added to an
rhashtable.
When kmalloc is used, kfree_rcu() can be used, which is fairly painless.
When a kmem_cache is used, you need to provide your own rcu free
function, which is clumsy.
With SLAB_TYPESAFE_BY_RCU, that isn't needed.  The object can be freed
immediately, providing you can cope with it being re-used (as the same
type) immediately.  Part of handling that is coping with the possibility
that it might be inserted into the same hash table, and possibly the
same chain, immediately it is freed.
lustre has 6 different resizable hashtables which I want to convert
to use rhashtable.
I currently need call_rcu handlers for 3 for these.  I want those
3 to use SLAB_TYPESAFE_BY_RCU instead so they can use
kmem_cache_free() directly.  For this, I need rhashtable to be safe if
an object is deleted and immediately re-inserted into the same hash
chain.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltL86AACgkQOeye3VZi
gbkVRhAAtP9k9AwRDW0vU0ImJDMAc/XIiv2vt8GAObHBtTBK9T5phKN6G+JBhUqL
rU+o5rVkv+QCfw55FAfufU6yfNkIv/exA5ov+3aIAmDS+8X1DNV8ArkADhM0AD3t
6ZeOAZ1uq81GsawxT5X2uA01CdvmNnYymnbr5ZsVihDN/zBcQrFi9lkYD61F8iZN
cKGqWdFKyp1ZgepfLFaCl96QEYUhHGXdN5OZ/t16QnvnAUUd3GPpQI78pHsiTYG+
D9b8gdhOX0b5MeFQkFRgMGyWL0XnmIlUP2UiezJKY8nF0l1lUdmp8Cj9ECMrsa7X
jOgZECZ2zAkdc+B582Cou8ZzXD1Pijdjt/Tw650gvjf1SSTD79K6FXEPp+2fB5d0
Qb87TZLtczKknonDeUYWbsZA+l8HjkqfKhOheRuMrc1XvkhMHm0qkkoVkq0G/PrG
vvGti2J8XB8nuCL1KFSsz2yh24P4YFsL6m8J7/JeO8c7gy7H95LMRo5XMZwWq8S7
3zQ6aZcNVnbPplAYp+FCfAoSjMb+ZJ48RyUan9XBoIIsw6Qfs3LyheDUUFAmRW6C
MLa85nloJxbFgW3hTPdFp+noFjnbAWE0ryfY3PBDFvXcKQdEEMVpqKb1hsJk522r
ETZGpau3Fd6Utww2cjVCGKRzOJBbyZzU0KCfqIAHfpeIflCuu0Q=
=vCNI
-----END PGP SIGNATURE-----
--=-=-=--
