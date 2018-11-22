Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5457C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C59420685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwmPuv9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C59420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395128AbeKVXQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:16:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51893 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbeKVXQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:16:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id j207so1698494wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 04:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=niIh/rHDS6XLBwNgmCyNlCdvUUAHmIubbZxX7Az/O64=;
        b=WwmPuv9g4PorfDCvI5jsXyuLGrtsAG27OYDQ71YU8bYQvImun65BIzFvg1H3eoZbl4
         JlkKuOxq1mznxojRI/lfKgL4H6FZGGIy3v12ZwfX5/s7vgF2dLrrgAA8a2ZXVY7dMa+b
         TQAXwC3DmwL7CwmEfesLEDHJrUa70/CGIMdqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=niIh/rHDS6XLBwNgmCyNlCdvUUAHmIubbZxX7Az/O64=;
        b=Hu8Afprvp/CmxRq1n0hNNu+sczb47emZNclPivvxeBti1gFmeGkUWBWbRHFXvXz2IA
         g22FWdLEu9YLSlB+8VixfDzDPJO1mBz0qPJH4bvPty/E/10fIc8o5fdhvQYzf2wvIX0E
         n9IUChJ5mMA6duEkU48W8pA+cHS33nqlCGljzjJ23wCRXyW2K9iRDBh6Y/MHPvCZKjyB
         d0lpxuAUHTnZiYHQJm0n78QtTtIkufOx5BOuPH0UskofErQ8xbkhP+HAPXBrdPW+2oVG
         ZchfSdiKYKSVl8zQhRkb59blXgGjtrm2Y/D3n9cWvEifPCfpEEb6YmV8t90b3LvWop0E
         dRng==
X-Gm-Message-State: AGRZ1gI++Og2YUNy9l+IOQkTQwMQJZAscvTSA5Q1/d8JuOuJqunNmWG1
        35af4S31byl3IrilsXvISN7NzA==
X-Google-Smtp-Source: AJdET5erliRNZrLwgjDHKo73mnPiiTJd4dwJTCdTA3yYj8Bl/fB1+xTW+QRvVuahVYOBstuL9GwHMA==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr10101732wmf.143.1542890225158;
        Thu, 22 Nov 2018 04:37:05 -0800 (PST)
Received: from localhost.localdomain (189.35.136.77.rev.sfr.net. [77.136.35.189])
        by smtp.gmail.com with ESMTPSA id x8sm12376840wrd.53.2018.11.22.04.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Nov 2018 04:37:04 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCH V2 1/2] base/drivers/arch_topology: Replace mutex with READ_ONCE / WRITE_ONCE
Date:   Thu, 22 Nov 2018 13:36:44 +0100
Message-Id: <1542890209-3263-1-git-send-email-daniel.lezcano@linaro.org>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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

