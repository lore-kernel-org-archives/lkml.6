Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeC1HEv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:04:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:59915 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbeC1HEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:04:49 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 28 Mar 2018 18:04:40 +1100
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] rhashtable: support guaranteed successful insertion.
In-Reply-To: <20180328060432.GA16291@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718434.11435.6551477417902631683.stgit@noble> <20180327155610.GD14001@gondor.apana.org.au> <87y3id42zo.fsf@notabene.neil.brown.name> <20180328060432.GA16291@gondor.apana.org.au>
Message-ID: <87d0zo4r5j.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed, Mar 28 2018, Herbert Xu wrote:

> On Wed, Mar 28, 2018 at 08:34:19AM +1100, NeilBrown wrote:
>>
>> It is easy to get an -EBUSY insertion failure when .disable_count is
>> enabled, and I did get that.  Blindly propagating that up caused lustre
>> to get terribly confused - not too surprising really.
>
> Right, so this failure mode is specific to your patch 6.

I disagree.  My patch 6 only makes it common instead of exceedingly
rare.  If any table in the list other than the first has a chain with 16
elements, then trying to insert an element with a hash which matches
that chain will fail with -EBUSY.  This is theoretically possible
already, though astronomically unlikely.  So that case will never be
tested for.

>
> I think I see the problem.  As it currently stands, we never
> need growing when we hit the bucket length limit.  We only do
> rehashes.
>
> With your patch, you must change it so that we actually try to
> grow the table if necessary when we hit the bucket length limit.

It is hard to know if it is necessary.  And making the new table larger
will make the error less likely, but still won't make it impossible.  So
callers will have to handle it - just like they currently have to handle
-ENOMEM even though it is highly unlikely (and not strictly necessary).

Are these errors ever actually useful?  I thought I had convinced myself
before that they were (to throttle attacks on the hash function), but
they happen even less often than I thought.

>
> Otherwise it will result in the EBUSY that you're seeing.
>
> I laso think that we shouldn't make this a toggle.  If we're going
> to do disable_count then it should be unconditionally done for
> everyone.
>
> However, I personally would prefer a percpu elem count instead of
> disabling it completely.  Would that be acceptable to your use-case?

Maybe. Reading a percpu counter isn't cheap.  Reading it whenever a hash
chain reaches 16 is reasonable, but I think we would want to read it a
lot more often than that.  So probably store the last-sampled time (with
no locking) and only sample the counter if last-sampled is more than
 jiffies - 10*HZ (???)

In the case in lustre we also shard the LRU list so that adding to the
LRU causes minimal contention. Keeping a shared counter together with
the lru is trivial and summing them periodically is little burden.
Maybe it makes sense to include that functionality if rhashtables so
that it is there for everyone.

A percpu counter uses a lot more memory than atomic_t.  Given that some
callers set nelem_hint to 2 or 3, it seem likely that those callers
don't want to waste memory.  Should we force them to?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq7PogACgkQOeye3VZi
gbmbRA/7B9ziYXYwefYsl4AT9GRSpQdWGtUl1fHHhOUKt97V328epMqQu4xcVwJE
Crl6D+gHEOHCa4ukJM/eVSJ1o7ESwHllO6C4IKxpDWl2/k9kCJ3hODDDDhWWa+zT
KLnpvBD1CQSuet3dXuvc0VjruzpPWB8nKaxkAclC1NfwerqlgOu9ekZywTlOYuOu
z/yif8Dcx8ys3ufBuoPMXFEKzoUX53f5eyTyQr5vx58sJGq8q0w6jDNN1fHkvtQx
Lji3xZENUovC1MERyh118ZqN0UCjaMs1ZtATJwobhNLUDHXLKfJPrCPtjhCIHVzQ
TIXWyS//hwT76W5yz1QxSHkF6yRFZHCzqBecBPOXg6i2VVI4KjrGtjRrYZO7LXii
yj4SenGVK3GLJddrWQDjefUs39HIYmHM7j3vCprZl+dSliKsKUCuciMpVUg1xONn
Vz6bwIzGbgL+Cjr8HUP+yo/XiiNMJXzMowgCPKpvodT6Lw/1A2jpeg6kIMmkr/PP
9rpLktmjrpI7jAguEEt0w/HGrMmHCZ8kVfLt5bDGBHNdCmf7+imNif2BDeDsjkfu
STHH2TXizlhh1RBw8As7l5GvZYbwZHgGaExBZnGlASUjCFdLxeGHPzAxrjmL956g
MCK9onE/UI4wuEFHga2NWSkt2Q+E8DyqLTzo3nAb6hJSOpnEaT4=
=bWLC
-----END PGP SIGNATURE-----
--=-=-=--
