Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28614C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2582184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M73vvH9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfAKJS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:18:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42895 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731481AbfAKJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:18:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so6511141plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bDGXNrblFZtK7bw9oWvAOgjAK+XZW8hm/2AA9LBN04=;
        b=M73vvH9oskBDtFhTprrzxcBTl5Pc1Op54bx6Q9UfoQ2JNFvvF4BAx2MdpBbzT14MHv
         91E+VqfcO098IBpmiYZ7+scXh0ZYy31S6lPH3UDAr42xOFA6Q+lhviBNUn76eX9MVVfo
         ytzz+/hSVl9V0xxJwke6nms1cl87sPV/j1pLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5bDGXNrblFZtK7bw9oWvAOgjAK+XZW8hm/2AA9LBN04=;
        b=A7kk/K/mvC8UEfPpQnsEH8zezYIfGAC/fFmOmfFYqcWB2CzbdxCvMD9hfot7h3v/xX
         8mvdashlLCB4bgozNpfA2tFbzNxs1tiGRqgWq6Ifd/G003Vj8C2jxH2DvPDZNDK3dqC+
         EcR2dtc708cWeCGWtFhNvmlNm3DdgxEt13tiMyC1fSKVQtR8VH1ecOqt5n5iOxo20Vyt
         CwmQHia1Yj8/k5jlntEbvU+E4PzMVZmRu5C6JJYAiLEcLny9sa1uCutzf4GNdtpXyUAM
         +SReVQjcaWpFmCFgUaciccRRdQzr9rQeZr1bJjSVWmpEIN7/IGoY3B2COkiuihK1Xe8o
         mb2g==
X-Gm-Message-State: AJcUukcv5n7LDwITIOxOrRvwAQuSSyCKaHOq3NcIG92hLPmJqrKotumy
        Stjrh9+IBzXZ+/KVwLoLrjbGzQ==
X-Google-Smtp-Source: ALg8bN51Jm462KLClI1RWP3YxkFSUx2ujJGDQyQ1R7OfHC+mkNwDRPjKxk8ACXAVKP/a8iErDULyTw==
X-Received: by 2002:a17:902:24e7:: with SMTP id l36mr13941694plg.61.1547198333961;
        Fri, 11 Jan 2019 01:18:53 -0800 (PST)
Received: from localhost ([122.172.34.203])
        by smtp.gmail.com with ESMTPSA id n68sm128916923pfb.62.2019.01.11.01.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 01:18:53 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cpufreq: Implement USER constraint
Date:   Fri, 11 Jan 2019 14:48:36 +0530
Message-Id: <616457a8af14cb152a85e8e3b2b4c2eb54a38e09.1547197612.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
In-Reply-To: <cover.1547197612.git.viresh.kumar@linaro.org>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the FREQ_CONSTRAINT_USER constraint and removes the old
style of doing the same. We just need to update the constraint on any
modifications to scaling_{min|max}_frequency and the freq-constraint
core will call cpufreq's callback which will call cpufreq_set_policy()
eventually.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 62 ++++++++++++++++++-----------------------------
 include/linux/cpufreq.h   |  8 ++----
 2 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 63028612d011..6f66e1261b65 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -685,22 +685,15 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 static ssize_t store_##file_name					\
 (struct cpufreq_policy *policy, const char *buf, size_t count)		\
 {									\
-	int ret, temp;							\
-	struct cpufreq_policy new_policy;				\
+	unsigned long min = policy->min, max = policy->max;		\
+	int ret;							\
 									\
-	memcpy(&new_policy, policy, sizeof(*policy));			\
-	new_policy.min = policy->user_policy.min;			\
-	new_policy.max = policy->user_policy.max;			\
-									\
-	ret = sscanf(buf, "%u", &new_policy.object);			\
+	ret = sscanf(buf, "%lu", &object);				\
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
-	temp = new_policy.object;					\
-	ret = cpufreq_set_policy(policy, &new_policy);		\
-	if (!ret)							\
-		policy->user_policy.object = temp;			\
-									\
+	ret = freq_constraint_update(get_cpu_device(policy->cpu),	\
+				     policy->user_fc, min, max);	\
 	return ret ? ret : count;					\
 }
 
@@ -1164,6 +1157,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	if (!IS_ERR(policy->user_fc))
+		freq_constraint_remove(get_cpu_device(policy->cpu),
+				       policy->user_fc);
 	freq_constraint_remove_cpumask_callback(policy->related_cpus);
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
@@ -1177,9 +1173,6 @@ static void freq_constraint_callback(void *param)
 	struct cpufreq_policy *policy = param;
 	struct cpufreq_policy new_policy = *policy;
 
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
-
 	down_write(&policy->rwsem);
 	if (policy_is_inactive(policy))
 		goto unlock;
@@ -1249,9 +1242,6 @@ static int cpufreq_online(unsigned int cpu)
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
 	if (new_policy) {
-		policy->user_policy.min = policy->min;
-		policy->user_policy.max = policy->max;
-
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j);
@@ -1264,9 +1254,15 @@ static int cpufreq_online(unsigned int cpu)
 			       ret, cpumask_pr_args(policy->cpus));
 			goto out_destroy_policy;
 		}
-	} else {
-		policy->min = policy->user_policy.min;
-		policy->max = policy->user_policy.max;
+
+		policy->user_fc = freq_constraint_add(get_cpu_device(cpu),
+						      FREQ_CONSTRAINT_USER,
+						      policy->min, policy->max);
+		if (IS_ERR(policy->user_fc)) {
+			ret = PTR_ERR(policy->user_fc);
+			pr_err("Failed to add user constraint: %d\n", ret);
+			goto out_destroy_policy;
+		}
 	}
 
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
@@ -2235,13 +2231,6 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	memcpy(&new_policy->cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
 
-	/*
-	* This check works well when we store new min/max freq attributes,
-	* because new_policy is a copy of policy with one field updated.
-	*/
-	if (new_policy->min > new_policy->max)
-		return -EINVAL;
-
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(new_policy);
 	if (ret)
@@ -2251,10 +2240,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	if (ret) {
 		dev_err(cpu_dev, "cpufreq: Failed to get freq-constraints\n");
 	} else {
-		if (fc_min > new_policy->min)
-			new_policy->min = fc_min;
-		if (fc_max < new_policy->max)
-			new_policy->max = fc_max;
+		new_policy->min = fc_min;
+		new_policy->max = fc_max;
 	}
 
 	/*
@@ -2356,8 +2343,6 @@ void cpufreq_update_policy(unsigned int cpu)
 
 	pr_debug("updating policy for CPU %u\n", cpu);
 	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
 
 	/*
 	 * BIOS might change freq behind our back
@@ -2401,10 +2386,11 @@ static int cpufreq_boost_set_sw(int state)
 			break;
 		}
 
-		down_write(&policy->rwsem);
-		policy->user_policy.max = policy->max;
-		cpufreq_governor_limits(policy);
-		up_write(&policy->rwsem);
+		ret = freq_constraint_update(get_cpu_device(policy->cpu),
+					     policy->user_fc, policy->min,
+					     policy->max);
+		if (ret)
+			break;
 	}
 
 	return ret;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c86d6d8bdfed..62bf33aafc6c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/cpumask.h>
 #include <linux/completion.h>
+#include <linux/freq_constraint.h>
 #include <linux/kobject.h>
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
@@ -57,11 +58,6 @@ struct cpufreq_cpuinfo {
 	unsigned int		transition_latency;
 };
 
-struct cpufreq_user_policy {
-	unsigned int		min;    /* in kHz */
-	unsigned int		max;    /* in kHz */
-};
-
 struct cpufreq_policy {
 	/* CPUs sharing clock, require sw coordination */
 	cpumask_var_t		cpus;	/* Online CPUs only */
@@ -91,7 +87,7 @@ struct cpufreq_policy {
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
 
-	struct cpufreq_user_policy user_policy;
+	struct freq_constraint	*user_fc;
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
-- 
2.7.4

