Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeBLRLi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:11:38 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:53984 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751161AbeBLRLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:11:33 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/2] Stop wake_affine fighting with automatic NUMA balancing
Date: Mon, 12 Feb 2018 17:11:29 +0000
Message-Id: <20180212171131.26139-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on top of the series entitled "Reduce migrations
due to load imbalance and process exits" but this is likely to be more
controversial so I wanted it to be considered separately.

The series was motivated by the observation that 4.15 (and 4.16 during the
merge window) that related processes had a tendency to start on different
nodes and then wake_affine and automatic NUMA balancing constantly overriding
each other. The first patch of this series makes it less likely that a
newly forked task will be scheduled on a remote node when the local node
has low utilisation. The second patch forces automatic NUMA balancing
to back-off when wake_affine migrates a wakee from a remote node to the
local node of the waker. The reasoning is that wake_affine knows there
is a definite relationship between tasks and arguably the data should
migrate too. Note that the load balancer can still come along and move
related tasks to be running on different nodes but I was not sure what a
good universal solution to that should be.

 kernel/sched/fair.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

-- 
2.15.1
