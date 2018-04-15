Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeDOAjA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 20:39:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeDOAi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 20:38:58 -0400
Subject: Re: [RFC tip/locking/lockdep v6 01/20] lockdep/Documention: Recursive
 read lock detection reasoning
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
 <20180411135110.9217-2-boqun.feng@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ed9bece-4e63-de49-8be5-0ebab83c9769@infradead.org>
Date: Sat, 14 Apr 2018 17:38:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411135110.9217-2-boqun.feng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a few typos etc. below...

On 04/11/2018 06:50 AM, Boqun Feng wrote:
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  Documentation/locking/lockdep-design.txt | 178 +++++++++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 
> diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
> index 9de1c158d44c..6bb9e90e2c4f 100644
> --- a/Documentation/locking/lockdep-design.txt
> +++ b/Documentation/locking/lockdep-design.txt
> @@ -284,3 +284,181 @@ Run the command and save the output, then compare against the output from
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
> +acquired recursively. Unlike non-recursive read locks, recursive read locks
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
> +is not a deadlock for recursive read locks, as while the task B is waiting for
> +the lock X, the second read_lock() doesn't need to wait because it's a recursive
> +read lock. However if the read_lock() is non-recursive read lock, then the above
> +case is a deadlock, because even if the write_lock() in TASK B can not get the
> +lock, but it can block the second read_lock() in TASK A.
> +
> +Note that a lock can be a write lock (exclusive lock), a non-recursive read
> +lock (non-recursive shared lock) or a recursive read lock (recursive shared
> +lock), depending on the lock operations used to acquire it (more specifically,
> +the value of the 'read' parameter for lock_acquire()). In other words, a single
> +lock instance has three types of acquisition depending on the acquisition
> +functions: exclusive, non-recursive read, and recursive read.
> +
> +To be concise, we call that write locks and non-recursive read locks as
> +"non-recursive" locks and recursive read locks as "recursive" locks.
> +
> +Recursive locks don't block each other, while non-recursive locks do (this is
> +even true for two non-recursive read locks). A non-recursive lock can block the
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
> +Task A is waiting for task B to read_unlock() Y and task B is waiting for task
> +A to read_unlock() X.
> +
> +Dependency types and strong dependency paths:
> +---------------------------------------------
> +In order to detect deadlocks as above, lockdep needs to track different dependencies.
> +There are 4 categories for dependency edges in the lockdep graph:
> +
> +1) -(NN)->: non-recursive to non-recursive dependency. "X -(NN)-> Y" means
> +            X -> Y and both X and Y are non-recursive locks.
> +
> +2) -(RN)->: recursive to non-recursive dependency. "X -(RN)-> Y" means
> +            X -> Y and X is recursive read lock and Y is non-recursive lock.
> +
> +3) -(NR)->: non-recursive to recursive dependency, "X -(NR)-> Y" means
> +            X -> Y and X is non-recursive lock and Y is recursive lock.
> +
> +4) -(RR)->: recursive to recursive dependency, "X -(RR)-> Y" means
> +            X -> Y and both X and Y are recursive locks.
> +
> +Note that given two locks, they may have multiple dependencies between them, for example:
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
> +We use -(*N)-> for edges that is either -(RN)-> or -(NN)->, the similar for -(N*)->,
> +-(*R)-> and -(R*)->
> +
> +A "path" is a series of conjunct dependency edges in the graph. And we define a
> +"strong" path, which indicates the strong dependency throughout each dependency
> +in the path, as the path that doesn't have two conjunct edges (dependencies) as
> +-(*R)-> and -(R*)->. In other words, a "strong" path is a path from a lock
> +walking to another through the lock dependencies, and if X -> Y -> Z in the
> +path (where X, Y, Z are locks), if the walk from X to Y is through a -(NR)-> or
> +-(RR)-> dependency, the walk from Y to Z must not be through a -(RN)-> or
> +-(RR)-> dependency, otherwise it's not a strong path.
> +
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

??                                                 circle

> +combination of locking sequences that causes deadlock. I.e. a strong circle is
> +sufficient for deadlock detection.
> +
> +Lemma 2:
> +
> +If there is no closed strong path (i.e. strong cirle), then there is no

??                                                circle

> +combination of locking sequences that could cause deadlock. I.e.  strong
> +circles are necessary for deadlock detection.
> +
> +With these two Lemmas, we can easily say a closed strong path is both sufficient
> +and necessary for deadlocks, therefore a closed strong path is equivalent to
> +deadlock possibility. As a closed strong path stands for a dependency chain that
> +could cause deadlocks, so we call it "strong", considering there are dependency
> +circles that won't cause deadlocks.
> +
> +Proof for sufficiency (Lemma 1):
> +
> +Let's say we have a strong cirlce:

                              circle:

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
> +We now can construct a combination of locking sequences that cause deadlock:
> +
> +Firstly let's make one CPU/task get the L1 in L1 -> L2, and then another get
> +the L2 in L2 -> L3, and so on. After this, all of the Lx in Lx -> Lx+1 are
> +held by different CPU/tasks.
> +
> +And then because we have L1 -> L2, so the holder of L1 is going to acquire L2
> +in L1 -> L2, however since L2 is already held by another CPU/task, plus L1 ->
> +L2 and L2 -> L3 are not *R and R* (the definition of strong), therefore the
> +holder of L1 can not get L2, it has to wait L2's holder to release.
> +
> +Moreover, we can have a similar conclusion for L2's holder: it has to wait L3's
> +holder to release, and so on. We now can proof that Lx's holder has to wait for

                                            prove

> +Lx+1's holder to release, and note that Ln+1 is L1, so we have a circular
> +waiting scenario and nobody can get progress, therefore a deadlock.
> +
> +Proof for necessary (Lemma 2):
> +
> +Lemma 2 is equivalent to: If there is a deadlock scenario, then there must be a
> +strong circle in the dependency graph.
> +
> +According to Wikipedia[1], if there is a deadlock, then there must be a circular
> +waiting scenario, means there are N CPU/tasks, where CPU/task P1 is waiting for
> +a lock held by P2, and P2 is waiting for a lock held by P3, ... and Pn is waiting
> +for a lock held by P1. Let's name the lock Px is waiting as Lx, so since P1 is waiting
> +for L1 and holding Ln, so we will have Ln -> L1 in the dependency graph. Similarly,
> +we have L1 -> L2, L2 -> L3, ..., Ln-1 -> Ln in the dependency graph, which means we
> +have a circle:
> +
> +	Ln -> L1 -> L2 -> ... -> Ln
> +
> +, and now let's prove the circle is strong:
> +
> +For a lock Lx, Px contributes the dependency Lx-1 -> Lx and Px+1 contributes
> +the dependency Lx -> Lx+1, and since Px is waiting for Px+1 to release Lx,
> +so Lx can not be both recursive in Lx -> Lx+1 and Lx-1 -> Lx, because recursive
> +locks don't block each other, therefore Lx-1 -> Lx and Lx -> Lx+1 can not be a
> +-(*R)-> -(R*)-> pair, and this is true for any lock in the circle, therefore,
> +the circle is strong.
> +
> +References:
> +-----------
> +[1]: https://en.wikipedia.org/wiki/Deadlock
> +[2]: Shibu, K. (2009). Intro To Embedded Systems (1st ed.). Tata McGraw-Hill
> 
I would also change all /can not/ to /cannot/...

-- 
~Randy
