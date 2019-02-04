Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEA4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2897B2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfBDRJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:09:52 -0500
Received: from foss.arm.com ([217.140.101.70]:58702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbfBDRJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:09:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D24151684;
        Mon,  4 Feb 2019 09:09:48 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 593A23F589;
        Mon,  4 Feb 2019 09:09:47 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will.deacon@arm.com, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, peterz@infradead.org, tglx@linutronix.de,
        bigeasy@linutronix.de
Subject: [PATCH 5/5] perf/arm_dsu: Fix CPU hotplug races
Date:   Mon,  4 Feb 2019 17:09:08 +0000
Message-Id: <d376f6bbd5804616b38145780789785b19a37543.1549299188.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
In-Reply-To: <cover.1549299188.git.robin.murphy@arm.com>
References: <cover.1549299188.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other system PMUs which associate themselves with an arbitrary CPU
for housekeeping purposes, arm_dsu has a race between registering the
hotplug notifier and registering the PMU device, such that the hotplug
niotifier can potentially fire and attempt to migrate the PMU context
before the latter is valid. This is easily resolved by inhibiting
hotplug until both the notifier and PMU device are successfully set up.

For the same reason, also suppress any synchronous notifier calls in the
cleanup path if PMU registration fails.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_dsu_pmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 660cb8ac886a..cfaca06b964a 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -717,7 +717,8 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 
 	dsu_pmu->irq = irq;
 	platform_set_drvdata(pdev, dsu_pmu);
-	rc = cpuhp_state_add_instance(dsu_pmu_cpuhp_state,
+	cpus_read_lock();
+	rc = cpuhp_state_add_instance_cpuslocked(dsu_pmu_cpuhp_state,
 						&dsu_pmu->cpuhp_node);
 	if (rc)
 		return rc;
@@ -738,9 +739,10 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	};
 
 	rc = perf_pmu_register(&dsu_pmu->pmu, name, -1);
+	cpus_read_unlock();
 	if (rc) {
-		cpuhp_state_remove_instance(dsu_pmu_cpuhp_state,
-						 &dsu_pmu->cpuhp_node);
+		cpuhp_state_remove_instance_nocalls(dsu_pmu_cpuhp_state,
+						    &dsu_pmu->cpuhp_node);
 		irq_set_affinity_hint(dsu_pmu->irq, NULL);
 	}
 
-- 
2.20.1.dirty

