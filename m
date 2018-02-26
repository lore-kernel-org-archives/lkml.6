Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeBZKQs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:16:48 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35408 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbeBZKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:16:47 -0500
X-Google-Smtp-Source: AG47ELujmzhhhV94woOaVIXt7hjvK5+UsrjJi4sT/4f6vAgSp4akwsch66eEODx9RRpWLlrX9zX+oQ==
X-ME-Sender: <xms:jd6TWphmD75DpbEx62aSdytaWfJOEu0q98uEkOgpKQl_s6PYuAblxA>
Date: Mon, 26 Feb 2018 18:20:16 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 04/17] lockdep: Introduce
 lock_list::dep
Message-ID: <20180226102016.4rms4ro6wcwwsw7d@tardis>
References: <20180222070904.548-5-boqun.feng@gmail.com>
 <20180223115520.GV25181@hirez.programming.kicks-ass.net>
 <20180223123732.acxbavnf2ktd4lzl@tardis>
 <20180224053250.ketrlbq4gtx573qo@tardis>
 <20180224063005.efbowkoq2v4qndan@tardis>
 <20180224083807.GB25201@hirez.programming.kicks-ass.net>
 <20180224090019.3smjampkk4zoacb3@tardis>
 <20180224092651.hjxznghmuiyj4rnp@tardis>
 <20180226090050.GE25201@hirez.programming.kicks-ass.net>
 <20180226101524.xaarifgmhzdzq7gs@tardis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pdbmadqmexido3oa"
Content-Disposition: inline
In-Reply-To: <20180226101524.xaarifgmhzdzq7gs@tardis>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pdbmadqmexido3oa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 06:15:24PM +0800, Boqun Feng wrote:
> On Mon, Feb 26, 2018 at 10:00:50AM +0100, Peter Zijlstra wrote:
> > On Sat, Feb 24, 2018 at 05:26:52PM +0800, Boqun Feng wrote:
> > > > This is for case like:
> > > >=20
> > > > 	TASK1:
> > > > 		read_lock(A);
> > > > 		read_lock(B);
> > > > =09
> > > > 	TASK2:
> > > > 		write_lock(B);
> > > > 		read_lock(C);
> > > > =09
> > > > 	TASK3:
> > > > 		read_lock(B);
> > > > 		write_lock(C);
> > > >=20
> > > > 	TASK4:
> > > > 		read_lock(C);
> > > > 		write_lock(A);
> > > >=20
> > > > , which is not a deadlock.
> > > >=20
> > >=20
> > > After TASK 1,2,3 have executed, we have A -(RR)-> B, B -(RN/NR)-> C, =
and
> > > when TASK4 executed, we will try to add C -(RN)-> A into the graph.
> > > Before that we need to check whether we have a A -> ... -(*N)-> C path
> > > in the graph already, so we search from A (@prev is C and @this is A):
> > >=20
> > > *	we set A->have_xr to false, because the dependency we are adding
> > > 	is a RN.
> > >=20
> > > *	we find A -(RR)-> B, and since have_xr (=3D A->have_xr) is false,
> > > 	we can pick this dependency, and since for A -> B, we only have
> > > 	RR, so we set B->have_xr to true.
> > >=20
> > > *	we then find B -(RN/NR)-> C, and since have_xr (=3D B->have_xr) is
> > > 	true, we will pick it only only_rx(C->dep) return false,
> > > 	otherwise we skip. Because we have RN and NR for B -> C,
> > > 	therefore we won't skip B -> C.
> > >=20
> > > *	Now we try to set C->have_xr, if we set it to only_xr(C->dep),
> > > 	we will set it to false, right? Because B -> C has RN.
> > >=20
> > > *	Since we now find a entry equal to @prev, we go into the
> > > 	hlock_conflict() logic and for expression
> > > 	=09
> > > 		hlock->read !=3D 2 || !entry->have_xr=20
> > > =09
> > > 	@hlock is the C in TASK4, so hlock->read =3D=3D 2, and @entry is the
> > > 	C whose ->have_xr we just set, so entry->have_xr is false.
> > > 	Therefore hlock_conflict() returns true. And that indicates we
> > > 	find a deadlock in the search. But the above senario can not
> > > 	introduce a deadlock.
> > >=20
> > > Could this help you, or I miss something?
> >=20
> > Yes, although it took me forever to grasp because I have snot for brains
> > atm :-(
> >=20
>=20
> Take care!
>=20
> > Would something like:
> >=20
> >=20
> > 	dep =3D entry->dep;
> >=20
> > 	/* Mask out all *R -> R* relations. */
> > 	if (have_xr)
> > 		dep &=3D ~(RR_MASK | RN_MASK);
> >=20
> > 	/* If nothing left, we're done. */
> > 	if (!dep)
> > 		continue;
> >=20
> > 	/* If there are (only) *R left, set that for the next step. */
> > 	entry->have_xr =3D !(dep & (RN_MASK | NN_MASK));
> >=20
> >=20
> > Work? I think that reads fairly simple.
>=20
> I think that works, will apply this simplification to see whether the
> self tests agree.
>=20

And the self tests agree this works ;-) Thank you!

Regards,
Boqun

> Btw, given the comments in the code, I think it's better to name
> "have_xr" as "only_xr"? I have a feeling that my comment-less code
> somehow misled you to that name ;-(
>=20
> Regards,
> Boqun
>=20



--pdbmadqmexido3oa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqT310ACgkQSXnow7UH
+riesgf/XuROhOCzU01HK8REoVFuiOnBNYDY2FzfZtKj1NC5skZ1Uw0WJt81kyVt
+5TYUH4h9eBfHq9zbOAg3KHEBvS0xWwdtjfWUTVoETGXQvqoaUTJdeWGY57oJgco
EfABVzafTecuwAPpzFEpMIPvP0o66igt5zHT0K8gi3rGzcBx0NMaz5B+zmJHldUB
C6iRrE9if7wksFFSlul7sA+9MVykYS9jx+yi8dJtS46nhR7Sj6iEwuuc1NPGokBQ
HY/Ej58uO0/ocgp+esjHracDOXlGV9mjohidhNDtGbhZlc8J9cgLQCmfxraOJHfY
5t7PMtEFl7b8wj6jks7sYGYr6UXQ0g==
=B6LP
-----END PGP SIGNATURE-----

--pdbmadqmexido3oa--
