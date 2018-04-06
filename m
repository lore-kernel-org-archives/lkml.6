Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeDFDMO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 23:12:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:39574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751315AbeDFDML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 23:12:11 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 06 Apr 2018 13:11:56 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 5/6] rhashtable: support guaranteed successful insertion.
In-Reply-To: <20180329052231.GA21028@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718434.11435.6551477417902631683.stgit@noble> <20180327155610.GD14001@gondor.apana.org.au> <87y3id42zo.fsf@notabene.neil.brown.name> <20180328060432.GA16291@gondor.apana.org.au> <87d0zo4r5j.fsf@notabene.neil.brown.name> <20180328072727.GA17306@gondor.apana.org.au> <87370j51tu.fsf@notabene.neil.brown.name> <20180329052231.GA21028@gondor.apana.org.au>
Message-ID: <87y3i1vxj7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29 2018, Herbert Xu wrote:

> On Thu, Mar 29, 2018 at 08:26:21AM +1100, NeilBrown wrote:
>>
>> I say "astronomically unlikely", you say "probability .. is extremely
>> low".  I think we are in agreement here.
>>=20
>> The point remains that if an error *can* be returned then I have to
>> write code to handle it and test that code.  I'd rather not.
>
> You have be able to handle errors anyway because of memory allocation
> failures.  Ultimately if you keep inserting you will eventually
> fail with ENOMEM.  So I don't see the issue with an additional
> error value.

You don't need to handle memory allocation failures at the point where
you insert into the table - adding to a linked list requires no new
memory.

If you are running out of memory, you will fail to allocate new objects,
so you won't be able to add them to the rhashtable.  Obviously you have
to handle that failure, and that is likely to save rhashtable from
getting many mem-alloc failures.

But once you have allocated a new object, rhashtable should just accept
it.  It doesn't help anyone to have the insertion fail.
The insertion can currently fail even when allocating a new object would
succeed, as assertion can require a GFP_ATOMIC allocation to succeed,
while allocating a new object might only need a GFP_KERNEL allocation to
succeed.=20

>
>> > Even if it does happen we won't fail because we will perform
>> > an immediate rehash.  We only fail if it happens right away
>> > after the rehash (that is, at least another 16 elements have
>> > been inserted and you're trying to insert a 17th element, all
>> > while the new hash table has not been completely populated),
>> > which means that somebody has figured out our hash secret and
>> > failing in that case makes sense.
>
> BTW, you didn't acknowledge this bit which I think is crucial to
> how likely such an error is.

The likelihood of the error isn't really the issue - it either can
happen or it cannot.  If it can, it requires code to handle it.

>
>> I never suggested retrying, but I would have to handle it somehow.  I'd
>> rather not.
>
> ...
>
>> While I have no doubt that there are hashtables where someone could try
>> to attack the hash, I am quite sure there are others where is such an
>> attack is meaningless - any code which could generate the required range=
 of
>> keys, could do far worse things more easily.
>
> Our network hashtable has to be secure against adversaries.  I
> understand that this may not be important to your use-case.  However,
> given the fact that the failure would only occur if an adversary
> is present and actively attacking your hash table, I don't think
> it has that much of a negative effect on your use-case either.

I certainly accept that there are circumstances where it is a real
possibility that an adversary might succeed in attacking the hash
function, and changing the seed for each table is an excellent idea.
It isn't clear to me that failing insertions is needed - it is done
rather late and so doesn't throttle much, and could give the attacker
feedback that they had succeeded (?).

Not all hash tables are susceptible to attack.  It would be nice if
developers working in less exposed areas could use rhashtable without ever
having to check for errors.

Error codes are messages from the implementation to the caller.
They should be chosen to help the caller make useful choices, not to
allow the implementation to avoid awkward situations.

>
> Of course if you can reproduce the EBUSY error without your
> disable_count patch or even after you have fixed the issue I
> have pointed out in your disable_count patch you can still reproduce
> it then that would suggest a real bug and we would need to fix it,
> for everyone.

I suspect that I cannot.  However experience tells me that customers do
things that I cannot and would never expect - they can often trigger
errors that I cannot.  It is best if the error cannot be returned.

>
>> Yes, storing a sharded count in the spinlock table does seem like an
>> appropriate granularity.  However that leads me to ask: why do we have
>> the spinlock table?  Why not bit spinlocks in the hashchain head like
>> include/linux/list_bl uses?
>
> The spinlock table predates rhashtable.  Perhaps Thomas/Eric/Dave
> can elucidate this.

Maybe I'll submit an RFC patch to change it - if I can make it work.

>
>> I don't understand how it can ever be "too late", though I appreciate
>> that in some cases "sooner" is better than "later"
>> If we give up on the single atomic_t counter, then we must accept that
>> the number of elements could exceed any given value.  The only promise
>> we can provide is that it wont exceed N% of the table size for more than
>> T seconds.
>
> Sure.  However, assuming we use an estimate that is hash-based,
> that *should* be fairly accurate assuming that your hash function
> is working in the first place.  It's completely different vs.
> estimating based on a per-cpu count which could be wildly inaccurate.

Ahhh... I see what you are thinking now.  You aren't suggestion a
sharded count that is summed periodically.  Rather you are suggesting that
we divide the hash space into N regions each with their own independent
counter, and resize the table if any one region reaches 70% occupancy -
on the assumption that the other regions are likely to be close.  Is
that right?
It would probably be dangerous to allow automatic shrinking (when just
one drops below 30%) in that case, but it might be OK for growing.

I'm not sure I like the idea, but it is worth thinking about.

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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrG5X0ACgkQOeye3VZi
gbk7SRAAs9/tvaBH4cKwT682PAJUmLRablqzBT95VyCdaK8NP76AS4u504ExhGzU
R5DLr3txoF2k5onS9gAfLk9XD1N0441oCN6o/+41wUtVu320NtiIiYsGADiPHL+9
zpibW3oQzZOwtVBuu/Q6TVtHAR744Tu/3EKp9/Qk5bILf/wJVGc92d9ptYwSSidC
USAJQosBciifC+vvD8L/XAhp/ctEGO0Jo/9GPGk2lID+gv9cRhyas8vnWSO5MYe5
CZJT2LVPaGG44WxKFaJSbwlU50kclIPXlZ4KFVEr2f+90OiepLUbkcOJxNtg/XPR
VYiXNTUchz8vetNXjzE+QqYoQJ+oDCABJ2OrAuvOFICb+tSsvmd9U7/BR3029iN/
+oz5+tYSf7xTYKt3xd9mu51XsEV4v2KetX8zg64mQba1BLYYTWyZxCFemy1rrsY3
5JKSH+yMYsHNeIEBYHlan77fCNdP9UzdHsXl+BZnVdf8kGc2wsCct0meU0BTwvbF
Dp4vqVIT6e4o/VPhPdZfXmcXWdN3eu/JHj7RE/LIN6tHPZhfKubaEb+As/CAz3/E
2TDfRwK2mtUqN+0gDVKpDIdThvlSZTKH+EV04FExeIs0O9CG+AQ1Obw/8vX52b5w
6jPfxkK+Ptwfxtr8BUhcDxX43ieyx40nDBKRdDns99xMi2e3CZU=
=wy1+
-----END PGP SIGNATURE-----
--=-=-=--
