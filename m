Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeB0FDG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 00:03:06 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35986 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeB0FDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 00:03:05 -0500
X-Google-Smtp-Source: AG47ELuarzOlzNDXVcP75sfmwtlkQhR+1XCPU3VsK54b+nB65Z8qCHsCeIrwyKRbcOi7KYv9x9MuCg==
X-ME-Sender: <xms:h-aUWnGVzJGh6HfvQPoWTQEo_YmwpPUEbCJKvYEmWTqph7BJmtTL6g>
Date: Tue, 27 Feb 2018 13:06:35 +0800
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
Message-ID: <20180227050635.es5v5yogz3x4qrtz@tardis>
References: <1519301990-11766-1-git-send-email-parri.andrea@gmail.com>
 <20180222134004.GN25181@hirez.programming.kicks-ass.net>
 <20180222141249.GA14033@andrea>
 <82beae6a-2589-6136-b563-3946d7c4fc60@nvidia.com>
 <20180222181317.GI2855@linux.vnet.ibm.com>
 <20180222182717.GS25181@hirez.programming.kicks-ass.net>
 <563431d0-4fb5-9efd-c393-83cc5197e934@nvidia.com>
 <20180226142107.uid5vtv5r7zbso33@yquem.inria.fr>
 <CA+55aFwu5jat5vV-d6RVaUFo=Bjeyv-7eXWUJySg6xFUTnfbWQ@mail.gmail.com>
 <20180226162426.GB17158@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xreb33oq7irsncof"
Content-Disposition: inline
In-Reply-To: <20180226162426.GB17158@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xreb33oq7irsncof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 04:24:27PM +0000, Will Deacon wrote:
> On Mon, Feb 26, 2018 at 08:06:59AM -0800, Linus Torvalds wrote:
> > On Mon, Feb 26, 2018 at 6:21 AM, Luc Maranget <luc.maranget@inria.fr> w=
rote:
> > >
> > > That is, locks are not implemented from more basic primitive but are =
specified.
> > > The specification can be described as behaving that way:
> > >   - A lock behaves as a read-modify-write. the read behaving as a rea=
d-acquire
> >=20
> > This is wrong, or perhaps just misleading.
> >=20
> > The *whole* r-m-w acts as an acquire. Not just the read part. The
> > write is very much part of it.
> >=20
> > Maybe that's what you meant, but it read to me as "just the read part
> > of the rmw behaves as a read-acquire".
> >=20
> > Because it is very important that the _write_ part of the rmw is also
> > ordered wrt everything that is inside the spinlock.
> >=20
> > So doing a spinlock as
> >=20
> >  (a) read-locked-acquire
> >    modify
> >  (c) write-conditional
> >=20
> > would be wrong, because the accesses inside the spinlock are ordered
> > not just wrt the read-acquire, they have to be ordered wrt the write
> > too.
> >=20
> > So it is closer to say that it's the _write_ of the r-m-w sequence
> > that has the acquire semantics, not the read.
>=20
> Strictly speaking, that's not what we've got implemented on arm64: only
> the read part of the RmW has Acquire semantics, but there is a total
> order on the lock/unlock operations for the lock. For example, if one
> CPU does:
>=20
> spin_lock(&lock);
> WRITE_ONCE(foo, 42);
>=20
> then another CPU could do:
>=20
> if (smp_load_acquire(&foo) =3D=3D 42)
> 	BUG_ON(!spin_is_locked(&lock));
>=20

Hmm.. this is new to me. So the write part of spin_lock() and the
WRITE_ONCE() will not get reordered? Could you explain more about this
or point where I should look in the document? I understand the write
part of spin_lock() must be committed earlier than the WRITE_ONCE()
committed due to the ll/sc, but I thought the ordering of their arrivals
in memory system is undefined/arbitary.

Regards,
Boqun

> and that could fire. Is that relied on somewhere?
>=20
> Will

--xreb33oq7irsncof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqU51gACgkQSXnow7UH
+rhZlQf/Qw9tLoKGXTMM//TJoOoReDlWxLq4jNBOFnq/rWhBh9b5uYajj5n73++I
ON+d+tpkOiNTD1vVTQtZEGXIqriDVMa88XSPbkPkUTn8zOTEXi7XbV+f6zl/MCK5
brMdbKkCV3erBzOTjeIX5lL74mV119k/NgH/i2nb2A/bjmwq5dE+mcGI2za6MWfO
8Dy6ziqQeC1/6HgXQVA5qUZiXjRIXj1AroJFUZV5m4iMQ+wK91hFB2q6O/ahAmJH
RnsDNJGjMl03EXC1biOMWuQk8A6eno3eYA6Oz2Sqo4FviRG+e/PvzSdlQj/vz58c
B92MHEgxkW6ZAlplbPwWsMUIll95ZA==
=zGTb
-----END PGP SIGNATURE-----

--xreb33oq7irsncof--
