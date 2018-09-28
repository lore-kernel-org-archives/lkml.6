Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A66204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A66204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeI2ASc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:18:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbeI2ASc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:18:32 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 909FD3097085;
        Fri, 28 Sep 2018 17:53:39 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A30A92010D95;
        Fri, 28 Sep 2018 17:53:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 0/5] locking/lockdep: Improve lockdep performance
Date:   Fri, 28 Sep 2018 13:53:16 -0400
Message-Id: <1538157201-29173-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 28 Sep 2018 17:53:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling CONFIG_LOCKDEP and other related debug options will greatly
reduce system performance. This patchset aims to reduce the performance
slowdown caused by the lockdep code.

Patch 1 just removes an inline function that wasn't used.

Patches 2 and 3 are minor twists to optimize the code.

Patch 4 makes class->ops a per-cpu counter.

Patch 5 moves the lock_release() call outside of a lock critical section.

Parallel kernel compilation tests (make -j <#cpu>) were performed on
2 different systems:

 1) an 1-socket 22-core 44-thread Skylake system
 2) a 4-socket 72-core 144-thread Broadwell system

The build times with pre-patch and post-patch debug kernels were:

   System      Pre-patch     Post-patch    %Change
   ------      ---------     ----------    -------
  1-socket      8m53.9s        8m41.2s      -2.4%
  4-socket      7m27.0s        5m31.0s      -26%

I think it is the last 2 patches that yield most of the performance
improvement.

Waiman Long (5):
  locking/lockdep: Remove add_chain_cache_classes()
  locking/lockdep: Eliminate redundant irqs check in __lock_acquire()
  locking/lockdep: Add a faster path in __lock_release()
  locking/lockdep: Make class->ops a percpu counter
  locking/lockdep: Call lock_release after releasing the lock

 include/linux/lockdep.h          |   2 +-
 include/linux/rwlock_api_smp.h   |  16 +++---
 include/linux/spinlock_api_smp.h |   8 +--
 kernel/locking/lockdep.c         | 120 ++++++++++++---------------------------
 4 files changed, 48 insertions(+), 98 deletions(-)

-- 
1.8.3.1

