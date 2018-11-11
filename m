Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72FEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DC22087C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DC22087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeKKR7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 12:59:20 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49419 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeKKR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 12:59:02 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gLkpo-000734-4Q; Sun, 11 Nov 2018 09:11:08 +0100
Subject: [GIT pull] scheduler fixes for 4.20
Message-ID: <154192381794.5458.16318183442023794568.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <154192381794.5458.5498732290895334242.tglx@nanos.tec.linutronix.de>
Date:   Sun, 11 Nov 2018 09:11:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

Two small scheduler fixes:

  - Take hotplug lock in sched_init_smp(). Technically not really required,
    but lockdep will complain other.

  - Trivial comment fix in sched/fair


Thanks,

	tglx

------------------>
Valentin Schneider (1):
      sched/core: Take the hotplug lock in sched_init_smp()

Yi Wang (1):
      sched/fair: Fix a comment in task_numa_fault()


 kernel/sched/core.c | 5 ++++-
 kernel/sched/fair.c | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fd2fce8a001b..02a20ef196a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5859,11 +5859,14 @@ void __init sched_init_smp(void)
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
-	 * happen.
+	 * happen. The hotplug lock is nevertheless taken to satisfy lockdep,
+	 * but there won't be any contention on it.
 	 */
+	cpus_read_lock();
 	mutex_lock(&sched_domains_mutex);
 	sched_init_domains(cpu_active_mask);
 	mutex_unlock(&sched_domains_mutex);
+	cpus_read_unlock();
 
 	/* Move init over to a non-isolated CPU */
 	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee271bb661cc..3648d0300fdf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2400,8 +2400,8 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 		local = 1;
 
 	/*
-	 * Retry task to preferred node migration periodically, in case it
-	 * case it previously failed, or the scheduler moved us.
+	 * Retry to migrate task to preferred node periodically, in case it
+	 * previously failed, or the scheduler moved us.
 	 */
 	if (time_after(jiffies, p->numa_migrate_retry)) {
 		task_numa_placement(p);

