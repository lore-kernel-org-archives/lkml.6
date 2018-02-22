Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeBVHFv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:05:51 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33998 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeBVHFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:05:50 -0500
X-Google-Smtp-Source: AH8x225g9klwH7ROARkjNJcbwqIqGtoqu1uSNLT1kRMk4WKKP/kkGWxOgpRLgw4dq0kRXBGPWT8fyA==
X-ME-Sender: <xms:ymuOWuG30rKItft6B5I7YHkJSDB9P1oXYSHoh5P_GYbiV62EF9runA>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v5 00/17] lockdep: Support deadlock detection for recursive read locks
Date: Thu, 22 Feb 2018 15:08:47 +0800
Message-Id: <20180222070904.548-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo and Peter,

This is V5 for recursive read lock support in lockdep. The changes since
V4 are quite trivial:

*	Fix some wording issues in patch #16 as pointed out by Randy
	Dunlap

I added the explanation about reasoning in patch #16 in V4, which will
help understand this whole series. This patchset is based on v4.16-rc2.

Changes since V3:

*	Reduce the unnecessary cost in structure lock_list as suggested
	by Peter Zijlstra

*	Add documentation for explanation of the reasoning in recursive
	read lock deadlock detection.

*	Add comments before bfs() describing the greedy search we use in
	BFS for strong dependency paths.

*	Add myself as a reviewer for LOCKING PRIMITIVES so that if there
	is any performance regression, log misunderstanding or false
	positives, people know who to blame^Wask help from.

V1: https://marc.info/?l=linux-kernel&m=150393341825453
V2: https://marc.info/?l=linux-kernel&m=150468649417950
V3: https://marc.info/?l=linux-kernel&m=150637795424969
V4: https://marc.info/?l=linux-kernel&m=151550860121565


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

The whole series consists of 17 patches:

1.	Do a clean up on the return value of __bfs() and its friends.

2.	Make __bfs() able to visit every dependency until a match is
	found. The old version of __bfs() could only visit each lock
	class once, and this is insufficient if we are going to add
	recursive read locks into the dependency graph.

3.	Redefine LOCK*_STATE*, now LOCK*_STATE_RR stand for recursive
	read lock only and LOCK*_STATE stand for write lock and
	non-recursive read lock.

4-5	Extend __bfs() to be able to traverse the stong dependency
	patchs after recursive read locks added into the graph.

6-8	Adjust check_redundant(), check_noncircular() and
	check_irq_usage() with recursive read locks into consideration.

9.	Finally add recursive read locks into the dependency graph.

10-11	Adjust lock cache chain key generation with recursive read locks
	into consideration, and provide a test case.

12-13	Add more test cases.

14.	Revert commit d82fed752942 ("locking/lockdep/selftests: Fix
	mixed read-write ABBA tests"),

15.	Reduce the extra size cost of lock_list to zero

16.	Add documentation for recursive read lock deadlock detection
	reasoning

17.	Add myself as a LOCKING PRIMITIVES reviewer.

This series passed all the lockdep selftest cases(including those I
introduce).

Test and comments are welcome!

Regards,
Boqun
