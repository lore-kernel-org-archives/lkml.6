Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F41C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59C72098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFb74++5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59C72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJDLIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:08:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34868 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeJDLIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:08:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so2721311pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 21:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+O/nJKlKvJKvAgRGQDY3iXasacOdOlADyrAzR7qH0as=;
        b=gFb74++5sBSXBRKyRh9zoskCFGBN0c5YX2PiIweIlXc2TjGMH/aoj3Zq2ALHwLEN4P
         GypB9imQMIOXMANH/NQNTTVSW5n+Ht9OUqCviu1QCl2IBYjRSR5hyMc/rGCRChly8OVX
         tg5KcI9qNsaAHsoKMhlR+1gM2aq1ONfI2SmPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+O/nJKlKvJKvAgRGQDY3iXasacOdOlADyrAzR7qH0as=;
        b=J2uwyLTL/wj8s/jaKjkiQZ9FXXDQBJYLwi1c+TdQwoRjFBwugSuHuF8gwllfkQ876u
         atZsnRq1o2WXJjIGVIiFwBMSE2WXE7+sRUdc4u8OvStHjn2T27aP4WTGTyUQrOB7UaWi
         eQOGxAV/dP69O3JNe8Wmjy0Niw/0kUYGyb/WKyKQh6OB7QD1PNqiSPPO72nef8w/L9ID
         34DbUvmDBHdYx/upj5XeCiLtwleYJxdPsxg/g0jjaT+W90fV2o0OJglMa5Lb+VGuy/Pa
         MDDueoC5vhnAOqji3FNRtF9Y3a3eJgOWqhGvZS3acfzbSm3Vl/PwKpknuBQaf1JgD4C1
         udtA==
X-Gm-Message-State: ABuFfojzVnvU/NbjuvjHbdbt4mvuEohFodU7GPcXF4eYTex3yTY/a/Qw
        L8vVkixTBMzB7a2mqhTmb/KV/+8f7Oc=
X-Google-Smtp-Source: ACcGV62Grsjuncah17DCZdmPJZgNGigTuyQMCazo9zdB5vTXKiEF81Jjva8yihTkP1vVzqrH9Ovneg==
X-Received: by 2002:a63:65c7:: with SMTP id z190-v6mr4054400pgb.146.1538626611807;
        Wed, 03 Oct 2018 21:16:51 -0700 (PDT)
Received: from localhost ([122.172.76.11])
        by smtp.gmail.com with ESMTPSA id c79-v6sm5304901pfc.92.2018.10.03.21.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 21:16:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        niklas.cassel@linaro.org, d-gerlach@ti.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] cpufreq: dt: Try freeing static OPPs only if we have added them
Date:   Thu,  4 Oct 2018 09:46:22 +0530
Message-Id: <51c99dd2c06b234575661fa1e0a1dea6c3ef566f.1538625101.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1538625101.git.viresh.kumar@linaro.org>
References: <cover.1538625101.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.18.0.rc1.242.g61856ae69a2c

