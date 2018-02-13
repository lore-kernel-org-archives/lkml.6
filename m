Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964985AbeBMNhf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:37:35 -0500
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:46788 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964775AbeBMNhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:37:32 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/6] Reduce migrations and conflicts with automatic NUMA balancing v2
Date: Tue, 13 Feb 2018 13:37:24 +0000
Message-Id: <20180213133730.24064-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a combination of "Reduce migrations due to load imbalance and
process exits" and "Stop wake_affine fighting with automatic NUMA balancing"
series.

There was a request for data on NAS OMP and how it compares with hard-binding
of threads to CPUs that is included in the changelog for the relevant
patch. I did not update most of the comparisons as a partial rerun of the
workloads shows similar results.

Changelog since v1
o Replace patch 4 with Peter's version
o Correct comments
o Add data on NAS OMP
o Rebase to 4.16-rc1

The following series was motivated by the fact that higher migrations were
observed than expected. The first two patches are minor cleanups. The third
patch avoids migrations on wakeup when two CPUs are equally loaded which is
particularly important in the case where the measured load is 0. The fourth
patch avoids cross-node migrations of a parent process when the child exits.
The fifth path resists new children being woken for the first time on a
remote node but it's not barred completely as that may lead to saturation
of a single node. The final patch forces automatic NUMA balancing to backoff
if it disagrees with wake_affine about where a task should be running.

 kernel/sched/fair.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 7 deletions(-)

-- 
2.15.1
