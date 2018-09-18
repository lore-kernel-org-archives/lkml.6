Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF888ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710C420C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710C420C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeIRPvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeIRPvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:51:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AFBC5F74A;
        Tue, 18 Sep 2018 10:20:00 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E893F61B64;
        Tue, 18 Sep 2018 10:19:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/4] percpu-refcount: move zeroing of percpu part into percpu_ref_switch_to_atomic_rcu
Date:   Tue, 18 Sep 2018 18:19:43 +0800
Message-Id: <20180918101946.13329-2-ming.lei@redhat.com>
In-Reply-To: <20180918101946.13329-1-ming.lei@redhat.com>
References: <20180918101946.13329-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 18 Sep 2018 10:20:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu parts are added to atomic part in percpu_ref_switch_to_atomic_rcu(),
so it is readable & reasonable to clear them there.

Cc: Tejun Heo <tj@kernel.org>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/percpu-refcount.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 9f96fa7bc000..a220b717f6bb 100644
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
 
@@ -202,9 +203,6 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 	 * zeroing is visible to all percpu accesses which can see the
 	 * following __PERCPU_REF_ATOMIC clearing.
 	 */
-	for_each_possible_cpu(cpu)
-		*per_cpu_ptr(percpu_count, cpu) = 0;
-
 	smp_store_release(&ref->percpu_count_ptr,
 			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);
 }
-- 
2.9.5

