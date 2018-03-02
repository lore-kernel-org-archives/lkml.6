Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164982AbeCBE2P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:28:15 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52266 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164199AbeCBE2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:28:12 -0500
X-Google-Smtp-Source: AG47ELuGSkFpy0E/P9080gADIA5tK8miP3PpcVp/6eMH7UvfpFMFFa+1c9nqwTvZxUznYvs4j2xGlw==
X-ME-Sender: <xms:19KYWo6sZasmPp9p7-QtoQtb_ebxgx9S-H5oNGHL5rpgovtiN9fYvw>
Date: Fri, 2 Mar 2018 12:31:41 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 v2 RFC] tools/memory-model: redefine rb in terms of
 rcu-fence
Message-ID: <20180302043141.fgmjyysrws55pi7q@tardis>
References: <20180301015531.olvuu5g35eta5xhr@tardis>
 <Pine.LNX.4.44L0.1803011027120.1394-100000@iolanthe.rowland.org>
 <20180301174906.GC3777@linux.vnet.ibm.com>
 <20180301183758.GA31761@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hya3soutqch7sd5d"
Content-Disposition: inline
In-Reply-To: <20180301183758.GA31761@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hya3soutqch7sd5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 10:37:58AM -0800, Paul E. McKenney wrote:
> On Thu, Mar 01, 2018 at 09:49:06AM -0800, Paul E. McKenney wrote:
> > On Thu, Mar 01, 2018 at 10:49:05AM -0500, Alan Stern wrote:
> > > On Thu, 1 Mar 2018, Boqun Feng wrote:
> > >=20
> > > > > +let rec rcu-fence =3D gp |
> > > > > +	(gp ; rcu-link ; rscs) |
> > > > > +	(rscs ; rcu-link ; gp) |
> > > > > +	(gp ; rcu-link ; rcu-fence ; rcu-link ; rscs) |
> > > > > +	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp) |
> > > > > +	(rcu-fence ; rcu-link ; rcu-fence)
> > > > > +
> > > > > +(* rb orders instructions just as pb does *)
> > > > > +let rb =3D prop ; rcu-fence ; hb* ; pb*
> > > > > =20
> > > > >  irreflexive rb as rcu
> > > >=20
> > > > I wonder whether we can simplify things as:
> > > >=20
> > > > 	let rec rcu-fence =3D
> > > > 	    (gp; rcu-link; rscs) |
> > > > 	    (rscs; rcu-link; gp) |
> > > > 	    (gp; rcu-link; rcu-fence; rcu-link; rscs) |
> > > > 	    (rscs; rcu-link; rcu-fence; rcu-link; gp)
> > > > =09
> > > > 	(* gp and rcu-fence; rcu-link; rcu-fence removed *)
> > > > =09
> > > > 	let rb =3D prop; rcu-fence; hb*; pb*
> > > >=20
> > > > 	acycle rb as rcu
> > > >=20
> > > > In this way, "rcu-fence" is defined as "any sequence containing as =
many
> > > > grace periods as RCU read-side critical sections (joined by rcu-lin=
k)."
> > > > Note that "rcu-link" contains "gp", so we don't miss the case where
> > > > there are more grace periods. And since we use "acycle" now, so we =
don't
> > > > need "rcu-fence; rcu-link; rcu-fence" to build "rcu-fence" recursiv=
ely.
> > >=20
> > > Would this definition of rcu-fence work for a sequence such as (leavi=
ng
> > > out the intermediate rcu-link parts):
> > >=20
> > > 	gp gp gp rscs rscs gp rscs rscs
> > >=20
> > > ?  I don't think it would.  Yes, if you had a cycle of that form then=
=20

Right.=20

> > > your "rcu" axiom would detect it, but at some point we might want to=
=20
> > > use rcu-fence for some other purpose, one that doesn't involve cycles.

OK, and I've not yet found another simple way to express rcu-fence for
purposes other than cycle-checking. So I'm OK to leave it as it is
except removing the redundant "gp" in rcu-fence definition.

But I will continue to search for a easier and sufficient way to define
these things ;-)=20

> >=20
> > Let's see, that would map to this:
> >=20
> > auto/RW-G+RW-G+RW-G+RW-R+RW-R+RW-G+RW-R+RW-R.litmus
> >=20
> > And no, there is no such automatically generated litmus test.  Let's
> > try reversing the "gp" and "rscs", which should have the same effect
> > courtesy of symmetry:
> >=20
> > auto/RW-R+RW-R+RW-R+RW-G+RW-G+RW-R+RW-G+RW-G.litmus
> >=20
> > And that one doesn't exist, either.  So much for random test generation=
!  :-/
> >=20
> > Clearly time to add them.  And here is what herd has to say about them:
> >=20
> > l$ sh scripts/checklitmus.sh /tmp/auto/C-RW-G+RW-G+RW-G+RW-R+RW-R+RW-G+=
RW-R+RW-R.litmus
> > Herd options: -conf linux-kernel.cfg
> > Observation /tmp/auto/C-RW-G+RW-G+RW-G+RW-R+RW-R+RW-G+RW-R+RW-R Sometim=
es 1 255
> >  ^^^ Unexpected non-Never verification
> >  0inputs+32outputs (0major+2605minor)pagefaults 0swaps
> > $ sh scripts/checklitmus.sh /tmp/auto/C-RW-R+RW-R+RW-R+RW-G+RW-G+RW-R+R=
W-G+RW-G.litmus
> > Herd options: -conf linux-kernel.cfg
> > Observation /tmp/auto/C-RW-R+RW-R+RW-R+RW-G+RW-G+RW-R+RW-G+RW-G Sometim=
es 1 255
> >  ^^^ Unexpected non-Never verification
> >  0inputs+32outputs (0major+2620minor)pagefaults 0swaps
> >=20
> > In other words, they are in fact misclassified as "Sometimes" when they
> > should be "Never".  I have my diffs below in case I misapplied Boqun's
> > change.
> >=20
> > With Alan's original formulation, these two litmus tests are correctly
> > handled:
> >=20
> > $ sh scripts/checklitmus.sh /tmp/auto/C-RW-G+RW-G+RW-G+RW-R+RW-R+RW-G+R=
W-R+RW-R.litmus
> > Herd options: -conf linux-kernel.cfg
> > Observation /tmp/auto/C-RW-G+RW-G+RW-G+RW-R+RW-R+RW-G+RW-R+RW-R Never 0=
 255
> > 1.61user 0.00system 0:01.63elapsed 98%CPU (0avgtext+0avgdata 9572maxres=
ident)k
> > $ sh scripts/checklitmus.sh /tmp/auto/C-RW-R+RW-R+RW-R+RW-G+RW-G+RW-R+R=
W-G+RW-G.litmus
> > Herd options: -conf linux-kernel.cfg
> > Observation /tmp/auto/C-RW-R+RW-R+RW-R+RW-G+RW-G+RW-R+RW-G+RW-G Never 0=
 255
> > 1.84user 0.01system 0:01.92elapsed 96%CPU (0avgtext+0avgdata 10112maxre=
sident)k
>=20
> And as Andrea pointed out off-list, I did indeed mess up Boqun's change.
> I forgot to change the "irreflexive" into "acyclic".  Applying that change
> makes everything work.
>=20
> Please accept my apologies for my confusion!
>=20

np, also I should have provided a proper patch for your testing.

For this Alan's patch, feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> 							Thanx, Paul
>=20
> > > > I prefer this because we already treat "gp" as "strong-fence", which
> > > > already is a "rcu-link".
> > >=20
> > > That's a good point; it had not occurred to me.
> >=20
> > And if I remove the "gp" but leave the last line, it does properly
> > classify the two new litmus tests.
> >=20
> > 							Thanx, Paul
> >=20
> > > >  Also, recurisively extending rcu-fence with
> > > > itself is exactly calculating the transitive closure, which we can =
avoid
> > > > by using a "acycle" rule. Besides, it looks more consistent with hb=
 and
> > > > pb.
> > >=20
> > > That _had_ occurred to me.  But I couldn't see any way to do it while=
=20
> > > still defining rcu-fence correctly.
> >=20
> > ------------------------------------------------------------------------
> >=20
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/l=
inux-kernel.cat
> > index 1e5c4653dd12..75d3c225146c 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -106,12 +106,11 @@ let rcu-link =3D hb* ; pb* ; prop
> >   * Any sequence containing at least as many grace periods as RCU read-=
side
> >   * critical sections (joined by rcu-link) acts as a generalized strong=
 fence.
> >   *)
> > -let rec rcu-fence =3D gp |
> > +let rec rcu-fence =3D
> >  	(gp ; rcu-link ; rscs) |
> >  	(rscs ; rcu-link ; gp) |
> >  	(gp ; rcu-link ; rcu-fence ; rcu-link ; rscs) |
> > -	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp) |
> > -	(rcu-fence ; rcu-link ; rcu-fence)
> > +	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp)
> > =20
> >  (* rb orders instructions just as pb does *)
> >  let rb =3D prop ; rcu-fence ; hb* ; pb*
>=20

--hya3soutqch7sd5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqY06kACgkQSXnow7UH
+riSPQgAmzgfU7ZJyU9vIARnoZtMRfQGFR7qLpP6r6fERm6n4h82Y9oevGqWdNG/
LyHzRLnNZxnHCyEEPMmgXtRPDNGGAlqRe4orN1HowKhlNiHWEJmE8e3u0Hi2WMM/
/QynUr3seS21OGLr7dmGyJ8VAtjF+MwgiBKbAEzM+8TZ60E7CDGaZ6QwmAIVHDfJ
lbDUkyjH62tBNUL++DUNTgDkQDcoK9spW+4Smpow5AqDLfHroZhYOmo2cnNXwG0P
xyR3wk0go10eaknfU+o7VM95+nAsK0KovNoPWlF/VZACQwaem1p4r+Oh51YCp7A7
K9DlBiYVAw/FLlMvbJqAXEeaAQts5w==
=RfcT
-----END PGP SIGNATURE-----

--hya3soutqch7sd5d--
