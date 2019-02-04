Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD729C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAAF2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfBDRJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:09:43 -0500
Received: from foss.arm.com ([217.140.101.70]:58656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfBDRJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:09:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C17A515AB;
        Mon,  4 Feb 2019 09:09:41 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24BF13F589;
        Mon,  4 Feb 2019 09:09:40 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will.deacon@arm.com, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, peterz@infradead.org, tglx@linutronix.de,
        bigeasy@linutronix.de, "Li, Meng" <Meng.Li@windriver.com>
Subject: [PATCH 1/5] perf/arm-cci: Fix CPU hotplug race avoidance
Date:   Mon,  4 Feb 2019 17:09:04 +0000
Message-Id: <606ff8c3f7f35ccdcb4b52a49f692fb20e27359c.1549299188.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
In-Reply-To: <cover.1549299188.git.robin.murphy@arm.com>
References: <cover.1549299188.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm-cci probe logic faces a cyclic dependency wherein it has to pick
a valid CPU to associate with before registering the PMU device, has to
have the PMU state initialised before handling hotplug events in case it
must be migrated, but has to have the hotplug notifier registered before
the chosen CPU may go offline lest things get out of sync. The present
code has tried to solve the races by using get_cpu() to pick the current
CPU and prevent it from disappearing while the other two registrations
are performed, but that results in taking mutexes with preemption
disabled, which makes certain configurations very unhappy:

[ 1.983337] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:2004
[ 1.983340] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
[ 1.983342] Preemption disabled at:
[ 1.983353] [<ffffff80089801f4>] cci_pmu_probe+0x1dc/0x488
[ 1.983360] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.20-rt8-yocto-preempt-rt #1
[ 1.983362] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
[ 1.983364] Call trace:
[ 1.983369] dump_backtrace+0x0/0x158
[ 1.983372] show_stack+0x24/0x30
[ 1.983378] dump_stack+0x80/0xa4
[ 1.983383] ___might_sleep+0x138/0x160
[ 1.983386] __might_sleep+0x58/0x90
[ 1.983391] __rt_mutex_lock_state+0x30/0xc0
[ 1.983395] _mutex_lock+0x24/0x30
[ 1.983400] perf_pmu_register+0x2c/0x388
[ 1.983404] cci_pmu_probe+0x2bc/0x488
[ 1.983409] platform_drv_probe+0x58/0xa8

However, we don't actually mind being preempted or migrated at this
point; all that really matters is that whichever CPU we pick does not
get offlined before we're done. Thus, do the robust thing and instead
take the lock to inhibit CPU hotplug for the duration. This also
revealed an additional race in assigning the global pointer too late
relative to the hotplug notifier, so that gets fixed in the process.

Reported-by: "Li, Meng" <Meng.Li@windriver.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cci.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 1bfeb160c5b1..f6d9df07ec9b 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1692,21 +1692,23 @@ static int cci_pmu_probe(struct platform_device *pdev)
 	raw_spin_lock_init(&cci_pmu->hw_events.pmu_lock);
 	mutex_init(&cci_pmu->reserve_mutex);
 	atomic_set(&cci_pmu->active_events, 0);
-	cci_pmu->cpu = get_cpu();
+
+	cpus_read_lock();
+	cci_pmu->cpu = smp_processor_id();
 
 	ret = cci_pmu_init(cci_pmu, pdev);
-	if (ret) {
-		put_cpu();
-		return ret;
-	}
+	if (ret)
+		goto out;
 
-	cpuhp_setup_state_nocalls(CPUHP_AP_PERF_ARM_CCI_ONLINE,
-				  "perf/arm/cci:online", NULL,
-				  cci_pmu_offline_cpu);
-	put_cpu();
 	g_cci_pmu = cci_pmu;
+	cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_PERF_ARM_CCI_ONLINE,
+					     "perf/arm/cci:online", NULL,
+					     cci_pmu_offline_cpu);
+
 	pr_info("ARM %s PMU driver probed", cci_pmu->model->name);
-	return 0;
+out:
+	cpus_read_unlock();
+	return ret;
 }
 
 static int cci_pmu_remove(struct platform_device *pdev)
-- 
2.20.1.dirty

