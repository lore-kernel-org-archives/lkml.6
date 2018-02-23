Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeBWE6w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 23:58:52 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:43710 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeBWE6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 23:58:50 -0500
X-Google-Smtp-Source: AG47ELtgY0helNBFsF3azexMeUQv9m5ZSAt29RFakCJpJPbVcAtqwHNqHUMIy7/g2a897gnbVNtLVQ==
X-ME-Sender: <xms:h5-PWkwqp57uMISTkQcZVCVkpiMOnFzrW2t1Wj1bMDdJ3N8laMPodg>
Date: Fri, 23 Feb 2018 13:02:09 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 05/17] lockdep: Extend __bfs() to
 work with multiple kinds of dependencies
Message-ID: <20180223050209.qy46njbj7phvuxqy@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-6-boqun.feng@gmail.com>
 <20180222142614.GR25201@hirez.programming.kicks-ass.net>
 <20180222151210.jwxjchywk4jfecyf@tardis>
 <20180222153034.GO25181@hirez.programming.kicks-ass.net>
 <20180222155143.GV25235@hirez.programming.kicks-ass.net>
 <20180222163120.zhytq7yezny4e7mj@tardis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v72geli2ovdrwu7e"
Content-Disposition: inline
In-Reply-To: <20180222163120.zhytq7yezny4e7mj@tardis>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v72geli2ovdrwu7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 12:31:20AM +0800, Boqun Feng wrote:
> On Thu, Feb 22, 2018 at 04:51:43PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 22, 2018 at 04:30:34PM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 22, 2018 at 11:12:10PM +0800, Boqun Feng wrote:
> > > > On Thu, Feb 22, 2018 at 03:26:14PM +0100, Peter Zijlstra wrote:
> > >=20
> > > > > However, I would suggest:
> > > > >=20
> > > > > static inline bool is_xr(u16 dep)
> > > > > {
> > > > > 	return !!(dep & (DEP_NR_MASK | DEP_RR_MASK));
> > > > > }
> > > > >=20
> > > > > static inline bool is_rx(u16 dep)
> > > > > {
> > > > > 	return !!(dep & (DEP_RN_MASK | DEP_RR_MASK));
> > > > > }
> > > > >=20
> > > > > 		/* Skip *R -> R* relations */
> > > > > 		if (have_xr && is_rx(entry->dep))
> > > > > 			continue;
> > > >=20
> > > > I don't think this works, if we pick a *R for previous entry, and f=
or
> > > > current entry, we have RR, NN and NR, your approach will skip the
> > > > current entry, but actually we can pick NN or NR (of course, in __b=
fs(),
> > > > we can greedily pick NN, because if NR causes a deadlock, so does N=
N).
> > >=20
> > > I don't get it, afaict my suggestion is identical.
> > >=20
> > > You skip condition: pick_dep() < 0, evaluates to:
> > >=20
> > > 	is_rr && (!NN_MASK && !NR_MASK) :=3D
> > > 	is_rr && (RN_MASK | RR_MASK)
> > >=20
> > > Which is exactly what I have.
> >=20
> > Ooh, I think I see what I did wrong, would something like:
> >=20
> > 	if (have_xr && !is_nx(entry-dep))
> >=20
> > work? That's a lot harder to argue about though, still much better than
>=20
> I think it works. Although I prefer use name "has_nx" for the fucntion.
>=20
> > that tri-state pick thing.
> >=20
>=20
> Agree.
>=20
> > > If that is satisfied, you set entry->is_rr to pick_dep(), which his
> > > harder to evaluate, but is something like:
> > >=20
> > > 	is_rr && NR_MASK || !(NN_MASK | RN_MASK) :=3D
>=20
> If is_rr is true and NN_MASK is true, pick_dep() will return 0, however,
> your expression will return NR_MASK.
>=20

It was too late last night, I was meant to say, the correct
entry->have_xr should be as follow:

> 	entry->have_xr =3D !(has_nn(entry->dep) || (!is_rr && has_rn(entry->dep)=
));
> 	              :=3D !has_nn(entry->dep) && (is_rr || !has_rn(entry->dep))
>=20

so it seems that we have to introduce is_{nn,rn,nx}(), I'm not sure
introducing three one-off helpers is a good direction to go. One benefit
of using pick_dep() is that we can keep the whole logic in one function.
Thoughts?

Regards,
Boqun

> Regards,
> Boqun
>=20
> > > 	is_rr && NR_MASK || (NR_MASK | RR_MASK) :=3D
> > > 	(NR_MASK | RR_MASK)
> > >=20
> > > (because is_rr && RR_MASK will have been skipped)
> > >=20
> > > > >=20
> > > > > 		entry->have_xr =3D is_xr(entry->dep);
> >=20
> > This one I think is still correct though.



--v72geli2ovdrwu7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqPoEQACgkQSXnow7UH
+ri2xwf/XC5MtkIhe+ak+TLg07EksxBzXSCdR+CGXd4jjuNDxFTqfzdgQbcQNctA
9gmjaJkUQ6y7SRo74A7bc+fHtkCr9F9wn6nk7b1HnDifXv8xssw0TQzIvq5CJuf1
mYVdtoZFK8vnmH+314hMRKaSszV7BbGeD8gmU5P5TXXH2ynW3ulc4VgMDfphLZm3
2g0ZaBSWxGcfTJ0T+Kp3og+oS8TqbrD+/moBwDOhRG4KIqwJeJwS7IZFEomMvLgF
NPOU1wXt2riWIM3qgI9SKgKo6pjgoH+GQlKEjgPXi3X72y7kkNRadrZPp6FVk82l
N/KODhrqNH89ekfngnIR9pqg69x28w==
=VswF
-----END PGP SIGNATURE-----

--v72geli2ovdrwu7e--
