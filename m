Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB9FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECC12404C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECC12404C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeGFJzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:55:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753553AbeGFJzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:55:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D59DAEC7;
        Fri,  6 Jul 2018 09:55:51 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Paolo Abeni <pabeni@redhat.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>
Date:   Fri, 06 Jul 2018 19:55:43 +1000
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rhashtable: further improve stability of rhashtable_walk
In-Reply-To: <0a44916eacea6c3899152a07321ff69d96ed8c52.camel@redhat.com>
References: <153086101070.2825.6850140624411927465.stgit@noble> <153086109256.2825.15329014177598382684.stgit@noble> <0a44916eacea6c3899152a07321ff69d96ed8c52.camel@redhat.com>
Message-ID: <87d0w0y9gg.fsf@notabene.neil.brown.name>
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

On Fri, Jul 06 2018, Paolo Abeni wrote:

> On Fri, 2018-07-06 at 17:11 +1000, NeilBrown wrote:
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
>
> The above scenario is very similar to the one I'm running:
>
>    rhashtable_walk_next(iter);
>    rhashtable_walk_stop(iter);=20=20=20=20=20
>    // rhashtable change not yet identified, could be either
>    // remove, insert or even rehash
>    rhashtable_walk_start(iter);
>    rhashtable_walk_next(iter);
>
> but I'm seeing use-after-free there. I'll try this patch to see if
> solves my issue.
>
> Note: the code under test is a pending new patch I'm holding due to the
> above issue, I can send it as RFC to share the code if you think it may
> help.

I'd suggest post it.  I may not get a chance to look at it, but if you
don't post it, then I definitely won't :-)

>
>> @@ -867,15 +866,39 @@ void *rhashtable_walk_next(struct rhashtable_iter =
*iter)
>>  	bool rhlist =3D ht->rhlist;
>>=20=20
>>  	if (p) {
>> -		if (!rhlist || !(list =3D rcu_dereference(list->next))) {
>> -			p =3D rcu_dereference(p->next);
>> -			list =3D container_of(p, struct rhlist_head, rhead);
>> -		}
>> -		if (!rht_is_a_nulls(p)) {
>> -			iter->skip++;
>> -			iter->p =3D p;
>> -			iter->list =3D list;
>> -			return rht_obj(ht, rhlist ? &list->rhead : p);
>> +		if (!rhlist && iter->p_is_unsafe) {
>> +			/*
>> +			 * First time next() was called after start().
>> +			 * Need to find location of 'p' in the list.
>> +			 */
>> +			struct rhash_head *p;
>> +
>> +			iter->skip =3D 0;
>> +			rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
>> +				iter->skip++;
>> +				if (p <=3D iter->p)
>> +					continue;
>
> Out of sheer ignorance, I really don't understand the goal of the above
> conditional ?!?

I hoped the patch description would cover that:
     With this patch:
     - a new object is always inserted after the last object with a
       smaller address, or at the start.  This preserves the property,
       important when allowing objects to be removed and re-added, that
       an object is never inserted *after* a position that it previously
       held in the list.

The items in each table slot are stored in order of the address of the
item.  So to find the first item in a slot that was not before the
previously returned item (iter->p), we step forward while this item is
<=3D that one.=20

Does that help at all?

NeilBrown


>
> Should it possibly be something like:
> 				if (p !=3D iter->p->next)
>
> instead?=20
> But I think we can't safely dereference 'p' yet ?!?
>
> I'm sorry for the possibly dumb comments, rhashtable internals are
> somewhat obscure to me, but I'm really interested in this topic.
>
> Cheers,
>
> Paolo

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAls/PKAACgkQOeye3VZi
gbmLWhAAkgJ5mVUzojHM+kPz/eOEEibiOVph84zuyRTwAXjz/TaZeEaS1F/Kcxcy
Xv+3yu5F2UMwr2xiv6mI4h0smZ+u+1iFzZ5rXo2DaYUzNm96o7VGTxiN58ZxVS5g
i4KOREOccngcuJWnA3rskT3HaKGnfUGJkwIXuy3uUl/lbb6/XjrpT+Q69Jg5UKZe
slWhaxKrBnDZSiVdwq7v7c2l4tMPVQM//3wBHjg4Bxmr/JqubVKV0MsurhdFUssY
iovVkfakYscNXXGlbiLzWJVJO9OqCnxdghReN3N3j4+gjWy97Pvg1Zb+aD7e1kBY
/4zMuPOQiiqLOfhxtGbX+ke9AO6Abravq1L6vahoh9spD3Zs7zRP6c+973SeFqzy
jROvh3VJ4jBIPrUWBrbzThFQZ8rFwLNdnJfeOsJ/ayiMAB10tF/GMolF2NRwQPuD
Kl5vM/H7L4ew1morv9FnpFISbUPwFLkMFWz4BmkyiKQE3WzbKSX+rqZaAw5UGkgc
DEWGa4qksKBvUAKbusfTn3jpUKwdWhxleG2G4fH2sLQcVf6crHJJnNlz3ORv9ms6
AcqzGUti/D8XPshisQoXQChFYDVHhcrfivkYRYY+EtWxCOS/+ODWYaePZwEbOy+W
W5mQsfGxV18tTLDaHJzxGV9goncTt1GsBUm/b2Bu3l8w9jt1460=
=p3av
-----END PGP SIGNATURE-----
--=-=-=--
