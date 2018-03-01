Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965568AbeCAIfw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:35:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34770 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964841AbeCAIfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:35:39 -0500
X-Google-Smtp-Source: AG47ELs0UUF+286MSmLhylziox541QcKWUoNCUTu6gmpCqobBfyXbikW0wQerZP/80DNWZDUwkiJLQ==
X-ME-Sender: <xms:VbuXWtLWgkUsXAbC-H_GSZIoUJD23pw57P_jYzAkgmq96eGxvzWbzw>
Date: Thu, 1 Mar 2018 16:39:06 +0800
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
Message-ID: <20180301083906.57lyn6kjyhgy75ee@tardis>
References: <Pine.LNX.4.44L0.1802281511320.1421-100000@iolanthe.rowland.org>
 <20180301015531.olvuu5g35eta5xhr@tardis>
 <20180301044937.GY3777@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5xrrchx6zgz36fmk"
Content-Disposition: inline
In-Reply-To: <20180301044937.GY3777@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5xrrchx6zgz36fmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 08:49:37PM -0800, Paul E. McKenney wrote:
> On Thu, Mar 01, 2018 at 09:55:31AM +0800, Boqun Feng wrote:
> > On Wed, Feb 28, 2018 at 03:13:54PM -0500, Alan Stern wrote:
> > > This patch reorganizes the definition of rb in the Linux Kernel Memory
> > > Consistency Model.  The relation is now expressed in terms of
> > > rcu-fence, which consists of a sequence of gp and rscs links separated
> > > by rcu-link links, in which the number of occurrences of gp is >=3D t=
he
> > > number of occurrences of rscs.
> > >=20
> > > Arguments similar to those published in
> > > http://diy.inria.fr/linux/long.pdf show that rcu-fence behaves like an
> > > inter-CPU strong fence.  Furthermore, the definition of rb in terms of
> > > rcu-fence is highly analogous to the definition of pb in terms of
> > > strong-fence, which can help explain why rcu-path expresses a form of
> > > temporal ordering.
> > >=20
> > > This change should not affect the semantics of the memory model, just
> > > its internal organization.
> > >=20
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > >=20
> > > ---
> > >=20
> > > v2: Rebase on top of the preceding patch which renames "link" to
> > > "rcu-link" and "rcu-path" to "rb".  Add back the missing "rec" keyword
> > > in the definition of rcu-fence.  Minor editing improvements in
> > > explanation.txt.
> > >=20
> > > Index: usb-4.x/tools/memory-model/linux-kernel.cat
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- usb-4.x.orig/tools/memory-model/linux-kernel.cat
> > > +++ usb-4.x/tools/memory-model/linux-kernel.cat
> > > @@ -102,20 +102,27 @@ let rscs =3D po ; crit^-1 ; po?
> > >   *)
> > >  let rcu-link =3D hb* ; pb* ; prop
> > > =20
> > > -(* Chains that affect the RCU grace-period guarantee *)
> > > -let gp-link =3D gp ; rcu-link
> > > -let rscs-link =3D rscs ; rcu-link
> > > -
> > >  (*
> > > - * A cycle containing at least as many grace periods as RCU read-side
> > > - * critical sections is forbidden.
> > > + * Any sequence containing at least as many grace periods as RCU rea=
d-side
> > > + * critical sections (joined by rcu-link) acts as a generalized stro=
ng fence.
> > >   *)
> > > -let rec rb =3D
> > > -	gp-link |
> > > -	(gp-link ; rscs-link) |
> > > -	(rscs-link ; gp-link) |
> > > -	(rb ; rb) |
> > > -	(gp-link ; rb ; rscs-link) |
> > > -	(rscs-link ; rb ; gp-link)
> > > +let rec rcu-fence =3D gp |
> > > +	(gp ; rcu-link ; rscs) |
> > > +	(rscs ; rcu-link ; gp) |
> > > +	(gp ; rcu-link ; rcu-fence ; rcu-link ; rscs) |
> > > +	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp) |
> > > +	(rcu-fence ; rcu-link ; rcu-fence)
> > > +
> > > +(* rb orders instructions just as pb does *)
> > > +let rb =3D prop ; rcu-fence ; hb* ; pb*
> > > =20
> > >  irreflexive rb as rcu
> >=20
> > I wonder whether we can simplify things as:
> >=20
> > 	let rec rcu-fence =3D
> > 	    (gp; rcu-link; rscs) |
> > 	    (rscs; rcu-link; gp) |
> > 	    (gp; rcu-link; rcu-fence; rcu-link; rscs) |
> > 	    (rscs; rcu-link; rcu-fence; rcu-link; gp)
> > =09
> > 	(* gp and rcu-fence; rcu-link; rcu-fence removed *)
> > =09
> > 	let rb =3D prop; rcu-fence; hb*; pb*
> >=20
> > 	acycle rb as rcu

Note this one should be "acyclic rb as rcu"...

> >=20
> > In this way, "rcu-fence" is defined as "any sequence containing as many
> > grace periods as RCU read-side critical sections (joined by rcu-link)."
> > Note that "rcu-link" contains "gp", so we don't miss the case where
> > there are more grace periods. And since we use "acycle" now, so we don't
> > need "rcu-fence; rcu-link; rcu-fence" to build "rcu-fence" recursively.
> >=20
> > I prefer this because we already treat "gp" as "strong-fence", which
> > already is a "rcu-link". Also, recurisively extending rcu-fence with
> > itself is exactly calculating the transitive closure, which we can avoid
> > by using a "acycle" rule. Besides, it looks more consistent with hb and
> > pb.
>=20
> I don't have any opinions from an aesthetics viewpoint, but this change
> does correctly handle the automatically generated tests.  I do not see
> any performance impact, if anything, about a 10% improvement based on
> this 11-process RCU litmus test:
>=20
> auto/C-RW-G+RW-G+RW-R+RW-R+RW-R+RW-R+RW-G+RW-G+RW-G+RW-G+RW-G.litmus
>=20
> With the change, about 10.4 seconds, without, about 11.4 seconds.
>=20

I got 12.0 seconds(my version) vs 13.59 seconds (Alan's version). So
clearly you have a faster computer than I ;-)

> I am not patient enough to try one of the really large ones, like this on=
e:
>=20
> auto/C-RW-G+RW-G+RW-R+RW-R+RW-R+RW-R+RW-G+RW-G+RW-G+RW-G+RW-R+RW-R+RW-R+R=
W-R+RW-G+RW-G+RW-G+RW-R+RW-G.litmus
>=20

I'm trying to run this on my laptop, but seems it will take forever to
run(now it has been running for 1 hour and a half with Alan's version).
I will update the result if it got finished some time later.

Regards,
Boqun

> However, it is in my "litmus" github archive, so please feel free to
> try it out.  Though I would suggest working up from those of intermediate
> length.
>=20
> 							Thanx, Paul
>=20
> > Thoughts?
> >=20
> > Regards,
> > Boqun
> >=20
> >=20
> > > +
> > > +(*
> > > + * The happens-before, propagation, and rcu constraints are all
> > > + * expressions of temporal ordering.  They could be replaced by
> > > + * a single constraint on an "executes-before" relation, xb:
> > > + *
> > > + * let xb =3D hb | pb | rb
> > > + * acyclic xb as executes-before
> > > + *)
> > > Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
> > > +++ usb-4.x/tools/memory-model/Documentation/explanation.txt
> > > @@ -27,7 +27,7 @@ Explanation of the Linux-Kernel Memory C
> > >    19. AND THEN THERE WAS ALPHA
> > >    20. THE HAPPENS-BEFORE RELATION: hb
> > >    21. THE PROPAGATES-BEFORE RELATION: pb
> > > -  22. RCU RELATIONS: rcu-link, gp-link, rscs-link, and rb
> > > +  22. RCU RELATIONS: rcu-link, gp, rscs, rcu-fence, and rb
> > >    23. ODDS AND ENDS
> > > =20
> > > =20
> > > @@ -1451,8 +1451,8 @@ they execute means that it cannot have c
> > >  the content of the LKMM's "propagation" axiom.
> > > =20
> > > =20
> > > -RCU RELATIONS: rcu-link, gp-link, rscs-link, and rb
> > > ----------------------------------------------------
> > > +RCU RELATIONS: rcu-link, gp, rscs, rcu-fence, and rb
> > > +----------------------------------------------------
> > > =20
> > >  RCU (Read-Copy-Update) is a powerful synchronization mechanism.  It
> > >  rests on two concepts: grace periods and read-side critical sections.
> > > @@ -1537,49 +1537,100 @@ relation, and the details don't matter u
> > >  a somewhat lengthy formal proof.  Pretty much all you need to know
> > >  about rcu-link is the information in the preceding paragraph.
> > > =20
> > > -The LKMM goes on to define the gp-link and rscs-link relations.  They
> > > -bring grace periods and read-side critical sections into the picture,
> > > -in the following way:
> > > -
> > > -	E ->gp-link F means there is a synchronize_rcu() fence event S
> > > -	and an event X such that E ->po S, either S ->po X or S =3D X,
> > > -	and X ->rcu-link F.  In other words, E and F are linked by a
> > > -	grace period followed by an instance of rcu-link.
> > > -
> > > -	E ->rscs-link F means there is a critical section delimited by
> > > -	an rcu_read_lock() fence L and an rcu_read_unlock() fence U,
> > > -	and an event X such that E ->po U, either L ->po X or L =3D X,
> > > -	and X ->rcu-link F.  Roughly speaking, this says that some
> > > -	event in the same critical section as E is linked by rcu-link
> > > -	to F.
> > > +The LKMM also defines the gp and rscs relations.  They bring grace
> > > +periods and read-side critical sections into the picture, in the
> > > +following way:
> > > +
> > > +	E ->gp F means there is a synchronize_rcu() fence event S such
> > > +	that E ->po S and either S ->po F or S =3D F.  In simple terms,
> > > +	there is a grace period po-between E and F.
> > > +
> > > +	E ->rscs F means there is a critical section delimited by an
> > > +	rcu_read_lock() fence L and an rcu_read_unlock() fence U, such
> > > +	that E ->po U and either L ->po F or L =3D F.  You can think of
> > > +	this as saying that E and F are in the same critical section
> > > +	(in fact, it also allows E to be po-before the start of the
> > > +	critical section and F to be po-after the end).
> > > =20
> > >  If we think of the rcu-link relation as standing for an extended
> > > -"before", then E ->gp-link F says that E executes before a grace
> > > -period which ends before F executes.  (In fact it covers more than
> > > -this, because it also includes cases where E executes before a grace
> > > -period and some store propagates to F's CPU before F executes and
> > > -doesn't propagate to some other CPU until after the grace period
> > > -ends.)  Similarly, E ->rscs-link F says that E is part of (or before
> > > -the start of) a critical section which starts before F executes.
> > > +"before", then X ->gp Y ->rcu-link Z says that X executes before a
> > > +grace period which ends before Z executes.  (In fact it covers more
> > > +than this, because it also includes cases where X executes before a
> > > +grace period and some store propagates to Z's CPU before Z executes
> > > +but doesn't propagate to some other CPU until after the grace period
> > > +ends.)  Similarly, X ->rscs Y ->rcu-link Z says that X is part of (or
> > > +before the start of) a critical section which starts before Z
> > > +executes.
> > > +
> > > +The LKMM goes on to define the rcu-fence relation as a sequence of gp
> > > +and rscs links separated by rcu-link links, in which the number of gp
> > > +links is >=3D the number of rscs links.  For example:
> > > +
> > > +	X ->gp Y ->rcu-link Z ->rscs T ->rcu-link U ->gp V
> > > +
> > > +would imply that X ->rcu-fence V, because this sequence contains two
> > > +gp links and only one rscs link.  (It also implies that X ->rcu-fenc=
e T
> > > +and Z ->rcu-fence V.)  On the other hand:
> > > +
> > > +	X ->rscs Y ->rcu-link Z ->rscs T ->rcu-link U ->gp V
> > > +
> > > +does not imply X ->rcu-fence V, because the sequence contains only
> > > +one gp link but two rscs links.
> > > +
> > > +The rcu-fence relation is important because the Grace Period Guarant=
ee
> > > +means that rcu-fence acts kind of like a strong fence.  In particula=
r,
> > > +if W is a write and we have W ->rcu-fence Z, the Guarantee says that=
 W
> > > +will propagate to every CPU before Z executes.
> > > +
> > > +To prove this in full generality requires some intellectual effort.
> > > +We'll consider just a very simple case:
> > > +
> > > +	W ->gp X ->rcu-link Y ->rscs Z.
> > > +
> > > +This formula means that there is a grace period G and a critical
> > > +section C such that:
> > > +
> > > +	1. W is po-before G;
> > > +
> > > +	2. X is equal to or po-after G;
> > > +
> > > +	3. X comes "before" Y in some sense;
> > > +
> > > +	4. Y is po-before the end of C;
> > > +
> > > +	5. Z is equal to or po-after the start of C.
> > > +
> > > +From 2 - 4 we deduce that the grace period G ends before the critical
> > > +section C.  Then the second part of the Grace Period Guarantee says
> > > +not only that G starts before C does, but also that W (which executes
> > > +on G's CPU before G starts) must propagate to every CPU before C
> > > +starts.  In particular, W propagates to every CPU before Z executes
> > > +(or finishes executing, in the case where Z is equal to the
> > > +rcu_read_lock() fence event which starts C.)  This sort of reasoning
> > > +can be expanded to handle all the situations covered by rcu-fence.
> > > +
> > > +Finally, the LKMM defines the RCU-before (rb) relation in terms of
> > > +rcu-fence.  This is done in essentially the same way as the pb
> > > +relation was defined in terms of strong-fence.  We will omit the
> > > +details; the end result is that E ->rb F implies E must execute befo=
re
> > > +F, just as E ->pb F does (and for much the same reasons).
> > > =20
> > >  Putting this all together, the LKMM expresses the Grace Period
> > > -Guarantee by requiring that there are no cycles consisting of gp-link
> > > -and rscs-link links in which the number of gp-link instances is >=3D=
 the
> > > -number of rscs-link instances.  It does this by defining the rb
> > > -relation to link events E and F whenever it is possible to pass from=
 E
> > > -to F by a sequence of gp-link and rscs-link links with at least as
> > > -many of the former as the latter.  The LKMM's "rcu" axiom then says
> > > -that there are no events E with E ->rb E.
> > > -
> > > -Justifying this axiom takes some intellectual effort, but it is in
> > > -fact a valid formalization of the Grace Period Guarantee.  We won't
> > > -attempt to go through the detailed argument, but the following
> > > -analysis gives a taste of what is involved.  Suppose we have a
> > > -violation of the first part of the Guarantee: A critical section
> > > -starts before a grace period, and some store propagates to the
> > > -critical section's CPU before the end of the critical section but
> > > -doesn't propagate to some other CPU until after the end of the grace
> > > -period.
> > > +Guarantee by requiring that the rb relation does not contain a cycle.
> > > +Equivalently, this "rcu" axiom requires that there are no events E a=
nd
> > > +F with E ->rcu-link F ->rcu-fence E.  Or to put it a third way, the
> > > +axiom requires that there are no cycles consisting of gp and rscs
> > > +alternating with rcu-link, where the number of gp links is >=3D the
> > > +number of rscs links.
> > > +
> > > +Justifying the axiom isn't easy, but it is in fact a valid
> > > +formalization of the Grace Period Guarantee.  We won't attempt to go
> > > +through the detailed argument, but the following analysis gives a
> > > +taste of what is involved.  Suppose we have a violation of the first
> > > +part of the Guarantee: A critical section starts before a grace
> > > +period, and some store propagates to the critical section's CPU befo=
re
> > > +the end of the critical section but doesn't propagate to some other
> > > +CPU until after the end of the grace period.
> > > =20
> > >  Putting symbols to these ideas, let L and U be the rcu_read_lock() a=
nd
> > >  rcu_read_unlock() fence events delimiting the critical section in
> > > @@ -1606,11 +1657,14 @@ by rcu-link, yielding:
> > > =20
> > >  	S ->po X ->rcu-link Z ->po U.
> > > =20
> > > -The formulas say that S is po-between F and X, hence F ->gp-link Z
> > > -via X.  They also say that Z comes before the end of the critical
> > > -section and E comes after its start, hence Z ->rscs-link F via E.  B=
ut
> > > -now we have a forbidden cycle: F ->gp-link Z ->rscs-link F.  Thus the
> > > -"rcu" axiom rules out this violation of the Grace Period Guarantee.
> > > +The formulas say that S is po-between F and X, hence F ->gp X.  They
> > > +also say that Z comes before the end of the critical section and E
> > > +comes after its start, hence Z ->rscs E.  From all this we obtain:
> > > +
> > > +	F ->gp X ->rcu-link Z ->rscs E ->rcu-link F,
> > > +
> > > +a forbidden cycle.  Thus the "rcu" axiom rules out this violation of
> > > +the Grace Period Guarantee.
> > > =20
> > >  For something a little more down-to-earth, let's see how the axiom
> > >  works out in practice.  Consider the RCU code example from above, th=
is
> > > @@ -1639,15 +1693,15 @@ time with statement labels added to the
> > >  If r2 =3D 0 at the end then P0's store at X overwrites the value that
> > >  P1's load at Z reads from, so we have Z ->fre X and thus Z ->rcu-lin=
k X.
> > >  In addition, there is a synchronize_rcu() between Y and Z, so theref=
ore
> > > -we have Y ->gp-link X.
> > > +we have Y ->gp Z.
> > > =20
> > >  If r1 =3D 1 at the end then P1's load at Y reads from P0's store at =
W,
> > >  so we have W ->rcu-link Y.  In addition, W and X are in the same cri=
tical
> > > -section, so therefore we have X ->rscs-link Y.
> > > +section, so therefore we have X ->rscs W.
> > > =20
> > > -This gives us a cycle, Y ->gp-link X ->rscs-link Y, with one gp-link
> > > -and one rscs-link, violating the "rcu" axiom.  Hence the outcome is
> > > -not allowed by the LKMM, as we would expect.
> > > +Then X ->rscs W ->rcu-link Y ->gp Z ->rcu-link X is a forbidden cycl=
e,
> > > +violating the "rcu" axiom.  Hence the outcome is not allowed by the
> > > +LKMM, as we would expect.
> > > =20
> > >  For contrast, let's see what can happen in a more complicated exampl=
e:
> > > =20
> > > @@ -1683,15 +1737,11 @@ For contrast, let's see what can happen
> > >  	}
> > > =20
> > >  If r0 =3D r1 =3D r2 =3D 1 at the end, then similar reasoning to befo=
re shows
> > > -that W ->rscs-link Y via X, Y ->gp-link U via Z, and U ->rscs-link W
> > > -via V.  And just as before, this gives a cycle:
> > > -
> > > -	W ->rscs-link Y ->gp-link U ->rscs-link W.
> > > -
> > > -However, this cycle has fewer gp-link instances than rscs-link
> > > -instances, and consequently the outcome is not forbidden by the LKMM.
> > > -The following instruction timing diagram shows how it might actually
> > > -occur:
> > > +that W ->rscs X ->rcu-link Y ->gp Z ->rcu-link U ->rscs V ->rcu-link=
 W.
> > > +However this cycle is not forbidden, because the sequence of relatio=
ns
> > > +contains fewer instances of gp (one) than of rscs (two).  Consequent=
ly
> > > +the outcome is allowed by the LKMM.  The following instruction timing
> > > +diagram shows how it might actually occur:
> > > =20
> > >  P0			P1			P2
> > >  --------------------	--------------------	--------------------
> > >=20
> > >=20
>=20
>=20

--5xrrchx6zgz36fmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqXvCYACgkQSXnow7UH
+riWeQf/TX7PJ01B2MsPh0Z0dRE43SQo+BCwFj0ZCI8r0UIDC5ozYwjMJlqQjzOy
onc2SW2kXuulu02bI4gXEswxGPQF877Psd3i0f9c5lAQRRhFtH+3Lyydk19OxlAK
ordvOpUS4DeS4RWtC3fXjA2s2ycClA3udAdbi75hfeRZoX/J7wbjDH3v0D53BSy8
eBYwAeqOtrbDSoiy7TLwmHF7EPVW2T/uJxI4o+gEHHFEYVPFg6UPoumyQgtUQ0j9
jwU2EtnShkddtsZs2WK8Djq4hdE8SyLiUPrxKKd1m4jdqJHPYL1XnjwBBb9Amhit
YruusDYUj+I8g117DdHnIPtnV1R69g==
=B+gX
-----END PGP SIGNATURE-----

--5xrrchx6zgz36fmk--
