Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeFEBAy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 21:00:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50257 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbeFEBAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 21:00:53 -0400
From: NeilBrown <neilb@suse.com>
To: Tom Herbert <tom@herbertland.com>
Date: Tue, 05 Jun 2018 11:00:43 +1000
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH 10/18] rhashtable: remove rhashtable_walk_peek()
In-Reply-To: <CALx6S35sf4oj=x73SfhUxi1e9-u4Stxgr9BAj5E7KKmbufntwg@mail.gmail.com>
References: <152782754287.30340.4395718227884933670.stgit@noble> <152782824964.30340.6329146982899668633.stgit@noble> <20180602154851.pfy4wryezuhxp76v@gondor.apana.org.au> <87y3fvpf40.fsf@notabene.neil.brown.name> <CALx6S37AYrFoJNrdToRc84J=B4f57jaHS077UsxdEoQ-xwyCeg@mail.gmail.com> <87sh63pakb.fsf@notabene.neil.brown.name> <CALx6S35sf4oj=x73SfhUxi1e9-u4Stxgr9BAj5E7KKmbufntwg@mail.gmail.com>
Message-ID: <87r2lmnj2c.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04 2018, Tom Herbert wrote:

>>
>> Maybe a useful way forward would be for you to write documentation for
>> the rhashtable_walk_peek() interface which correctly describes what it
>> does and how it is used.  Given that, I can implement that interface
>> with the stability improvements that I'm working on.
>>
>
> Here's how it's documented currently:
>
> "rhashtable_walk_peek - Return the next object but don't advance the iter=
ator"
>
> I don't see what is incorrect about that.

rhashtable_walk_next is documented:

 * rhashtable_walk_next - Return the next object and advance the iterator

So it seems reasonable to assume that you get the same object, no matter
which one you call.  Yet this is not (necessarily) the case.


>                                           Peek returns the next object
> in the walk, however does not move the iterator past that object, so
> sucessive calls to peek return the same object. In other words it's a
> way to inspect the next object but not "consume" it. This is what is
> needed when netlink returns in the middle of a walk. The last object
> retrieved from the table may not have been processed completely, so it
> needs to be the first one processed on the next invocation to netlink.

I completely agree with this last sentence.
We typically need to process the last object retrieved.  This could also
be described as the previously retrieved object.
So rhashtable_walk_last() and rhashtable_walk_prev() might both be
suitable names, though each is open to misinterpretation.
I fail to see how the "last object retrieved" could be the same as
"the next object" which rhashtable_walk_peek claims to return.
=20=20
>
> This is also easily distinguishable from
>
> "rhashtable_walk_next - Return the next object and advance the iterator"
>
> Where the only difference is that peek and walk is that, walk advances
> the iterator and peek does not. Hence why "peek" is a descriptive name
> for what is happening.

Maybe if we step back and go for a totally different API.

We could change rhashtable_walk_start() to return the object that was
current (most recently returned) when rhashtable_walk_stop() was called,
if it is still in the table, otherwise it returns NULL (as it would the
first time it was called).
This loses the option for rhashtable_walk_start() to return -EAGAIN, but
I would rather than rhashtable_walk_next() were the only thing to return
that.

The only time it really makes sense to call rhashtable_walk_peek() is
immediately after rhashtable_walk_start(), and this change would make
that fact clear in the API.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsV4LsACgkQOeye3VZi
gbka1BAAhMr4/i5jalgUktSeWH93sRjMU93mwgGYvMbLzTOudAQL+16kF2Gd8DjJ
YoXLu+yNLe+KrqHu9YxTMLTbJoV/5Q8VBJ3udvedhv/0iLaOP6zvyIq+87ksGgIc
MwSJPaaMTvadMBHFkHmY0MPcA+Yd8QzmzITqvxz5r2RSp/9xCymw+vqNV5fiLsZL
ubi6sGVIV6H+YXXw9jUSvbkTi6tCHJMzXsxcMn6tlCP3gM9cPOnNTaqo08/DOSs1
ivn8KZVpmQEXfwwGZJI1w0NpVD308dIfxstaZfous9Y3+TAwUI/tH60SZkhJWYAO
tmM1SIFL9kENiRdfarBKlMjBS88TDHpe1U72c7DUJOR3L+nKLMyvv0eb/5fMKlFp
HscRcBa1k089Rz91Q7YIR3VVXC4qcfQ4wmgflVP0klyqXskoL+l34nrIQEJ0NIrb
5+jBHDAUQ5DJ8IIlLgQklYlfdTJa6raU10mr6xQVjAWpXze/5lRilhpcxkU8U22H
DilzMi3XsKhk6jx3puWp1KfJeROzcktUCIIG1Qmw8OPDI0lvHEimmeHChQTMUyUW
WBvNuU4o8mDpEEDH2a3SUo1ZfhPpdXwm6bBVOGYxx6nsVCQH5AJSAgZ3F7l7tkzW
s2upkSkteDrwz0C2JKr6jBRRbbQeb3wlLeOaELXwI17zPsaLSho=
=Uahz
-----END PGP SIGNATURE-----
--=-=-=--
