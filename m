Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F346CC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B067E20811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M067d3ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B067E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbeLNKQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:16:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46758 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbeLNKP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:15:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so2485204pgp.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMuVu8n3ZWdRbQbhEMy90Uj7CKk0/3mUfjD2e/MUMn0=;
        b=M067d3mlqJZnjoZ6EfwLLzsP0gOVKArU5HUpi9pSuQQwWwKtbwfhoSZAj16RvErXA0
         +ozZSMVoLrL+OOnAJhFn85fqIajezry3r1RNBLHY5qoHeMW1y7hD0bcHogfN2NvoxhMe
         8GzGbec6hmUnBDxrcmXceXeePzBOmbmpuK13U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMuVu8n3ZWdRbQbhEMy90Uj7CKk0/3mUfjD2e/MUMn0=;
        b=rMUC0Mck1pnm8wmWlx8I8HKZthkQZx9dhPAjX52EsvePfSixkCdY7ty2VfZ+yHRfRB
         TqVYkFQG9GyrJKlp3R3cDlwGH/vhDbNCRvLmnInavp8/OZJ4xwEnLZDAsvoC1WJ51to9
         oYb5eT0GiOt1iG8aU+74NfJ/FONqXVsq5MKYSPRM8z9pLHK1enLMGmTu1yuXfRJCLHMc
         X7NOsw11cI7es/sP/pU4/LOh8tkcuci7v/sPoL4MdNFpgOhAEQ0dDwimFCIZH3FtmOCT
         zXYo0/NlE0szc/m8i+kWvP3TtR8gxE4D7txVHk9j8Km6Xvz6TBGA2mpxfU7SVyJQ030a
         B6VA==
X-Gm-Message-State: AA+aEWZWos7IX59l7MrwRx9/q0LhmdrN0jm/Vl12wwkGYr5UH1BfJ9rO
        frjge764QXW94m32i0y4+k1SuA==
X-Google-Smtp-Source: AFSGD/VYpEbPnSvpirsrHD60lnam/veZGq8aedvSPG6mAyl2jDYn8J8Itljc1xk6gNr+ePwpNdHTEA==
X-Received: by 2002:a62:de06:: with SMTP id h6mr2339573pfg.158.1544782556201;
        Fri, 14 Dec 2018 02:15:56 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id y71sm9960187pfi.123.2018.12.14.02.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 02:15:55 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 6/7] PM / Domains: Factorize dev_pm_genpd_set_performance_state()
Date:   Fri, 14 Dec 2018 15:45:32 +0530
Message-Id: <f6153683d88cce25319945e4308bef46edaaaa54.1544782279.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544782279.git.viresh.kumar@linaro.org>
References: <cover.1544782279.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate out _genpd_set_performance_state() and
_genpd_reeval_performance_state() from
dev_pm_genpd_set_performance_state() to handle performance state update
related stuff. This will be used by a later commit.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 95 +++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 40 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 1e98c637e069..808ba41b6580 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -239,6 +239,56 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
 static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
 #endif
 
+static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
+					   unsigned int state)
+{
+	struct generic_pm_domain_data *pd_data;
+	struct pm_domain_data *pdd;
+
+	/* New requested state is same as Max requested state */
+	if (state == genpd->performance_state)
+		return state;
+
+	/* New requested state is higher than Max requested state */
+	if (state > genpd->performance_state)
+		return state;
+
+	/* Traverse all devices within the domain */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		pd_data = to_gpd_data(pdd);
+
+		if (pd_data->performance_state > state)
+			state = pd_data->performance_state;
+	}
+
+	/*
+	 * We aren't propagating performance state changes of a subdomain to its
+	 * masters as we don't have hardware that needs it. Over that, the
+	 * performance states of subdomain and its masters may not have
+	 * one-to-one mapping and would require additional information. We can
+	 * get back to this once we have hardware that needs it. For that
+	 * reason, we don't have to consider performance state of the subdomains
+	 * of genpd here.
+	 */
+	return state;
+}
+
+static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
+					unsigned int state)
+{
+	int ret;
+
+	if (state == genpd->performance_state)
+		return 0;
+
+	ret = genpd->set_performance_state(genpd, state);
+	if (ret)
+		return ret;
+
+	genpd->performance_state = state;
+	return 0;
+}
+
 /**
  * dev_pm_genpd_set_performance_state- Set performance state of device's power
  * domain.
@@ -257,10 +307,9 @@ static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 {
 	struct generic_pm_domain *genpd;
-	struct generic_pm_domain_data *gpd_data, *pd_data;
-	struct pm_domain_data *pdd;
+	struct generic_pm_domain_data *gpd_data;
 	unsigned int prev;
-	int ret = 0;
+	int ret;
 
 	genpd = dev_to_genpd(dev);
 	if (IS_ERR(genpd))
@@ -281,45 +330,11 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	prev = gpd_data->performance_state;
 	gpd_data->performance_state = state;
 
-	/* New requested state is same as Max requested state */
-	if (state == genpd->performance_state)
-		goto unlock;
-
-	/* New requested state is higher than Max requested state */
-	if (state > genpd->performance_state)
-		goto update_state;
-
-	/* Traverse all devices within the domain */
-	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
-		pd_data = to_gpd_data(pdd);
-
-		if (pd_data->performance_state > state)
-			state = pd_data->performance_state;
-	}
-
-	if (state == genpd->performance_state)
-		goto unlock;
-
-	/*
-	 * We aren't propagating performance state changes of a subdomain to its
-	 * masters as we don't have hardware that needs it. Over that, the
-	 * performance states of subdomain and its masters may not have
-	 * one-to-one mapping and would require additional information. We can
-	 * get back to this once we have hardware that needs it. For that
-	 * reason, we don't have to consider performance state of the subdomains
-	 * of genpd here.
-	 */
-
-update_state:
-	ret = genpd->set_performance_state(genpd, state);
-	if (ret) {
+	state = _genpd_reeval_performance_state(genpd, state);
+	ret = _genpd_set_performance_state(genpd, state);
+	if (ret)
 		gpd_data->performance_state = prev;
-		goto unlock;
-	}
 
-	genpd->performance_state = state;
-
-unlock:
 	genpd_unlock(genpd);
 
 	return ret;
-- 
2.19.1.568.g152ad8e3369a

