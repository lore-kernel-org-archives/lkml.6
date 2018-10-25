Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BACECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B2320831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tr274oTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B2320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJYOY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:24:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46327 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJYOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:24:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so3626990pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCyv0YPeiesSsQ4IoZUlYIyjO5zGVV/PfYBEjZv38ns=;
        b=Tr274oTjSRe7HrJGKcPK9ZS5P9wSPAwa2j6WXy/z51FssCnW30JuGEChZz4ZM5zJsl
         Js/6XCYiwcE5Idx3zJz4gzCZoPBYtsCi+mTEQp+Su0XzrNqGZ4CKx/VOXnUaOBA1TTLx
         YSBdMsDEC1hrzsCrpsAlXoo4L8a6IIYgekpvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCyv0YPeiesSsQ4IoZUlYIyjO5zGVV/PfYBEjZv38ns=;
        b=bXIYGQWBG7sL0NRKWdnu7ZJhoQqS14M2WJAb+eZLS1BeVntSaY2CzqnpogRlORneJW
         mh0IAW7YHcfEfPeyr6Bsc+VY24iGMkhiruhlcme6nBMmqNqrvBJ1fcCIAY6d5I+RM+v5
         VmSVZMJEa29emovZj3KR6/aRDo0pSFvLqktDsLAD5MkkTUza49lzEcEDhnYwzwtUeAKS
         B+pbrpBNEW3p3sYm04BLTcV1k2IL5qUyO3AII3EZy22BfndWK52Wvkkr8lpwkzlU/yy0
         5oz34j9eCqxebvtYFMw7J5GDd3D3p/BkFtoD6nvwrUexBGU3nfjbDOcnn+xTF2Rgd9Mf
         P+mw==
X-Gm-Message-State: AGRZ1gK1LXGhD3CybJb6sxro7eQ3lyIlsNTG2sOtoxt7euq7NgCMJ5xh
        3/AC7o2hAx1iMULbWlTYgnaANQ==
X-Google-Smtp-Source: AJdET5dYNlADdJmN2+eEp93f5bWX0QXNwg/1IWALZV/DtzAcUQJOxh7IgHOD/+1pdVWSSyn7kVjRzQ==
X-Received: by 2002:a62:8f:: with SMTP id 137-v6mr228758pfa.24.1540446826410;
        Wed, 24 Oct 2018 22:53:46 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id z2-v6sm1408294pfm.106.2018.10.24.22.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 22:53:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 09/10] OPP: Rename and relocate of_genpd_opp_to_performance_state()
Date:   Thu, 25 Oct 2018 11:22:46 +0530
Message-Id: <6ac7dd52047805dc1ec211cce261aee561d10abc.1540446493.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 7be8c94c6b7f..8e554e6a82a2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2552,54 +2552,6 @@ unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_opp_to_performance_state);
 
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
index 4e494720ac25..0755ee307b1a 100644
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
index 4f803f934308..642036952553 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -260,8 +260,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
 unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
 					       struct dev_pm_opp *opp);
-unsigned int of_genpd_opp_to_performance_state(struct device *dev,
-				struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -308,13 +306,6 @@ pm_genpd_opp_to_performance_state(struct device *genpd_dev,
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
index 8fed222c089b..889bb347fbd9 100644
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
2.19.1.568.g152ad8e3369a

