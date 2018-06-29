Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B62C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC91427B2F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hd5h0+dC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC91427B2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933665AbeF2GVL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:21:11 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42928 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933567AbeF2GUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:20:17 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so3537844pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nYL1CW04bSitJU9aZchvpfflvfV+miLBzuZ+X6mk+3s=;
        b=hd5h0+dC+9OjBYA6Bgt+gp9/Po5kiudhamXfCF6JLQ4Czxak/+7KYDgzXL3Fv9XSGR
         MnxaTyNbLoO9eGq+0C7OGNotUQ3fSv/PaqeeN1HRVn5lrYJx8GyNADOum5uD97MOGMEa
         2ey4QiN5hbKt+TLZhPAbO/hqVWEzEYgyEXgUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nYL1CW04bSitJU9aZchvpfflvfV+miLBzuZ+X6mk+3s=;
        b=S5Bv+St+cee3P/VfoFhCBQgdtoLtmF3FEmdHiLzE1bmZGkAJ0CvVK7gEYY27QPGRWu
         /IxEVjC/D5yCCoJd6CUs5sKCBAzQCIZ7EzVHaIdr+9mvXS5QhtvLwcpQMH18DXTu1dM+
         6VbVohwsN6rzkTZp/cbFRwAdhHiVMI4nkgUo6wEq2VbFR4ifqvfFvH4UkLJqHRF69Vi9
         5nv4plaeWRiSAG8HjNSUph1H3chWUmjQrUD40VYWAK63Z49UPEDTN9MWZp7W76Ko44Gg
         A3qdv4omBtpQgzI0oE69s5Lagk24UYaSt8K5L6Ajr02hIVq7IZEMAq2VnCRt582BHbhp
         kyPA==
X-Gm-Message-State: APt69E36gazzGdXywvI0ej5P4TCTac9mKDllnXjO11VTEo+ccdLpGKvR
        xl9WSrwxeUoZMeQLQ2uC3kV6DA==
X-Google-Smtp-Source: ADUXVKLxkSMIrvp9ycIQCt8qvBnFIgxK4XvYQVa/LxuP5xNzNp6Gn3Fnjr7iZY/xX1jeUX072T6HZg==
X-Received: by 2002:a63:a809:: with SMTP id o9-v6mr11679259pgf.313.1530253216409;
        Thu, 28 Jun 2018 23:20:16 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id d23-v6sm23810414pfe.2.2018.06.28.23.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 23:20:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] PM / Domains: Add genpd_opp_to_performance_state()
Date:   Fri, 29 Jun 2018 11:49:37 +0530
Message-Id: <476e0a8c4bb54190f3019055b369110d0964b798.1530252803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core currently stores the performance state in the end device's
OPP structures, but that is going to change now and these values will be
set directly in the genpd's OPP structures.

For that we need to get the performance state genpd's device structure
instead of the end user's device structure. Add a new helper to do that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 39 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e9c85c96580c..15ffac081b0e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2505,6 +2505,45 @@ int of_genpd_parse_idle_states(struct device_node *dn,
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
index cb8d84090cfb..b3c5f1eaf16c 100644
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
 
@@ -272,6 +274,12 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
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

