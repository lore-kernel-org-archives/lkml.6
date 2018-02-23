Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeBWMeN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:34:13 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:46766 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBWMeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:34:11 -0500
X-Google-Smtp-Source: AG47ELtW8eR1HcZcz6j6dBlXhaNJS0YlLX6yA3GewWtRM29TySgH2Go9Y6nGuN7dAnQZx+1Cdq2z1g==
X-ME-Sender: <xms:QAqQWpCE7rA-O6eKZGU0KbRUSsNJlRY5ww-XlXpMdTVRwGJQE3Y4Xg>
Date: Fri, 23 Feb 2018 20:37:32 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 04/17] lockdep: Introduce
 lock_list::dep
Message-ID: <20180223123732.acxbavnf2ktd4lzl@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-5-boqun.feng@gmail.com>
 <20180223115520.GV25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l4ucs6he4tmf3ml5"
Content-Disposition: inline
In-Reply-To: <20180223115520.GV25181@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l4ucs6he4tmf3ml5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 12:55:20PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 03:08:51PM +0800, Boqun Feng wrote:
> > @@ -1012,6 +1013,33 @@ static inline bool bfs_error(enum bfs_result res)
> >  	return res < 0;
> >  }
> > =20
> > +#define DEP_NN_BIT 0
> > +#define DEP_RN_BIT 1
> > +#define DEP_NR_BIT 2
> > +#define DEP_RR_BIT 3
> > +
> > +#define DEP_NN_MASK (1U << (DEP_NN_BIT))
> > +#define DEP_RN_MASK (1U << (DEP_RN_BIT))
> > +#define DEP_NR_MASK (1U << (DEP_NR_BIT))
> > +#define DEP_RR_MASK (1U << (DEP_RR_BIT))
> > +
> > +static inline unsigned int __calc_dep_bit(int prev, int next)
> > +{
> > +	if (prev =3D=3D 2 && next !=3D 2)
> > +		return DEP_RN_BIT;
> > +	if (prev !=3D 2 && next =3D=3D 2)
> > +		return DEP_NR_BIT;
> > +	if (prev =3D=3D 2 && next =3D=3D 2)
> > +		return DEP_RR_BIT;
> > +	else
> > +		return DEP_NN_BIT;
> > +}
> > +
> > +static inline unsigned int calc_dep(int prev, int next)
> > +{
> > +	return 1U << __calc_dep_bit(prev, next);
> > +}
> > +
> >  static enum bfs_result __bfs(struct lock_list *source_entry,
> >  			     void *data,
> >  			     int (*match)(struct lock_list *entry, void *data),
> > @@ -1921,6 +1949,16 @@ check_prev_add(struct task_struct *curr, struct =
held_lock *prev,
> >  		if (entry->class =3D=3D hlock_class(next)) {
> >  			if (distance =3D=3D 1)
> >  				entry->distance =3D 1;
> > +			entry->dep |=3D calc_dep(prev->read, next->read);
> > +		}
> > +	}
> > +
> > +	/* Also, update the reverse dependency in @next's ->locks_before list=
 */
> > +	list_for_each_entry(entry, &hlock_class(next)->locks_before, entry) {
> > +		if (entry->class =3D=3D hlock_class(prev)) {
> > +			if (distance =3D=3D 1)
> > +				entry->distance =3D 1;
> > +			entry->dep |=3D calc_dep(next->read, prev->read);
> >  			return 1;
> >  		}
> >  	}
>=20
> I think it all becomes simpler if you use only 2 bits. Such that:
>=20
>   bit0 is the prev R (0) or N (1) value,
>   bit1 is the next R (0) or N (1) value.
>=20
> I think this should work because we don't care about the empty set
> (currently 0000) and all the complexity in patch 5 is because we can
> have R bits set when there's also N bits. The concequence of that is
> that we cannot replace ! with ~ (which is what I kept doing).
>=20
> But with only 2 bits, we only track the strongest relation in the set,
> which is exactly what we appear to need.
>=20

But if we only have RN and NR, both bits will be set, we can not check
whether we have NN or not. Consider we have:

	A -(RR)-> B
	B -(NR)-> C and B -(RN)-> C
	C -(RN)-> A

this is not a deadlock case, but with "two bits" approach, we can not
differ this with:

	A -(RR)-> B
	B -(NN)-> C
	C -(RN)-> A

, which is a deadlock.

But maybe "three bits" (NR, RN and NN bits) approach works, that is if
->dep is 0, we indicates this is only RR, and is_rx() becomes:

	static inline bool is_rx(u8 dep)
	{
		return !(dep & (NR_MASK | NN_MASK));
	}

and is_xr() becomes:

	static inline bool is_xr(u8 dep)
	{
		return !(dep & (RN_MASK | NN_MASK));
	}

, with this I think your simplification with have_xr works, thanks!

Regards,
Boqun

>=20
> The above then becomes something like:
>=20
> static inline u8 __calc_dep(struct held_lock *lock)
> {
> 	return lock->read !=3D 2;
> }
>=20
> static inline u8
> calc_dep(struct held_lock *prev, struct held_lock *next)
> {
> 	return (__calc_dep(prev) << 0) | (__calc_dep(next) << 1);
> }
>=20
>=20
> 	entry->dep |=3D calc_dep(prev, next);
>=20
>=20
>=20
> Then the stuff from 5 can be:
>=20
> static inline bool is_rx(u8 dep)
> {
> 	return !(dep & 1);
> }
>=20
> static inline bool is_xr(u8 dep)
> {
> 	return !(dep & 2);
> }
>=20
>=20
> 	if (have_xr && is_rx(entry->dep))
> 		continue;
>=20
> 	entry->have_xr =3D is_xr(entry->dep);
>=20
>=20
> Or did I mess that up somewhere?

--l4ucs6he4tmf3ml5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqQCwkACgkQSXnow7UH
+rihnwf/bfreTR7tos5t+AupSBtiyoF0b7afb1ILGKY+Z87YLvFZ3BzH/xqbcUoB
mmXnr1UIWjXXsHKrVepRuMyhsvExMFh+bH4SWF4HXJk35kasIXf3tb7Uk8IcFLCC
xcxPZwsH1zvhcyz+bV2aDYFSUFR02PE70cgC+ii1ks3zbKSjbHqpGWZ0e5py5DYP
O20J0Ny/iCKTu3j9msou6eFrU55tZLMADIP32v0MbsQ2+Bp8sGrZpHpvtlBlE6K7
Kqgxgi4Lgvwqhcl3jbr/EzofXN22crxy+V6R7yLhUVOtcPP/O9LIhh3eFnNHUk+V
gApSslxXux5Mbl8ijPCG+E6w3a3YsQ==
=fYrB
-----END PGP SIGNATURE-----

--l4ucs6he4tmf3ml5--
