Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44153C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F6A21B24
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991707;
	bh=UCuKZRINIGYH8jItewswKPPx+aFEx0fZ4THyyLZTTg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rD/U3+PeLDqt0yGnjpDZwCYBBsk1YXKAWcQttKaAodl8W0ClQpNBAF9aWQLIPjr3y
	 j+ftbs9H5Z+97o2pFx2Wi4nzTgsMoYV3y77XsU8UDnnk4HqhqqS/yQ59QzF3aMYSyW
	 kNZN+Ob0WQSLOfJW8IVqSITIDJE63pYvapV+/mMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfBLRPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731452AbfBLRPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:03 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201BB218FD;
        Tue, 12 Feb 2019 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991702;
        bh=UCuKZRINIGYH8jItewswKPPx+aFEx0fZ4THyyLZTTg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQa9J6XtDaxxFMGhKc0MvnyszYqhl9a2qQ+YUvkoT9pAgV/cgnqYOyf9781uhygqq
         ennClZ/2gs42ZbwEgXzlgGrhcpGGdOBLTUfZ7lmD/Ag1mDH826F5cvwLy5R/vxnHMD
         Y/hOH8Gqu4p626nwaRL6vBQZEbxnU32DvWDMB9x8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 10/32] locking/lockdep: Make mark_lock() verbosity aware of vector
Date:   Tue, 12 Feb 2019 18:14:01 +0100
Message-Id: <20190212171423.8308-11-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the effective usage bit on top of the lock usage bit/vector pair
while in verbose mode logging in mark_lock().

FIXME: This only handle the first bit in the mask. We may need to
iterate over all of them.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4bac8c1a3929..6a74b433fe4c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3219,7 +3219,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	 * We must printk outside of the graph_lock:
 	 */
 	if (ret == 2) {
-		printk("\nmarked lock as {%s}:\n", usage_str[new_usage->bit]);
+		printk("\nmarked lock as {%s}:\n", usage_str[__ffs64(lock_usage_mask(new_usage))]);
 		print_lock(this);
 		print_irqtrace_events(curr);
 		dump_stack();
-- 
2.17.1

