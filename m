Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EADBC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2488A20858
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ER4xWmIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2488A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeJIXnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:43:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44785 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJIXnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:43:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id c56-v6so2271565qtd.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GRe242656I2kSmkisEDP4QURqPrSR1lR6wXda3PHx2M=;
        b=ER4xWmIGGf0H2vl9y2Fj4owD1BLyf9jZ95fW+MYRK+nMMVlkbQWwdinhRQcjqR5zxn
         PykedBVvjECgPpObatTrDWTvAFhWZwEnfot/r1pOdP7ivf04iIYooC4YU3fO2I0jg7eT
         F1bCoLNJysWM98qBP8HpCLP3hZcnodWcJAFb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GRe242656I2kSmkisEDP4QURqPrSR1lR6wXda3PHx2M=;
        b=EXf1wEa56NdpLBRcpz9IxszTmfuD+7GvRPmV/4a5B590Mc/NH3ZlhSY/ZcAvK1gHGP
         fjen6SneXh9xYReFFahRVZGm4Y2i+PTndx4yodoqUe77IScd3TAAgyy2/jglo3QIvAl4
         p5YHTYPuWqlYPfdEnujefq4UZDez8zC4vb4T5/3pW2XYegVeFE1tLPOUWU9RDe5eoBQv
         oCGePH2xOfEEKmuOToI3SrwTvbSEPx+2rG8dnjk6A5xaYnRQYYuCpKNFHA4lhk9Wn3vv
         aUsMNqvgUZQlhGXv3iE60gAVOY6uADxTcD/1DQtjEhIHnttANSzXKVwg3SG3ZvlCsPW+
         3grA==
X-Gm-Message-State: ABuFfog9k+ARRMTfQCINHjQYSaQ+VkthlA9W7NMQV0sdea5jz9N0J9q3
        9stCre/qHmJsYW6x9aGWV1uuxPQD32WVpA==
X-Google-Smtp-Source: ACcGV60Llln9ZCWafJEK6fMBK1Nqy3RYsHyDNkTUKBi8WhMBLN3UN0uL+/DEIuwtndugvjZNB4QhdQ==
X-Received: by 2002:ac8:b0d:: with SMTP id e13-v6mr742910qti.375.1539102317526;
        Tue, 09 Oct 2018 09:25:17 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm10441169qkc.67.2018.10.09.09.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 09:25:16 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
Subject: [RFC PATCH 7/7] thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
Date:   Tue,  9 Oct 2018 12:25:02 -0400
Message-Id: <1539102302-9057-8-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal governors can request for a cpu's maximum supported frequency
to be capped in case of an overheat event. This in turn means that the
maximum capacity available for tasks to run on the particular cpu is
reduced. Delta between the original maximum capacity and capped
maximum capacity is known as thermal pressure. Enable cpufreq cooling
device to update the thermal pressure in event of a capped
maximum frequency.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfd2324..da8de66 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
+#include <linux/sched/topology.h>
 
 #include <trace/events/thermal.h>
 
@@ -132,6 +133,21 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 }
 
 /**
+ * cpufreq_update_sched_max_capacity - update scheduler about change in cpu
+ *					max frequency.
+ * @policy - cpufreq policy whose max frequency is capped.
+ */
+static void cpufreq_update_sched_max_capacity(struct cpufreq_policy *policy)
+{
+	int cpu;
+	unsigned long capacity = (policy->max << SCHED_CAPACITY_SHIFT) /
+					policy->cpuinfo.max_freq;
+
+	for_each_cpu(cpu, policy->cpus)
+		update_maxcap_capacity(cpu, capacity);
+}
+
+/**
  * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
  * @nb:	struct notifier_block * with callback info.
  * @event: value showing cpufreq event for which this function invoked.
@@ -175,8 +191,10 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 		 */
 		clipped_freq = cpufreq_cdev->clipped_freq;
 
-		if (policy->max > clipped_freq)
+		if (policy->max > clipped_freq) {
 			cpufreq_verify_within_limits(policy, 0, clipped_freq);
+			cpufreq_update_sched_max_capacity(policy);
+		}
 		break;
 	}
 	mutex_unlock(&cooling_list_lock);
-- 
2.1.4

