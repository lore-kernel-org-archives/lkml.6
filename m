Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbeCKP4h (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:56:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44544 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932162AbeCKP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:56:36 -0400
Date: Sun, 11 Mar 2018 08:56:27 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] locking fix for 4.16
Message-ID: <alpine.DEB.2.21.1803110852070.3841@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking-urgent-for-linus git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

rt_mutex_futex_unlock() grew a new irq-off call site, but the function
assumes that its always called from irq enabled context. Use the
(un)lock_irqsafe to handle te new call site correctly.

Thanks,

	tglx

------------------>
Boqun Feng (1):
      rtmutex: Make rt_mutex_futex_unlock() safe for irq-off callsites


 kernel/locking/rtmutex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 65cc0cb984e6..940633c63254 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1616,11 +1616,12 @@ bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
 void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 {
 	DEFINE_WAKE_Q(wake_q);
+	unsigned long flags;
 	bool postunlock;
 
-	raw_spin_lock_irq(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	postunlock = __rt_mutex_futex_unlock(lock, &wake_q);
-	raw_spin_unlock_irq(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	if (postunlock)
 		rt_mutex_postunlock(&wake_q);
