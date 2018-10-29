Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E11C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1372084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3oAfEOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1372084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeJ3BNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:13:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38114 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbeJ3BNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:13:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so9384639wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xF7JxkKvdHK/anNbLW0P/RgEA6x91dDlC16uGRsXEpA=;
        b=I3oAfEOwOHRbCq+1bEpOrnF5NMYcJDSEE7M8MADPyMAICoYRO2BM1rjUeHmo920khB
         ATeS1j1vfRprif6Ph3vekUkcxzeGVgu1w461KLQ18IcpJqjV5EJ7SirEMuEja8/oAWd0
         55TMbF5vQdelAR5s+HcQTn9Yp3TyFiJocWQTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xF7JxkKvdHK/anNbLW0P/RgEA6x91dDlC16uGRsXEpA=;
        b=ArEHtBXUpcECHX3AayC+g/k2L6wSylSRJX2Ic2+lOkxjX/x9ame5lB2RDJtE2y+BCJ
         zXCdl/qF1B3gxxGCx7md655Kidr3WohxPjv9PawU0U2K3z71UpgGqxzgdiaq7z/kVoT6
         91qVi7aSY6DTxJePRCMLAv0sm90wam1vJ62lh7oK0g3/MSnpDXJo6ZXcJwdxedHYSCsz
         1XzS2VgUNH5/a/f0Pa3y79mM/NWEgZ1uzLJn/9XECXYfvwXofCqBEhbKCgO3/gltdtI2
         2vAreYZ0ast6AWZdzwelMRnOI6PGVj8IcTTcRUUcHms8g4N0YxL4HBJS9QpwuuU11Bpu
         q/7g==
X-Gm-Message-State: AGRZ1gL/k1k6+SMXHw4MXv1vVGgnfntuQC1aurH4rVMjMOYY8k6rMupl
        Q+tBLYSDDrGRy+i032+THUNBQw==
X-Google-Smtp-Source: AJdET5e7aqLy57T9i6Px1ctMYS/Y2f/kB4M6WzNPrGCLTIk2HyFi1w9znMOfDjRXK/a6sNX63tdh6Q==
X-Received: by 2002:adf:8281:: with SMTP id 1-v6mr15560623wrc.252.1540830228052;
        Mon, 29 Oct 2018 09:23:48 -0700 (PDT)
Received: from localhost.localdomain (137.55.88.92.rev.sfr.net. [92.88.55.137])
        by smtp.gmail.com with ESMTPSA id y19-v6sm28150499wra.60.2018.10.29.09.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Oct 2018 09:23:47 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 2/4] base/drivers/arch_topology: Replace mutex with READ_ONCE / WRITE_ONCE
Date:   Mon, 29 Oct 2018 17:23:18 +0100
Message-Id: <1540830201-2947-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
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
---
 drivers/base/arch_topology.c  | 7 +------
 include/linux/arch_topology.h | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 204ed10..b19d6d4 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -30,12 +30,11 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
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
@@ -67,10 +66,8 @@ static ssize_t cpu_capacity_store(struct device *dev,
 	if (new_capacity > SCHED_CAPACITY_SCALE)
 		return -EINVAL;
 
-	mutex_lock(&cpu_scale_mutex);
 	for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
 		topology_set_cpu_scale(i, new_capacity);
-	mutex_unlock(&cpu_scale_mutex);
 
 	return count;
 }
@@ -116,7 +113,6 @@ void topology_normalize_cpu_scale(void)
 		return;
 
 	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
-	mutex_lock(&cpu_scale_mutex);
 	for_each_possible_cpu(cpu) {
 		pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
 			 cpu, raw_capacity[cpu]);
@@ -126,7 +122,6 @@ void topology_normalize_cpu_scale(void)
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
 			cpu, topology_get_cpu_scale(NULL, cpu));
 	}
-	mutex_unlock(&cpu_scale_mutex);
 }
 
 bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 2b70941..7c0aaa9 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -19,7 +19,7 @@ struct sched_domain;
 static inline
 unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
 {
-	return per_cpu(cpu_scale, cpu);
+	return READ_ONCE(per_cpu(cpu_scale, cpu));
 }
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
-- 
2.7.4

