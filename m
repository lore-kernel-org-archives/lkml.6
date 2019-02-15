Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B44E222DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391217AbfBOUuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:50:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388469AbfBOUuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:50:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C3B78E6E5;
        Fri, 15 Feb 2019 20:50:21 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D8F65DD6B;
        Fri, 15 Feb 2019 20:50:17 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2 00/10] locking/rwsem: Rwsem rearchitecture part 1
Date:   Fri, 15 Feb 2019 15:50:00 -0500
Message-Id: <1550263810-31947-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 15 Feb 2019 20:50:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v2:
  - Sync up to v4 of the part 0 patch.
  - Remove the rwsem.h->rwsem-xadd.h renaming patch & change patches
    to modify rwsem.h instead of rwsem-xadd.h.
  - Add a new patch to micro-optimize rwsem_try_read_lock_unqueued().

This is part 1 of a 3-part (0/1/2) series to rearchitect the internal
operation of rwsem. This depends on the v4 part 0 patches sent out
previously

https://lore.kernel.org/lkml/1550095217-12047-1-git-send-email-longman@redhat.com

This part lays the foundation for part 2 without making any functional
changes. This part includes the following changes:

 1) Move code around and micro-optimize rwsem_try_read_lock_unqueued()
    (patches 1-4).
 2) Enhance the DEBUG_RWSEMS_WARN_ON() macro to provide more information
    and add additional checks (patches 5 & 6).
 3) Make the core qspinlock_stat.h code generic (lock event counting)
    so that it can be used by all the architectures as well as other
    locking subsystems such as rwsem (patches 7-10). Lock event
    counting help us visualize how frequently a code path is being
    used as well as spotting abnormal behavior due to bugs in the code
    without noticeably affecting kernel performance and hence behavior.

Both (2) and (3) are useful debugging aids.

Waiman Long (10):
  locking/rwsem: Relocate rwsem_down_read_failed()
  locking/rwsem: Move owner setting code from rwsem.c to rwsem.h
  locking/rwsem: Move rwsem internal function declarations to
    rwsem-xadd.h
  locking/rwsem: Micro-optimize rwsem_try_read_lock_unqueued()
  locking/rwsem: Add debug check for __down_read*()
  locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
  locking/qspinlock_stat: Introduce a generic lockevent counting APIs
  locking/lock_events: Make lock_events available for all archs & other
    locks
  locking/lock_events: Don't show pvqspinlock events on bare metal
  locking/rwsem: Enable lock event counting

 arch/Kconfig                        |   9 ++
 arch/x86/Kconfig                    |   8 --
 include/linux/rwsem.h               |   7 --
 kernel/locking/Makefile             |   1 +
 kernel/locking/lock_events.c        | 179 ++++++++++++++++++++++++++
 kernel/locking/lock_events.h        |  59 +++++++++
 kernel/locking/lock_events_list.h   |  67 ++++++++++
 kernel/locking/qspinlock.c          |   8 +-
 kernel/locking/qspinlock_paravirt.h |  19 +--
 kernel/locking/qspinlock_stat.h     | 242 +++++++-----------------------------
 kernel/locking/rwsem-xadd.c         | 204 +++++++++++++++---------------
 kernel/locking/rwsem.c              |  25 +---
 kernel/locking/rwsem.h              |  47 ++++++-
 13 files changed, 523 insertions(+), 352 deletions(-)
 create mode 100644 kernel/locking/lock_events.c
 create mode 100644 kernel/locking/lock_events.h
 create mode 100644 kernel/locking/lock_events_list.h

-- 
1.8.3.1

