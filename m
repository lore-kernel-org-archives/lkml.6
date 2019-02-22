Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8DFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49402070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfBVSur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:50:47 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39134 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVSuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:50:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 448F41682;
        Fri, 22 Feb 2019 10:50:45 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 09DB33F5C1;
        Fri, 22 Feb 2019 10:50:41 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 03/20] mmiowb: Hook up mmiowb helpers to spinlocks and generic I/O accessors
Date:   Fri, 22 Feb 2019 18:50:09 +0000
Message-Id: <20190222185026.10973-4-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing explicit calls to mmiowb() from driver code means that we must
now call into the generic mmiowb_spin_{lock,unlock}() functions from the
core spinlock code. In order to elide barriers following critical
sections without any I/O writes, we also hook into the asm-generic I/O
routines.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/io.h        |  3 ++-
 include/linux/spinlock.h        | 11 ++++++++++-
 kernel/locking/spinlock_debug.c |  6 +++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 303871651f8a..bc490a746602 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -19,6 +19,7 @@
 #include <asm-generic/iomap.h>
 #endif
 
+#include <asm/mmiowb.h>
 #include <asm-generic/pci_iomap.h>
 
 #ifndef mmiowb
@@ -49,7 +50,7 @@
 
 /* serialize device access against a spin_unlock, usually handled there. */
 #ifndef __io_aw
-#define __io_aw()      barrier()
+#define __io_aw()      mmiowb_set_pending()
 #endif
 
 #ifndef __io_pbw
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index e089157dcf97..4298b1b31d9b 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -57,6 +57,7 @@
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
 #include <asm/barrier.h>
+#include <asm/mmiowb.h>
 
 
 /*
@@ -177,6 +178,7 @@ do {								\
 static inline void do_raw_spin_lock(raw_spinlock_t *lock) __acquires(lock)
 {
 	__acquire(lock);
+	mmiowb_spin_lock();
 	arch_spin_lock(&lock->raw_lock);
 }
 
@@ -188,16 +190,23 @@ static inline void
 do_raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long *flags) __acquires(lock)
 {
 	__acquire(lock);
+	mmiowb_spin_lock();
 	arch_spin_lock_flags(&lock->raw_lock, *flags);
 }
 
 static inline int do_raw_spin_trylock(raw_spinlock_t *lock)
 {
-	return arch_spin_trylock(&(lock)->raw_lock);
+	int ret = arch_spin_trylock(&(lock)->raw_lock);
+
+	if (ret)
+		mmiowb_spin_lock();
+
+	return ret;
 }
 
 static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 {
+	mmiowb_spin_unlock();
 	arch_spin_unlock(&lock->raw_lock);
 	__release(lock);
 }
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 9aa0fccd5d43..654484b6e70c 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -109,6 +109,7 @@ static inline void debug_spin_unlock(raw_spinlock_t *lock)
  */
 void do_raw_spin_lock(raw_spinlock_t *lock)
 {
+	mmiowb_spin_lock();
 	debug_spin_lock_before(lock);
 	arch_spin_lock(&lock->raw_lock);
 	debug_spin_lock_after(lock);
@@ -118,8 +119,10 @@ int do_raw_spin_trylock(raw_spinlock_t *lock)
 {
 	int ret = arch_spin_trylock(&lock->raw_lock);
 
-	if (ret)
+	if (ret) {
+		mmiowb_spin_lock();
 		debug_spin_lock_after(lock);
+	}
 #ifndef CONFIG_SMP
 	/*
 	 * Must not happen on UP:
@@ -131,6 +134,7 @@ int do_raw_spin_trylock(raw_spinlock_t *lock)
 
 void do_raw_spin_unlock(raw_spinlock_t *lock)
 {
+	mmiowb_spin_unlock();
 	debug_spin_unlock(lock);
 	arch_spin_unlock(&lock->raw_lock);
 }
-- 
2.11.0

