Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAB1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAE12087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5rUBQr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAE12087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeJLSnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:43:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45047 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbeJLSnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:43:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id p25-v6so5778651pli.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=blaWPqPFlJGJ+DD2m7muSQ78d8p4LHOlTL3txRfKTuM=;
        b=D5rUBQr1vrcVc2BiXCmd7EiQMTO1uXdbtMYnWRamB5cquWHi9NzLxeEsCMD0M9wOgo
         PHNKNZrl2nVXuRuwsowZrfnIswszWdoTKiBxdadMSfSDWAEwRn7SPyGBVf8ezP66W1TL
         GtoFhOj9S7JgD8sZTolBIrQkHyr3Xfi0uqygY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=blaWPqPFlJGJ+DD2m7muSQ78d8p4LHOlTL3txRfKTuM=;
        b=sWKHsjxkk74jNippRcwoHC/k09fmyUB3rIwSW1cXSZhAY3GK3qLaUo24GizmqLSH0p
         ZsYFbWJawI/XliPvbcB0DD3SC6Iffpnb7zaoSkxBUWbJAIwMzN+gAbXHCqqWgU0T+NPa
         L6LQm84/TO+PSzT9YijgV9pN86bCFMnaroVLmEkrw29cTF7Vnu6neNrClz0vD2tUZXJN
         DlUDHxJFOj1rBr3itq0tNO+3v3AcRniEFe7W0M2c4TdFs/XEzju/daw5lU60LVAaFRYP
         BIeuj2eSqDn96JrJzW0m7gQGIV0GKoT15LQmeSoyku9jX4FiCSQGO7nhezbk9V9Km0Vg
         +51w==
X-Gm-Message-State: ABuFfogPFe04KhMd5u6UzgQP5dd30xznIelCmaMeIUFGXd1CvOayShe2
        NEAhosiW35t+1pJcVgiqFbb0Rg==
X-Google-Smtp-Source: ACcGV63JM5te/uuGWCSK65s+DowlSq8SaJditcZxpAVtvofBuSo9+hBbIVxppn9VuMAAIvZr4IajxQ==
X-Received: by 2002:a17:902:1129:: with SMTP id d38-v6mr156721pla.270.1539342717651;
        Fri, 12 Oct 2018 04:11:57 -0700 (PDT)
Received: from localhost ([122.171.67.41])
        by smtp.gmail.com with ESMTPSA id l129-v6sm2092376pfc.155.2018.10.12.04.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 04:11:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/9] PM / Domains: Add genpd_opp_to_performance_state()
Date:   Fri, 12 Oct 2018 16:41:13 +0530
Message-Id: <ec154fa205967507c7352a2d0088346aba562ff2.1539341929.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core currently stores the performance state in the consumer
device's OPP table, but that is going to change going forward and
performance state will rather be set directly in the genpd's OPP table.

For that we need to get the performance state for genpd's device
structure instead of the consumer device's structure. Add a new helper
to do that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 39 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4b5714199490..2c82194d2a30 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2508,6 +2508,45 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
+/**
+ * genpd_opp_to_performance_state- Gets performance state of the genpd from its OPP node.
+ *
+ * @genpd_dev: Genpd's device for which the performance-state needs to be found.
+ * @opp: struct dev_pm_opp of the OPP for which we need to find performance
+ *	state.
+ *
+ * Returns performance state encoded in the OPP of the genpd. This calls
+ * platform specific genpd->opp_to_performance_state() callback to translate
+ * power domain OPP to performance state.
+ *
+ * Returns performance state on success and 0 on failure.
+ */
+unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
+					    struct dev_pm_opp *opp)
+{
+	struct generic_pm_domain *genpd = NULL, *temp;
+	int state;
+
+	lockdep_assert_held(&gpd_list_lock);
+
+	list_for_each_entry(temp, &gpd_list, gpd_list_node) {
+		if (&temp->dev == genpd_dev) {
+			genpd = temp;
+			break;
+		}
+	}
+
+	if (unlikely(!genpd || !genpd->opp_to_performance_state))
+		return 0;
+
+	genpd_lock(genpd);
+	state = genpd->opp_to_performance_state(genpd, opp);
+	genpd_unlock(genpd);
+
+	return state;
+}
+EXPORT_SYMBOL_GPL(genpd_opp_to_performance_state);
+
 /**
  * of_genpd_opp_to_performance_state- Gets performance state of device's
  * power domain corresponding to a DT node's "required-opps" property.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 776c546d581a..e03f300f7468 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -233,6 +233,8 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent,
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
+unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
+					    struct dev_pm_opp *opp);
 unsigned int of_genpd_opp_to_performance_state(struct device *dev,
 				struct device_node *np);
 
@@ -274,6 +276,12 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 	return -ENODEV;
 }
 
+static inline unsigned int
+genpd_opp_to_performance_state(struct device *genpd_dev, struct dev_pm_opp *opp)
+{
+	return 0;
+}
+
 static inline unsigned int
 of_genpd_opp_to_performance_state(struct device *dev,
 				  struct device_node *np)
-- 
2.18.0.rc1.242.g61856ae69a2c

