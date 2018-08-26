Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A59C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C959E208B1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C959E208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeH0Ah0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:37:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbeH0Ah0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:37:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB7DF4023132;
        Sun, 26 Aug 2018 20:53:45 +0000 (UTC)
Received: from llong.com (ovpn-121-41.rdu2.redhat.com [10.10.121.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94F4D2026D76;
        Sun, 26 Aug 2018 20:53:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/3] xfs: Reduce spinlock contention in log space slowpath code
Date:   Sun, 26 Aug 2018 16:53:12 -0400
Message-Id: <1535316795-21560-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sun, 26 Aug 2018 20:53:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sun, 26 Aug 2018 20:53:45 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
 - For patch 1, remove wake_q_empty() & add task_in_wake_q().
 - Rewrite patch 2 after comments from Dave Chinner and break it down
   to 2 separate patches. Now the original xfs logic was kept. The
   patches just try to move the task wakeup calls to outside the
   spinlock.

While running the AIM7 microbenchmark on a small xfs filesystem, it
was found that there was a severe spinlock contention problem in the
current XFS log space reservation code. To alleviate the problem, the
patches try to move as much task wakeup code to outside the spinlock
using the wake_q mechanism so as to reduce the lock hold time as much
as possible.

Patch 1 exports the wake_up_q() and wake_q_add() functions and adds
the task_in_wake_q() inline function.

Patch 2 adds a new flag XLOG_TIC_WAKING to mark a task that is being
waken up and skip the wake_up_process() if a previous wakeup has
been issued.

Patch 3 modifies the xlog_grant_head_wait() and xlog_grant_head_wake()
functions to use wake_q for waking up tasks outside the lock critical
section instead of calling wake_up_process() directly.

The following table shows the performance improvement in the AIM7
fserver workload after applying patches 2 and 3:

  Patches	Jobs/min	% Change
  -------	--------	--------
     -		 91,486		   -
     2		192,666		 +111%
    2+3		285,221 	 +212%

So the final patched kernel performed more than 3X better than the
unpatched one.

Waiman Long (3):
  sched/core: Export wake_q functions to kernel modules
  xfs: Prevent multiple wakeups of the same log space waiter
  xfs: Use wake_q for waking up log space waiters

 fs/xfs/xfs_linux.h           |  1 +
 fs/xfs/xfs_log.c             | 57 ++++++++++++++++++++++++++++++------
 fs/xfs/xfs_log_priv.h        |  1 +
 include/linux/sched/wake_q.h |  5 ++++
 kernel/sched/core.c          |  2 ++
 5 files changed, 57 insertions(+), 9 deletions(-)

-- 
2.18.0

