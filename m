Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE08DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4FA20867
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxzQxtXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4FA20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbeITEBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:01:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33638 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbeITEA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:00:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so93126pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lOCO4EDC8Q7oDBzPlggldAfccotE1FhuTN71HpuLTTI=;
        b=dxzQxtXOMt24gp9Kdm/pMZ4LveTazVeLqdhF0qSrKiMNHtcJ44NVLQzl9NBf+hGERr
         JhaKkEzKDIC4UUM4N51wTgrXmUhXBu5rFIbe7nDqq/HjP0dKHAXUBMbLAquaY8pySmiy
         itRyPU2Xdg6pKq0p+JcgiptMxGSHBVQbyWTsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lOCO4EDC8Q7oDBzPlggldAfccotE1FhuTN71HpuLTTI=;
        b=AbyOLE2ynofNsduz6jxWWRYAQ3lfe0jaQ2e1NnaZDU4BvSAXjY+MbSWYpKDIHi8OL3
         JrRL3i0xElrP5Km3fkcNB5pWHhttsgqusqgE8CPtS3A3pude6uva0dQ+oXL71YdGvGxL
         007IwZUVO21j5wYPiu0LJjJhtBQeBjJIs71pWBAGG5RR/W4OGglD00JNF5CAgNzhPUMd
         GT2gQcan6yfg0tc+liNJBuY1HCeSExzPr4t0BGCIDj9obf8+MpbK1oUFfB2WjwCsBU31
         30ptmFXdOhHaAhn0arWG7M9kcvjG7Jwpmoml1tsjE0G/QL4HGcO5zbz1KPGtEzKcoC/c
         uOWA==
X-Gm-Message-State: APzg51CHR1DV37p7qX1bme9W+Bj+GrK/vXsHnqcw5XsPm/TxnuiEvOX7
        5Xy+TfPK8/XzJRk0/4RIc+aKbg6bvyQ=
X-Google-Smtp-Source: ANB0VdaL1SAy6f+k+QqxgnNOtaMzq9r0+V5SBrXriQSGTNP4raT39QMHeqYwfQq/s0SG59BTbXBKeA==
X-Received: by 2002:a62:225d:: with SMTP id i90-v6mr37923089pfi.246.1537395656692;
        Wed, 19 Sep 2018 15:20:56 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id f11-v6sm32580232pfa.131.2018.09.19.15.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:56 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/12] OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()
Date:   Wed, 19 Sep 2018 15:20:28 -0700
Message-Id: <2a4eb7358aba6beff7fa23f028c733310756e525.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only one platform was depending on this feature and it is already
updated now. Stop removing dynamic OPPs from _dev_pm_opp_remove_table().
This simplifies lot of paths and removes unnecessary parameters.

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 20 +++++---------------
 drivers/opp/cpu.c  |  9 +++------
 drivers/opp/of.c   | 12 ++++++------
 drivers/opp/opp.h  |  6 +++---
 4 files changed, 17 insertions(+), 30 deletions(-)

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
index 36586f66cd83..ab6d07e78945 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -108,7 +108,7 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of,
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask,
 				      int last_cpu)
 {
 	struct device *cpu_dev;
@@ -127,10 +127,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of,
 			continue;
 		}
 
-		if (of)
-			dev_pm_opp_of_remove_table(cpu_dev);
-		else
-			dev_pm_opp_remove_table(cpu_dev);
+		_dev_pm_opp_find_and_remove_table(cpu_dev);
 	}
 }
 
@@ -144,7 +141,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of,
  */
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask)
 {
-	_dev_pm_opp_cpumask_remove_table(cpumask, false, -1);
+	_dev_pm_opp_cpumask_remove_table(cpumask, -1);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index aaa4bab69846..861cc75de329 100644
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
-	_dev_pm_opp_cpumask_remove_table(cpumask, true, -1);
+	_dev_pm_opp_cpumask_remove_table(cpumask, -1);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 
@@ -653,7 +653,7 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 				 __func__, cpu, ret);
 
 			/* Free all other OPPs */
-			_dev_pm_opp_cpumask_remove_table(cpumask, true, cpu);
+			_dev_pm_opp_cpumask_remove_table(cpumask, cpu);
 			break;
 		}
 	}
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9274116c90e4..98dd7d39e1ad 100644
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
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of, int last_cpu);
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
 struct opp_table *_add_opp_table(struct device *dev);
 void _put_opp_list_kref(struct opp_table *opp_table);
 
-- 
2.14.1

