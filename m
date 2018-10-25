Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B01ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D253720840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyQEdTMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D253720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJYOYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:24:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46935 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeJYOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:24:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id bb7-v6so3332522plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DREmCWfscdpbRmqLABL+1ARNsgewbNNclEM2YGn70QU=;
        b=NyQEdTMmA4psl6Bd/PFMDjhuAKsz4CEmaWHkW6frOoA/VWVk14rQoho2kvKnxP37Ut
         vQoY3wwxPCEb5nsUrKulHikjV1Uxh3Aqh1GN0xkQm5ugyZGgpGdsA0gvRsov08DrUm+V
         Tgfvv0idzTcGoOI4VeInxcNgth7u4VDflzUdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DREmCWfscdpbRmqLABL+1ARNsgewbNNclEM2YGn70QU=;
        b=Sfa5uSFo80gndrQw0ZqcfC038Wl7Tm3qkX+dtusFUzI8QY8x7HVqlkHa7OawojVmUP
         cL7nG/2TdGZU9A/je576L/Eq/LjeiWGIcNaSQ4a8pQD4Sh1i06jEsmlqpmRwHlg3CXtN
         zWwi8qOPFAnRU4g/HQSC5vItLgWjBOZuAZZ2PzBDq1eN0BEXccj6DbehbrtonrhMwIvI
         9cGjj79JhTCEsb3Ywxg1ND99MBQ8Do00RXU4GKcMetvZahWWfg202dz3xLWiBx2G3JJp
         ZWRlj0EpmneYgayVFoK+Z5lZ7cHz0Bnr+yqIXbBJDwspigT3EhRZO6jTl0FWukwzckde
         lcTQ==
X-Gm-Message-State: AGRZ1gK3FP4gITqyOjkGR/KkuDiWQY0PpgARRSN9MwXAAUG5rdqlrJS+
        dmn0eojWrkEmHw8V8pW9ZrviKA==
X-Google-Smtp-Source: AJdET5cbFbEOTIgkWRlJGteCbjAw1i0IwcYTWFnMqcDeFP9hGkDv1Jf1NjvIOnd3d93Xc6a1WMqMZA==
X-Received: by 2002:a17:902:7e03:: with SMTP id b3-v6mr202147plm.246.1540446815767;
        Wed, 24 Oct 2018 22:53:35 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id m20-v6sm7734646pfj.171.2018.10.24.22.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 22:53:35 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 06/10] PM / Domains: Add genpd_opp_to_performance_state()
Date:   Thu, 25 Oct 2018 11:22:43 +0530
Message-Id: <e09b2960614c70e38347d52bd4093ab93af1da47.1540446493.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core currently stores the performance state in the consumer
device's OPP table, but that is going to change going forward and
performance state will rather be set directly in the genpd's OPP table.

For that we need to get the performance state for genpd's device
structure (genpd->dev) instead of the consumer device's structure. Add a
new helper to do that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  9 +++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index fe9b0527b161..7be8c94c6b7f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2520,6 +2520,38 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
+/**
+ * pm_genpd_opp_to_performance_state - Gets performance state of the genpd from its OPP node.
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
+unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
+					       struct dev_pm_opp *opp)
+{
+	struct generic_pm_domain *genpd = NULL;
+	int state;
+
+	genpd = container_of(genpd_dev, struct generic_pm_domain, dev);
+
+	if (unlikely(!genpd->opp_to_performance_state))
+		return 0;
+
+	genpd_lock(genpd);
+	state = genpd->opp_to_performance_state(genpd, opp);
+	genpd_unlock(genpd);
+
+	return state;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_opp_to_performance_state);
+
 /**
  * of_genpd_opp_to_performance_state- Gets performance state of device's
  * power domain corresponding to a DT node's "required-opps" property.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 3b5d7280e52e..4f803f934308 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -258,6 +258,8 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent,
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
+unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
+					       struct dev_pm_opp *opp);
 unsigned int of_genpd_opp_to_performance_state(struct device *dev,
 				struct device_node *np);
 
@@ -299,6 +301,13 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 	return -ENODEV;
 }
 
+static inline unsigned int
+pm_genpd_opp_to_performance_state(struct device *genpd_dev,
+				  struct dev_pm_opp *opp)
+{
+	return 0;
+}
+
 static inline unsigned int
 of_genpd_opp_to_performance_state(struct device *dev,
 				  struct device_node *np)
-- 
2.19.1.568.g152ad8e3369a

