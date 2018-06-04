Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeFDCJW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 22:09:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:49114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751489AbeFDCJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 22:09:21 -0400
From: NeilBrown <neilb@suse.com>
To: Tom Herbert <tom@herbertland.com>
Date: Mon, 04 Jun 2018 12:09:08 +1000
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH 10/18] rhashtable: remove rhashtable_walk_peek()
In-Reply-To: <CALx6S37AYrFoJNrdToRc84J=B4f57jaHS077UsxdEoQ-xwyCeg@mail.gmail.com>
References: <152782754287.30340.4395718227884933670.stgit@noble> <152782824964.30340.6329146982899668633.stgit@noble> <20180602154851.pfy4wryezuhxp76v@gondor.apana.org.au> <87y3fvpf40.fsf@notabene.neil.brown.name> <CALx6S37AYrFoJNrdToRc84J=B4f57jaHS077UsxdEoQ-xwyCeg@mail.gmail.com>
Message-ID: <87sh63pakb.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sun, Jun 03 2018, Tom Herbert wrote:

> On Sun, Jun 3, 2018 at 5:30 PM, NeilBrown <neilb@suse.com> wrote:
>> On Sat, Jun 02 2018, Herbert Xu wrote:
>>
>>> On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
>>>> This function has a somewhat confused behavior that is not properly
>>>> described by the documentation.
>>>> Sometimes is returns the previous object, sometimes it returns the
>>>> next one.
>>>> Sometimes it changes the iterator, sometimes it doesn't.
>>>>
>>>> This function is not currently used and is not worth keeping, so
>>>> remove it.
>>>>
>>>> A future patch will introduce a new function with a
>>>> simpler interface which can meet the same need that
>>>> this was added for.
>>>>
>>>> Signed-off-by: NeilBrown <neilb@suse.com>
>>>
>>> Please keep Tom Herbert in the loop.  IIRC he had an issue with
>>> this patch.
>>
>> Yes you are right - sorry for forgetting to add Tom.
>>
>> My understanding of where this issue stands is that Tom raised issue and
>> asked for clarification, I replied, nothing further happened.
>>
>> It summary, my position is that:
>> - most users of my new rhashtable_walk_prev() will use it like
>>    rhasthable_talk_prev() ?: rhashtable_walk_next()
>>   which is close to what rhashtable_walk_peek() does
>> - I know of no use-case that could not be solved if we only had
>>   the combined operation
>> - BUT it is hard to document the combined operation, as it really
>>   does two things.  If it is hard to document, then it might be
>>   hard to understand.
>>
>> So provide the most understandable/maintainable solution, I think
>> we should provide rhashtable_walk_prev() as a separate interface.
>>
> I'm still missing why requiring two API operations instead of one is
> simpler or easier to document. Also, I disagree that
> rhashtable_walk_peek does two things-- it just does one which is to
> return the current element in the walk without advancing to the next
> one. The fact that the iterator may or may not move is immaterial in
> the API, that is an implementation detail. In fact, it's conceivable
> that we might completely reimplement this someday such that the
> iterator works completely differently implementation semantics but the
> API doesn't change. Also the naming in your proposal is confusing,
> we'd have operations to get the previous, and the next next object--
> so the user may ask where's the API to get the current object in the
> walk? The idea that we get it by first trying to get the previous
> object, and then if that fails getting the next object seems
> counterintuitive.

To respond to your points out of order:

- I accept that "rhashtable_walk_prev" is not a perfect name.  It
  suggests a stronger symmetry with rhasthable_walk_next than actually
  exist.  I cannot think of a better name, but I think the
  description "Return the previously returned object if it is
  still in the table" is clear and simple and explains the name.
  I'm certainly open to suggestions for a better name.

- I don't think it is meaningful to talk about a "current" element in a
  table where asynchronous insert/remove is to be expected.
  The best we can hope for is a "current location" is the sequence of
  objects in the table - a location which is after some objects and
  before all others.  rhashtable_walk_next() returns the next object
  after the current location, and advances the location pointer past
  that object.
  rhashtable_walk_prev() *doesn't* return the previous object in the
  table.  It returns the previously returned object. ("previous" in
  time, but not in space, if you like).

- rhashtable_walk_peek() currently does one of two different things.
  It either returns the previously returned object (iter->p) if that
  is still in the table, or it find the next object, steps over it, and
  returns it.

- I would like to suggest that when an API acts on a iterator object,
  the question of whether or not the iterator is advanced *must* be a
  fundamental question, not one that might change from time to time.

Maybe a useful way forward would be for you to write documentation for
the rhashtable_walk_peek() interface which correctly describes what it
does and how it is used.  Given that, I can implement that interface
with the stability improvements that I'm working on.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsUn0QACgkQOeye3VZi
gbk3BBAAm9I67JvwBU9zajnqjltyUgjRcEXE5ig3sEM0gkTXAxXeOoEVeqAXyQ0D
OuRSrRT/Lc5TPhMxdzJXfEKX+Btelrjxx0E13YLGuQRSAXu3EqskZ8p3dRqYeAuN
FbAfURAL+u1y0H2iRbvOIDKcgTyHI6jWQzel0lftRFsFc7/Jf6Z+yUjs7zfaGPDS
S0hojOoJUbpl3YhUGCeVpuIknUG/sEpD5/kCwXzJZJyGs5xAhe+FMh6gPQJCrvTJ
/UJlO5PKWjE0NU8lXjS53nOmm1I7ASFVpiipeoIbc9Adl8u/R6MiFJtDIjcZnnXb
0s9VVratNsVhxG8eslARxigC6/OEoqteZvRpcdrQm+t/I/XwPlJYZI36YCOCZVjW
5Hm/85GccFqFmKgzeIQhnJj9+OXFWoXp9w2cnKy1gWpRmb63Om+v0PzmVQ/IeZkf
dwnWgPVIzWDRBGiX4H19LEDgium4Ee1f0LJhD0GOQ3oYlJWiAvf8r8pdQr3p2l5Q
CUF3wNn7PoMDh+FCzvKaiA+dI8mfFKrd1DPF6Y4RfE+W98c8cdLHG3j1nH2KiOOL
35AT6dev4IPMnnqWxw7Vpby0AdUTnZ1cef3+SrYzQv5F3DOpXIfs3rP+cl1rp0r3
qcyROueXMtnAtHETJg3EC2Bz9b9Bp5T0uEiQ9O9oJP7bnQ5EwXw=
=A+jC
-----END PGP SIGNATURE-----
--=-=-=--
