Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85565C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F1C218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbeLSSYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:24:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbeLSSYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:24:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F72F15BE;
        Wed, 19 Dec 2018 10:24:12 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 716353F59C;
        Wed, 19 Dec 2018 10:24:10 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     cai@gmx.us, daniel.lezcano@linaro.org,
        linux-arm-kernel@lists.infradead.org, longman@redhat.com,
        marc.zyngier@arm.com, mark.rutland@arm.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, dietmar.eggemann@arm.com
Subject: [PATCH 2/2] Revert "sched/core: Take the hotplug lock in sched_init_smp()"
Date:   Wed, 19 Dec 2018 18:23:16 +0000
Message-Id: <1545243796-23224-3-git-send-email-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
References: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 40fa3780bac2b654edf23f6b13f4e2dd550aea10.

Now that we have a system-wide muting of hotplug lockdep during init,
this is no longer needed.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e4ca15d..144b778 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5854,14 +5854,11 @@ void __init sched_init_smp(void)
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
-	 * happen. The hotplug lock is nevertheless taken to satisfy lockdep,
-	 * but there won't be any contention on it.
+	 * happen.
 	 */
-	cpus_read_lock();
 	mutex_lock(&sched_domains_mutex);
 	sched_init_domains(cpu_active_mask);
 	mutex_unlock(&sched_domains_mutex);
-	cpus_read_unlock();
 
 	/* Move init over to a non-isolated CPU */
 	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
--
2.7.4

