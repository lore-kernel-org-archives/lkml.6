Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C99ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C6B2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQ4ZDR4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C6B2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeKEPz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:55:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43424 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbeKEPz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:55:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id g59-v6so3935408plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 22:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTLJoVN5MMvVsPcSQkjRuLaNcVa7Qww7gt9pAH6Lr8g=;
        b=eQ4ZDR4zxeQ4zqmCfhat2+B6osV3DKaHIS04eIZ1r4ALYqveT91QcWVWqZg6cYxFVj
         THKU2ML7zxiXa7E3oWKx+ZHUpXr0kFlDJNAynDRAxQZJnMIIvyDo5qzCioDnNypZeBmg
         c1Caqp57G8aux6i4Z62Vi2M98jfLVWJaEhH2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTLJoVN5MMvVsPcSQkjRuLaNcVa7Qww7gt9pAH6Lr8g=;
        b=Fo6XyDfL9SD4U24+85BrARcfbkBf81m46ynrp9W+Jz0CCxGldNl7uplUU/3OX6bWhq
         ASd/5LDi0z+4f2hZ7RTjyCFJ2eilETJV9/jL0T3S5+0lfhnNLpU0VIP8qSvg2ZIP/lIG
         zoGSuWeNPCbo84hUvdg6tVj+UyfRNucze6tVCJTtHw/kd1+oArFzYYzIsdkn6ma7uvmT
         7i055MdLrADhjTNTH/qDFyIneo6rMhlO8KUoEaAOAfv7i64TwxJ95wn/RgH5V+DRtCdD
         znJSJguVC13sVyZ8ykcjqUfnkkQYmX2rYy3LMbQRv2jzqoZspZOkZ07i0pIdbPhQJrGH
         N0GQ==
X-Gm-Message-State: AGRZ1gKfueM7X0xsYvICFybGgd4d3KFXuHSJgL+q5mK74YPC7EUoSs4U
        pnKhqEFsuwg4aiEoYKEUTy1xrw==
X-Google-Smtp-Source: AJdET5cjug70QCZ364hO296xS2PWVEzmAh4RMzJh+wiZEXNUpCE/6IxxCNi1ojCrtcRN5lLf1wzLOA==
X-Received: by 2002:a17:902:74c4:: with SMTP id f4-v6mr21229811plt.52.1541399840064;
        Sun, 04 Nov 2018 22:37:20 -0800 (PST)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id e204-v6sm6986750pfh.68.2018.11.04.22.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 22:37:19 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] PM / Domains: Factorize dev_pm_genpd_set_performance_state()
Date:   Mon,  5 Nov 2018 12:06:45 +0530
Message-Id: <fe07f860e87833377183e1f77ecb089407eb9ad4.1541399301.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1541399301.git.viresh.kumar@linaro.org>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
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
 drivers/base/power/domain.c | 104 +++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 43 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0d928359b880..6d2e9b3406f1 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -239,6 +239,62 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
 static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
 #endif
 
+static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
+					unsigned int state)
+{
+	int ret;
+
+	if (!genpd_status_on(genpd))
+		goto out;
+
+	ret = genpd->set_performance_state(genpd, state);
+	if (ret)
+		return ret;
+
+out:
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
+	return _genpd_set_performance_state(genpd, state);
+}
+
 /**
  * dev_pm_genpd_set_performance_state- Set performance state of device's power
  * domain.
@@ -257,10 +313,9 @@ static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
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
@@ -281,47 +336,10 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
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

