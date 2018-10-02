Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AACC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408CB20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408CB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeJCDFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:05:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeJCDFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:05:46 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 046C2A1E45;
        Tue,  2 Oct 2018 20:20:41 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1515A3001748;
        Tue,  2 Oct 2018 20:20:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/5] locking/lockdep: Improve lockdep performance
Date:   Tue,  2 Oct 2018 16:19:15 -0400
Message-Id: <1538511560-10090-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 02 Oct 2018 20:20:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v1->v2:
  - Minor twists to incorporate Ingo's comments.
  - Move class->ops from the lock_class structure to percpu array under
    CONFIG_DEBUG_LOCKDEP. That moves the increased memory consumption
    to CONFIG_DEBUG_LOCKDEP only.

Enabling CONFIG_LOCKDEP and other related debug options will greatly
reduce system performance. This patchset aims to reduce the performance
slowdown caused by the lockdep code.

Patch 1 just removes an inline function that wasn't used.

Patches 2 and 3 are minor twists to optimize the code.

Patch 4 makes class->ops a per-cpu counter and moves the stat counter
under CONFIG_DEBUG_LOCKDEP again.

Patch 5 moves the lock_release() call outside of the lock critical 
section.

Parallel kernel compilation tests (make -j <#cpu>, best of 3 runs)
with gcc8 were performed on 2 different systems:

 1) an 1-socket 22-core 44-thread Skylake system
 2) a 4-socket 72-core 144-thread Broadwell system

Four different kernel variants based on the 4.19-rc5 kernel were used:

 1) non-debug kernel (with minimal debug options enabled)
 2) pre-patch debug kernel  (CONFIG_LOCKDEP, !CONFIG_DEBUG_LOCKDEP)
 3) post-patch debug kernel (CONFIG_LOCKDEP, !CONFIG_DEBUG_LOCKDEP)
 4) post-patch debug kernel (CONFIG_LOCKDEP,  CONFIG_DEBUG_LOCKDEP)

Note that the debug kernels had more debug options enabled than just
LOCKDEP.

The build times with pre-patch and post-patch debug kernels were:

   System    Kernel 1    Kernel 2    Kernel 3    Kernel 4
   ------    --------    --------    --------    --------
  1-socket    6m06.0s     8m54.7s     8m34.9s     9m28.1s
  4-socket    4m09.2s     7m36.0s     5m38.8s     6m17.8s

Using the non-debug kernel execution times as the baseline, the % 
runtime increase of the other 3 kernel variants were:

   System    Kernel 2    Kernel 3    Kernel 4
   ------    --------    --------    --------    
  1-socket    +46.1%      +40.7%      +55.2%
  4-socket    +83.0%      +36.0%      +51.6%

Comparing just kernels 2 and 3, the patch reduced the execution times 
by 3.7% and 25.7% for the 1-socket and 4-socket systems respectively.

I think the last 2 patches yield most of the performance improvement.

Waiman Long (5):
  locking/lockdep: Remove add_chain_cache_classes()
  locking/lockdep: Eliminate redundant irqs check in __lock_acquire()
  locking/lockdep: Add a faster path in __lock_release()
  locking/lockdep: Make class->ops a percpu counter
  locking/lockdep: Call lock_release() after releasing the lock

 include/linux/lockdep.h            |   7 +-
 include/linux/rwlock_api_smp.h     |  16 ++--
 include/linux/spinlock_api_smp.h   |   8 +-
 kernel/locking/lockdep.c           | 113 ++++++++---------------------
 kernel/locking/lockdep_internals.h |  23 ++++++
 kernel/locking/lockdep_proc.c      |   2 +-
 6 files changed, 66 insertions(+), 103 deletions(-)

-- 
2.18.0

