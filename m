Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087C9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D1E20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D1E20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLMDtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:49:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:60244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbeLMDtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:49:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19FD9AC81;
        Thu, 13 Dec 2018 03:49:10 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu, 13 Dec 2018 14:48:59 +1100
Cc:     Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rhashtable: further improve stability of rhashtable_walk
In-Reply-To: <20181213014309.uufaeoijhympgxbz@gondor.apana.org.au>
References: <153086109256.2825.15329014177598382684.stgit@noble> <87zhtkeimx.fsf@notabene.neil.brown.name> <20181207053943.7zacyn5uvqkfnfoi@gondor.apana.org.au> <87k1kico1o.fsf@notabene.neil.brown.name> <20181211051755.modgomqzszkbiihe@gondor.apana.org.au> <87mupbvch0.fsf@notabene.neil.brown.name> <20181212054601.wbzpxjunnsfi62mz@gondor.apana.org.au> <87efanuu06.fsf@notabene.neil.brown.name> <20181212080037.j2zs22t57uxdu2jr@gondor.apana.org.au> <87bm5ruo3f.fsf@notabene.neil.brown.name> <20181213014309.uufaeoijhympgxbz@gondor.apana.org.au>
Message-ID: <8736r2ulw4.fsf@notabene.neil.brown.name>
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

On Thu, Dec 13 2018, Herbert Xu wrote:

> On Wed, Dec 12, 2018 at 07:49:08PM +1100, NeilBrown wrote:
>> On Wed, Dec 12 2018, Herbert Xu wrote:
>>=20
>> > On Wed, Dec 12, 2018 at 05:41:29PM +1100, NeilBrown wrote:
>> >>
>> >> So you would substantially slow down the rhashtable_walk_start() step.
>> >
>> > This whole thing is meant for uses such as /proc and netlink
>> > enumeration.  Speed is definitely not a prerogative of these
>> > iterators.
>>=20
>> An RCU grace period is typically 10s of milliseconds.  It doesn't take
>> very many of those to start being noticed.
>
> Why would you even need an RCU grace period for deleting and adding
> the walker object to the bucket list? You just allocate a new one
> each time and free the old one after an RCU grace period.  I don't
> see where the latency is coming from.

Yes, you could rcu_free the old one and allocate a new one.  Then you
would have to be ready to deal with memory allocation failure which
complicates usage (I already don't like that rhashtable_insert() can
report -ENOMEM!).

Another problem with inserting a marker object on rhashtable_walk_stop()
is that it might not be clear where to insert it.
You would have to take the spinlock, and then you might find that the
location that you want to mark has been deleted from the list.  I think
you can probably still manage a reliable placement, but it could get
messy.

>
>> > For that matter, if speed was an issue then surely you would
>> > not drop out of the RCU read lock at all while iterating.
>>=20
>> tipc_nl_sk_walk() drops out of RCU for every object.
>> I don't know what it is used for, but I doubt that making it thousands
>> of times slower would be a good thing.
>
> Now you're conflating two different things.  Dropping the RCU
> isn't necessarily slow.  We were talking about waiting for an
> RCU grace period which would only come into play if you were
> suspending the walk indefinitely.  Actually as I said above even
> there you don't really need to wait.

How would rhashtable_walk_stop() know if it was indefinite or not?

Yes, if you allocate a new marker on each rhashtable_walk_start()
(passing in a gfp_t and coping with errors) then you don't need to wait
a grace period.  If you reuse one to avoid the errors, you do.

>
>> > It sounds to me like you're trying to use this interface for
>> > something that it's simply not designed to do.
>>=20
>> I'm just trying to make sure we have a reliable data structure which I
>> can use without having to be worried that I might accidentally hit some
>> unsupported behaviour.
>
> Now that is something I agree with.
>
>> I don't really see why you think my patch is all that complex.
>> The only conceptual change is that hash chains are now ordered, and
>> ordered chains are easy to understand.
>> The biggest part of the code change is just moving some code from
>> rhashtable_walk_start() to rhashtable_walk_next().
>>=20
>> Why don't you like it?
>
> My main beef is the fact that it doesn't work with rhlist.  So down
> the track either we'll have to add more complexity for rhlist or
> we will have to rip this out again do something completely different.

You have previously said that functionality which isn't needed by current
code should not be a concern.  No current code ever stops and restarts
an rhlist walk, so this shouldn't be relevant.  Solve that problem
when/if we come to it.

If this is really the main beef, then let's turn the question around.
Suppose this patch had landed before rhltables had landed.  How would we
implement rhltables without breaking this functionality?

Keeping all the objects with the same key in a linked list is clearly a
good idea - make this a circular list as there is no obvious "first".

*Not* keeping them all in the hash chain is ideal, but not essential.
I see three costs with this.
One is that we would compare the same key multiple times for lookup.
How much of a problem is that? A failing compare is usually quite quick,
and most rhltable uses have inline memcmp for comparison (admittedly not
all).

The second cost is tracking the chain length against elasticity.
We could flag one object with each key as a 'master' (low bit of the
'next' pointer) and only count the masters.  When lookup raced with
remove this might get a slightly incorrect count, but I don't think that
hurts.

Finally, there is more pointer chasing as the chains are longer.

Was performance part of the reason for adding rhltables?  It isn't
mentioned in the commit message, but it is easy to miss things.

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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwR1qsACgkQOeye3VZi
gbm9EQ//YMmhaw/7qwcdmu7LkybnSiR7bI0EkcaEFLLLL2ujLgOQmg4SpaueNFuo
PLOvmOfbpq1UGGt8OVOjPt0Fy4M/Bca0CczgkVZY8eagQtoTkxa9KFgsddZPLB4q
2RguKZr489AJre1/Q2JIONdS4ZnIMQXclnlLHjeMp4pSUv6C4pL4BUQ+z8K3geD7
EREz6SMfGSsU1oIY49QAomKQ2yjlxwbYYc2FbLVF/2YmO9DJPrWGTVNUV2AevdlT
dJNDxkR34WqK2sps4VRdZjRdawxbdR9CZrhh28DbxAO8Z0lV0zJfm/7buo3dX1Br
h4T7+U6i+WPqH/nGCzda6H1j1OC23eIjGME9hVcv/RpO881Pnd0oxGxP1ly0i01G
GmDr913bhzFqUEh/lVFGQAtfnEaxK7NK/Z57gWKC1+yr41lAmo8fZGY9xW0bCA7L
Lr5/PhFYL2INTY3WC8P2VtJzYhfM+TfJbOn7dP6lFkKgd0kS5ieiLvaSfZ+Ua/hI
gswPlPgWPdU0adNu789bszpm00lybI8SNP1JkDTXsEIZw/HwYovtpIt7HvlwVj58
6XrWXi+upb1FiH/uEBDtjONx0UJsoLHK16gV28ZWkVJlDHtW7Gyg87ERyd79UOtA
DrzmX29zvK/ob5alPwXIvbeJzsy2J52889bGHYwxbKhhAUuu8n8=
=7HH4
-----END PGP SIGNATURE-----
--=-=-=--
