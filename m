Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7223C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8022D2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c70DCuhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8022D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeJLSoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:44:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43478 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeJLSoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:44:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id 30-v6so5774750plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W7x0CiKb4U6qIR1zXs5ITgLcyJxUy+TLv0dVjSNwJic=;
        b=c70DCuhJCrcHCiyYNXpWSLjp8BDBV9DaDf//Lo+hMZKPWCOxggc1q/ZQjZBXoXvAmn
         VAsNNq6yprZTKf0ql4H2nTKcozARHVDW1l+Ao/aftttNEDOSPEoQRiKpXG3rJMmY7qEu
         qgZfMoRzRbahtlZm99W+CTUsS8QvPj0vNSc+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W7x0CiKb4U6qIR1zXs5ITgLcyJxUy+TLv0dVjSNwJic=;
        b=r2KTAOI93lmeeEFQJr/pu+CX3TwQbMT2G1JF34zNyUI+vM1BHKRIxI/XXI2rjiHci6
         bLQqog4I/Fn6v8SEhwYo+MOZwJBCqSice2ph9fL3w5mcxKrVgVpp3o1LzExLMgBm+7G+
         q5M1t5WYdvqypJAgsLLDwmI1AO6E6WrB/260SvYo/uBzo2BiPxfDMMYd34e+E5R39/29
         fuGEA+WSoxGWSDhF/mNfI8mwdCmzmGP/R6Ylf4p1KnEpI1I/E864Z200b2Y6LSiLxlTR
         C+4iAuk7FyYXF4MIwbYHpFOJa3SBZtkZ/bQuzJG75MQNyTt244AjeEGcM4X+PIhavk7X
         xRJQ==
X-Gm-Message-State: ABuFfojjvEwGexDHa6AQjtL3bOoeAaF3pVOBof3m/VKmVxyrpAoSj3ip
        QBIpaIChuBr/rcFRRzEtzmPJGg==
X-Google-Smtp-Source: ACcGV62XwYP2b4JgBOz28Z1SBkqBTdXdP/98N6TRgKhpHKYydunRVuhz45DQ8wJImn3VpzHHiQ19Og==
X-Received: by 2002:a17:902:8342:: with SMTP id z2-v6mr5428232pln.147.1539342724696;
        Fri, 12 Oct 2018 04:12:04 -0700 (PDT)
Received: from localhost ([122.171.67.41])
        by smtp.gmail.com with ESMTPSA id q21-v6sm5728065pfq.51.2018.10.12.04.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 04:12:04 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 7/9] OPP: Configure all required OPPs
Date:   Fri, 12 Oct 2018 16:41:15 +0530
Message-Id: <e23cf6535abffbe9d2db63a555089cdc6d2d1d14.1539341929.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org>
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
genpd_opp_to_performance_state() instead of
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
index 8d7bf9d83752..1eeb89ab9a68 100644
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
+	struct device **genpd_devices = opp_table->genpd_devices;
+	unsigned int pstate;
+	int i, ret = 0;
+
+	if (!required_opp_tables)
+		return 0;
+
+	/* Single genpd case */
+	if (!genpd_devices) {
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
+	 * Acquire genpd_dev_lock to make sure we don't use a genpd_dev after it
+	 * is freed from another thread.
+	 */
+	mutex_lock(&opp_table->genpd_dev_lock);
+
+	for (i = 0; i < opp_table->required_opp_count; i++) {
+		pstate = opp->required_opps[i]->pstate;
+
+		if (!genpd_devices[i])
+			continue;
+
+		ret = dev_pm_genpd_set_performance_state(genpd_devices[i], pstate);
+		if (ret) {
+			dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
+				dev_name(genpd_devices[i]), pstate, ret);
+			break;
+		}
+	}
+	mutex_unlock(&opp_table->genpd_dev_lock);
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
index fd67c9b55d7d..f4e8895542ca 100644
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
+		new_opp->pstate = genpd_opp_to_performance_state(dev, new_opp);
+
 	ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
 	if (ret) {
 		/* Don't return error for duplicate OPPs */
-- 
2.18.0.rc1.242.g61856ae69a2c

