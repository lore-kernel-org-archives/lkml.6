Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90022C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC452084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390756AbfAKUXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:23:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34633 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389005AbfAKUXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:23:09 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gi3KT-0003i8-MX; Fri, 11 Jan 2019 21:22:57 +0100
Date:   Fri, 11 Jan 2019 21:22:57 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <Joe.Korty@concurrent-rt.com>
Cc:     "julia@ni.com" <julia@ni.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH RT] rtmutex/rwlock: preserve state like a sleeping lock
Message-ID: <20190111202257.5wcqht6nwx7y6lmy@linutronix.de>
References: <20181119194619.GA32121@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119194619.GA32121@zipoli.concurrent-rt.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rwlock is spinning while acquiring a lock. Therefore it must become
a sleeping lock on RT and preserve its task state while sleeping and
waiting for the lock.

Reported-by: Joe Korty <Joe.Korty@concurrent-rt.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rwlock-rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index f2e155b2c4a8b..c3b91205161cc 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -128,7 +128,7 @@ void __sched __read_rt_lock(struct rt_rw_lock *lock)
 	 * That would put Reader1 behind the writer waiting on
 	 * Reader2 to call read_unlock() which might be unbound.
 	 */
-	rt_mutex_init_waiter(&waiter, false);
+	rt_mutex_init_waiter(&waiter, true);
 	rt_spin_lock_slowlock_locked(m, &waiter, flags);
 	/*
 	 * The slowlock() above is guaranteed to return with the rtmutex is
-- 
2.20.1

