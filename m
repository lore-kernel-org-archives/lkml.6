Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBD1ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D566320664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeM+YutB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D566320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeKAIjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbeKAIIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F7D520664;
        Wed, 31 Oct 2018 23:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027303;
        bh=VBXsMqhmxXoiCeVeo9pOALxeXQzW0h+eRtgfqb5gFCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeM+YutB50ZOr2wfhGYCt2Wbpxi4yXQjoJCabhKTBf+KPlYWh+P6UlLAlbtBnUPJn
         lADJPUtXv9IJNblT/FqxNdZksqjW1RrUzNse0+wgVL46jc7DsWThWBMdJphRfKuQ1y
         qI58yvd1Iwo/UTdR0fdgxbGDRAgu1Ia/ZU8/gAbk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 032/126] cpufreq: dt: Try freeing static OPPs only if we have added them
Date:   Wed, 31 Oct 2018 19:06:20 -0400
Message-Id: <20181031230754.29029-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 51c99dd2c06b234575661fa1e0a1dea6c3ef566f ]

We can not call dev_pm_opp_of_cpumask_remove_table() freely anymore
since the latest OPP core updates as that uses reference counting to
free resources. There are cases where no static OPPs are added (using
DT) for a platform and trying to remove the OPP table may end up
decrementing refcount which is already zero and hence generating
warnings.

Lets track if we were able to add static OPPs or not and then only
remove the table based on that. Some reshuffling of code is also done to
do that.

Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq-dt.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 0a9ebf00be46..e58bfcb1169e 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -32,6 +32,7 @@ struct private_data {
 	struct device *cpu_dev;
 	struct thermal_cooling_device *cdev;
 	const char *reg_name;
+	bool have_static_opps;
 };
 
 static struct freq_attr *cpufreq_dt_attr[] = {
@@ -204,6 +205,15 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		}
 	}
 
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out_put_regulator;
+	}
+
+	priv->reg_name = name;
+	priv->opp_table = opp_table;
+
 	/*
 	 * Initialize OPP tables for all policy->cpus. They will be shared by
 	 * all CPUs which have marked their CPUs shared with OPP bindings.
@@ -214,7 +224,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 *
 	 * OPPs might be populated at runtime, don't check for error here
 	 */
-	dev_pm_opp_of_cpumask_add_table(policy->cpus);
+	if (!dev_pm_opp_of_cpumask_add_table(policy->cpus))
+		priv->have_static_opps = true;
 
 	/*
 	 * But we need OPP table to function so if it is not there let's
@@ -240,19 +251,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 				__func__, ret);
 	}
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out_free_opp;
-	}
-
-	priv->reg_name = name;
-	priv->opp_table = opp_table;
-
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
-		goto out_free_priv;
+		goto out_free_opp;
 	}
 
 	priv->cpu_dev = cpu_dev;
@@ -282,10 +284,11 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 out_free_cpufreq_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
-out_free_priv:
-	kfree(priv);
 out_free_opp:
-	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
+	if (priv->have_static_opps)
+		dev_pm_opp_of_cpumask_remove_table(policy->cpus);
+	kfree(priv);
+out_put_regulator:
 	if (name)
 		dev_pm_opp_put_regulators(opp_table);
 out_put_clk:
@@ -300,7 +303,8 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
+	if (priv->have_static_opps)
+		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	if (priv->reg_name)
 		dev_pm_opp_put_regulators(priv->opp_table);
 
-- 
2.17.1

