Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9214DC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F99220849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F99220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeLLACr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:02:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:53868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbeLLACq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:02:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06675AD02;
        Wed, 12 Dec 2018 00:02:43 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed, 12 Dec 2018 11:02:35 +1100
Cc:     Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rhashtable: further improve stability of rhashtable_walk
In-Reply-To: <20181211051755.modgomqzszkbiihe@gondor.apana.org.au>
References: <153086101070.2825.6850140624411927465.stgit@noble> <153086109256.2825.15329014177598382684.stgit@noble> <87zhtkeimx.fsf@notabene.neil.brown.name> <20181207053943.7zacyn5uvqkfnfoi@gondor.apana.org.au> <87k1kico1o.fsf@notabene.neil.brown.name> <20181211051755.modgomqzszkbiihe@gondor.apana.org.au>
Message-ID: <87mupbvch0.fsf@notabene.neil.brown.name>
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

On Tue, Dec 11 2018, Herbert Xu wrote:

> Hi Neil:
>
> On Mon, Dec 10, 2018 at 09:50:43AM +1100, NeilBrown wrote:
>>  I think it was agreed that I would not pursue features that were only
>>  of use to out-of-tree code, but I don't think that applies here.  This
>>  is not a feature, this is a quality-of-implementation improvement.
>>  There are users in the kernel today which use
>>    rhashtable_walk_stop()/rhashtable_walk_start()
>>  to drop out of RCU protection for periods during the walk.
>>  Any such user might miss seeing an object that has been in the table
>>  for a while - sure that is less than optimal, and should be fixed if
>>  the cost is small.
>>=20
>>  There are currently no rhlist users which use stop/start to drop out
>>  of RCU, so there is no clear value in fixing that case, or cost in not
>>  fixing it.
>
> I think the complexities of this patch outweighs any benefit.
>
> Walking an rhashtable is inherently unreliable, due to rehashing.
> If you need an 100% reliable walking mechanism, then add your own
> linked list alongside the hash table like xfrm does.
>
> Having said that, if the current code is missing items that existed
> prior to the start of the walk (in the absence of a rehash) then
> that would be a bug that we should fix.  Anything else like
> duplicates just needs to be accepted by the caller.
>
> So please explain how can an object be missed then we can work on
> fixing that and that only.

The commit comment gives the context:

  If the sequence:
     obj =3D rhashtable_walk_next(iter);
     rhashtable_walk_stop(iter);
     rhashtable_remove_fast(ht, &obj->head, params);
     rhashtable_walk_start(iter);

   races with another thread inserting or removing
   an object on the same hash chain, a subsequent
   rhashtable_walk_next() is not guaranteed to get the "next"
   object. It is possible that an object could be
   repeated, or missed.

The rhashtable_walk_start() at the end of this sequence will find that
iter->p is not null (it will be precisely &obj->head) and will look for
it in the chain, but will not find it (because of the remove_fast).  So
it sets iter->p to NULL.  This causes rhashtable_walk_next() to fall
through to __rhashtable_walk_find_next() which looks for the entry
number item->skip in the chain for item->slot.
=2D>skip will be the index for the entry just beyond obj->head.  Since
that has been removed, it is actually the index for the object one
further on.  So if obj->head was not the last entry in the chain, the
object after it will be missed.

The code in tipc_nl_sk_walk() is fairly similar to this pattern in that
the sock_put() call could potentially result in a call to
rhashtable_remove_fast().
It avoids the problem by ensuring that the rhashtable_remove_fast() is
*after* the rhashtable_walk_start().

If the rhashtable_remove_fast() happened from some other thread due to a
race, the walk could still miss an object.
Currently, the only way to protect against this is to hold a reference
to an object across rhashtable_walk_stop()/rhashtable_walk_start().
Sometimes that is easy to do, other times - not so much.

So I think this is a real bug - it is quite unlikely to hit, but
possibly.
You need a chain with at least 2 objects, you need
rhashtable_walk_stop() to be called after visiting an object other than
the last object, and you need some thread (this or some other) to remove
that object from the table.

The patch that I posted aims to fix that bug, and only that bug.
The only alternative that I can think of is to document that this can
happen and advise that a reference should be held to the last visited
object when stop/start is called, or in some other way ensure that it
doesn't get removed.

Thanks,
NeilBrown


>
> Thanks,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwQUBsACgkQOeye3VZi
gblkuw//fFhBWw2ElI6v+ciQwAEeW6ValZ9PZCnTjuHjdC3LKAdJxtj0m9xDnsad
WxitiWaOzpnZINWhAki/HglnuIJGAPROxmjeGzvH7MbAZDVqkp3HlSGgaYdqSYK5
QoNQPBBFw/wrtO93gjnaaLyvKwIJUr3zkzLUACFepY40iG2fN1Ofwj9N/GS8q3HI
2sTxrhvNNe0xB6HmuwlwTchw+kXOL7cJiqThofhFg6QoFlXwCSmMPIsCY86CCHHf
1cYjJM2g7pwRwSUCd9zlMNU4hbmy5uZ3DlyjyCK0/oKO2hFptzPADGk60NA5qYFR
XP1UC7cVENBDVWa6psXj8yIAgz3xE1eEJbgMVwg6t4Om04y80IjWNBNva0kIxjJm
8HZjNHa7QH91nQ/ku+Iq2ZU7qFemq2Ft9Q8IjK4AjipsjOYhopm3/royzMcDF+vr
2sDLIInyP5yd+CuW7P8+ohR4qDLMIzbnbcD3+KJzUYjaabGGIO+RcEDDgpqTDU8w
xJY5yIRtvagHhc2vWVlhLpSoE0uLQ7x8qmhK08SkpbwZFWaCQVTyV7JwvkWwn3jr
Aai7yHqmRGqxMzEn+yK6qVmXPFZ4Yq6BzBDt9tc7URBFlXTpEDwAPir71xB0xmRI
9CnIYOX7p+SNFt6MEgpPM5YReQzM092FrTZlDd75eAulgHHcVsE=
=Pi0N
-----END PGP SIGNATURE-----
--=-=-=--
