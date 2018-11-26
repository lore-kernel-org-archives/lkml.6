Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E59C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F7B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K90cOgBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F7B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeKZTh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:37:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33395 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeKZTh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:37:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so12285487wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=He3pqGo+A5MVuYP3nfDqw4JkRlqG2IIP4aWgZQSIRFM=;
        b=K90cOgBQAPar+TCdDVEU4wOtnfYpzEitFO8EccUFV2G5w8dZvaY4eGF2Z1Csvun9VP
         CLwZoD8BaIrdLRSrplDK9o+WLMwp1WdRXI6z4dfplsYQSxuywDR7TJfzltkHI6GBi6AB
         KHMyM2sqXvcyujvKfa01AlX2+uzFfXgMp12a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=He3pqGo+A5MVuYP3nfDqw4JkRlqG2IIP4aWgZQSIRFM=;
        b=fea1C0B8c1IJQkK1j6B6WlEfX2JkLIDKw0CCQceVrZ9gfX+644smljZtVPUJt5CEgM
         V4EIU4rWXynDP0DJloJDf+ZVWSFVr5hNhzbtRes/+i6yqBNtuoXoPiygTqiS9vi0EJpw
         3ui6NLy0GmTg3dxCNlgD6yIIJO0Vb5HQO6fzGbDOM7Ap28hu/WGZWDg35irQNFOzXGGu
         GnBE+p2f8orYI8wIQC++wlCzAeeD7Q+JSfrJr/sufa0JuT1YByoDwLtRjdz+3MgUeVvu
         9cRWPBaXPI/15Mux7t7UZInrdiMLx0MdKE1TZsFotaPvhgLfs0VHUmKOzVXprld+kL/S
         XBww==
X-Gm-Message-State: AA+aEWaR4B1emWDZgxg3eRValyJRrJNGah6cfgWv8Dz0VqEH6K5rFUhT
        Axpjm+O1wfRK1EWbPlysvAhRsg==
X-Google-Smtp-Source: AFSGD/VXqQ3MHEbKPUaWDca/yLfibVXjgYrSRhj++xV5liCzpOvZQruzNBmUADJZiUFLJuUPi+Mc0w==
X-Received: by 2002:adf:fd50:: with SMTP id h16mr19200808wrs.228.1543221872362;
        Mon, 26 Nov 2018 00:44:32 -0800 (PST)
Received: from localhost.localdomain (72.224.136.77.rev.sfr.net. [77.136.224.72])
        by smtp.gmail.com with ESMTPSA id a204sm98009wmh.23.2018.11.26.00.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 00:44:31 -0800 (PST)
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
Subject: [PATCH V3 1/2] base/drivers/arch_topology: Replace mutex with READ_ONCE / WRITE_ONCE
Date:   Mon, 26 Nov 2018 09:44:20 +0100
Message-Id: <1543221866-19671-1-git-send-email-daniel.lezcano@linaro.org>
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

