Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A2C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935B120865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935B120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeIIRsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 13:48:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726790AbeIIRsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 13:48:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CFF98011462;
        Sun,  9 Sep 2018 12:58:35 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A404510EE785;
        Sun,  9 Sep 2018 12:58:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Date:   Sun,  9 Sep 2018 20:58:24 +0800
Message-Id: <20180909125824.9150-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 09 Sep 2018 12:58:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 09 Sep 2018 12:58:35 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now percpu_ref_reinit() can only be done on one percpu refcounter
when it drops zero. And the limit shouldn't be so strict, and it
is quite straightforward that percpu_ref_reinit() can be done when
this counter is at atomic mode.

This patch relaxes the limit, so we may avoid extra change[1] for NVMe
timeout's requirement.

[1] https://marc.info/?l=linux-kernel&m=153612052611020&w=2

Cc: Tejun Heo <tj@kernel.org>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/percpu-refcount.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 9f96fa7bc000..af6b514c7d72 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -130,8 +130,10 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 	unsigned long count = 0;
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		count += *per_cpu_ptr(percpu_count, cpu);
+		*per_cpu_ptr(percpu_count, cpu) = 0;
+	}
 
 	pr_debug("global %ld percpu %ld",
 		 atomic_long_read(&ref->count), (long)count);
@@ -187,7 +189,6 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 {
 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
-	int cpu;
 
 	BUG_ON(!percpu_count);
 
@@ -196,15 +197,6 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 
 	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
 
-	/*
-	 * Restore per-cpu operation.  smp_store_release() is paired
-	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
-	 * zeroing is visible to all percpu accesses which can see the
-	 * following __PERCPU_REF_ATOMIC clearing.
-	 */
-	for_each_possible_cpu(cpu)
-		*per_cpu_ptr(percpu_count, cpu) = 0;
-
 	smp_store_release(&ref->percpu_count_ptr,
 			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);
 }
@@ -349,7 +341,7 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
  *
  * Re-initialize @ref so that it's in the same state as when it finished
  * percpu_ref_init() ignoring %PERCPU_REF_INIT_DEAD.  @ref must have been
- * initialized successfully and reached 0 but not exited.
+ * initialized successfully and in atomic mode but not exited.
  *
  * Note that percpu_ref_tryget[_live]() are safe to perform on @ref while
  * this function is in progress.
@@ -357,10 +349,11 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
 void percpu_ref_reinit(struct percpu_ref *ref)
 {
 	unsigned long flags;
+	unsigned long __percpu *percpu_count;
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
-	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
+	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
 
 	ref->percpu_count_ptr &= ~__PERCPU_REF_DEAD;
 	percpu_ref_get(ref);
-- 
2.9.5

