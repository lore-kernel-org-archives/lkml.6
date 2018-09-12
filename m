Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31204C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51C020880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8CurDyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51C020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeILNdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:33:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46470 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbeILNdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:33:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so633447pfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=72mpelPluGWAZTfEgSG4c7FeAVh+FKHnEDbIa+aT9Iw=;
        b=W8CurDyOSrdu5Jx55Z7SyRskyd+RGAImYa7B4muSn4jkcvv/8dyq2/iLjdDRXirr3f
         mncOA7TdK+pZHUzFLVmL+lMPofjUuhUOZIiHpxxvHbU8tJkMWjRs/7xvnmVjiymH+A+2
         GvnDmN6eTcRmZ4tFyMDfOVdtX3aws/sPgEqbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=72mpelPluGWAZTfEgSG4c7FeAVh+FKHnEDbIa+aT9Iw=;
        b=M67fULgcwMhFDk2tyqj3UtA05ahOGt1oP+EQYaZfldSbtuO/AFyIuEfY/Ei2D4NU8c
         NFvCM5y9ihOpQTKNtmDG/cNVu6TNcUU7obySN4WdMa0Uv9uFB3n7HUz/QZnyowfcEJc4
         aHAJ7NYOuM3F36qu6m9otG6afq9Y5zjzjfVA5rS4rXU1alV03OSU54x7WL0XmyGiTTP0
         UQfv/rouMO1nhW7idPz+uo+yRmNAYJHsV44juF/tgEGuAypWyk/W3+ftvWeJLz7rOzKC
         QJfKjsNOdOOmMjFwa46vGmwJJ0tRDpYXc83V8F7H0bX23qD24SPygmUBIJzJTiwG2+/Z
         lJ+g==
X-Gm-Message-State: APzg51CduxCesfyfzUfj3lID45hR9gWkVFrus8hhU/cPvTdiBoBD5hoR
        rDLaGjdL9Fb2JowIZlyQhsVrBg==
X-Google-Smtp-Source: ANB0Vda81SzWizVJt4PMbp/pS2AYE+Hr4fBla+4gguu45omIYr/9az8x2N3EKmLdQqQ04IAX6/gTow==
X-Received: by 2002:a65:560a:: with SMTP id l10-v6mr919201pgs.130.1536741012097;
        Wed, 12 Sep 2018 01:30:12 -0700 (PDT)
Received: from localhost ([122.171.64.45])
        by smtp.gmail.com with ESMTPSA id u9-v6sm729814pfi.104.2018.09.12.01.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:30:11 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()
Date:   Wed, 12 Sep 2018 13:58:47 +0530
Message-Id: <4d433fbb463a5a66a5576e37173dac9a55f48b82.1536736872.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only one platform was depending on this feature and it is already
updated now. Stop removing dynamic OPPs from _dev_pm_opp_remove_table().
This simplifies lot of paths and removes unnecessary parameters.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 20 +++++---------------
 drivers/opp/cpu.c  |  9 +++------
 drivers/opp/of.c   | 10 +++++-----
 drivers/opp/opp.h  |  6 +++---
 4 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b555121b878b..2319ad4a0177 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1759,14 +1759,10 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
 EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
 
 /*
- * Free OPPs either created using static entries present in DT or even the
- * dynamically added entries based on remove_all param.
+ * Free OPPs either created using static entries present in DT.
  */
-void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
-			      bool remove_all)
+void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev)
 {
-	struct dev_pm_opp *opp, *tmp;
-
 	/* Protect dev_list */
 	mutex_lock(&opp_table->lock);
 
@@ -1775,12 +1771,6 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
 		/* Free static OPPs */
 		_put_opp_list_kref(opp_table);
 
-		/* Free dynamic OPPs */
-		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
-			if (remove_all)
-				dev_pm_opp_put(opp);
-		}
-
 		/*
 		 * The OPP table is getting removed, drop the performance state
 		 * constraints.
@@ -1795,7 +1785,7 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
 	mutex_unlock(&opp_table->lock);
 }
 
-void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
+void _dev_pm_opp_find_and_remove_table(struct device *dev)
 {
 	struct opp_table *opp_table;
 
@@ -1812,7 +1802,7 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
 		return;
 	}
 
-	_dev_pm_opp_remove_table(opp_table, dev, remove_all);
+	_dev_pm_opp_remove_table(opp_table, dev);
 
 	dev_pm_opp_put_opp_table(opp_table);
 }
@@ -1826,6 +1816,6 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
  */
 void dev_pm_opp_remove_table(struct device *dev)
 {
-	_dev_pm_opp_find_and_remove_table(dev, true);
+	_dev_pm_opp_find_and_remove_table(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 2868a022a040..2d4505ea34d2 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -108,7 +108,7 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -123,10 +123,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
 			continue;
 		}
 
-		if (of)
-			dev_pm_opp_of_remove_table(cpu_dev);
-		else
-			dev_pm_opp_remove_table(cpu_dev);
+		_dev_pm_opp_find_and_remove_table(cpu_dev);
 	}
 }
 
@@ -140,7 +137,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
  */
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask)
 {
-	_dev_pm_opp_cpumask_remove_table(cpumask, false);
+	_dev_pm_opp_cpumask_remove_table(cpumask);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 892d17069f05..9c98682af374 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -279,7 +279,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
  */
 void dev_pm_opp_of_remove_table(struct device *dev)
 {
-	_dev_pm_opp_find_and_remove_table(dev, false);
+	_dev_pm_opp_find_and_remove_table(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
@@ -432,7 +432,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
-			_dev_pm_opp_remove_table(opp_table, dev, false);
+			_dev_pm_opp_remove_table(opp_table, dev);
 			of_node_put(np);
 			goto put_opp_table;
 		}
@@ -453,7 +453,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
 		ret = -ENOENT;
-		_dev_pm_opp_remove_table(opp_table, dev, false);
+		_dev_pm_opp_remove_table(opp_table, dev);
 		goto put_opp_table;
 	}
 
@@ -507,7 +507,7 @@ static int _of_add_opp_table_v1(struct device *dev)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
-			_dev_pm_opp_remove_table(opp_table, dev, false);
+			_dev_pm_opp_remove_table(opp_table, dev);
 			break;
 		}
 		nr -= 2;
@@ -618,7 +618,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
  */
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
 {
-	_dev_pm_opp_cpumask_remove_table(cpumask, true);
+	_dev_pm_opp_cpumask_remove_table(cpumask);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 783428fa9c33..3b1d94748a4d 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -194,13 +194,13 @@ void _get_opp_table_kref(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
-void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev, bool remove_all);
-void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all);
+void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev);
+void _dev_pm_opp_find_and_remove_table(struct device *dev);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of);
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 struct opp_table *_add_opp_table(struct device *dev);
 void _put_opp_list_kref(struct opp_table *opp_table);
 
-- 
2.18.0.rc1.242.g61856ae69a2c

