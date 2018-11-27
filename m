Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7FEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA2021104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDVRI/At"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA2021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeK1AW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:22:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35907 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbeK1AW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:22:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id s11so22252578wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=He3pqGo+A5MVuYP3nfDqw4JkRlqG2IIP4aWgZQSIRFM=;
        b=EDVRI/AthinCP7ldegu7GhnBcZcqO7yh5Mn3mh/GYspg5L/sZFTu6IbwAhFvZnmYBG
         KOaIa9aN3JZzI/XcQe6pw+szL9ncITY0Q754FOQkd433jxv1mN73ZHHQpdc6Mk68yYYL
         uXFYbdRjtRFtl+XK3RTHegc24Uk1+R/rnZl24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=He3pqGo+A5MVuYP3nfDqw4JkRlqG2IIP4aWgZQSIRFM=;
        b=KjpwkqyRa0+4IbwVU8hAllXgsvP0y8iExSoR0IPPlhWrcEu0w8T4HaWolPKo6lJDq7
         SaXwXY8zHOKKjQHHLzVqND4WWhcghf1Imz2++qlwc6tlyAqz6/eiz5ddmN+iEmErgC7O
         02WHyskOrv5pen2doYUYKiToP29aA2vkJObvNn5+G+bJQwVNsuLYmLg62uQnrD+wVvVz
         LeuSEosmzpAKKkjjytKcF5tdOAVOVkoFbGu/iEIZ47xX33nxRcdrnYQ0aaBztdBUQ1M0
         PXPF+OCHvcYu8ZxUj8+2C3xR95CO7K+Hpx+9oV7D8Vxmy5v5VPJck8lfEZbtjPgUoY/w
         MUmw==
X-Gm-Message-State: AA+aEWakBEzOBR4FUV98EE77b9+KYVhYrNiZkIQQrNrj6VpLQvZxPw/o
        Uhf663u4GckVGeAR5Fp9ydTQXQ==
X-Google-Smtp-Source: AJdET5d+E3C4Mj2PApLrgXx8hGTq8PBgcwYHnlJVKbDgZRIf+4ivy80UFk7fvvIYgc1pQbWPKYvgHQ==
X-Received: by 2002:a1c:d912:: with SMTP id q18mr27440497wmg.122.1543325070781;
        Tue, 27 Nov 2018 05:24:30 -0800 (PST)
Received: from localhost.localdomain (179.156.136.77.rev.sfr.net. [77.136.156.179])
        by smtp.gmail.com with ESMTPSA id 80sm6137635wmv.6.2018.11.27.05.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 05:24:30 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH V5 1/2] base/drivers/arch_topology: Replace mutex with READ_ONCE / WRITE_ONCE
Date:   Tue, 27 Nov 2018 14:24:14 +0100
Message-Id: <1543325060-1599-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mutex protects a per_cpu variable access. The potential race can
happen only when the cpufreq governor module is loaded and at the same
time the cpu capacity is changed in the sysfs.

There is no real interest of using a mutex to protect a variable
assignation when there is no situation where a task can take the lock
and block.

Replace the mutex by READ_ONCE / WRITE_ONCE.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c  | 7 +------
 include/linux/arch_topology.h | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index edfcf8d..fd5325b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -31,12 +31,11 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 		per_cpu(freq_scale, i) = scale;
 }
 
-static DEFINE_MUTEX(cpu_scale_mutex);
 DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 {
-	per_cpu(cpu_scale, cpu) = capacity;
+	WRITE_ONCE(per_cpu(cpu_scale, cpu), capacity);
 }
 
 static ssize_t cpu_capacity_show(struct device *dev,
@@ -71,10 +70,8 @@ static ssize_t cpu_capacity_store(struct device *dev,
 	if (new_capacity > SCHED_CAPACITY_SCALE)
 		return -EINVAL;
 
-	mutex_lock(&cpu_scale_mutex);
 	for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
 		topology_set_cpu_scale(i, new_capacity);
-	mutex_unlock(&cpu_scale_mutex);
 
 	schedule_work(&update_topology_flags_work);
 
@@ -141,7 +138,6 @@ void topology_normalize_cpu_scale(void)
 		return;
 
 	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
-	mutex_lock(&cpu_scale_mutex);
 	for_each_possible_cpu(cpu) {
 		pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
 			 cpu, raw_capacity[cpu]);
@@ -151,7 +147,6 @@ void topology_normalize_cpu_scale(void)
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
 			cpu, topology_get_cpu_scale(NULL, cpu));
 	}
-	mutex_unlock(&cpu_scale_mutex);
 }
 
 bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index d9bdc1a..12c439f 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -20,7 +20,7 @@ struct sched_domain;
 static inline
 unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
 {
-	return per_cpu(cpu_scale, cpu);
+	return READ_ONCE(per_cpu(cpu_scale, cpu));
 }
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
-- 
2.7.4

