Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F815C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4BF20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbC4bfM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4BF20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeLLK6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:58:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32918 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeLLK6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:58:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so8724786pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6NgWUw1lJ1tXqc1WKyoMXFmTwlvDqOcRTcyO/vcEI0=;
        b=LbC4bfM36KSfUk5o6CDIqbn5bhmGTEdG0x06MAHHI8ykcrXJsDDIz3hd8cvztrhgjK
         j36FQiU7+8sHmXBMPte6x0Q2wAQ7thSkPi1O5n/eOPgJ6u8gKKyij0jyscRWdo7MXgpe
         8WfEI8X47+WhJuGfQ+N8+bVrIcbgFjFKve/Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6NgWUw1lJ1tXqc1WKyoMXFmTwlvDqOcRTcyO/vcEI0=;
        b=YzdOr+zuuUGLznrLVSNNOh+hjb5nM5rerOoQJHnAVwd/7T/3c0f0igYjWvkC6XJsuQ
         jE1p3xDP3Y2kdkxxgkYAWT3jdwWmj4r4O7ubzybnLAVlXxBe4p3i9wfx9sDnoC8jwRRw
         iUcDrJ9PNzBd+S45yp6AeUbM/nre6HIyZ9pW8/cUdHfXzfbalOWQ93ZnkM9OhyDCEc3w
         8QbjLaIpWPoH07qz7pyEVVseaLZZWBHpH9Xsy2jJG//7IWNJJiasbcBQT7NZIDLzZOG3
         9CMX4kSZUf14MkRFdimePvwIalWAwdipreOxlJiFF3DvIzJatAKIJjJFp3+EOeJXCFbu
         nC0A==
X-Gm-Message-State: AA+aEWYlA3kCM9nHIyxjRGnUXR8qZKR3qljlORmmFt44vR7//FENzqm8
        iB3HV4DoAo5SyE8PYgheiqKFww==
X-Google-Smtp-Source: AFSGD/Vly/FyH5r0YJBgz7Db8JAoq9pm7gI2A+mlbpw5vFSG9d08cKT7qhYHhT52Tx7gkABdZUUuhQ==
X-Received: by 2002:a63:1b48:: with SMTP id b8mr17939588pgm.187.1544612282767;
        Wed, 12 Dec 2018 02:58:02 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id v12sm25370916pgg.41.2018.12.12.02.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 02:58:02 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/6] PM / Domains: Factorize dev_pm_genpd_set_performance_state()
Date:   Wed, 12 Dec 2018 16:27:28 +0530
Message-Id: <729bf6e3b2f434df7e11370d01bc8b0a6f80da5a.1544611890.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544611890.git.viresh.kumar@linaro.org>
References: <cover.1544611890.git.viresh.kumar@linaro.org>
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

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 96 +++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 40 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 1e98c637e069..32ecbefbd191 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -239,6 +239,58 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
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
+	return _genpd_set_performance_state(genpd, state);
+}
+
 /**
  * dev_pm_genpd_set_performance_state- Set performance state of device's power
  * domain.
@@ -257,10 +309,9 @@ static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
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
@@ -281,45 +332,10 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
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
+	ret = _genpd_reeval_performance_state(genpd, state);
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

