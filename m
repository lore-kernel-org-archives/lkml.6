Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeB0C2z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:28:55 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36120 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbeB0C2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:28:53 -0500
X-Google-Smtp-Source: AH8x226AvZl67Yjdpopix6IXiJAVSvxER/90MZRiEuuP5A7I/wspusnVvr6Yx8tjUPVMbAUT5JCJLw==
X-ME-Sender: <xms:YMKUWpLT8Vdz5FN9dPBUthfEfG7JDMisPvWIBDGVM1pExEe_QpQkoA>
Date: Tue, 27 Feb 2018 10:32:20 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC tip/locking/lockdep v5 16/17] lockdep: Documention for
 recursive read lock detection reasoning
Message-ID: <20180227023220.ou7764tt56mey3or@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-17-boqun.feng@gmail.com>
 <20180224225320.GA3027@andrea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mxk7lghi3marwmye"
Content-Disposition: inline
In-Reply-To: <20180224225320.GA3027@andrea>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxk7lghi3marwmye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 11:53:20PM +0100, Andrea Parri wrote:
> On Thu, Feb 22, 2018 at 03:09:03PM +0800, Boqun Feng wrote:
> > As now we support recursive read lock deadlock detection, add related
> > explanation in the Documentation/lockdep/lockdep-desgin.txt:
> >=20
> > *	Definition of recursive read locks, non-recursive locks, strong
> > 	dependency path and notions of -(**)->.
> >=20
> > *	Lockdep's assumption.
> >=20
> > *	Informal proof of recursive read lock deadlock detection.
>=20
> Once again... much appreciated!!, thanks for sharing.
>=20

np ;-)

>=20
> >=20
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > ---
> >  Documentation/locking/lockdep-design.txt | 170 +++++++++++++++++++++++=
++++++++
> >  1 file changed, 170 insertions(+)
> >=20
> > diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/l=
ocking/lockdep-design.txt
> > index 382bc25589c2..fd8a8d97ce58 100644
> > --- a/Documentation/locking/lockdep-design.txt
> > +++ b/Documentation/locking/lockdep-design.txt
> > @@ -284,3 +284,173 @@ Run the command and save the output, then compare=
 against the output from
> >  a later run of this command to identify the leakers.  This same output
> >  can also help you find situations where runtime lock initialization has
> >  been omitted.
> > +
> > +Recursive Read Deadlock Detection:
> > +----------------------------------
> > +Lockdep now is equipped with deadlock detection for recursive read loc=
ks.
> > +
> > +Recursive read locks, as their name indicates, are the locks able to be
> > +acquired recursively. Unlike non-recursive read locks, recursive read =
locks
> > +only get blocked by current write lock *holders* other than write lock
> > +*waiters*, for example:
> > +
> > +	TASK A:			TASK B:
> > +
> > +	read_lock(X);
> > +
> > +				write_lock(X);
> > +
> > +	read_lock(X);
> > +
> > +is not a deadlock for recursive read locks, as while the task B is wai=
ting for
> > +the lock X, the second read_lock() doesn't need to wait because it's a=
 recursive
> > +read lock.
> > +
> > +Note that a lock can be a write lock(exclusive lock), a non-recursive =
read lock
> > +(non-recursive shared lock) or a recursive read lock(recursive shared =
lock),
> > +depending on the API used to acquire it(more specifically, the value o=
f the
> > +'read' parameter for lock_acquire(...)). In other words, a single lock=
 instance
> > +has three types of acquisition depending on the acquisition functions:
> > +exclusive, non-recursive read, and recursive read.
> > +
> > +That said, recursive read locks could introduce deadlocks too, conside=
ring the
> > +following:
> > +
> > +	TASK A:			TASK B:
> > +
> > +	read_lock(X);
> > +				read_lock(Y);
> > +	write_lock(Y);
> > +				write_lock(X);
> > +
> > +, neither task could get the write locks because the corresponding rea=
d locks
> > +are held by each other.
> > +
> > +Lockdep could detect recursive read lock related deadlocks. The depend=
encies(edges)
> > +in the lockdep graph are classified into four categories:
> > +
> > +1) -(NN)->: non-recursive to non-recursive dependency, non-recursive l=
ocks include
> > +            non-recursive read locks, write locks and exclusive locks(=
e.g. spinlock_t).
> > +	    They are treated equally in deadlock detection. "X -(NN)-> Y" mea=
ns
> > +            X -> Y and both X and Y are non-recursive locks.
> > +
> > +2) -(RN)->: recursive to non-recursive dependency, recursive locks mea=
ns recursive read
> > +	    locks. "X -(RN)-> Y" means X -> Y and X is recursive read lock and
> > +            Y is non-recursive lock.
> > +
> > +3) -(NR)->: non-recursive to recursive dependency, "X -(NR)-> Y" means=
 X -> Y and X is
> > +            non-recursive lock and Y is recursive lock.
> > +
> > +4) -(RR)->: recursive to recursive dependency, "X -(RR)-> Y" means X -=
> Y and both X
> > +            and Y are recursive locks.
> > +
> > +Note that given two locks, they may have multiple dependencies between=
 them, for example:
> > +
> > +	TASK A:
> > +
> > +	read_lock(X);
> > +	write_lock(Y);
> > +	...
> > +
> > +	TASK B:
> > +
> > +	write_lock(X);
> > +	write_lock(Y);
> > +
> > +, we have both X -(RN)-> Y and X -(NN)-> Y in the dependency graph.
> > +
> > +And obviously a non-recursive lock can block the corresponding recursi=
ve lock,
> > +and vice versa. Besides a non-recursive lock may block the other non-r=
ecursive
> > +lock of the same instance(e.g. a write lock may block a corresponding
> > +non-recursive read lock and vice versa).
> > +
> > +We use -(*N)-> for edges that is either -(RN)-> or -(NN)->, the simila=
r for -(N*)->,
> > +-(*R)-> and -(R*)->
> > +
> > +A "path" is a series of conjunct dependency edges in the graph. And we=
 define a
> > +"strong" path, which indicates the strong dependency throughout each d=
ependency
> > +in the path, as the path that doesn't have two conjunct edges(dependen=
cies) as
> > +-(*R)-> and -(R*)->. IOW, a "strong" path is a path from a lock walkin=
g to another
> > +through the lock dependencies, and if X -> Y -> Z in the path(where X,=
 Y, Z are
> > +locks), if the walk from X to Y is through a -(NR)-> or -(RR)-> depend=
ency, the
> > +walk from Y to Z must not be through a -(RN)-> or -(RR)-> dependency, =
otherwise
> > +it's not a strong path.
> > +
> > +We now prove that if a strong path forms a circle, then we have a pote=
ntial deadlock.
> > +By "forms a circle", it means for a set of locks A0,A1...An, there is =
a path from
> > +A0 to An:
> > +
> > +	A0 -> A1 -> ... -> An
> > +
> > +and there is also a dependency An->A0. And as the circle is formed by =
a strong path,
> > +so there are no two conjunct dependency edges as -(*R)-> and -(R*)->.
> > +
> > +
> > +To understand the actual proof, let's look into lockdep's assumption:
> > +
> > +For each lockdep dependency A -> B, there may exist a case where someo=
ne is
> > +trying to acquire B with A held, and the existence of such a case is
> > +independent to the existences of cases for other lockdep dependencies.
> > +
> > +For example if we have two functions func1 and func2:
> > +
> > +	void func1(...) {
> > +		lock(A);
> > +		lock(B);
> > +		unlock(A);
> > +		unlock(B);
> > +
> > +		lock(C);
> > +		lock(A);
> > +		unlock(A);
> > +		unlock(C);
> > +	}
> > +
> > +	void func2(...) {
> > +		lock(B);
> > +		lock(C);
> > +		unlock(C);
> > +		unlock(B);
> > +	}
> > +
> > +lockdep will generate dependencies: A->B, B->C and C->A, and assume th=
at:
> > +
> > +	there may exist a case where someone is trying to acquire B with A he=
ld,
> > +	there may exist a case where someone is trying to acquire C with B he=
ld,
> > +	and there may exist a case where someone is trying to acquire A with =
C held,
> > +
> > +and those three cases exist *independently*, meaning they can happen a=
t the
> > +same time(which requires func1() being called simultaneously by two CP=
Us or
> > +tasks, which may be impossible due to other constraints in the real li=
fe)
> > +
> > +
> > +With this assumption, we can prove that if a strong dependency path fo=
rms a circle,
> > +then it indicates a deadlock as far as lockdep is concerned.
>=20
> As mentioned in a private communication, I would recommend the adoption of
> a "more impersonal" style.  Here, for instance, the expression:
>=20
>   "indicates a deadlock as far as lockdep is concerned"
>=20
> would be replaced with:
>=20
>   "indicates a deadlock as (informally) defined in Sect. ?.?";
>=20
> similarly (from the proof):
>=20
>   "For a strong dependency [...], lockdep assumes that [...]"
>=20
> would be replaced with:
>=20
>   "For a strong dependency [...], from assumption/notation ?.?,
>    we have/we can conclude [...]".
>=20
> This could mean that additional text/content would need to be added to the
> present doc./.txt; OTOH, this could help to make this doc. self-contained/
> more accessible to "non-lockdep-experts".
>=20

Yeah. I will do that in next spin. Thanks!

Regards,
Boqun

>   Andrea
>=20
>=20
> > +
> > +For a strong dependency circle like:
> > +
> > +	A0 -> A1 -> ... -> An
> > +	^                  |
> > +	|                  |
> > +	+------------------+
> > +, lockdep assumes that
> > +
> > +	there may exist a case where someone is trying to acquire A1 with A0 =
held
> > +	there may exist a case where someone is trying to acquire A2 with A1 =
held
> > +	...
> > +	there may exist a case where someone is trying to acquire An with An-=
1 held
> > +	there may exist a case where someone is trying to acquire A0 with An =
held
> > +
> > +, and because it's a *strong* dependency circle for every Ai (0<=3Di<=
=3Dn), Ai is either
> > +held as a non-recursive lock or someone is trying to acquire Ai as a n=
on-recursive lock,
> > +which gives:
> > +
> > +*	If Ai is held as a non-recursive lock, then trying to acquire it,
> > +	whether as a recursive lock or not, will get blocked.
> > +
> > +*	If Ai is held as a recursive lock, then there must be someone is try=
ing to acquire
> > +	it as a non-recursive lock, and because recursive locks blocks non-re=
cursive locks,
> > +	then it(the "someone") will get blocked.
> > +
> > +So all the holders of A0, A1...An are blocked with A0, A1...An held by=
 each other,
> > +no one can progress, therefore deadlock.
> > --=20
> > 2.16.1
> >=20

--mxk7lghi3marwmye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqUwzEACgkQSXnow7UH
+rjCkAgAjWnWZZOprqcO+NhASNWhV/RfjLek2cMyl5NM+nNn3K1rxh28KL12wbKh
Bv0IKn5Z4vH6gpx8/QO3td7HIViaHeyW4LaD0DsOQjNpjyGQDcVyDDwSEqN+0u5z
VJRYnSVZGT7sQ0ehLVdVE3fW9rr5oHSLs9AZzU/CEYgv70/Yf9o8mGBKwrswDVke
pwWpHveVJ2ZD+0xS3zBcqa/jgf3AIX7Cfg/NzGn92fou60yt/A8fwB8mAMbarxZj
qXz1ogZM7hxA4NZy2FEMgFWveMFlb7pMTDmNY7lljJ66q6pjMBwB6dPC45Aonnkv
xJrkmKWHgDR7kOrK+kvexikWO8gyMQ==
=HzBF
-----END PGP SIGNATURE-----

--mxk7lghi3marwmye--
