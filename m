Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933234AbeBVQ17 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:27:59 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:51720 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbeBVQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:27:58 -0500
X-Google-Smtp-Source: AH8x224a707C/QpojFSRaZt+5KBDwrbfym3sFGPZlTvVpoZR3n9f6njBZ2zBYTCTGaalmvRVQZhuOg==
X-ME-Sender: <xms:iO-OWs-9k_4fXprCBFNjWamPZJfb2sRtOwNpV4FqqSD2tKR7530NgQ>
Date: Fri, 23 Feb 2018 00:31:20 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 05/17] lockdep: Extend __bfs() to
 work with multiple kinds of dependencies
Message-ID: <20180222163120.zhytq7yezny4e7mj@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-6-boqun.feng@gmail.com>
 <20180222142614.GR25201@hirez.programming.kicks-ass.net>
 <20180222151210.jwxjchywk4jfecyf@tardis>
 <20180222153034.GO25181@hirez.programming.kicks-ass.net>
 <20180222155143.GV25235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6gf6kgjvgo7vnbac"
Content-Disposition: inline
In-Reply-To: <20180222155143.GV25235@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6gf6kgjvgo7vnbac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 04:51:43PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 04:30:34PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 22, 2018 at 11:12:10PM +0800, Boqun Feng wrote:
> > > On Thu, Feb 22, 2018 at 03:26:14PM +0100, Peter Zijlstra wrote:
> >=20
> > > > However, I would suggest:
> > > >=20
> > > > static inline bool is_xr(u16 dep)
> > > > {
> > > > 	return !!(dep & (DEP_NR_MASK | DEP_RR_MASK));
> > > > }
> > > >=20
> > > > static inline bool is_rx(u16 dep)
> > > > {
> > > > 	return !!(dep & (DEP_RN_MASK | DEP_RR_MASK));
> > > > }
> > > >=20
> > > > 		/* Skip *R -> R* relations */
> > > > 		if (have_xr && is_rx(entry->dep))
> > > > 			continue;
> > >=20
> > > I don't think this works, if we pick a *R for previous entry, and for
> > > current entry, we have RR, NN and NR, your approach will skip the
> > > current entry, but actually we can pick NN or NR (of course, in __bfs=
(),
> > > we can greedily pick NN, because if NR causes a deadlock, so does NN).
> >=20
> > I don't get it, afaict my suggestion is identical.
> >=20
> > You skip condition: pick_dep() < 0, evaluates to:
> >=20
> > 	is_rr && (!NN_MASK && !NR_MASK) :=3D
> > 	is_rr && (RN_MASK | RR_MASK)
> >=20
> > Which is exactly what I have.
>=20
> Ooh, I think I see what I did wrong, would something like:
>=20
> 	if (have_xr && !is_nx(entry-dep))
>=20
> work? That's a lot harder to argue about though, still much better than

I think it works. Although I prefer use name "has_nx" for the fucntion.

> that tri-state pick thing.
>=20

Agree.

> > If that is satisfied, you set entry->is_rr to pick_dep(), which his
> > harder to evaluate, but is something like:
> >=20
> > 	is_rr && NR_MASK || !(NN_MASK | RN_MASK) :=3D

If is_rr is true and NN_MASK is true, pick_dep() will return 0, however,
your expression will return NR_MASK.

	entry->have_xr =3D !(has_nn(entry->dep) || (!is_rr && has_rn(entry->dep)));
	              :=3D !has_nn(entry->dep) && (is_rr || !has_rn(entry->dep))

Regards,
Boqun

> > 	is_rr && NR_MASK || (NR_MASK | RR_MASK) :=3D
> > 	(NR_MASK | RR_MASK)
> >=20
> > (because is_rr && RR_MASK will have been skipped)
> >=20
> > > >=20
> > > > 		entry->have_xr =3D is_xr(entry->dep);
>=20
> This one I think is still correct though.

--6gf6kgjvgo7vnbac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqO8FUACgkQSXnow7UH
+rg0xAgArZ1YjSSEWIHx4sbrnwc+0CWjavuB9wut9YkbBU0y4QPtc8tZONI55FOJ
7RZ+7HkHUb1Zk4Czz7EUVt3T9tYmJ3cLXlKJtzhUxeEzhSzy0cqlKzLQhgCgh/lN
Z+bn0xyVRvK5eXgHrKWU6760em198y/5jaj/QzFp2Sl6mzdNtxHnAt6HCDEEtPED
cOiX7gkDGOMyQ3Bxttya4h2aryiQ+lYXmM7dwNaqgScezKwTo4O4bbTvfY6RPaYk
B+XhUNzppcyYzfb3cGpMR5xiKIrmEioMzEbC70gItXX/8nbjW0Nas74F6WprmrOG
vNNT47v41hfMRaVuxir6KINVEb7t5w==
=Uuyg
-----END PGP SIGNATURE-----

--6gf6kgjvgo7vnbac--
