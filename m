Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03B8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73891204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73891204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeI2ASj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:18:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbeI2ASi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:18:38 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62E3888E69;
        Fri, 28 Sep 2018 17:53:45 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCB2C2010DAA;
        Fri, 28 Sep 2018 17:53:44 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 5/5] locking/lockdep: Call lock_release after releasing the lock
Date:   Fri, 28 Sep 2018 13:53:21 -0400
Message-Id: <1538157201-29173-6-git-send-email-longman@redhat.com>
In-Reply-To: <1538157201-29173-1-git-send-email-longman@redhat.com>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 28 Sep 2018 17:53:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, lock_acquire() is called before acquiring the lock and
lock_release() is called before the releasing the lock. As a result,
the execution time of lock_release() is added to the lock hold time
reducing locking throughput, especially for spinlocks and rwlocks which
tend to have a much shorter lock hold time.

As lock_release() is not going to update any shared data that needs
protection from the lock, we don't actually need to call it before
releasing the lock. So the lock_release() calls are now postponed to
after releasing the lock for spinlocks and rwlocks.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rwlock_api_smp.h   | 16 ++++++++--------
 include/linux/spinlock_api_smp.h |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index 86ebb4b..b026940 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -215,63 +215,63 @@ static inline void __raw_write_lock(rwlock_t *lock)
 
 static inline void __raw_write_unlock(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_write_unlock(lock);
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	preempt_enable();
 }
 
 static inline void __raw_read_unlock(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_read_unlock(lock);
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	preempt_enable();
 }
 
 static inline void
 __raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_read_unlock(lock);
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	local_irq_restore(flags);
 	preempt_enable();
 }
 
 static inline void __raw_read_unlock_irq(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_read_unlock(lock);
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	local_irq_enable();
 	preempt_enable();
 }
 
 static inline void __raw_read_unlock_bh(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_read_unlock(lock);
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 }
 
 static inline void __raw_write_unlock_irqrestore(rwlock_t *lock,
 					     unsigned long flags)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_write_unlock(lock);
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	local_irq_restore(flags);
 	preempt_enable();
 }
 
 static inline void __raw_write_unlock_irq(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_write_unlock(lock);
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	local_irq_enable();
 	preempt_enable();
 }
 
 static inline void __raw_write_unlock_bh(rwlock_t *lock)
 {
-	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_write_unlock(lock);
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 }
 
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 42dfab8..fcb84df 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -147,32 +147,32 @@ static inline void __raw_spin_lock(raw_spinlock_t *lock)
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
-	spin_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_spin_unlock(lock);
+	spin_release(&lock->dep_map, 1, _RET_IP_);
 	preempt_enable();
 }
 
 static inline void __raw_spin_unlock_irqrestore(raw_spinlock_t *lock,
 					    unsigned long flags)
 {
-	spin_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_spin_unlock(lock);
+	spin_release(&lock->dep_map, 1, _RET_IP_);
 	local_irq_restore(flags);
 	preempt_enable();
 }
 
 static inline void __raw_spin_unlock_irq(raw_spinlock_t *lock)
 {
-	spin_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_spin_unlock(lock);
+	spin_release(&lock->dep_map, 1, _RET_IP_);
 	local_irq_enable();
 	preempt_enable();
 }
 
 static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock)
 {
-	spin_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_spin_unlock(lock);
+	spin_release(&lock->dep_map, 1, _RET_IP_);
 	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 }
 
-- 
1.8.3.1

