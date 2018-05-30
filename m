Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753796AbeE3PYq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:24:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753043AbeE3PYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:24:42 -0400
Date: Wed, 30 May 2018 11:24:41 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <matthew@wil.cx>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] semaphore: use raw_spin_lock_irq instead of
 raw_spin_lock_irqsave
Message-ID: <alpine.LRH.2.02.1805301120180.3104@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sleeping functions down, down_interruptible, down_killable and
down_timeout can't be called with interrupts disabled, so we don't have to
save and restore interrupt flag.

This patch avoids the costly pushf and popf instructions on the semaphore
path.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 kernel/locking/semaphore.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

Index: linux-2.6/kernel/locking/semaphore.c
===================================================================
--- linux-2.6.orig/kernel/locking/semaphore.c	2017-06-03 00:22:44.000000000 +0200
+++ linux-2.6/kernel/locking/semaphore.c	2018-05-30 14:46:35.000000000 +0200
@@ -53,14 +53,12 @@ static noinline void __up(struct semapho
  */
 void down(struct semaphore *sem)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&sem->lock, flags);
+	raw_spin_lock_irq(&sem->lock);
 	if (likely(sem->count > 0))
 		sem->count--;
 	else
 		__down(sem);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	raw_spin_unlock_irq(&sem->lock);
 }
 EXPORT_SYMBOL(down);
 
@@ -75,15 +73,14 @@ EXPORT_SYMBOL(down);
  */
 int down_interruptible(struct semaphore *sem)
 {
-	unsigned long flags;
 	int result = 0;
 
-	raw_spin_lock_irqsave(&sem->lock, flags);
+	raw_spin_lock_irq(&sem->lock);
 	if (likely(sem->count > 0))
 		sem->count--;
 	else
 		result = __down_interruptible(sem);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	raw_spin_unlock_irq(&sem->lock);
 
 	return result;
 }
@@ -101,15 +98,14 @@ EXPORT_SYMBOL(down_interruptible);
  */
 int down_killable(struct semaphore *sem)
 {
-	unsigned long flags;
 	int result = 0;
 
-	raw_spin_lock_irqsave(&sem->lock, flags);
+	raw_spin_lock_irq(&sem->lock);
 	if (likely(sem->count > 0))
 		sem->count--;
 	else
 		result = __down_killable(sem);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	raw_spin_unlock_irq(&sem->lock);
 
 	return result;
 }
@@ -155,15 +151,14 @@ EXPORT_SYMBOL(down_trylock);
  */
 int down_timeout(struct semaphore *sem, long timeout)
 {
-	unsigned long flags;
 	int result = 0;
 
-	raw_spin_lock_irqsave(&sem->lock, flags);
+	raw_spin_lock_irq(&sem->lock);
 	if (likely(sem->count > 0))
 		sem->count--;
 	else
 		result = __down_timeout(sem, timeout);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	raw_spin_unlock_irq(&sem->lock);
 
 	return result;
 }
