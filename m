Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0704C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1AC20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJHirIh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1AC20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbeKLKEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:04:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730472AbeKLIRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:15 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB61A22360;
        Sun, 11 Nov 2018 22:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975240;
        bh=ToYSEaNLrF1nh8CdqspjWx57CRwfv+aShSVOd66QUkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJHirIh4AKeTXCgYVa6yGbS7rX3VBHCS3Y2ZvHtuZ80UZukiuFu7p3CYUyhFM65xe
         5nw4LkqNS51ospxO5SJntpKe/YVE5gJPRgtsJtJ+3CFPhINebj4INpOknbvj0oKX67
         noB1mCf4yVEwD/lLcEbNRnFNaebiMrKD0xB3pF7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 082/361] cpufreq: dt: Try freeing static OPPs only if we have added them
Date:   Sun, 11 Nov 2018 14:17:09 -0800
Message-Id: <20181111221631.455138403@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq-dt.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -32,6 +32,7 @@ struct private_data {
 	struct device *cpu_dev;
 	struct thermal_cooling_device *cdev;
 	const char *reg_name;
+	bool have_static_opps;
 };
 
 static struct freq_attr *cpufreq_dt_attr[] = {
@@ -204,6 +205,15 @@ static int cpufreq_init(struct cpufreq_p
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
@@ -214,7 +224,8 @@ static int cpufreq_init(struct cpufreq_p
 	 *
 	 * OPPs might be populated at runtime, don't check for error here
 	 */
-	dev_pm_opp_of_cpumask_add_table(policy->cpus);
+	if (!dev_pm_opp_of_cpumask_add_table(policy->cpus))
+		priv->have_static_opps = true;
 
 	/*
 	 * But we need OPP table to function so if it is not there let's
@@ -240,19 +251,10 @@ static int cpufreq_init(struct cpufreq_p
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
@@ -282,10 +284,11 @@ static int cpufreq_init(struct cpufreq_p
 
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
@@ -300,7 +303,8 @@ static int cpufreq_exit(struct cpufreq_p
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
+	if (priv->have_static_opps)
+		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	if (priv->reg_name)
 		dev_pm_opp_put_regulators(priv->opp_table);
 


