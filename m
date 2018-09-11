Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B0BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFC42086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFC42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIKXEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:04:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44005 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKXEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:04:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8BI3oQb2330617
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Sep 2018 11:03:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8BI3oYh2330614;
        Tue, 11 Sep 2018 11:03:50 -0700
Date:   Tue, 11 Sep 2018 11:03:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-cb92173d1f0474784c6171a9d3fdbbca0ee53554@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org
Reply-To: peterz@infradead.org, mingo@kernel.org,
          torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180911095127.GT24082@hirez.programming.kicks-ass.net>
References: <20180911095127.GT24082@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep, cpu/hotplug: Annotate AP thread
Git-Commit-ID: cb92173d1f0474784c6171a9d3fdbbca0ee53554
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cb92173d1f0474784c6171a9d3fdbbca0ee53554
Gitweb:     https://git.kernel.org/tip/cb92173d1f0474784c6171a9d3fdbbca0ee53554
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 11 Sep 2018 11:51:27 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Sep 2018 20:01:03 +0200

locking/lockdep, cpu/hotplug: Annotate AP thread

Anybody trying to assert the cpu_hotplug_lock is held (lockdep_assert_cpus_held())
from AP callbacks will fail, because the lock is held by the BP.

Stick in an explicit annotation in cpuhp_thread_fun() to make this work.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org
Fixes: cb538267ea1e ("jump_label/lockdep: Assert we hold the hotplug lock for _cpuslocked() operations")
Link: http://lkml.kernel.org/r/20180911095127.GT24082@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/cpu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0097acec1c71..be4859f07153 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -315,6 +315,16 @@ void lockdep_assert_cpus_held(void)
 	percpu_rwsem_assert_held(&cpu_hotplug_lock);
 }
 
+static void lockdep_acquire_cpus_lock(void)
+{
+	rwsem_acquire(&cpu_hotplug_lock.rw_sem.dep_map, 0, 0, _THIS_IP_);
+}
+
+static void lockdep_release_cpus_lock(void)
+{
+	rwsem_release(&cpu_hotplug_lock.rw_sem.dep_map, 1, _THIS_IP_);
+}
+
 /*
  * Wait for currently running CPU hotplug operations to complete (if any) and
  * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
@@ -344,6 +354,17 @@ void cpu_hotplug_enable(void)
 	cpu_maps_update_done();
 }
 EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
+
+#else
+
+static void lockdep_acquire_cpus_lock(void)
+{
+}
+
+static void lockdep_release_cpus_lock(void)
+{
+}
+
 #endif	/* CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_HOTPLUG_SMT
@@ -616,6 +637,12 @@ static void cpuhp_thread_fun(unsigned int cpu)
 	 */
 	smp_mb();
 
+	/*
+	 * The BP holds the hotplug lock, but we're now running on the AP,
+	 * ensure that anybody asserting the lock is held, will actually find
+	 * it so.
+	 */
+	lockdep_acquire_cpus_lock();
 	cpuhp_lock_acquire(bringup);
 
 	if (st->single) {
@@ -661,6 +688,7 @@ static void cpuhp_thread_fun(unsigned int cpu)
 	}
 
 	cpuhp_lock_release(bringup);
+	lockdep_release_cpus_lock();
 
 	if (!st->should_run)
 		complete_ap_thread(st, bringup);
