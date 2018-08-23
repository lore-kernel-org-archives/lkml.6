Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E45C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FD72098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FD72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeHWT4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:56:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbeHWT4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:56:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A894087A78;
        Thu, 23 Aug 2018 16:26:19 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7E6310CD7CC;
        Thu, 23 Aug 2018 16:26:17 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] xfs: Use wake_q for waking up log space waiters
Date:   Thu, 23 Aug 2018 12:26:08 -0400
Message-Id: <1535041570-24102-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 23 Aug 2018 16:26:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 23 Aug 2018 16:26:19 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running the AIM7 microbenchmark, it was found that there was
a severe spinlock contention problem in the current XFS log space
reservation code. To alleviate the problem, the log space waiter
waiting and waking functions are modified to use the wake_q for waking
up waiters without holding the lock so as to reduce the lock hold time.

The result was a 4X performance improvement in that microbenchmark
which is worth persuing.

Patch 1 is an enablement patch to make wake_q service available to
kernel modules.

Patch 2 changes the XFS log space reservation code to use wake_q for
task wakeup.

Waiman Long (2):
  sched/core: Export wake_q functions to kernel modules
  xfs: Use wake_q for waking up log space waiters

 fs/xfs/xfs_log.c             | 48 ++++++++++++++++++++++++++++++++++----------
 include/linux/sched/wake_q.h |  5 +++++
 kernel/sched/core.c          |  2 ++
 3 files changed, 44 insertions(+), 11 deletions(-)

-- 
1.8.3.1

