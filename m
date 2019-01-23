Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10740C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E6D21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfAWDtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:49:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfAWDtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:49:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FF2CE1F05;
        Wed, 23 Jan 2019 03:49:22 +0000 (UTC)
Received: from llong.com (ovpn-120-224.rdu2.redhat.com [10.10.120.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CAF05D6A6;
        Wed, 23 Jan 2019 03:49:17 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        SRINIVAS <srinivas.eeda@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/4] locking/qspinlock: Handle > 4 nesting levels
Date:   Tue, 22 Jan 2019 22:49:07 -0500
Message-Id: <1548215351-18896-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 23 Jan 2019 03:49:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v2:
  - Use the simple trylock loop as suggested by PeterZ.

The current allows up to 4 levels of nested slowpath spinlock calls.
That should be enough for the process, soft irq, hard irq, and nmi.
With the unfortunate event of nested NMIs happening with slowpath
spinlock call in each of the previous level, we are going to run out
of useable MCS node for queuing.

In this case, we fall back to a simple TAS lock and spin on the lock
cacheline until the lock is free. This is not most elegant solution
but is simple enough.

Patch 1 implements the TAS loop when all the existing MCS nodes are
occupied.

Patches 2-4 enhances the locking statistics code to track the new code
as well as enabling it on other architectures such as ARM64.

By setting MAX_NODES to 1, we can have some usage of the new code path
during the booting process as demonstrated by the stat counter values
shown below on an 1-socket 22-core 44-thread x86-64 system after booting
up the new kernel.

  lock_no_node=20
  lock_pending=29660
  lock_slowpath=172714

Waiman Long (4):
  locking/qspinlock: Handle > 4 slowpath nesting levels
  locking/qspinlock_stat: Track the no MCS node available case
  locking/qspinlock_stat: Separate out the PV specific stat counts
  locking/qspinlock_stat: Allow QUEUED_LOCK_STAT for all archs

 arch/Kconfig                    |   7 ++
 arch/x86/Kconfig                |   8 ---
 kernel/locking/qspinlock.c      |  18 ++++-
 kernel/locking/qspinlock_stat.h | 150 +++++++++++++++++++++++++---------------
 4 files changed, 120 insertions(+), 63 deletions(-)

-- 
1.8.3.1

