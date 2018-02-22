Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeBVHHE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:07:04 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:40646 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeBVHG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:59 -0500
X-Google-Smtp-Source: AH8x226jI18OxhvTFIk2gw6rIZYb0K6UeH/IVhEkquqSCTGZFUlgQCn/Gc+JGhvuFUVeoJlrt3P+zw==
X-ME-Sender: <xms:DmyOWsIFznJQl6DH6XSlPmWx7MQWsRjjli_czr42z56ML4kHVfEc6g>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [RFC tip/locking/lockdep v5 16/17] lockdep: Documention for recursive read lock detection reasoning
Date: Thu, 22 Feb 2018 15:09:03 +0800
Message-Id: <20180222070904.548-17-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As now we support recursive read lock deadlock detection, add related
explanation in the Documentation/lockdep/lockdep-desgin.txt:

*	Definition of recursive read locks, non-recursive locks, strong
	dependency path and notions of -(**)->.

*	Lockdep's assumption.

*	Informal proof of recursive read lock deadlock detection.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/locking/lockdep-design.txt | 170 +++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 382bc25589c2..fd8a8d97ce58 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -284,3 +284,173 @@ Run the command and save the output, then compare against the output from
 a later run of this command to identify the leakers.  This same output
 can also help you find situations where runtime lock initialization has
 been omitted.
+
+Recursive Read Deadlock Detection:
+----------------------------------
+Lockdep now is equipped with deadlock detection for recursive read locks.
+
+Recursive read locks, as their name indicates, are the locks able to be
+acquired recursively. Unlike non-recursive read locks, recursive read locks
+only get blocked by current write lock *holders* other than write lock
+*waiters*, for example:
+
+	TASK A:			TASK B:
+
+	read_lock(X);
+
+				write_lock(X);
+
+	read_lock(X);
+
+is not a deadlock for recursive read locks, as while the task B is waiting for
+the lock X, the second read_lock() doesn't need to wait because it's a recursive
+read lock.
+
+Note that a lock can be a write lock(exclusive lock), a non-recursive read lock
+(non-recursive shared lock) or a recursive read lock(recursive shared lock),
+depending on the API used to acquire it(more specifically, the value of the
+'read' parameter for lock_acquire(...)). In other words, a single lock instance
+has three types of acquisition depending on the acquisition functions:
+exclusive, non-recursive read, and recursive read.
+
+That said, recursive read locks could introduce deadlocks too, considering the
+following:
+
+	TASK A:			TASK B:
+
+	read_lock(X);
+				read_lock(Y);
+	write_lock(Y);
+				write_lock(X);
+
+, neither task could get the write locks because the corresponding read locks
+are held by each other.
+
+Lockdep could detect recursive read lock related deadlocks. The dependencies(edges)
+in the lockdep graph are classified into four categories:
+
+1) -(NN)->: non-recursive to non-recursive dependency, non-recursive locks include
+            non-recursive read locks, write locks and exclusive locks(e.g. spinlock_t).
+	    They are treated equally in deadlock detection. "X -(NN)-> Y" means
+            X -> Y and both X and Y are non-recursive locks.
+
+2) -(RN)->: recursive to non-recursive dependency, recursive locks means recursive read
+	    locks. "X -(RN)-> Y" means X -> Y and X is recursive read lock and
+            Y is non-recursive lock.
+
+3) -(NR)->: non-recursive to recursive dependency, "X -(NR)-> Y" means X -> Y and X is
+            non-recursive lock and Y is recursive lock.
+
+4) -(RR)->: recursive to recursive dependency, "X -(RR)-> Y" means X -> Y and both X
+            and Y are recursive locks.
+
+Note that given two locks, they may have multiple dependencies between them, for example:
+
+	TASK A:
+
+	read_lock(X);
+	write_lock(Y);
+	...
+
+	TASK B:
+
+	write_lock(X);
+	write_lock(Y);
+
+, we have both X -(RN)-> Y and X -(NN)-> Y in the dependency graph.
+
+And obviously a non-recursive lock can block the corresponding recursive lock,
+and vice versa. Besides a non-recursive lock may block the other non-recursive
+lock of the same instance(e.g. a write lock may block a corresponding
+non-recursive read lock and vice versa).
+
+We use -(*N)-> for edges that is either -(RN)-> or -(NN)->, the similar for -(N*)->,
+-(*R)-> and -(R*)->
+
+A "path" is a series of conjunct dependency edges in the graph. And we define a
+"strong" path, which indicates the strong dependency throughout each dependency
+in the path, as the path that doesn't have two conjunct edges(dependencies) as
+-(*R)-> and -(R*)->. IOW, a "strong" path is a path from a lock walking to another
+through the lock dependencies, and if X -> Y -> Z in the path(where X, Y, Z are
+locks), if the walk from X to Y is through a -(NR)-> or -(RR)-> dependency, the
+walk from Y to Z must not be through a -(RN)-> or -(RR)-> dependency, otherwise
+it's not a strong path.
+
+We now prove that if a strong path forms a circle, then we have a potential deadlock.
+By "forms a circle", it means for a set of locks A0,A1...An, there is a path from
+A0 to An:
+
+	A0 -> A1 -> ... -> An
+
+and there is also a dependency An->A0. And as the circle is formed by a strong path,
+so there are no two conjunct dependency edges as -(*R)-> and -(R*)->.
+
+
+To understand the actual proof, let's look into lockdep's assumption:
+
+For each lockdep dependency A -> B, there may exist a case where someone is
+trying to acquire B with A held, and the existence of such a case is
+independent to the existences of cases for other lockdep dependencies.
+
+For example if we have two functions func1 and func2:
+
+	void func1(...) {
+		lock(A);
+		lock(B);
+		unlock(A);
+		unlock(B);
+
+		lock(C);
+		lock(A);
+		unlock(A);
+		unlock(C);
+	}
+
+	void func2(...) {
+		lock(B);
+		lock(C);
+		unlock(C);
+		unlock(B);
+	}
+
+lockdep will generate dependencies: A->B, B->C and C->A, and assume that:
+
+	there may exist a case where someone is trying to acquire B with A held,
+	there may exist a case where someone is trying to acquire C with B held,
+	and there may exist a case where someone is trying to acquire A with C held,
+
+and those three cases exist *independently*, meaning they can happen at the
+same time(which requires func1() being called simultaneously by two CPUs or
+tasks, which may be impossible due to other constraints in the real life)
+
+
+With this assumption, we can prove that if a strong dependency path forms a circle,
+then it indicates a deadlock as far as lockdep is concerned.
+
+For a strong dependency circle like:
+
+	A0 -> A1 -> ... -> An
+	^                  |
+	|                  |
+	+------------------+
+, lockdep assumes that
+
+	there may exist a case where someone is trying to acquire A1 with A0 held
+	there may exist a case where someone is trying to acquire A2 with A1 held
+	...
+	there may exist a case where someone is trying to acquire An with An-1 held
+	there may exist a case where someone is trying to acquire A0 with An held
+
+, and because it's a *strong* dependency circle for every Ai (0<=i<=n), Ai is either
+held as a non-recursive lock or someone is trying to acquire Ai as a non-recursive lock,
+which gives:
+
+*	If Ai is held as a non-recursive lock, then trying to acquire it,
+	whether as a recursive lock or not, will get blocked.
+
+*	If Ai is held as a recursive lock, then there must be someone is trying to acquire
+	it as a non-recursive lock, and because recursive locks blocks non-recursive locks,
+	then it(the "someone") will get blocked.
+
+So all the holders of A0, A1...An are blocked with A0, A1...An held by each other,
+no one can progress, therefore deadlock.
-- 
2.16.1
