Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx49h97471nFK65WshPNo1OlwEKn+evwCwDtSOANZnVtti/5T710IDNXeqh60Mh0K+d5fKa7+
ARC-Seal: i=1; a=rsa-sha256; t=1524021436; cv=none;
        d=google.com; s=arc-20160816;
        b=OQs5gfO7viUIKFt1AmB3HDlvu5WhJmqbFrpj0tnK5K0tQzzAbw6iEU1FrTqnlZ9psI
         Zk+h4DIpIMkQeC7Wi6+gK/KqAJty7oHf+KTbw/jEOIkAibANpxBHvTTY/Ej+qbNAAm/k
         iz0B9zFzfxjUFZTf680JbTixcdWL6nY33E6jYHDJHPj82BeKwnmMNmB1VbbNpMHROgrc
         KaNeYdWYDSxZ/fBbIHcDYZ6tnLVLzD1X6hVOk89HwEzj3yhhzd27oihhZX5nC/+h2NMH
         fX36eSYqNfqzpAeK91k/Kj24HKkIJZfDDm30686mVsoGEYfCNWVoDVR+NzeYAfp6JGEz
         tQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=jPHv12eoeJiObZlMAfTKCNoFtW+/ZaXdSQNSG54Hijw=;
        b=Yj0YtaQvq++mUm85vWJUi3kdYQHE65oeJXFTez3soyWU7QHBmyZzICV5QZ41MiR6gt
         wNWo9SBB62UhiTksTfF1hSr8xSTfAhYNkw03Z8PTs+aRqB12xE9l6NygS4nxVPjJr8/c
         eaelfVI3IDEeLaFFr8LOUHBRe3lZ+JhpDQ+xfKGNtoJOj0DBjYAr2Ys3xWtkuUXX6xxA
         T6MI+kY0jKcOnwwzteS9SBM5YtP5mOqbRQN80qiG+pQQxTkmPrzxK07B8LQyHLOiq9TW
         NGcAaq3X2tPHXRjvTR7Ro11WR2Tnbr3wA92mkyVme4TjTx60U7+JO+Sfo1Bz54a5p0Zg
         9EGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>
Date: Wed, 18 Apr 2018 13:17:07 +1000
Cc: Oleg Drokin <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andreas Dilger <andreas.dilger@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 00/20] staging: lustre: convert to rhashtable
In-Reply-To: <alpine.LFD.2.21.1804170429300.14398@casper.infradead.org>
References: <152348312863.12394.11915752362061083241.stgit@noble> <alpine.LFD.2.21.1804170429300.14398@casper.infradead.org>
Message-ID: <87y3hlqk3w.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597488463998050383?=
X-GMAIL-MSGID: =?utf-8?q?1598052301459530839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17 2018, James Simmons wrote:

>> libcfs in lustre has a resizeable hashtable.
>> Linux already has a resizeable hashtable, rhashtable, which is better
>> is most metrics. See https://lwn.net/Articles/751374/ in a few days
>> for an introduction to rhashtable.
>
> Thansk for starting this work. I was think about cleaning the libcfs
> hash but your port to rhashtables is way better. How did you gather
> metrics to see that rhashtable was better than libcfs hash?

Code inspection and reputation.  It is hard to beat inlined lockless
code for lookups.  And rhashtable is heavily used in the network
subsystem and they are very focused on latency there.  I'm not sure that
insertion is as fast as it can be (I have some thoughts on that) but I'm
sure lookup will be better.
I haven't done any performance testing myself, only correctness.

>=20=20
>> This series converts lustre to use rhashtable.  This affects several
>> different tables, and each is different is various ways.
>>=20
>> There are two outstanding issues.  One is that a bug in rhashtable
>> means that we cannot enable auto-shrinking in one of the tables.  That
>> is documented as appropriate and should be fixed soon.
>>=20
>> The other is that rhashtable has an atomic_t which counts the elements
>> in a hash table.  At least one table in lustre went to some trouble to
>> avoid any table-wide atomics, so that could lead to a regression.
>> I'm hoping that rhashtable can be enhanced with the option of a
>> per-cpu counter, or similar.
>>=20
>
> This doesn't sound quite ready to land just yet. This will have to do some
> soak testing and a larger scope of test to make sure no new regressions
> happen. Believe me I did work to make lustre work better on tickless=20
> systems, which I'm preparing for the linux client, and small changes coul=
d=20
> break things in interesting ways. I will port the rhashtable change to th=
e=20
> Intel developement branch and get people more familar with the hash code
> to look at it.

Whether it is "ready" or not probably depends on perspective and
priorities.  As I see it, getting lustre cleaned up and out of staging
is a fairly high priority, and it will require a lot of code change.
It is inevitable that regressions will slip in (some already have) and
it is important to keep testing (the test suite is of great benefit, but
is only part of the story of course).  But to test the code, it needs to
land.  Testing the code in Intel's devel branch and then porting it
across doesn't really prove much.  For testing to be meaningful, it
needs to be tested in a branch that up-to-date with mainline and on
track to be merged into mainline.

I have no particular desire to rush this in, but I don't see any
particular benefit in delaying it either.

I guess I see staging as implicitly a 'devel' branch.  You seem to be
treating it a bit like a 'stable' branch - is that right?

As mentioned, I think there is room for improvement in rhashtable.
=2D making the atomic counter optional
=2D replacing the separate spinlocks with bit-locks in the hash-chain head
  so that the lock and chain are in the same cache line
=2D for the common case of inserting in an empty chain, a single atomic
  cmpxchg() should be sufficient
I think we have a better chance of being heard if we have "skin in the
game" and have upstream code that would use this.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrWuLMACgkQOeye3VZi
gblQhxAAokHsWpgyZ720VM9Xq9qXhxCENMtSZSpcz3H3BqkgTloyb/JGz3ovGU5+
Tq1WIJU+oLNyYqp0ThH8/uAnLoqZCnbmbPg0VcAXTRcVPKQ7j71ZNVtmbYc3/Nfn
tbGBaXpNjys09CqkriqHbN+Zfa2+ssiO8zkw3lY7/z2DDIrJTMSsT4NQlCpFgl1z
H7hT/vnQNfHiKxYktiWwPaQ0DcGBV9dBYU4//e0dCnrP70K/ObSp9KID0vHhI3kX
Kgf3+A0YAGeMyc93WOCYvQgazKFFBaGTNKCQhGZoqiDzSxrnlFlAOX8AWbA6+Tdv
Q6sJu+jy0b8NFMD6MEJrF3DmHUFx4BcbBJ+J+jLeILVjbvxb3X40bGLeyI6WMBdB
gxU8rKP2kpSsPUWj/p36OsRjD50jOx6NV2O5TiytSLH/7IHG+RtM4oQsUe0AgRgN
WtA2fTdwhnd8UVutAmwcL6hYlWqfDvf6ceyQHWaWv/YdDQCml3+liGKZNB0DCiU2
LKrNVyG90Oyhn8Tw68EZ43VMN/hHAvyUzaBswPrVmUDUQ8VRl3GdEESGCxXWQFsM
fCr2mLRtB3EHoUz1LyWfLfDeMMo43XGjnSCn+DfJZz4QNzCP4aS/3TKVx1wwLp/A
fCM0ThfpSDfQtNstR7gpreictsEm4cRqmBFycaY4cpYFdoGpjcw=
=qQDF
-----END PGP SIGNATURE-----
--=-=-=--
