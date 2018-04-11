Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeDKNrR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:47:17 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:43771 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeDKNrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:15 -0400
X-Google-Smtp-Source: AIpwx4/sawW5t/AHNUEtwVf7vldWK704RfAfln+EZxnEH4wNi8jNhlRaH0OXqliJs5G4usKCJaRCOw==
X-ME-Sender: <xms:3xHOWjfC4fncvM3qx5TT1McliIUCxzzqYQ-L0bbjPxeUUGDz6sgTVA>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 00/20] lockdep: Support deadlock detection for recursive read locks
Date: Wed, 11 Apr 2018 21:50:50 +0800
Message-Id: <20180411135110.9217-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo and Peter,

This is V6 for recursive read lock support in lockdep. I moved the
explanation about reasoning to patch #1, which will help understand this
whole series. This patchset is based on v4.16.

Other changes since V5:

*	Rewrite the the explanation of the reasoning, focus on the proof
	of equivalence between closed strong paths and deadlock
	possiblity.

*	Rewrite the detection for irq-safe->irq-unsafe check, not only
	we support deadlock detection for recursive read locks, but also
	save two BFS searchs (one backwards and one forwards) in the
	detection. Thanks a lot for the discussion with Peter Zijlstra.

*	Annotate SRCU related primitives with 'check' lockdep
	annotations, so that we can detect deadlocks related to SRCU.
	Also a self test case is added. The use case is provided by Paul
	E. Mckenney.

*	Make __bfs(.math) return bool, as suggested by Peter Zijlstra.

*	Improve the readibliy of code based on good suggestions from
	Peter Zijlstra. Hope this time nobody's brain gets hurted ;-)

*	Minor fixes for typos.

V1: https://marc.info/?l=linux-kernel&m=150393341825453
V2: https://marc.info/?l=linux-kernel&m=150468649417950
V3: https://marc.info/?l=linux-kernel&m=150637795424969
V4: https://marc.info/?l=linux-kernel&m=151550860121565
V5: https://marc.info/?l=linux-kernel&m=151928315529363


As Peter pointed out:

	https://marc.info/?l=linux-kernel&m=150349072023540

The lockdep current has a limit support for recursive read locks, the
deadlock case as follow could not be detected:

	read_lock(A);
				lock(B);
	lock(B);
				write_lock(A);

I got some inspiration from Gautham R Shenoy:

	https://lwn.net/Articles/332801/

, and came up with this series.

The basic idea is:

*	Add recursive read locks into the graph

*	Classify dependencies into -(RR)->, -(NR)->, -(RN)->,
	-(NN)->, where R stands for recursive read lock, N stands for
	other locks(i.e. non-recursive read locks and write locks).

*	Define strong dependency paths as the paths of dependencies
	don't have two adjacent dependencies as -(*R)-> and -(R*)->.

*	Extend __bfs() to only traverse on strong dependency paths.

*	If __bfs() finds a strong dependency circle, then a deadlock is
	reported.

The whole series consists of 20 patches:

1.	Add documentation for recursive read lock deadlock detection
	reasoning

2.	Do a clean up on the return value of __bfs() and its friends.

3.	Make __bfs() able to visit every dependency until a match is
	found. The old version of __bfs() could only visit each lock
	class once, and this is insufficient if we are going to add
	recursive read locks into the dependency graph.

4.	Redefine LOCK*_STATE*, now LOCK*_STATE_RR stand for recursive
	read lock only and LOCK*_STATE stand for write lock and
	non-recursive read lock.

5.	Reduce the size of lock_list::distance.

6-7	Extend __bfs() to be able to traverse the stong dependency
	patchs after recursive read locks added into the graph.

8.	Make __bfs(.math) return bool.

9-11	Adjust check_redundant(), check_noncircular() and
	check_irq_usage() with recursive read locks into consideration.

12.	Finally add recursive read locks into the dependency graph.

13-14	Adjust lock cache chain key generation with recursive read locks
	into consideration, and provide a test case.

15-16	Add more test cases.

17.	Revert commit d82fed752942 ("locking/lockdep/selftests: Fix
	mixed read-write ABBA tests"),

18.	Add myself as a LOCKING PRIMITIVES reviewer.

19-20	Annotation SRCU correctly for deadlock detection, and provide a
	test case.

This series passed all the lockdep selftest cases (including those I
introduce).

Test and comments are welcome!

Regards,
Boqun
