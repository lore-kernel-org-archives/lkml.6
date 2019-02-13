Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E41C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFC8222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbfBMA1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:27:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15161 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfBMA1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:27:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B9DCE6A68;
        Wed, 13 Feb 2019 00:27:34 +0000 (UTC)
Received: from llong.com (ovpn-121-56.rdu2.redhat.com [10.10.121.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D68465C219;
        Wed, 13 Feb 2019 00:27:27 +0000 (UTC)
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
Subject: [PATCH 00/10] locking/rwsem: Rwsem rearchitecture part 1
Date:   Tue, 12 Feb 2019 19:26:57 -0500
Message-Id: <1550017627-14504-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 13 Feb 2019 00:27:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 1 of a 3-part (0/1/2) series to rearchitect the internal
operation of rwsem. This depends on the part 0 patches sent out previously

https://lore.kernel.org/lkml/1549913486-16799-1-git-send-email-longman@redhat.com

This part lays the foundation for part 2 without making any functional
changes. This part includes the following changes:

 1) Move code around and rename kernel/locking/rwsem.h to
    kernel/locking/rwsem-xadd.h as it will be specific to rwsem-xadd.c
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
  locking/rwsem: Rename kernel/locking/rwsem.h
  locking/rwsem: Move rwsem internal function declarations to
    rwsem-xadd.h
  locking/rwsem: Add debug check for __down_read*()
  locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
  locking/qspinlock_stat: Introduce a generic lockevent counting APIs
  locking/lock_events: Make lock_events available for all archs & other
    locks
  locking/lock_events: Don't show pvqspinlock events on bare metal
  locking/rwsem: Enable lock event counting

 arch/Kconfig                        |  10 ++
 arch/x86/Kconfig                    |   8 -
 include/linux/rwsem.h               |   7 -
 kernel/locking/Makefile             |   1 +
 kernel/locking/lock_events.c        | 179 ++++++++++++++++++++++
 kernel/locking/lock_events.h        |  55 +++++++
 kernel/locking/lock_events_list.h   |  67 ++++++++
 kernel/locking/percpu-rwsem.c       |   4 +-
 kernel/locking/qspinlock.c          |   8 +-
 kernel/locking/qspinlock_paravirt.h |  19 +--
 kernel/locking/qspinlock_stat.h     | 242 ++++++-----------------------
 kernel/locking/rwsem-xadd.c         | 192 ++++++++++++-----------
 kernel/locking/rwsem-xadd.h         | 294 ++++++++++++++++++++++++++++++++++++
 kernel/locking/rwsem.c              |  32 ++--
 kernel/locking/rwsem.h              | 264 --------------------------------
 15 files changed, 778 insertions(+), 604 deletions(-)
 create mode 100644 kernel/locking/lock_events.c
 create mode 100644 kernel/locking/lock_events.h
 create mode 100644 kernel/locking/lock_events_list.h
 create mode 100644 kernel/locking/rwsem-xadd.h
 delete mode 100644 kernel/locking/rwsem.h

-- 
1.8.3.1

