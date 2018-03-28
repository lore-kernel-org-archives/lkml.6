Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbeC1V0b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 17:26:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:48487 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752887AbeC1V03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 17:26:29 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 29 Mar 2018 08:26:21 +1100
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] rhashtable: support guaranteed successful insertion.
In-Reply-To: <20180328072727.GA17306@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718434.11435.6551477417902631683.stgit@noble> <20180327155610.GD14001@gondor.apana.org.au> <87y3id42zo.fsf@notabene.neil.brown.name> <20180328060432.GA16291@gondor.apana.org.au> <87d0zo4r5j.fsf@notabene.neil.brown.name> <20180328072727.GA17306@gondor.apana.org.au>
Message-ID: <87370j51tu.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28 2018, Herbert Xu wrote:

> On Wed, Mar 28, 2018 at 06:04:40PM +1100, NeilBrown wrote:
>>
>> I disagree.  My patch 6 only makes it common instead of exceedingly
>> rare.  If any table in the list other than the first has a chain with 16
>> elements, then trying to insert an element with a hash which matches
>> that chain will fail with -EBUSY.  This is theoretically possible
>> already, though astronomically unlikely.  So that case will never be
>> tested for.
>
> No that's not true.  If the table is correctly sized then the
> probability of having a chain with 16 elements is extremely low.

I say "astronomically unlikely", you say "probability .. is extremely
low".  I think we are in agreement here.

The point remains that if an error *can* be returned then I have to
write code to handle it and test that code.  I'd rather not.

>
> Even if it does happen we won't fail because we will perform
> an immediate rehash.  We only fail if it happens right away
> after the rehash (that is, at least another 16 elements have
> been inserted and you're trying to insert a 17th element, all
> while the new hash table has not been completely populated),
> which means that somebody has figured out our hash secret and
> failing in that case makes sense.
>
>> It is hard to know if it is necessary.  And making the new table larger
>> will make the error less likely, but still won't make it impossible.  So
>> callers will have to handle it - just like they currently have to handle
>> -ENOMEM even though it is highly unlikely (and not strictly necessary).
>
> Callers should not handle an ENOMEM error by retrying.  Nor should
> they retry an EBUSY return value.

I never suggested retrying, but I would have to handle it somehow.  I'd
rather not.

>
>> Are these errors ever actually useful?  I thought I had convinced myself
>> before that they were (to throttle attacks on the hash function), but
>> they happen even less often than I thought.
>
> The EBUSY error indicates that the hash table has essentially
> degenereated into a linked list because somebody has worked out
> our hash secret.

While I have no doubt that there are hashtables where someone could try
to attack the hash, I am quite sure there are others where is such an
attack is meaningless - any code which could generate the required range of
keys, could do far worse things more easily.

>
>> Maybe. Reading a percpu counter isn't cheap.  Reading it whenever a hash
>> chain reaches 16 is reasonable, but I think we would want to read it a
>> lot more often than that.  So probably store the last-sampled time (with
>> no locking) and only sample the counter if last-sampled is more than
>>  jiffies - 10*HZ (???)
>
> We could also take the spinlock table approach and have a counter
> per bucket spinlock.  This should be sufficient as you'll contend
> on the bucket spinlock table anyway.

Yes, storing a sharded count in the spinlock table does seem like an
appropriate granularity.  However that leads me to ask: why do we have
the spinlock table?  Why not bit spinlocks in the hashchain head like
include/linux/list_bl uses?

>
> This also allows us to estimate the total table size and not have
> to always do a last-ditch growth when it's too late.

I don't understand how it can ever be "too late", though I appreciate
that in some cases "sooner" is better than "later"
If we give up on the single atomic_t counter, then we must accept that
the number of elements could exceed any given value.  The only promise
we can provide is that it wont exceed N% of the table size for more than
T seconds.

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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq8CH0ACgkQOeye3VZi
gbnUkg/5AYRx+nSwNNDMCSUSMCfJSZXeT8FRL/nXAJj1w9WjZgnSccvg6dpTvvTr
Pl5wZD+yOnkakDAzoKd71xoYEK9AWm5vOGrc/7Te+4kmYvmXuHDiKusWS+tEP8G3
TDHjhqVOMaDP6Naei5LFHj3v9nI0oxDYXh4Yc4OBfTIPJ1PLObyMkHBOH3L5QNrD
Fy2+4yg6LPrETufUBCDyLJZM0Pa/brMCIy+g1DOpGpbQl0v6q/iEXO9na/flCvMj
zLiJmch7V/6t1y+N/rr9HR6O9HJVN5DK8in16moFelc/y32kgpiYJTVQ3XFbVd17
0AVxe2wsgsliwQgyF9QprlyMjFybt+Vey/fhLYWEVNAMx83ri1cndtZyh9f7ix96
atFGuGdo5PTiabodyOSsKfMnH+mx2Zl/hO/3a7lsIGgeNiCQgQTAzxrgR7FLFMaJ
xtGQzJkUMYQNoh5oCDHoaRcOOxIvKEtBaftV8LGuQLqHIBB1FPL5JJ/irHla+7AB
JVnugb/BDZylEva5y+kMyFvr2UFjDfSB6hOD02tUoVWMvijquo+K7kRzkfQdd7HO
rPTlwgaTMQ4uEW7X9JKeAc9HS6JFGPLKolKkFEYaW2cYvmcF4jHrfQPz/M0J4izc
f9Gkywm13MTyji9N1sYUqotG/eVpitP2qcHJ49ALQELIglWor30=
=lLnV
-----END PGP SIGNATURE-----
--=-=-=--
