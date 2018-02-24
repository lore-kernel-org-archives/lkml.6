Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbeBXI45 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 03:56:57 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35503 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeBXI44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 03:56:56 -0500
X-Google-Smtp-Source: AH8x227eUaPbhVd2531TTCQliu+JEFsBGxyVRZ4VthnjSsjy1sjWNcAPnuGbabIPZQ0nn2A+NVovlg==
X-ME-Sender: <xms:0yiRWjrell-WPA3jkHim82Yi-nC_jpmGt3iLv3LnnmOzKlYWqC4PBQ>
Date: Sat, 24 Feb 2018 17:00:19 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 04/17] lockdep: Introduce
 lock_list::dep
Message-ID: <20180224090019.3smjampkk4zoacb3@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-5-boqun.feng@gmail.com>
 <20180223115520.GV25181@hirez.programming.kicks-ass.net>
 <20180223123732.acxbavnf2ktd4lzl@tardis>
 <20180224053250.ketrlbq4gtx573qo@tardis>
 <20180224063005.efbowkoq2v4qndan@tardis>
 <20180224083807.GB25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xdcpymzgkkvrxpgg"
Content-Disposition: inline
In-Reply-To: <20180224083807.GB25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xdcpymzgkkvrxpgg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 09:38:07AM +0100, Peter Zijlstra wrote:
> On Sat, Feb 24, 2018 at 02:30:05PM +0800, Boqun Feng wrote:
> > On Sat, Feb 24, 2018 at 01:32:50PM +0800, Boqun Feng wrote:
>=20
> > > 	/*
> > > 	 * DEP_*_BIT in lock_list::dep
> > > 	 *
> > > 	 * For dependency @prev -> @next:
> > > 	 *
> > > 	 *   RR: both @prev and @next are recursive read locks, i.e. ->read =
=3D=3D 2.
> > > 	 *   RN: @prev is recursive and @next is non-recursive.
> > > 	 *   NR: @prev is a not recursive and @next is recursive.
> > > 	 *   NN: both @prev and @next are non-recursive.
> > > 	 *=20
> > > 	 * Note that we define the value of DEP_*_BITs so that:
> > > 	 * 	bit0 is prev->read !=3D 2
> > > 	 * 	bit1 is next->read !=3D 2
> > > 	 */
> > > 	#define DEP_RR_BIT 0
> > > 	#define DEP_RN_BIT 1
> > > 	#define DEP_NR_BIT 2
> > > 	#define DEP_NN_BIT 3
> > >=20
> > > 	#define DEP_RR_MASK (1U << (DEP_RR_BIT))
> > > 	#define DEP_RN_MASK (1U << (DEP_RN_BIT))
> > > 	#define DEP_NR_MASK (1U << (DEP_NR_BIT))
> > > 	#define DEP_NN_MASK (1U << (DEP_NN_BIT))
> > >=20
> > > 	static inline unsigned int
> > > 	__calc_dep_bit(struct held_lock *prev, struct held_lock *next)
> > > 	{
> > > 		return (prev->read !=3D 2) + ((next->read !=3D 2) << 1)
> > > 	}
> > >=20
> > > 	static inline u8 calc_dep(struct held_lock *prev, struct held_lock *=
next)
> > > 	{
> > > 		return 1U << __calc_dep_bit(prev, next);
> > > 	}
> > >=20
> > >  	static inline bool only_rx(u8 dep)
> > >  	{
> > >  		return !(dep & (DEP_NR_MASK | DEP_NN_MASK));
> > >  	}
> > >=20
> > >  	static inline bool only_xr(u8 dep)
> > >  	{
> > >  		return !(dep & (DEP_NR_MASK | DEP_NN_MASK));
> > >  	}
> > >=20
>=20
> > > > > 	if (have_xr && is_rx(entry->dep))
> > > > > 		continue;
> > > > >=20
> > > > > 	entry->have_xr =3D is_xr(entry->dep);
> > > > >=20
> >=20
> > Hmm.. I think this part also needs some tweak:
> >=20
> > 	/* if -> prev is *R, and we only have R* for prev -> this, * skip*/
> > 	if (have_xr && only_rx(entry->dep))
> > 		continue;
> > =09
> > 	/*
> > 	 * we pick a *R for prev -> this only if:
> > 	 *     prev -> this dependencies are all *R=20
> > 	 * or
> > 	 *     -> prev is *R, and we don't have NN for prev -> this
> > 	 */
> > 	entry->have_xr =3D only_xr(entry->dep) || (have_xr && !is_nn(entry->de=
p));
> >=20
> > otherwise, we will wrongly set entry->have_xr to false if have_xr is
> > true and we have RN for prev -> this.
>=20
> OK, so its saturday morning and such, but what? Why should we set
> have_xr true when we have RN? Note that if we only had RN we'd already
> have bailed on the continue due to only_rx().
>=20

But what if we have RN and NR? only_rx() will return false, but due to
have_xr is true, we can not pick RN, so entry->have_xr should be set to
true (due to we have to pick NR), however only_xr() is false becuase we
have RN, so if we set entry->have_xr to only_xr(), we set it as false.

This is for case like:

	TASK1:
		read_lock(A);
		read_lock(B);
=09
	TASK2:
		write_lock(B);
		read_lock(C);
=09
	TASK3:
		read_lock(B);
		write_lock(C);

	TASK4:
		read_lock(C);
		write_lock(A);

, which is not a deadlock.

Am I missing something sublte?
	=09

Regards,
Boqun

> So can you elaborate a bit?

--xdcpymzgkkvrxpgg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqRKaAACgkQSXnow7UH
+rhOAgf6ArSpXp5sy98SkqwMUOoRF9Soy9nSDHashhwXCPqwBB4TGFoopwCT5W9Y
5UwjotT4t17yw6BthMKej3SNf6AEYArH0sGv4cXaIkX62hYLTdRnONsfQX9XHUBd
aDey0838RLascH9gGjHgJkvgwPa3xf4eudQt0nrQ1iKldzFE6H0tHwKFjn4CWtiG
lypY9oqPTXjv4hvC+p9FgF7QsYTStPByMQAI8GT8Qz09OZ1D5Aa9zrFh5/jOJIWl
MhBgvQhAkzBL/FPefaI+ESTMJIYNb5EldOCBvLIE16Ja9/NJPpm17Wr/11xWLsx0
pzOf//Dcmc+9NaxZZONVHODHYoQkEw==
=ZMeq
-----END PGP SIGNATURE-----

--xdcpymzgkkvrxpgg--
