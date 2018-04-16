Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbeDPGZv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:25:51 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33486 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753742AbeDPGZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:25:47 -0400
X-Google-Smtp-Source: AIpwx48QP3kk7dxpkPRVDjdXyMaSFQSuPKltFnX2p5peWZSGolqfTXTq+4QOW+xmovOljj5MZke/yw==
X-ME-Sender: <xms:5kHUWidGzNWYNIxz4_BuTMc8P3fmsBQDrV5iRFa_yZEzHY6eLHLGcg>
Date: Mon, 16 Apr 2018 14:29:56 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC tip/locking/lockdep v6 01/20] lockdep/Documention:
 Recursive read lock detection reasoning
Message-ID: <20180416062956.fwoz5snuwcbwaueh@tardis>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
 <20180411135110.9217-2-boqun.feng@gmail.com>
 <0ed9bece-4e63-de49-8be5-0ebab83c9769@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3f2idczmrxg2o2og"
Content-Disposition: inline
In-Reply-To: <0ed9bece-4e63-de49-8be5-0ebab83c9769@infradead.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3f2idczmrxg2o2og
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 14, 2018 at 05:38:54PM -0700, Randy Dunlap wrote:
> Hi,
>=20

Hello Randy,

> Just a few typos etc. below...
>=20

Thanks! I fixed those typos according to your comments.

> On 04/11/2018 06:50 AM, Boqun Feng wrote:
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  Documentation/locking/lockdep-design.txt | 178 +++++++++++++++++++++++=
++++++++
> >  1 file changed, 178 insertions(+)
> >=20
> > diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/l=
ocking/lockdep-design.txt
> > index 9de1c158d44c..6bb9e90e2c4f 100644
> > --- a/Documentation/locking/lockdep-design.txt
> > +++ b/Documentation/locking/lockdep-design.txt
> > @@ -284,3 +284,181 @@ Run the command and save the output, then compare=
 against the output from
> >  a later run of this command to identify the leakers.  This same output
> >  can also help you find situations where runtime lock initialization has
> >  been omitted.
> > +
> > +Recursive read locks:
> > +---------------------
> > +
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
> > +read lock. However if the read_lock() is non-recursive read lock, then=
 the above
> > +case is a deadlock, because even if the write_lock() in TASK B can not=
 get the
> > +lock, but it can block the second read_lock() in TASK A.
> > +
> > +Note that a lock can be a write lock (exclusive lock), a non-recursive=
 read
> > +lock (non-recursive shared lock) or a recursive read lock (recursive s=
hared
> > +lock), depending on the lock operations used to acquire it (more speci=
fically,
> > +the value of the 'read' parameter for lock_acquire()). In other words,=
 a single
> > +lock instance has three types of acquisition depending on the acquisit=
ion
> > +functions: exclusive, non-recursive read, and recursive read.
> > +
> > +To be concise, we call that write locks and non-recursive read locks as
> > +"non-recursive" locks and recursive read locks as "recursive" locks.
> > +
> > +Recursive locks don't block each other, while non-recursive locks do (=
this is
> > +even true for two non-recursive read locks). A non-recursive lock can =
block the
> > +corresponding recursive lock, and vice versa.
> > +
> > +A deadlock case with recursive locks involved is as follow:
> > +
> > +	TASK A:			TASK B:
> > +
> > +	read_lock(X);
> > +				read_lock(Y);
> > +	write_lock(Y);
> > +				write_lock(X);
> > +
> > +Task A is waiting for task B to read_unlock() Y and task B is waiting =
for task
> > +A to read_unlock() X.
> > +
> > +Dependency types and strong dependency paths:
> > +---------------------------------------------
> > +In order to detect deadlocks as above, lockdep needs to track differen=
t dependencies.
> > +There are 4 categories for dependency edges in the lockdep graph:
> > +
> > +1) -(NN)->: non-recursive to non-recursive dependency. "X -(NN)-> Y" m=
eans
> > +            X -> Y and both X and Y are non-recursive locks.
> > +
> > +2) -(RN)->: recursive to non-recursive dependency. "X -(RN)-> Y" means
> > +            X -> Y and X is recursive read lock and Y is non-recursive=
 lock.
> > +
> > +3) -(NR)->: non-recursive to recursive dependency, "X -(NR)-> Y" means
> > +            X -> Y and X is non-recursive lock and Y is recursive lock.
> > +
> > +4) -(RR)->: recursive to recursive dependency, "X -(RR)-> Y" means
> > +            X -> Y and both X and Y are recursive locks.
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
> > +We use -(*N)-> for edges that is either -(RN)-> or -(NN)->, the simila=
r for -(N*)->,
> > +-(*R)-> and -(R*)->
> > +
> > +A "path" is a series of conjunct dependency edges in the graph. And we=
 define a
> > +"strong" path, which indicates the strong dependency throughout each d=
ependency
> > +in the path, as the path that doesn't have two conjunct edges (depende=
ncies) as
> > +-(*R)-> and -(R*)->. In other words, a "strong" path is a path from a =
lock
> > +walking to another through the lock dependencies, and if X -> Y -> Z i=
n the
> > +path (where X, Y, Z are locks), if the walk from X to Y is through a -=
(NR)-> or
> > +-(RR)-> dependency, the walk from Y to Z must not be through a -(RN)->=
 or
> > +-(RR)-> dependency, otherwise it's not a strong path.
> > +
> > +We will see why the path is called "strong" in next section.
> > +
> > +Recursive Read Deadlock Detection:
> > +----------------------------------
> > +
> > +We now prove two things:
> > +
> > +Lemma 1:
> > +
> > +If there is a closed strong path (i.e. a strong cirle), then there is a
>=20
> ??                                                 circle
>=20
> > +combination of locking sequences that causes deadlock. I.e. a strong c=
ircle is
> > +sufficient for deadlock detection.
> > +
> > +Lemma 2:
> > +
> > +If there is no closed strong path (i.e. strong cirle), then there is no
>=20
> ??                                                circle
>=20
> > +combination of locking sequences that could cause deadlock. I.e.  stro=
ng
> > +circles are necessary for deadlock detection.
> > +
> > +With these two Lemmas, we can easily say a closed strong path is both =
sufficient
> > +and necessary for deadlocks, therefore a closed strong path is equival=
ent to
> > +deadlock possibility. As a closed strong path stands for a dependency =
chain that
> > +could cause deadlocks, so we call it "strong", considering there are d=
ependency
> > +circles that won't cause deadlocks.
> > +
> > +Proof for sufficiency (Lemma 1):
> > +
> > +Let's say we have a strong cirlce:
>=20
>                               circle:
>=20
> > +
> > +	L1 -> L2 ... -> Ln -> L1
> > +
> > +, which means we have dependencies:
> > +
> > +	L1 -> L2
> > +	L2 -> L3
> > +	...
> > +	Ln-1 -> Ln
> > +	Ln -> L1
> > +
> > +We now can construct a combination of locking sequences that cause dea=
dlock:
> > +
> > +Firstly let's make one CPU/task get the L1 in L1 -> L2, and then anoth=
er get
> > +the L2 in L2 -> L3, and so on. After this, all of the Lx in Lx -> Lx+1=
 are
> > +held by different CPU/tasks.
> > +
> > +And then because we have L1 -> L2, so the holder of L1 is going to acq=
uire L2
> > +in L1 -> L2, however since L2 is already held by another CPU/task, plu=
s L1 ->
> > +L2 and L2 -> L3 are not *R and R* (the definition of strong), therefor=
e the
> > +holder of L1 can not get L2, it has to wait L2's holder to release.
> > +
> > +Moreover, we can have a similar conclusion for L2's holder: it has to =
wait L3's
> > +holder to release, and so on. We now can proof that Lx's holder has to=
 wait for
>=20
>                                             prove
>=20
> > +Lx+1's holder to release, and note that Ln+1 is L1, so we have a circu=
lar
> > +waiting scenario and nobody can get progress, therefore a deadlock.
> > +
> > +Proof for necessary (Lemma 2):
> > +
> > +Lemma 2 is equivalent to: If there is a deadlock scenario, then there =
must be a
> > +strong circle in the dependency graph.
> > +
> > +According to Wikipedia[1], if there is a deadlock, then there must be =
a circular
> > +waiting scenario, means there are N CPU/tasks, where CPU/task P1 is wa=
iting for
> > +a lock held by P2, and P2 is waiting for a lock held by P3, ... and Pn=
 is waiting
> > +for a lock held by P1. Let's name the lock Px is waiting as Lx, so sin=
ce P1 is waiting
> > +for L1 and holding Ln, so we will have Ln -> L1 in the dependency grap=
h. Similarly,
> > +we have L1 -> L2, L2 -> L3, ..., Ln-1 -> Ln in the dependency graph, w=
hich means we
> > +have a circle:
> > +
> > +	Ln -> L1 -> L2 -> ... -> Ln
> > +
> > +, and now let's prove the circle is strong:
> > +
> > +For a lock Lx, Px contributes the dependency Lx-1 -> Lx and Px+1 contr=
ibutes
> > +the dependency Lx -> Lx+1, and since Px is waiting for Px+1 to release=
 Lx,
> > +so Lx can not be both recursive in Lx -> Lx+1 and Lx-1 -> Lx, because =
recursive
> > +locks don't block each other, therefore Lx-1 -> Lx and Lx -> Lx+1 can =
not be a
> > +-(*R)-> -(R*)-> pair, and this is true for any lock in the circle, the=
refore,
> > +the circle is strong.
> > +
> > +References:
> > +-----------
> > +[1]: https://en.wikipedia.org/wiki/Deadlock
> > +[2]: Shibu, K. (2009). Intro To Embedded Systems (1st ed.). Tata McGra=
w-Hill
> >=20
> I would also change all /can not/ to /cannot/...

Agreed. I will use 'cannot' for any future version, thanks a lot!

Regards,
Boqun

>=20
> --=20
> ~Randy

--3f2idczmrxg2o2og
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrUQuEACgkQSXnow7UH
+rhceAgAiFC1FgfpxNWeoMXGSpVvNXiTJ8VC78SG9qSIKLJnk7a3nuJBV7nQbs6R
Q+5BRUppjceXxesBjOdN5ykPER5PRyhki2P4SyYxHrpPn8P86R7U3bOUord6oOSY
34k9ruzFf4VwUgvPbNjama2oip5+0VcIabTDxbeM1tnqsksorp6u/RdEZ9UddsBl
AzTKk1c5SKPp6p9M/KBsVFwknPb9kvMTN/ExyEta+eAGLtsKya4IUalam4ps7OdC
I6xLNaHEwZ7k+zW1vo/2ZZUFF/9QZtgiE3efU0CcxAVBWq4odgjtdaJJiqGDtSJm
irxwXtUIQNsu+fSP+bSFHQVRansqgQ==
=kjOm
-----END PGP SIGNATURE-----

--3f2idczmrxg2o2og--
