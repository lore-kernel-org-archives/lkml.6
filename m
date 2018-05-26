Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032010AbeEZPrX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 11:47:23 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:52054 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031885AbeEZPrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 11:47:22 -0400
From: Paul Burton <paul.burton@mips.com>
To: <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 0/2] sched: Fix a race between CPU onlining & user task scheduling
Date: Sat, 26 May 2018 08:46:46 -0700
Message-ID: <20180526154648.11635-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1527349614-321459-6793-23952-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193394
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short series fixes a race condition I've observed in which user
tasks can be scheduled on CPUs that are still in the process of being
brought online (or rather being made active) by hotplug.

I've created a small test case for the observed problem here:

  https://gist.github.com/paulburton/25187c4f537263a6be9c8aac67bd33bf

The issue was first observed on a MIPS system running a test program
that was sensitive to CPU affinity, but has been reproduced on x86_64
using the above program too. On my laptop with an Intel i7-5600U CPU the
test tends to fail within 10 minutes, but with this series applied runs
cleanly overnight.

Thanks,
    Paul

Paul Burton (2):
  sched: Make select_task_rq() require cpu_active() for user tasks
  sched: Warn if we fail to migrate a task

 kernel/sched/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.0
