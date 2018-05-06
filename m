Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeEFWQg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 18:16:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:38048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbeEFWQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 18:16:33 -0400
From: NeilBrown <neilb@suse.com>
To: Tom Herbert <tom@quantonium.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 07 May 2018 08:16:25 +1000
Cc: Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] rhashtable: add rhashtable_walk_prev()
In-Reply-To: <CAPDqMeoPjypXCioHwy9CPiT_XZfWZk8_A6cErQuxVMAJqkQEqQ@mail.gmail.com>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605441.18473.4087381584733882012.stgit@noble> <20180505094324.wwjtl76oofgrtpg4@gondor.apana.org.au> <CAPDqMeoPjypXCioHwy9CPiT_XZfWZk8_A6cErQuxVMAJqkQEqQ@mail.gmail.com>
Message-ID: <87bmdsctvq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sat, May 05 2018, Tom Herbert wrote:

> On Sat, May 5, 2018 at 2:43 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
>>> rhashtable_walk_prev() returns the object returned by
>>> the previous rhashtable_walk_next(), providing it is still in the
>>> table (or was during this grace period).
>>> This works even if rhashtable_walk_stop() and rhashtable_talk_start()
>>> have been called since the last rhashtable_walk_next().
>>>
>>> If there have been no calls to rhashtable_walk_next(), or if the
>>> object is gone from the table, then NULL is returned.
>>>
>>> This can usefully be used in a seq_file ->start() function.
>>> If the pos is the same as was returned by the last ->next() call,
>>> then rhashtable_walk_prev() can be used to re-establish the
>>> current location in the table.  If it returns NULL, then
>>> rhashtable_walk_next() should be used.
>>>
>>> Signed-off-by: NeilBrown <neilb@suse.com>
>>
>> I will ack this if Tom is OK with replacing peek with it.
>>
> I'm not following why this is any better than peek. The point of
> having rhashtable_walk_peek is to to allow the caller to get then
> current element not the next one. This is needed when table is read in
> multiple parts and we need to pick up with what was returned from the
> last call to rhashtable_walk_next (which apparently is what this patch
> is also trying to do).
>
> There is one significant difference in that peek will return the
> element in the table regardless of where the iterator is at (this is
> why peek can move the iterator) and only returns NULL at end of table.
> As mentioned above rhashtable_walk_prev can return NULL so then caller
> needs and so rhashtable_walk_next "should be used" to get the previous
> element. Doing a peek is a lot cleaner and more straightforward API in
> this regard.

Thanks for the review.  I agree with a lot of what you say about the
behavior of the different implementations.
One important difference is the documentation.  The current
documentation for rhashtable_walk_peek() is wrong.   For example it says
that the function doesn't change the iterator, but sometimes it does.
The first rhashtable patch I submitted tried to fix this up, but it is
hard to document the function clearly because it really is doing one of
two different things.  It returns the previous element if it still
exists, or it returns the next one.  With my rhashtable_walk_prev(),
that can be done with
  rhashtable_walk_prev() ?: rhashtable_walk_next();

Both of these functions can easily be documented clearly.
We could combine the two as you have done, but "peek" does seem like a
good name.  "prev_or_next" is more honest, but somewhat clumsy.
Whether that is a good thing or not is partly a matter of taste, and we
seem to be on opposite sides of that fence.
There is a practical aspect to it though.

Lustre has a debugfs seq_file which shows all the cached pages of all
the cached object.  The objects are in a hashtable (which I want to
change to an rhashtable).  So the seq_file iterator has both an
rhashtable iterator an offset in the object.

When we restart a walk, we might be in the middle of some object - but
that object might have been removed from the cache, so we would need to
go on to the first page of the next object.
Using my interface I can do

 obj = rhashtable_walk_prev(&iter.rhash_iter);
 offset = iter.offset;
 if (!obj) {
    obj = rhashtable_walk_next(&iter.rhash_iter)
    offset = 0;
 }

I could achieve something similar with your interface if I kept an extra
copy of the previous object and compared with the value returned by
rhashtable_walk_peek(), but (to me) that seems like double handling.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrvfrkACgkQOeye3VZi
gblDQA/9FlhwYLVi2B/T3rB4WqlCnsfZDhrkMHVEtmJI+U7v9bOZLw1zY6yoCbhS
yJnr0hhLw5Dc8eLaF8bddSNXxdu4yP82obO6Hz8p3CY1/mxL5g2s6u5J97Hp6ArW
h/LBz3HB4aANZguJkUrDq5wMakG7JEjfyIE/3AnGArT7IIEivXboKDtKOzySbPi3
iEjjtPra06NmL1FwEeX+mNW3RbQQev5LMZvhHMvvaBHN+MCIgoL6uV5gnDCjFGg8
RH895xYrY3yGwe7imSHrKzKyA+EFCq79F+8muvcI0HslI8Lv+tWvIAGe8MiV3SLt
7QQJJEzAL5NXvwCGSgYggc/mLgJTtnefEV8TzwrY9NrUctaknhJ0hCkgm5vLqy0o
j+2l78iEch7SNRGGKqw9XMHKroY+bcK7mNZ4GqpYgTpkvfjxyMTKMkIdi4GOg6BH
hhNjlwRedfCy15IB3UtY+Xv6RgrmyFmwykSnWuY1OAizBaNTrfd85ZY5ne6b3iaj
mDeMD5L2bsavsliENlGIKGE5pNAK5JLIDLicYzXSLwDS8YCLFtwy7fRcLYn1uIQ4
hsNHPpE5P7BHh4hBOQiiBPYZUeb+uPwJM6r7CKoHWc2jvxbt9lpOj8ZDP545218d
YSiKAMehEZZ7lDDIFDhn+/UTC9fqybaTJ8FUBpnrB0XEtVYNnCg=
=iDBQ
-----END PGP SIGNATURE-----
--=-=-=--
