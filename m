Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60E4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A1120872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FwbyUPAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfAKJSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:18:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40416 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731471AbfAKJSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:18:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so6692470pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+6233nv3v674fm7wJsKedOHZKQamoc11CkEUfZqX4M=;
        b=FwbyUPAUmpqC61yhz0XF4E2qHvR6Cdtuq/oGJ6LEvdual17YNidGP089pNN1OcdGhB
         K05rSCSYooEGkbYa2eWcYEC4of3smANzkOk9dYUA39f0+kWNsLPoBn5TzATaGfBnDcQ5
         2opZHEx2LKv75FUC2Th8/jZWQHps3KQfSci3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+6233nv3v674fm7wJsKedOHZKQamoc11CkEUfZqX4M=;
        b=tVUAlWmoGp8G9zYPciF/pfbKk0qwBk2aSCRfFyY7yfkzJXVJijsrKeVmhVmu3XoC0Q
         qknA5EDr1eDNfVUnI1ycaUD05jWrzyXWW7MWDpOxNwAua+BT06H9cNKcUjOQ8dIw3dnY
         zJlfHqU0VlVECA/IRvp55cs6gjrVcu1XLihqJZoGqV3Pdf8enwQWTdhHxzVoTLjynKMg
         KGyABqjcHpgehG8GpaL4SYTOUzNtoXNSyGoWgX3sj69AvW1cWkBi+/C4hZcNu57wwOr3
         3Wxrvegpzye0P/6gK22PclZoK0fgANVOW8GkaHV/6xgripTX3ZzUb6jIJGAk8+llsUrn
         ikMg==
X-Gm-Message-State: AJcUukdnxzXTZoortN8Y0BPS4jm1Qud9iX3ADVJFTeiQ4OP+FJKnqA+M
        RUCAtJ2hQVlHPj2xeKR4dYT34w==
X-Google-Smtp-Source: ALg8bN5WfTu3w+J6eiEzwSJaIdJ51KHJgn/ntyMyXIV5Hlo8HFOB3p6k07tHMrfNsyI8L30JvtVedw==
X-Received: by 2002:a63:86c1:: with SMTP id x184mr10318302pgd.305.1547198330528;
        Fri, 11 Jan 2019 01:18:50 -0800 (PST)
Received: from localhost ([122.172.34.203])
        by smtp.gmail.com with ESMTPSA id h134sm158868104pfe.27.2019.01.11.01.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 01:18:49 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cpufreq: Implement freq-constraint callback
Date:   Fri, 11 Jan 2019 14:48:35 +0530
Message-Id: <d6dad7a600a528665eaf309ab2182bc7b5e8060c.1547197612.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
In-Reply-To: <cover.1547197612.git.viresh.kumar@linaro.org>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the frequency constraint callback and registers it with
the freq-constraint framework whenever a policy is created. On policy
removal the callback is unregistered.

The constraints are also taken into consideration in
cpufreq_set_policy().

No constraints are added until now though.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig   |  1 +
 drivers/cpufreq/cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 608af20a3494..2c2842cf2734 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -2,6 +2,7 @@ menu "CPU Frequency scaling"
 
 config CPU_FREQ
 	bool "CPU Frequency scaling"
+	select DEVICE_FREQ_CONSTRAINT
 	select SRCU
 	help
 	  CPU Frequency scaling allows you to change the clock speed of 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a8fa684f5f90..63028612d011 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -21,6 +21,7 @@
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/freq_constraint.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
@@ -1163,6 +1164,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	freq_constraint_remove_cpumask_callback(policy->related_cpus);
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
@@ -1170,6 +1172,24 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	kfree(policy);
 }
 
+static void freq_constraint_callback(void *param)
+{
+	struct cpufreq_policy *policy = param;
+	struct cpufreq_policy new_policy = *policy;
+
+	new_policy.min = policy->user_policy.min;
+	new_policy.max = policy->user_policy.max;
+
+	down_write(&policy->rwsem);
+	if (policy_is_inactive(policy))
+		goto unlock;
+
+	cpufreq_set_policy(policy, &new_policy);
+
+unlock:
+	up_write(&policy->rwsem);
+}
+
 static int cpufreq_online(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
@@ -1236,6 +1256,14 @@ static int cpufreq_online(unsigned int cpu)
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j);
 		}
+
+		ret = freq_constraint_set_cpumask_callback(policy->related_cpus,
+					freq_constraint_callback, policy);
+		if (ret) {
+			pr_err("Failed to set freq-constraints: %d (%*pbl)\n",
+			       ret, cpumask_pr_args(policy->cpus));
+			goto out_destroy_policy;
+		}
 	} else {
 		policy->min = policy->user_policy.min;
 		policy->max = policy->user_policy.max;
@@ -2198,6 +2226,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 				struct cpufreq_policy *new_policy)
 {
 	struct cpufreq_governor *old_gov;
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+	unsigned long fc_min, fc_max;
 	int ret;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
@@ -2217,6 +2247,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
+	ret = freq_constraints_get(cpu_dev, &fc_min, &fc_max);
+	if (ret) {
+		dev_err(cpu_dev, "cpufreq: Failed to get freq-constraints\n");
+	} else {
+		if (fc_min > new_policy->min)
+			new_policy->min = fc_min;
+		if (fc_max < new_policy->max)
+			new_policy->max = fc_max;
+	}
+
+	/*
+	 * The notifier-chain shall be removed once all the users of
+	 * CPUFREQ_ADJUST are moved to use the freq-constraints.
+	 */
 	/* adjust if necessary - all reasons */
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 			CPUFREQ_ADJUST, new_policy);
-- 
2.7.4

