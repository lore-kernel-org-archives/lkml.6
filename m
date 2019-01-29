Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C250AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918C52082F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfA2VyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:54:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfA2VyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:54:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A71787F41D;
        Tue, 29 Jan 2019 21:54:02 +0000 (UTC)
Received: from llong.com (dhcp-17-91.bos.redhat.com [10.18.17.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55C3F5D96F;
        Tue, 29 Jan 2019 21:53:58 +0000 (UTC)
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
Subject: [PATCH v3 0/4] locking/qspinlock: Handle > 4 nesting levels
Date:   Tue, 29 Jan 2019 22:53:44 +0100
Message-Id: <1548798828-16156-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 29 Jan 2019 21:54:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v3:
  - Fix typo error in patch 2.
  - Rework patches 3/4 to create a new lockevent_* API to handle lock
    event counting that can be used by other locking code as well as
    on all architectures that are applicable.

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

Patch 2 adds a new counter to track the no MCS node available event.

Patches 3 & 4 create a a new lockevent_* API to handle lock event
counting that can be used by other locking code as well as on all
architectures that are applicable.

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
  locking/qspinlock_stat: Introduce a generic lockevent counting APIs
  locking/lock_events: Make lock_events available for all archs & other
    locks

 arch/Kconfig                        |  10 ++
 arch/x86/Kconfig                    |   8 --
 kernel/locking/Makefile             |   1 +
 kernel/locking/lock_events.c        | 152 +++++++++++++++++++++++
 kernel/locking/lock_events.h        |  46 +++++++
 kernel/locking/lock_events_list.h   |  49 ++++++++
 kernel/locking/qspinlock.c          |  22 +++-
 kernel/locking/qspinlock_paravirt.h |  19 +--
 kernel/locking/qspinlock_stat.h     | 233 +++++++-----------------------------
 9 files changed, 330 insertions(+), 210 deletions(-)
 create mode 100644 kernel/locking/lock_events.c
 create mode 100644 kernel/locking/lock_events.h
 create mode 100644 kernel/locking/lock_events_list.h

-- 
1.8.3.1

