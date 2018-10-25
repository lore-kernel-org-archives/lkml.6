Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D5DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A972520831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMOV8aLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A972520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeJYOYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:24:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34574 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJYOYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:24:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id f10-v6so3364241plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVqXjk7n5hkE0ZKH0VVF90h6UKPg3BztsmMsFz9tDjQ=;
        b=YMOV8aLqj0s4wouk2hoc6g3a5TknOvFQwTYrKdRQx4+4IZ+zU6pJsa8DeEHssYaV4K
         szxmNbene+On3UE0B9vncK5IGLEnb1s5gXmWn1rQ1vlbXaKtUD1RhbAe5lI1HvV38Msw
         mYNp2dzBVT5xmwnbAmi2PwzKUudqLfCmQaezE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVqXjk7n5hkE0ZKH0VVF90h6UKPg3BztsmMsFz9tDjQ=;
        b=HcvNj53dZSn3+kwKMwfy8DbJLEN9u14ZAkbNucDPpvI/4xjO2dTzLnqvboOdAmC8IH
         wpMYGXtGTP8DhQi4+e3IX7q97BLcIayF1d9BzapQNP5VpEF8hyhS/WRLwynKbFLff5X1
         Wv2rkGV8z4Qw8JQynsTy2vJ/4/NhhCpu6v0av40Vpopk9XbtEiQ+CJ2u77Tz1Fe/nZU3
         A3GowwVj00yOqWuYAhfHzqpzx48v1+oLRkcc1wnFmxcAhOUw1OTM84AHEVnXkBB9Ef3A
         kvl7iMwJlMGgfbcWThabWdYyMqLpUfzaxx7rXKZsOoI8eY7sAi5gLMrQWj5acNGSSsXl
         Dl7A==
X-Gm-Message-State: AGRZ1gLqJOTbvKj9Qy3NNLBH7T1L3LjSRrX3HqaONpBob9JC/8AIwZQs
        ilj98pzA323NT2nP/gjVdiTKag==
X-Google-Smtp-Source: AJdET5fB/sfMUu3wKd+ObYuigORacvhqh9qLS5vizCv2Vfa98s4DDp0jjsc85nyNiiYH8ejUiOxM4A==
X-Received: by 2002:a17:902:b70a:: with SMTP id d10-v6mr181769pls.199.1540446823059;
        Wed, 24 Oct 2018 22:53:43 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id d186-v6sm7829835pfg.173.2018.10.24.22.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 22:53:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 08/10] OPP: Configure all required OPPs
Date:   Thu, 25 Oct 2018 11:22:45 +0530
Message-Id: <f49e46f8cd45f7458dfbaf0abac1d2941136ae19.1540446493.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the infrastructure is in place to support multiple required
OPPs, lets switch over to using it.

A new internal routine _set_required_opps() takes care of updating
performance state for all the required OPPs. With this the performance
state updates are supported even when the end device needs to configure
regulators as well, that wasn't the case earlier.

The pstates were earlier stored in the end device's OPP structures, that
also changes now as those values are stored in the genpd's OPP
structures. And so we switch over to using
pm_genpd_opp_to_performance_state() instead of
of_genpd_opp_to_performance_state() to get performance state for the
genpd OPPs.

The routine _generic_set_opp_domain() is not required anymore and is
removed.

On errors we don't try to recover by reverting to old settings as things
are really complex now and the calls here should never really fail
unless there is a bug. There is no point increasing the complexity, for
code which will never be executed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 113 ++++++++++++++++++++++++++-------------------
 drivers/opp/of.c   |   5 +-
 2 files changed, 68 insertions(+), 50 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cef2ccda355d..0eaa954b3f6c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -548,44 +548,6 @@ _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
-static inline int
-_generic_set_opp_domain(struct device *dev, struct clk *clk,
-			unsigned long old_freq, unsigned long freq,
-			unsigned int old_pstate, unsigned int new_pstate)
-{
-	int ret;
-
-	/* Scaling up? Scale domain performance state before frequency */
-	if (freq > old_freq) {
-		ret = dev_pm_genpd_set_performance_state(dev, new_pstate);
-		if (ret)
-			return ret;
-	}
-
-	ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
-	if (ret)
-		goto restore_domain_state;
-
-	/* Scaling down? Scale domain performance state after frequency */
-	if (freq < old_freq) {
-		ret = dev_pm_genpd_set_performance_state(dev, new_pstate);
-		if (ret)
-			goto restore_freq;
-	}
-
-	return 0;
-
-restore_freq:
-	if (_generic_set_opp_clk_only(dev, clk, freq, old_freq))
-		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
-			__func__, old_freq);
-restore_domain_state:
-	if (freq > old_freq)
-		dev_pm_genpd_set_performance_state(dev, old_pstate);
-
-	return ret;
-}
-
 static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 				      struct device *dev,
 				      unsigned long old_freq,
@@ -663,6 +625,56 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 	return opp_table->set_opp(data);
 }
 
+/* This is only called for PM domain for now */
+static int _set_required_opps(struct device *dev,
+			      struct opp_table *opp_table,
+			      struct dev_pm_opp *opp)
+{
+	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
+	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
+	unsigned int pstate;
+	int i, ret = 0;
+
+	if (!required_opp_tables)
+		return 0;
+
+	/* Single genpd case */
+	if (!genpd_virt_devs) {
+		pstate = opp->required_opps[0]->pstate;
+		ret = dev_pm_genpd_set_performance_state(dev, pstate);
+		if (ret) {
+			dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
+				dev_name(dev), pstate, ret);
+		}
+		return ret;
+	}
+
+	/* Multiple genpd case */
+
+	/*
+	 * Acquire genpd_virt_dev_lock to make sure we don't use a genpd_dev
+	 * after it is freed from another thread.
+	 */
+	mutex_lock(&opp_table->genpd_virt_dev_lock);
+
+	for (i = 0; i < opp_table->required_opp_count; i++) {
+		pstate = opp->required_opps[i]->pstate;
+
+		if (!genpd_virt_devs[i])
+			continue;
+
+		ret = dev_pm_genpd_set_performance_state(genpd_virt_devs[i], pstate);
+		if (ret) {
+			dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
+				dev_name(genpd_virt_devs[i]), pstate, ret);
+			break;
+		}
+	}
+	mutex_unlock(&opp_table->genpd_virt_dev_lock);
+
+	return ret;
+}
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
@@ -730,6 +742,13 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
 		old_freq, freq);
 
+	/* Scaling up? Configure required OPPs before frequency */
+	if (freq > old_freq) {
+		ret = _set_required_opps(dev, opp_table, opp);
+		if (ret)
+			goto put_opp;
+	}
+
 	if (opp_table->set_opp) {
 		ret = _set_opp_custom(opp_table, dev, old_freq, freq,
 				      IS_ERR(old_opp) ? NULL : old_opp->supplies,
@@ -740,19 +759,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 						 opp->supplies);
 	} else {
 		/* Only frequency scaling */
+		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+	}
 
-		/*
-		 * We don't support devices with both regulator and
-		 * domain performance-state for now.
-		 */
-		if (opp_table->genpd_performance_state)
-			ret = _generic_set_opp_domain(dev, clk, old_freq, freq,
-						      IS_ERR(old_opp) ? 0 : old_opp->pstate,
-						      opp->pstate);
-		else
-			ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+	/* Scaling down? Configure required OPPs after frequency */
+	if (!ret && freq < old_freq) {
+		ret = _set_required_opps(dev, opp_table, opp);
+		if (ret)
+			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
 
+put_opp:
 	dev_pm_opp_put(opp);
 put_old_opp:
 	if (!IS_ERR(old_opp))
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 71aef28953c2..4e494720ac25 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -595,12 +595,13 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
-	new_opp->pstate = of_genpd_opp_to_performance_state(dev, np);
-
 	ret = opp_parse_supplies(new_opp, dev, opp_table);
 	if (ret)
 		goto free_required_opps;
 
+	if (opp_table->is_genpd)
+		new_opp->pstate = pm_genpd_opp_to_performance_state(dev, new_opp);
+
 	ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
 	if (ret) {
 		/* Don't return error for duplicate OPPs */
-- 
2.19.1.568.g152ad8e3369a

