Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DDBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412A62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLQ+7HTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412A62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeKZTDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:03:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33091 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:03:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so13501402plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8dZ2xNG0wrY9M18CIWOaB56vm2msQMB1AEL61XjNEVo=;
        b=QLQ+7HTQdMzShJXE7t+Oz9eWOxQdypgCasgsGB7kGoxExkPT34ic6ehUvvVl2iXkWd
         yIIk7EAD1BChWJmt874dyKhY1jpS/HovTG4+28bU7F10g6+qJl8bB3Pm5fiSVoSPO+FD
         WsNvEZnNo/G+1Y/bYClJb1vxET6pXtQ9WZcfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8dZ2xNG0wrY9M18CIWOaB56vm2msQMB1AEL61XjNEVo=;
        b=UQcByOjv9oficmbvcYhabwvD2Mfp46GzFHCI+97fkfSvKdFy+HOlFgC2HZjwc+uZ7l
         s7rgX+yZBflenjwtmE3SSeWDvyqK+YcSCVSUJEB4eLefJtJZfk6NjPP+Rkg2tL1c7Pqr
         uYcwKyvqaSWXGrs1/Sl3mccAViwBLjueJp4kGMW0Zrpq5Yy4VJLZhH5ObIA331SPvdGB
         dKMoTiUjc9+VfCpISxQP08Usuo1Lt9WuVXVfU2hWv7VE+OhF0CfV70+P0u2Af2b5hsfH
         r2jku9N6NbaFEMy3pcihYYm0SXPjZdkC/RtUsXB5MBY/My6NAST32uDmXKItj4KpCTPv
         DMhQ==
X-Gm-Message-State: AA+aEWYk1bIX2vMwrx6fPTR6NyeuKoaUAKr+JgrWfOkK54dY/PMOgk45
        as4jO1jAb/cCdovt0Jx9vWHF/A==
X-Google-Smtp-Source: AFSGD/X4h/YDoy4Uv3S1FzIHHLTNebFt9EK6LNPOm6wsk9i/zfwIWWsZeJcKaoumGiHb6CoT5q0cfA==
X-Received: by 2002:a17:902:b592:: with SMTP id a18mr26996386pls.182.1543219829636;
        Mon, 26 Nov 2018 00:10:29 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id l64sm70802998pge.73.2018.11.26.00.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:10:29 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/5] PM / Domains: Factorize dev_pm_genpd_set_performance_state()
Date:   Mon, 26 Nov 2018 13:40:03 +0530
Message-Id: <401e29cb9e8d762e076253220f4a5dc22464e9fa.1543219386.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1543219386.git.viresh.kumar@linaro.org>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 105 +++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 43 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0d928359b880..d6b389a9f678 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -239,6 +239,63 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
 static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
 #endif
 
+static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
+					unsigned int state)
+{
+	int ret;
+
+	ret = genpd->set_performance_state(genpd, state);
+	if (ret)
+		return ret;
+
+	genpd->performance_state = state;
+	return 0;
+}
+
+static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
+					   unsigned int state)
+{
+	struct generic_pm_domain_data *pd_data;
+	struct pm_domain_data *pdd;
+
+	/* New requested state is same as Max requested state */
+	if (state == genpd->performance_state)
+		return 0;
+
+	/* New requested state is higher than Max requested state */
+	if (state > genpd->performance_state)
+		goto update_state;
+
+	/* Traverse all devices within the domain */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		pd_data = to_gpd_data(pdd);
+
+		if (pd_data->performance_state > state)
+			state = pd_data->performance_state;
+	}
+
+	if (state == genpd->performance_state)
+		return 0;
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
+
+update_state:
+	if (!genpd_status_on(genpd)) {
+		genpd->performance_state = state;
+		return 0;
+	}
+
+	return _genpd_set_performance_state(genpd, state);
+}
+
 /**
  * dev_pm_genpd_set_performance_state- Set performance state of device's power
  * domain.
@@ -257,10 +314,9 @@ static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
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
@@ -281,47 +337,10 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
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
-	if (genpd_status_on(genpd)) {
-		ret = genpd->set_performance_state(genpd, state);
-		if (ret) {
-			gpd_data->performance_state = prev;
-			goto unlock;
-		}
-	}
-
-	genpd->performance_state = state;
+	ret = _genpd_reeval_performance_state(genpd, state);
+	if (ret)
+		gpd_data->performance_state = prev;
 
-unlock:
 	genpd_unlock(genpd);
 
 	return ret;
-- 
2.19.1.568.g152ad8e3369a

