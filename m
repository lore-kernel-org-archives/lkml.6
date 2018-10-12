Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFA4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987042087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jmt2y/NC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987042087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeJLSoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:44:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46243 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeJLSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:44:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id v5-v6so5775582plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tFludSDWfmu59Yda7wPTpBXSCzbJ9HkYZfHCRf1lMuA=;
        b=Jmt2y/NCLwN416KNrQMN17HrZZlZnY2TvYunD+RbJmi2hIvKbxFBH1DopThfxTEpwp
         z6cLd3UkobbUBsvKWvsVZHvjZAs0cYQ3kcynbVaEtT7Po28AWAy1X8Mh19Hk2qqTzxPU
         n8OXeTSsdTIqdLThOplthf9IGJCIWRwrSp8eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tFludSDWfmu59Yda7wPTpBXSCzbJ9HkYZfHCRf1lMuA=;
        b=kY+Kotrgxxbhc6/dWK7Nv0bY3DvVneWvQFVlHa599VtrVbIxp/64jv1dLnKgYES913
         XXVYFaKmgEqfpHGlP+cFR7TeVKDFQdQLBFkpdk1UNe2BtBmLvFJwitzeKbjH7nbA4odM
         7sgVANgn1JNSaXAUrX2mXHMuw8GMBiPZIr5YS0v/uOyRO1/Q3WVyAUHapQTSPVi+vTMo
         bOTmozbUl6z/Z6ToIKVcgsIZOceHITuhLDmUlJdw3YwL7ea/HciRPamkroG84c3ZbRha
         sx1EirQnw2wBCwTI/QxK6p6yLQOTy47jYG8koDVjABLbJPG8GXdVeGDg//sJzIMowGGK
         9v4A==
X-Gm-Message-State: ABuFfohAVyAEy7uycfc8glSOpQ9vNi8ejkLl0Ud58c4giMyH5ZA4QL++
        AFogbaRlotHfni5BfLSHwkRXWg==
X-Google-Smtp-Source: ACcGV61ZGr48XI77l0FdZotj5hfhC9xaW/sHRszxwnRiFSmQ+uwR+MTqqY51NG2/Z64HwJtjcNryqA==
X-Received: by 2002:a17:902:3a2:: with SMTP id d31-v6mr5496193pld.287.1539342728164;
        Fri, 12 Oct 2018 04:12:08 -0700 (PDT)
Received: from localhost ([122.171.67.41])
        by smtp.gmail.com with ESMTPSA id l83-v6sm3043645pfi.172.2018.10.12.04.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 04:12:07 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 8/9] OPP: Rename and relocate of_genpd_opp_to_performance_state()
Date:   Fri, 12 Oct 2018 16:41:16 +0530
Message-Id: <e0289455803131d73765c22dee2b455866c25380.1539341929.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core already has the performance state values for each of the
genpd's OPPs and there is no need to call the genpd callback again to
get the performance state for the case where the end device doesn't have
an OPP table and has the "required-opps" property directly in its node.

This commit renames of_genpd_opp_to_performance_state() as
of_get_required_opp_performance_state() and moves it to the OPP core, as
it is all about OPP stuff now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 48 -------------------------------------
 drivers/opp/of.c            | 44 ++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  9 -------
 include/linux/pm_opp.h      |  5 ++++
 4 files changed, 49 insertions(+), 57 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2c82194d2a30..55f3a172f6b4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2547,54 +2547,6 @@ unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
 }
 EXPORT_SYMBOL_GPL(genpd_opp_to_performance_state);
 
-/**
- * of_genpd_opp_to_performance_state- Gets performance state of device's
- * power domain corresponding to a DT node's "required-opps" property.
- *
- * @dev: Device for which the performance-state needs to be found.
- * @np: DT node where the "required-opps" property is present. This can be
- *	the device node itself (if it doesn't have an OPP table) or a node
- *	within the OPP table of a device (if device has an OPP table).
- *
- * Returns performance state corresponding to the "required-opps" property of
- * a DT node. This calls platform specific genpd->opp_to_performance_state()
- * callback to translate power domain OPP to performance state.
- *
- * Returns performance state on success and 0 on failure.
- */
-unsigned int of_genpd_opp_to_performance_state(struct device *dev,
-					       struct device_node *np)
-{
-	struct generic_pm_domain *genpd;
-	struct dev_pm_opp *opp;
-	int state = 0;
-
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return 0;
-
-	if (unlikely(!genpd->set_performance_state))
-		return 0;
-
-	genpd_lock(genpd);
-
-	opp = of_dev_pm_opp_find_required_opp(&genpd->dev, np);
-	if (IS_ERR(opp)) {
-		dev_err(dev, "Failed to find required OPP: %ld\n",
-			PTR_ERR(opp));
-		goto unlock;
-	}
-
-	state = genpd->opp_to_performance_state(genpd, opp);
-	dev_pm_opp_put(opp);
-
-unlock:
-	genpd_unlock(genpd);
-
-	return state;
-}
-EXPORT_SYMBOL_GPL(of_genpd_opp_to_performance_state);
-
 static int __init genpd_bus_init(void)
 {
 	return bus_register(&genpd_bus_type);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index f4e8895542ca..b059d833f920 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -969,6 +969,50 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
 
+/**
+ * of_get_required_opp_performance_state() - Search for required OPP and return its performance state.
+ * @np: Node that contains the "required-opps" property.
+ * @index: Index of the phandle to parse.
+ *
+ * Returns the performance state of the OPP pointed out by the "required-opps"
+ * property at @index in @np.
+ *
+ * Return: Positive performance state on success, otherwise 0 on errors.
+ */
+unsigned int of_get_required_opp_performance_state(struct device_node *np,
+						   int index)
+{
+	struct dev_pm_opp *opp;
+	struct device_node *required_np;
+	struct opp_table *opp_table;
+	unsigned int pstate = 0;
+
+	required_np = of_parse_required_opp(np, index);
+	if (!required_np)
+		return -ENODEV;
+
+	opp_table = _find_table_of_opp_np(required_np);
+	if (IS_ERR(opp_table)) {
+		pr_err("%s: Failed to find required OPP table %pOF: %ld\n",
+		       __func__, np, PTR_ERR(opp_table));
+		goto put_required_np;
+	}
+
+	opp = _find_opp_of_np(opp_table, required_np);
+	if (opp) {
+		pstate = opp->pstate;
+		dev_pm_opp_put(opp);
+	}
+
+	dev_pm_opp_put_opp_table(opp_table);
+
+put_required_np:
+	of_node_put(required_np);
+
+	return pstate;
+}
+EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
+
 /**
  * of_dev_pm_opp_find_required_opp() - Search for required OPP.
  * @dev: The device whose OPP node is referenced by the 'np' DT node.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index e03f300f7468..80672bcb1216 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -235,8 +235,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
 unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
 					    struct dev_pm_opp *opp);
-unsigned int of_genpd_opp_to_performance_state(struct device *dev,
-				struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -282,13 +280,6 @@ genpd_opp_to_performance_state(struct device *genpd_dev, struct dev_pm_opp *opp)
 	return 0;
 }
 
-static inline unsigned int
-of_genpd_opp_to_performance_state(struct device *dev,
-				  struct device_node *np)
-{
-	return 0;
-}
-
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return 0;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index b14600ce078f..f440e625f1fd 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -315,6 +315,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
+unsigned int of_get_required_opp_performance_state(struct device_node *np, int index);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -357,6 +358,10 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 {
 	return NULL;
 }
+static inline unsigned int of_get_required_opp_performance_state(struct device_node *np, int index)
+{
+	return 0;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.18.0.rc1.242.g61856ae69a2c

