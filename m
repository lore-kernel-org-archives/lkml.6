Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeB0KMl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:12:41 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36910 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeB0KMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:12:39 -0500
X-Google-Smtp-Source: AG47ELtbBBvSbkaR22m+hcvVv5MFxh73EaBIQ6l/LoKEgk66t2Eh9RguAVG9/a6nuY05g+q7KPLnvw==
X-ME-Sender: <xms:ES-VWmIxYHaO9qsvYXQqNWyl4VPBcstnV_5mM2-obWwHvY19QCar2A>
Date: Tue, 27 Feb 2018 18:16:05 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, Akira Yokosawa <akiyks@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH] riscv/locking: Strengthen spin_lock() and
 spin_unlock()
Message-ID: <20180227101605.tlo37kjhc673pzqj@tardis>
References: <20180222134004.GN25181@hirez.programming.kicks-ass.net>
 <20180222141249.GA14033@andrea>
 <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com>
 <20180222181317.GI2855@linux.vnet.ibm.com>
 <20180222182717.GS25181@hirez.programming.kicks-ass.net>
 <563431d0-4fb5-9efd-c393-83cc5197e934@nvidia.com>
 <20180226142107.uid5vtv5r7zbso33@yquem.inria.fr>
 <CA+55aFwu5jat5vV-d6RVaUFo=Bjeyv-7eXWUJySg6xFUTnfbWQ@mail.gmail.com>
 <20180226162426.GB17158@arm.com>
 <20180227050635.es5v5yogz3x4qrtz@tardis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="igtgcicfi4tjp6fy"
Content-Disposition: inline
In-Reply-To: <20180227050635.es5v5yogz3x4qrtz@tardis>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--igtgcicfi4tjp6fy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 01:06:35PM +0800, Boqun Feng wrote:
> On Mon, Feb 26, 2018 at 04:24:27PM +0000, Will Deacon wrote:
> > On Mon, Feb 26, 2018 at 08:06:59AM -0800, Linus Torvalds wrote:
> > > On Mon, Feb 26, 2018 at 6:21 AM, Luc Maranget <luc.maranget@inria.fr>=
 wrote:
> > > >
> > > > That is, locks are not implemented from more basic primitive but ar=
e specified.
> > > > The specification can be described as behaving that way:
> > > >   - A lock behaves as a read-modify-write. the read behaving as a r=
ead-acquire
> > >=20
> > > This is wrong, or perhaps just misleading.
> > >=20
> > > The *whole* r-m-w acts as an acquire. Not just the read part. The
> > > write is very much part of it.
> > >=20
> > > Maybe that's what you meant, but it read to me as "just the read part
> > > of the rmw behaves as a read-acquire".
> > >=20
> > > Because it is very important that the _write_ part of the rmw is also
> > > ordered wrt everything that is inside the spinlock.
> > >=20
> > > So doing a spinlock as
> > >=20
> > >  (a) read-locked-acquire
> > >    modify
> > >  (c) write-conditional
> > >=20
> > > would be wrong, because the accesses inside the spinlock are ordered
> > > not just wrt the read-acquire, they have to be ordered wrt the write
> > > too.
> > >=20
> > > So it is closer to say that it's the _write_ of the r-m-w sequence
> > > that has the acquire semantics, not the read.
> >=20
> > Strictly speaking, that's not what we've got implemented on arm64: only
> > the read part of the RmW has Acquire semantics, but there is a total
> > order on the lock/unlock operations for the lock. For example, if one
> > CPU does:
> >=20
> > spin_lock(&lock);
> > WRITE_ONCE(foo, 42);
> >=20
> > then another CPU could do:
> >=20
> > if (smp_load_acquire(&foo) =3D=3D 42)
> > 	BUG_ON(!spin_is_locked(&lock));
> >=20
>=20
> Hmm.. this is new to me. So the write part of spin_lock() and the
> WRITE_ONCE() will not get reordered? Could you explain more about this
> or point where I should look in the document? I understand the write
> part of spin_lock() must be committed earlier than the WRITE_ONCE()
> committed due to the ll/sc, but I thought the ordering of their arrivals
> in memory system is undefined/arbitary.
>=20
> Regards,
> Boqun
>=20
> > and that could fire. Is that relied on somewhere?
> >=20

My bad, I misunderstood your mail. So you were saying the BUG_ON() can
be triggered in currently implementations. Never mind my reply above.

Regards,
Boqun

> > Will



--igtgcicfi4tjp6fy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqVL+IACgkQSXnow7UH
+rig/wf9HxNie+FgAAzVu4KyG9gEoXpAnhjMLnaOBI669E0oevin3ofeH+0jKUXt
3aB94uubyzWM3ssA+15cIMZ0cOKAKRFiY6+lGQBpZaJV4lnQabieDl9DMftDTWuB
agIPwINLRFJXmfC/fSkGqVxgzBW0fiy2kAcmfVLxTZx/SiTAZwr0EoOkrgDscaUv
TujrM4iDfpOYht971f8V8ZeyTB2+dYjS4H6OayUEim/94gBfkXRsfblJky4lfMOS
ozgHK9ro1jBopm/CR0O6vMRj5CmKKUM03pCpHMTnSNiCCUUFBQsHvA/uqqLAhiEe
rqQkBxkhPsXy/i98RryOja7lMx5DlQ==
=5XUX
-----END PGP SIGNATURE-----

--igtgcicfi4tjp6fy--
