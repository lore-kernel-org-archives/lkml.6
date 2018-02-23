Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeBWIyt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:54:49 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37005 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeBWIyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:54:47 -0500
X-Google-Smtp-Source: AH8x2255o5f07gXgyysvhOmMfRiitFL1AtVX28WJh/Zcy9i/v2jmgSRq9uguUroSdasbBlU3lO6Y+Q==
X-ME-Sender: <xms:09aPWhr3Ll6dileTA_w5PeilPmZbqujvmPeTEuIqLh0c1G_lYFXJ9A>
Date: Fri, 23 Feb 2018 16:58:12 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 08/17] lockdep: Fix recursive read
 lock related safe->unsafe detection
Message-ID: <20180223085812.22u7o6z2gcg272jn@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-9-boqun.feng@gmail.com>
 <20180222174654.GW25201@hirez.programming.kicks-ass.net>
 <20180223082134.ykkbzqj2h7glxrqn@tardis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zwqd4op5xu7ger2e"
Content-Disposition: inline
In-Reply-To: <20180223082134.ykkbzqj2h7glxrqn@tardis>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zwqd4op5xu7ger2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 04:21:34PM +0800, Boqun Feng wrote:
> On Thu, Feb 22, 2018 at 06:46:54PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 22, 2018 at 03:08:55PM +0800, Boqun Feng wrote:
> > > There are four cases for recursive read lock realted deadlocks:
> > >=20
> > > (--(X..Y)--> means a strong dependency path starts with a --(X*)-->
> > > dependency and ends with a --(*Y)-- dependency.)
> > >=20
> > > 1.	An irq-safe lock L1 has a dependency --(*..*)--> to an
> > > 	irq-unsafe lock L2.
> > >=20
> > > 2.	An irq-read-safe lock L1 has a dependency --(N..*)--> to an
> > > 	irq-unsafe lock L2.
> > >=20
> > > 3.	An irq-safe lock L1 has a dependency --(*..N)--> to an
> > > 	irq-read-unsafe lock L2.
> > >=20
> > > 4.	An irq-read-safe lock L1 has a dependency --(N..N)--> to an
> > > 	irq-read-unsafe lock L2.
> > >=20
> > > The current check_usage() only checks 1) and 2), so this patch adds
> > > checks for 3) and 4) and makes sure when find_usage_{back,for}wards f=
ind
> > > an irq-read-{,un}safe lock, the traverse path should ends at a
> > > dependency --(*N)-->. Note when we search backwards, --(*N)--> indica=
tes
> > > a real dependency --(N*)-->.
> >=20
> > This adds 4 __bfs() searches for every new link.
> >=20
> > Can't we make the existing traversals smarter?
>=20
> Haven't really thought this one through, I will try. But as you said, we

Hmm... think again, maybe I can combine case 1 with 3, and case 2 with
4, because each of them could share the same find_usage_backwards(), and
find_usage_forwards() uses a usage_match_forwards() as follow for the
match function:

	static inline int usage_match_forwards(struct lock_list *entry, void *bit)
	{
		enum lock_usage_bit ub =3D (enum lock_usage_bit)bit;
		unsigned long mask;
		unsigned long read_mask;

		/* mask out the read bit */
		ub &=3D ~1;

		mask =3D 1ULL << ub;
		read_mask =3D 1ULL << (ub + 1);

		return (entry->class->usage_mask & mask) ||  // *-> L2 and L2 is an irq-u=
nsafe lock
		       ((entry->class->usage_mask & read_mask) && !entry->is_rr); // N-> =
L2 and L2 is an irq-read-unsafe lock
	}

Got a bus to catch, I can explain this later, if you need ;-)

Regards,
Boqun

> only need to do more searchs for _new_ links, so I think it's the slow
> path, would the performance matter that much?
>=20
> Regards,
> Boqun



--zwqd4op5xu7ger2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqP16AACgkQSXnow7UH
+rgmSwf/XlM7/ph/GuiOIou6v7OpVJW1VKgy3OEdPPXQcIIDcMtrgjJOL7FAmoQw
/hPnLmmubkbj6hAfbgf3bayhDyBPRJOWMw2mVEVrGwpQ7S+byOI/VXfU2hkfwBP9
FvoSPZBC0CRqlEDMbl9apDskseE3XkqCko/nSSaom19mILY1wWyM8HnfT3sb3yXL
QVG6bMfLkWR6YhXKcVsL8jQfPrUaih7u55Opxw3RBENc+mSC+7AucXC0Ci2lVQdI
9wjkgHsjstqMPlnvPh90Hagi2YPqrK7mO5AbYBvpPht0dV4tEdeUyNpStAY7iCze
VDDlqbkBfKeCBtacd3vuwR24u/Gj2Q==
=sWM2
-----END PGP SIGNATURE-----

--zwqd4op5xu7ger2e--
