Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DACECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21752146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21752146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeIRE1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:27:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbeIRE1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:27:33 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BEA08C49;
        Mon, 17 Sep 2018 22:58:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, dave@stgolabs.net,
        longman@redhat.com, parri.andrea@gmail.com, sramana@codeaurora.org,
        Ingo Molnar <mingo@kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 13/70] locking/rwsem-xadd: Fix missed wakeup due to reordering of load
Date:   Tue, 18 Sep 2018 00:41:46 +0200
Message-Id: <20180917211650.297286017@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prateek Sood <prsood@codeaurora.org>

commit 9c29c31830a4eca724e137a9339137204bbb31be upstream.

If a spinner is present, there is a chance that the load of
rwsem_has_spinner() in rwsem_wake() can be reordered with
respect to decrement of rwsem count in __up_write() leading
to wakeup being missed:

 spinning writer                  up_write caller
 ---------------                  -----------------------
 [S] osq_unlock()                 [L] osq
  spin_lock(wait_lock)
  sem->count=0xFFFFFFFF00000001
            +0xFFFFFFFF00000000
  count=sem->count
  MB
                                   sem->count=0xFFFFFFFE00000001
                                             -0xFFFFFFFF00000001
                                   spin_trylock(wait_lock)
                                   return
 rwsem_try_write_lock(count)
 spin_unlock(wait_lock)
 schedule()

Reordering of atomic_long_sub_return_release() in __up_write()
and rwsem_has_spinner() in rwsem_wake() can cause missing of
wakeup in up_write() context. In spinning writer, sem->count
and local variable count is 0XFFFFFFFE00000001. It would result
in rwsem_try_write_lock() failing to acquire rwsem and spinning
writer going to sleep in rwsem_down_write_failed().

The smp_rmb() will make sure that the spinner state is
consulted after sem->count is updated in up_write context.

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave@stgolabs.net
Cc: longman@redhat.com
Cc: parri.andrea@gmail.com
Cc: sramana@codeaurora.org
Link: http://lkml.kernel.org/r/1504794658-15397-1-git-send-email-prsood@codeaurora.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/locking/rwsem-xadd.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -574,6 +574,33 @@ struct rw_semaphore *rwsem_wake(struct r
 	WAKE_Q(wake_q);
 
 	/*
+	* __rwsem_down_write_failed_common(sem)
+	*   rwsem_optimistic_spin(sem)
+	*     osq_unlock(sem->osq)
+	*   ...
+	*   atomic_long_add_return(&sem->count)
+	*
+	*      - VS -
+	*
+	*              __up_write()
+	*                if (atomic_long_sub_return_release(&sem->count) < 0)
+	*                  rwsem_wake(sem)
+	*                    osq_is_locked(&sem->osq)
+	*
+	* And __up_write() must observe !osq_is_locked() when it observes the
+	* atomic_long_add_return() in order to not miss a wakeup.
+	*
+	* This boils down to:
+	*
+	* [S.rel] X = 1                [RmW] r0 = (Y += 0)
+	*         MB                         RMB
+	* [RmW]   Y += 1               [L]   r1 = X
+	*
+	* exists (r0=1 /\ r1=0)
+	*/
+	smp_rmb();
+
+	/*
 	 * If a spinner is present, it is not necessary to do the wakeup.
 	 * Try to do wakeup only if the trylock succeeds to minimize
 	 * spinlock contention which may introduce too much delay in the


