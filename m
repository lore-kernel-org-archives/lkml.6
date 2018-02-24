Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeBXG0m (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 01:26:42 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:36380 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeBXG0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 01:26:41 -0500
X-Google-Smtp-Source: AG47ELutbEn2EDRej1octblOZC1ygW+h7K/E6Gh1l7qx8fI8VhO/kvoNbOOOvfJHfkiBPb8Tjr2Iqw==
X-ME-Sender: <xms:ngWRWhq6ZrcTir_F9LR_-dD6J_3ZzO3APHcgqS4QjKIYu-JG2HbKhg>
Date: Sat, 24 Feb 2018 14:30:05 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 04/17] lockdep: Introduce
 lock_list::dep
Message-ID: <20180224063005.efbowkoq2v4qndan@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-5-boqun.feng@gmail.com>
 <20180223115520.GV25181@hirez.programming.kicks-ass.net>
 <20180223123732.acxbavnf2ktd4lzl@tardis>
 <20180224053250.ketrlbq4gtx573qo@tardis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wunwknbpeonuisk7"
Content-Disposition: inline
In-Reply-To: <20180224053250.ketrlbq4gtx573qo@tardis>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wunwknbpeonuisk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 01:32:50PM +0800, Boqun Feng wrote:
> On Fri, Feb 23, 2018 at 08:37:32PM +0800, Boqun Feng wrote:
> > On Fri, Feb 23, 2018 at 12:55:20PM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 22, 2018 at 03:08:51PM +0800, Boqun Feng wrote:
> > > > @@ -1012,6 +1013,33 @@ static inline bool bfs_error(enum bfs_result=
 res)
> > > >  	return res < 0;
> > > >  }
> > > > =20
> > > > +#define DEP_NN_BIT 0
> > > > +#define DEP_RN_BIT 1
> > > > +#define DEP_NR_BIT 2
> > > > +#define DEP_RR_BIT 3
> > > > +
> > > > +#define DEP_NN_MASK (1U << (DEP_NN_BIT))
> > > > +#define DEP_RN_MASK (1U << (DEP_RN_BIT))
> > > > +#define DEP_NR_MASK (1U << (DEP_NR_BIT))
> > > > +#define DEP_RR_MASK (1U << (DEP_RR_BIT))
> > > > +
> > > > +static inline unsigned int __calc_dep_bit(int prev, int next)
> > > > +{
> > > > +	if (prev =3D=3D 2 && next !=3D 2)
> > > > +		return DEP_RN_BIT;
> > > > +	if (prev !=3D 2 && next =3D=3D 2)
> > > > +		return DEP_NR_BIT;
> > > > +	if (prev =3D=3D 2 && next =3D=3D 2)
> > > > +		return DEP_RR_BIT;
> > > > +	else
> > > > +		return DEP_NN_BIT;
> > > > +}
> > > > +
> > > > +static inline unsigned int calc_dep(int prev, int next)
> > > > +{
> > > > +	return 1U << __calc_dep_bit(prev, next);
> > > > +}
> > > > +
> > > >  static enum bfs_result __bfs(struct lock_list *source_entry,
> > > >  			     void *data,
> > > >  			     int (*match)(struct lock_list *entry, void *data),
> > > > @@ -1921,6 +1949,16 @@ check_prev_add(struct task_struct *curr, str=
uct held_lock *prev,
> > > >  		if (entry->class =3D=3D hlock_class(next)) {
> > > >  			if (distance =3D=3D 1)
> > > >  				entry->distance =3D 1;
> > > > +			entry->dep |=3D calc_dep(prev->read, next->read);
> > > > +		}
> > > > +	}
> > > > +
> > > > +	/* Also, update the reverse dependency in @next's ->locks_before =
list */
> > > > +	list_for_each_entry(entry, &hlock_class(next)->locks_before, entr=
y) {
> > > > +		if (entry->class =3D=3D hlock_class(prev)) {
> > > > +			if (distance =3D=3D 1)
> > > > +				entry->distance =3D 1;
> > > > +			entry->dep |=3D calc_dep(next->read, prev->read);
> > > >  			return 1;
> > > >  		}
> > > >  	}
> > >=20
> > > I think it all becomes simpler if you use only 2 bits. Such that:
> > >=20
> > >   bit0 is the prev R (0) or N (1) value,
> > >   bit1 is the next R (0) or N (1) value.
> > >=20
> > > I think this should work because we don't care about the empty set
> > > (currently 0000) and all the complexity in patch 5 is because we can
> > > have R bits set when there's also N bits. The concequence of that is
> > > that we cannot replace ! with ~ (which is what I kept doing).
> > >=20
> > > But with only 2 bits, we only track the strongest relation in the set,
> > > which is exactly what we appear to need.
> > >=20
> >=20
> > But if we only have RN and NR, both bits will be set, we can not check
> > whether we have NN or not. Consider we have:
> >=20
> > 	A -(RR)-> B
> > 	B -(NR)-> C and B -(RN)-> C
> > 	C -(RN)-> A
> >=20
> > this is not a deadlock case, but with "two bits" approach, we can not
> > differ this with:
> >=20
> > 	A -(RR)-> B
> > 	B -(NN)-> C
> > 	C -(RN)-> A
> >=20
> > , which is a deadlock.
> >=20
> > But maybe "three bits" (NR, RN and NN bits) approach works, that is if
> > ->dep is 0, we indicates this is only RR, and is_rx() becomes:
> >=20
> > 	static inline bool is_rx(u8 dep)
> > 	{
> > 		return !(dep & (NR_MASK | NN_MASK));
> > 	}
> >=20
> > and is_xr() becomes:
> >=20
> > 	static inline bool is_xr(u8 dep)
> > 	{
> > 		return !(dep & (RN_MASK | NN_MASK));
> > 	}
> >=20
> > , with this I think your simplification with have_xr works, thanks!
> >=20
>=20
> Ah! I see. Actually your very first approach works, except the
> definitions of is_rx() and ir_xr() are wrong. In that approach, you
> define
> =09
> 	static inline bool is_rx(u8 dep)
> 	{
> 		return !!(dep & (DEP_RR_MASK | DEP_RN_MASK);
> 	}
>=20
> , which means "whether we have a R* dependency?". But in fact, what we
> need to check is "whether we _only_ have R* dependencies?", if so and
> have_xr is true, that means we could only have a -(*R)-> A -(R*)-> if we
> pick the next dependency, and that means we should skip. So my new
> definition above works, and I think we better name it as only_rx() to
> avoid confusion? Ditto for is_xr().
>=20
> I also reorder bit number for each kind of dependency, so that we have a
> simple __calc_dep_bit(), see the following:
>=20
> 	/*
> 	 * DEP_*_BIT in lock_list::dep
> 	 *
> 	 * For dependency @prev -> @next:
> 	 *
> 	 *   RR: both @prev and @next are recursive read locks, i.e. ->read =3D=
=3D 2.
> 	 *   RN: @prev is recursive and @next is non-recursive.
> 	 *   NR: @prev is a not recursive and @next is recursive.
> 	 *   NN: both @prev and @next are non-recursive.
> 	 *=20
> 	 * Note that we define the value of DEP_*_BITs so that:
> 	 * 	bit0 is prev->read !=3D 2
> 	 * 	bit1 is next->read !=3D 2
> 	 */
> 	#define DEP_RR_BIT 0
> 	#define DEP_RN_BIT 1
> 	#define DEP_NR_BIT 2
> 	#define DEP_NN_BIT 3
>=20
> 	#define DEP_RR_MASK (1U << (DEP_RR_BIT))
> 	#define DEP_RN_MASK (1U << (DEP_RN_BIT))
> 	#define DEP_NR_MASK (1U << (DEP_NR_BIT))
> 	#define DEP_NN_MASK (1U << (DEP_NN_BIT))
>=20
> 	static inline unsigned int
> 	__calc_dep_bit(struct held_lock *prev, struct held_lock *next)
> 	{
> 		return (prev->read !=3D 2) + ((next->read !=3D 2) << 1)
> 	}
>=20
> 	static inline u8 calc_dep(struct held_lock *prev, struct held_lock *next)
> 	{
> 		return 1U << __calc_dep_bit(prev, next);
> 	}
>=20
>  	static inline bool only_rx(u8 dep)
>  	{
>  		return !(dep & (DEP_NR_MASK | DEP_NN_MASK));
>  	}
>=20
>  	static inline bool only_xr(u8 dep)
>  	{
>  		return !(dep & (DEP_NR_MASK | DEP_NN_MASK));
>  	}
>=20
> Note that we actually don't need DEP_RR_BIT, but I leave it there for
> implementation simplicity. With this, your check and set below works.
>=20
> Thoughts?
>=20
> Regards,
> Boqun
>=20
> > >=20
> > >=20
> > > 	if (have_xr && is_rx(entry->dep))
> > > 		continue;
> > >=20
> > > 	entry->have_xr =3D is_xr(entry->dep);
> > >=20

Hmm.. I think this part also needs some tweak:

	/* if -> prev is *R, and we only have R* for prev -> this, * skip*/
	if (have_xr && only_rx(entry->dep))
		continue;
=09
	/*
	 * we pick a *R for prev -> this only if:
	 *     prev -> this dependencies are all *R=20
	 * or
	 *     -> prev is *R, and we don't have NN for prev -> this
	 */
	entry->have_xr =3D only_xr(entry->dep) || (have_xr && !is_nn(entry->dep));

otherwise, we will wrongly set entry->have_xr to false if have_xr is
true and we have RN for prev -> this.

Regards,
Boqun

> > >=20
> > > Or did I mess that up somewhere?
>=20
>=20



--wunwknbpeonuisk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqRBmoACgkQSXnow7UH
+rgLTAgAtEV5tlmtu9fjnV9a7x8Z7PiLoW4Ve0oqb8XBlVarBtLrhJStV0CcBcLJ
ziCXju0mqnIAGDl+Etwd4DU0Ybc4dpRtBzfz+m5R7ROgYdmToBH0jsBPoD7UVAvB
Vt1rf1OvsPlbnbvzD7YVaZLbWwn/vvZ4O1UslyeGRcCaQTx6uSm+HJfVI3QsI8nA
Rv5F6yzSjrm8OpjxjW4Vy4LdENk+nD0k4k4ubDtSXXMLfZ1I9sH9DXPq5diC4DNM
HZ3PZjIl2DvN/rPqebytYEprR5+Nf4ggUdRWI6UnLv5+8bduz8m9mYAyVpkfg0je
diKgANEfPHrXAugd8IY3NNzWBVsRCA==
=yiVS
-----END PGP SIGNATURE-----

--wunwknbpeonuisk7--
