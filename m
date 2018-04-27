Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758461AbeD0NqB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:46:01 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35004 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932455AbeD0Np6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:45:58 -0400
X-Google-Smtp-Source: AB8JxZqq4yhliTBK9X76QHvowyNhc5ezBZFB6jeeNlBNCC/hFhdI7uM+VzEWIDZnbjGwqz4a/OMHcA==
X-ME-Sender: <xms:kynjWoYpZzFqy7alm4-AlIW5XLZr5tK1MpnB0Jx0eveFuJM6fHQPUw>
Date: Fri, 27 Apr 2018 21:50:19 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        willy@infradead.org, ktkhai@virtuozzo.com, jlayton@kernel.org,
        bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, longman@redhat.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC tip/locking/lockdep v6 01/20] lockdep/Documention:
 Recursive read lock detection reasoning
Message-ID: <20180427135019.lzz6oiqhp3xc6ojl@tardis>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
 <20180411135110.9217-2-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zlpn6su6shqyvjo"
Content-Disposition: inline
In-Reply-To: <20180411135110.9217-2-boqun.feng@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zlpn6su6shqyvjo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Copy more people)

On Wed, Apr 11, 2018 at 09:50:51PM +0800, Boqun Feng wrote:
> This patch add the documentation piece for the reasoning of deadlock
> detection related to recursive read lock. The following sections are
> added:
>=20
> *	Explain what is a recursive read lock, and what deadlock cases
> 	they could introduce.
>=20
> *	Introduce the notations for different types of dependencies, and
> 	the definition of strong paths.
>=20
> *	Proof for a closed strong path is both sufficient and necessary
> 	for deadlock detections with recursive read locks involved. The
> 	proof could also explain why we call the path "strong"
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  Documentation/locking/lockdep-design.txt | 178 +++++++++++++++++++++++++=
++++++
>  1 file changed, 178 insertions(+)
>=20
> diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/loc=
king/lockdep-design.txt
> index 9de1c158d44c..6bb9e90e2c4f 100644
> --- a/Documentation/locking/lockdep-design.txt
> +++ b/Documentation/locking/lockdep-design.txt
> @@ -284,3 +284,181 @@ Run the command and save the output, then compare a=
gainst the output from
>  a later run of this command to identify the leakers.  This same output
>  can also help you find situations where runtime lock initialization has
>  been omitted.
> +
> +Recursive read locks:
> +---------------------
> +
> +Lockdep now is equipped with deadlock detection for recursive read locks.
> +
> +Recursive read locks, as their name indicates, are the locks able to be
> +acquired recursively. Unlike non-recursive read locks, recursive read lo=
cks
> +only get blocked by current write lock *holders* other than write lock
> +*waiters*, for example:
> +
> +	TASK A:			TASK B:
> +
> +	read_lock(X);
> +
> +				write_lock(X);
> +
> +	read_lock(X);
> +
> +is not a deadlock for recursive read locks, as while the task B is waiti=
ng for
> +the lock X, the second read_lock() doesn't need to wait because it's a r=
ecursive
> +read lock. However if the read_lock() is non-recursive read lock, then t=
he above
> +case is a deadlock, because even if the write_lock() in TASK B can not g=
et the
> +lock, but it can block the second read_lock() in TASK A.
> +
> +Note that a lock can be a write lock (exclusive lock), a non-recursive r=
ead
> +lock (non-recursive shared lock) or a recursive read lock (recursive sha=
red
> +lock), depending on the lock operations used to acquire it (more specifi=
cally,
> +the value of the 'read' parameter for lock_acquire()). In other words, a=
 single
> +lock instance has three types of acquisition depending on the acquisition
> +functions: exclusive, non-recursive read, and recursive read.
> +
> +To be concise, we call that write locks and non-recursive read locks as
> +"non-recursive" locks and recursive read locks as "recursive" locks.
> +
> +Recursive locks don't block each other, while non-recursive locks do (th=
is is
> +even true for two non-recursive read locks). A non-recursive lock can bl=
ock the
> +corresponding recursive lock, and vice versa.
> +
> +A deadlock case with recursive locks involved is as follow:
> +
> +	TASK A:			TASK B:
> +
> +	read_lock(X);
> +				read_lock(Y);
> +	write_lock(Y);
> +				write_lock(X);
> +
> +Task A is waiting for task B to read_unlock() Y and task B is waiting fo=
r task
> +A to read_unlock() X.
> +
> +Dependency types and strong dependency paths:
> +---------------------------------------------
> +In order to detect deadlocks as above, lockdep needs to track different =
dependencies.
> +There are 4 categories for dependency edges in the lockdep graph:
> +
> +1) -(NN)->: non-recursive to non-recursive dependency. "X -(NN)-> Y" mea=
ns
> +            X -> Y and both X and Y are non-recursive locks.
> +
> +2) -(RN)->: recursive to non-recursive dependency. "X -(RN)-> Y" means
> +            X -> Y and X is recursive read lock and Y is non-recursive l=
ock.
> +
> +3) -(NR)->: non-recursive to recursive dependency, "X -(NR)-> Y" means
> +            X -> Y and X is non-recursive lock and Y is recursive lock.
> +
> +4) -(RR)->: recursive to recursive dependency, "X -(RR)-> Y" means
> +            X -> Y and both X and Y are recursive locks.
> +
> +Note that given two locks, they may have multiple dependencies between t=
hem, for example:
> +
> +	TASK A:
> +
> +	read_lock(X);
> +	write_lock(Y);
> +	...
> +
> +	TASK B:
> +
> +	write_lock(X);
> +	write_lock(Y);
> +
> +, we have both X -(RN)-> Y and X -(NN)-> Y in the dependency graph.
> +
> +We use -(*N)-> for edges that is either -(RN)-> or -(NN)->, the similar =
for -(N*)->,
> +-(*R)-> and -(R*)->
> +
> +A "path" is a series of conjunct dependency edges in the graph. And we d=
efine a
> +"strong" path, which indicates the strong dependency throughout each dep=
endency
> +in the path, as the path that doesn't have two conjunct edges (dependenc=
ies) as
> +-(*R)-> and -(R*)->. In other words, a "strong" path is a path from a lo=
ck
> +walking to another through the lock dependencies, and if X -> Y -> Z in =
the
> +path (where X, Y, Z are locks), if the walk from X to Y is through a -(N=
R)-> or
> +-(RR)-> dependency, the walk from Y to Z must not be through a -(RN)-> or
> +-(RR)-> dependency, otherwise it's not a strong path.
> +

So Matthew's request for better deadlock detection for rwlock can be
solved by:

	https://marc.info/?l=3Dlinux-kernel&m=3D152483640529740&w=3D2k

However, that will bring up a new challenge for the deadlock detection
of recursive read locks. Because in my previous design, I assumed that
a lock cannot have both non-recursive readers and recursive readers.
With that assumption, the definition of "strong" path works.

Now since rwlock_t may have both non-recursive readers and recursive
readers, then we have more interesting cases:

Case 1:

	<in irq handler>
	read_lock(&A);
				spin_lock_irq(&B);=09
	spin_lock(&B); // recursive
				read_lock(&A);

, is a deadlock. And we have circle A -(RN)-> B -(NN)-> A (note that "N"
stands for non-recursive).

Case 2:

	<in irq handler>
	spin_lock(&A);
				read_lock(&B);
	read_lock(&A); // recursive
				spin_lock_irq(&B);

, is not a deadlock, even if we have circle A -(NR)-> B -(NN)-> A.

So we need to redefine "strong" path, because the block conditions
change between non-recursive locks and recursive locks: a recursive
readers can block a non-recursive readers, while a non-recursive readers
cannot block a recursive readers.

Let's mark non-recursive readers as S (shared) and writers as W, then
the "strong" path is a path without conjunct edges as -(*R)-> -(S*)-> or
-(*R)-> -(R*)->, we can prove this with similar reasoning based on the
new block conditions.

And luckily enough, we don't need to change the code too much, because
we can, rather than record RR RN NR NN, record

1)	-(R/S N)->: the first lock is reader (recursive or not) and the
		    second is non-recursive (writer or non-recursive
		    reader)

2)	-(R/S R)->: the first lock is reader and the second is recursive

3)	-(W N)->: the first lock is writer and the second is non-recursive

4)	-(W R)->: the first lock is writer and the second is recursive

, and a "strong" path is a path without conjunct edges -(*R) -(R/S*)->.

As a result, only a bit code needs to be changed, and I have already
done that in a local branch (though a lot of documention updates are
needed and I haven't done that yet for the new version).

There remains two questions before I make a move:

1.	Changing the annotation for queued rwlocks needs extra work for
	lockdep self test cases, but could help reveal more bugs. Do
	people want this very soon?

2.	Or we can focus on deadlock detections for recursive read locks
	first? And if we get it settled, we can move to annotate queued
	rwlocks properly.

I ask because doing those two together seems too big for a patchset, and
probably both will introduce some regression, so..

Thoughts?

Regards,
Boqun
> +We will see why the path is called "strong" in next section.
> +
> +Recursive Read Deadlock Detection:
> +----------------------------------
> +
> +We now prove two things:
> +
> +Lemma 1:
> +
> +If there is a closed strong path (i.e. a strong cirle), then there is a
> +combination of locking sequences that causes deadlock. I.e. a strong cir=
cle is
> +sufficient for deadlock detection.
> +
> +Lemma 2:
> +
> +If there is no closed strong path (i.e. strong cirle), then there is no
> +combination of locking sequences that could cause deadlock. I.e.  strong
> +circles are necessary for deadlock detection.
> +
> +With these two Lemmas, we can easily say a closed strong path is both su=
fficient
> +and necessary for deadlocks, therefore a closed strong path is equivalen=
t to
> +deadlock possibility. As a closed strong path stands for a dependency ch=
ain that
> +could cause deadlocks, so we call it "strong", considering there are dep=
endency
> +circles that won't cause deadlocks.
> +
> +Proof for sufficiency (Lemma 1):
> +
> +Let's say we have a strong cirlce:
> +
> +	L1 -> L2 ... -> Ln -> L1
> +
> +, which means we have dependencies:
> +
> +	L1 -> L2
> +	L2 -> L3
> +	...
> +	Ln-1 -> Ln
> +	Ln -> L1
> +
> +We now can construct a combination of locking sequences that cause deadl=
ock:
> +
> +Firstly let's make one CPU/task get the L1 in L1 -> L2, and then another=
 get
> +the L2 in L2 -> L3, and so on. After this, all of the Lx in Lx -> Lx+1 a=
re
> +held by different CPU/tasks.
> +
> +And then because we have L1 -> L2, so the holder of L1 is going to acqui=
re L2
> +in L1 -> L2, however since L2 is already held by another CPU/task, plus =
L1 ->
> +L2 and L2 -> L3 are not *R and R* (the definition of strong), therefore =
the
> +holder of L1 can not get L2, it has to wait L2's holder to release.
> +
> +Moreover, we can have a similar conclusion for L2's holder: it has to wa=
it L3's
> +holder to release, and so on. We now can proof that Lx's holder has to w=
ait for
> +Lx+1's holder to release, and note that Ln+1 is L1, so we have a circular
> +waiting scenario and nobody can get progress, therefore a deadlock.
> +
> +Proof for necessary (Lemma 2):
> +
> +Lemma 2 is equivalent to: If there is a deadlock scenario, then there mu=
st be a
> +strong circle in the dependency graph.
> +
> +According to Wikipedia[1], if there is a deadlock, then there must be a =
circular
> +waiting scenario, means there are N CPU/tasks, where CPU/task P1 is wait=
ing for
> +a lock held by P2, and P2 is waiting for a lock held by P3, ... and Pn i=
s waiting
> +for a lock held by P1. Let's name the lock Px is waiting as Lx, so since=
 P1 is waiting
> +for L1 and holding Ln, so we will have Ln -> L1 in the dependency graph.=
 Similarly,
> +we have L1 -> L2, L2 -> L3, ..., Ln-1 -> Ln in the dependency graph, whi=
ch means we
> +have a circle:
> +
> +	Ln -> L1 -> L2 -> ... -> Ln
> +
> +, and now let's prove the circle is strong:
> +
> +For a lock Lx, Px contributes the dependency Lx-1 -> Lx and Px+1 contrib=
utes
> +the dependency Lx -> Lx+1, and since Px is waiting for Px+1 to release L=
x,
> +so Lx can not be both recursive in Lx -> Lx+1 and Lx-1 -> Lx, because re=
cursive
> +locks don't block each other, therefore Lx-1 -> Lx and Lx -> Lx+1 can no=
t be a
> +-(*R)-> -(R*)-> pair, and this is true for any lock in the circle, there=
fore,
> +the circle is strong.
> +
> +References:
> +-----------
> +[1]: https://en.wikipedia.org/wiki/Deadlock
> +[2]: Shibu, K. (2009). Intro To Embedded Systems (1st ed.). Tata McGraw-=
Hill
> --=20
> 2.16.2
>=20

--4zlpn6su6shqyvjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlrjKpcACgkQSXnow7UH
+rgLLgf+PPcZ1i0t+34oypgsb9c0pQ7TpjrKll7yAoJQoQy+0b3nf0Q5y3jzu42R
LhQ5yUi974wkkVhVQjuu0v9y8sk3Bm6F0ayQQjdwtcpUSKcK3OhS0LcW1549x9+l
CBr37JDHWxE2y5RPAra5xrvmh3OHcnJE41kVnNr6ZYbVKkS6/BGl1uJt3BlzUd35
ubSpE/kSB7C2QdwW2SCJ4ftDhupVq97GkV6kEOow/T7JVUnFGPGHEcHeRNIKhvrB
gVuo5AJ4ZUfsDlM1vz3ht9HNM0CqI6aHB6RPfxJI3ZDkJkCUlObugX0YZLXyLt2H
G75fFV61P843xfGKgJeKjU47duYg9A==
=aSFR
-----END PGP SIGNATURE-----

--4zlpn6su6shqyvjo--
