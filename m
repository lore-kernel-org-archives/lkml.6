Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3929CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82FA2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGUDL663"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82FA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeLKL0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:26:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43201 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeLKL0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:26:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so6782612plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 03:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGPFU18FRcBHgDNjMcG97Gn8p1v4eOuwzNawMRtl3c0=;
        b=NGUDL6636OAW+dYdC5wd4YwFZHG1wqsui2WuR7n4cYm2RSbrNcTFnQPoIWvRhyP3Jn
         xSImzjVN9FIWdeuL1MeM1HF3j9sq8TfDgLGDkMMOEZILXT6yxp16fj1p7iE48acjJ4MR
         xo978ilSg63xTHs5fAC5Ojz3k6MfF7xXVWrKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGPFU18FRcBHgDNjMcG97Gn8p1v4eOuwzNawMRtl3c0=;
        b=U74JvPu+SurEPoLIhxGtdKEG/FG7Ur6zgwvXutuSe9dQ0TTq1Dr3u2KyaLrByt/Ogz
         jTfyKREsMIgrA+y/vS5qfHY6jlncDmmMOW/9T6/4LQdJ88QHB9l44rLlHaQYhWI5Rzka
         Ix+YxIUx9xfAEwPv5DxEXbzL9uTxBBqbMcO9UJ22dp43q9J7bQvu6Hgre4PzygA8A86o
         0ctwJXVkSo7jrL4xRKN5tQv7EKDrKwzEFfk3AZBpc5pHFvWy4zmgb3kh0aR8smHJRQtf
         BlJEdzIm3mfBveRVi3DBGVA8a6xbbjABDecV+mse039xusu+lEM54vyqqziZPx9k7IEJ
         ncOw==
X-Gm-Message-State: AA+aEWZLnVJnmkNgXoCjXvCZrMfNHxE8zYEjYvBBCeWzl2jktJ9HKVgw
        UVPRU5AvNAlw6nQPMRkRAP4gvQ==
X-Google-Smtp-Source: AFSGD/XOzWz3vaZrWTpOaLhROmaF7sVCum6/7qfuxBihqVLsnWxyyMJ+3h9JAdEXqy0nTfCD7ZmUww==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38mr14940803plg.250.1544527603082;
        Tue, 11 Dec 2018 03:26:43 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id n22sm29008615pfh.166.2018.12.11.03.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:26:42 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Quentin Perret <quentin.perret@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] OPP: Fix missing debugfs supply directory for OPPs
Date:   Tue, 11 Dec 2018 16:56:29 +0530
Message-Id: <46f48aca2e5aef3f430e95d1a5fb68227ec8ec85.1544527580.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <90e3577b5feb42bac1269e16bb3d2bdd8f6df40f.1544527580.git.viresh.kumar@linaro.org>
References: <90e3577b5feb42bac1269e16bb3d2bdd8f6df40f.1544527580.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one case where we may end up with no "supply" directory for the
OPPs in debugfs. That happens when the OPP core isn't managing the
regulators for the device and the device's OPP do have microvolt
property. It happens because the opp_table->regulator_count remains set
to 0 and the debugfs routines don't add any supply directory in such a
case.

This commit fixes that by setting opp_table->regulator_count to 1 in
that particular case. But to make everything work nicely and not break
other parts of the core, regulator_count is defined as "int" now instead
of "unsigned int" and it can have different special values now. It is
set to -1 initially to mark it "uninitialized" and later only we set it
to 0 or positive values after checking how many supplies are there.

This also helps in finding the bugs where only few of the OPPs have the
"opp-microvolt" property set and not all.

Fixes: 1fae788ed640 ("PM / OPP: Don't create debugfs "supply-0" directory unnecessarily")
Reported-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 12 +++++++++---
 drivers/opp/of.c   | 20 ++++++++++++++++----
 drivers/opp/opp.h  |  6 ++++--
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2d3d0d1180ea..23b086fcbf84 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -812,6 +812,9 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	mutex_init(&opp_table->lock);
 	INIT_LIST_HEAD(&opp_table->dev_list);
 
+	/* Mark regulator count uninitialized */
+	opp_table->regulator_count = -1;
+
 	opp_dev = _add_opp_dev(dev, opp_table);
 	if (!opp_dev) {
 		kfree(opp_table);
@@ -1028,7 +1031,7 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *table)
 	int count, supply_size;
 
 	/* Allocate space for at least one supply */
-	count = table->regulator_count ? table->regulator_count : 1;
+	count = table->regulator_count > 0 ? table->regulator_count : 1;
 	supply_size = sizeof(*opp->supplies) * count;
 
 	/* allocate new OPP node and supplies structures */
@@ -1433,7 +1436,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 
 	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
-	opp_table->regulator_count = 0;
+	opp_table->regulator_count = -1;
 err:
 	dev_pm_opp_put_opp_table(opp_table);
 
@@ -1462,7 +1465,7 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 
 	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
-	opp_table->regulator_count = 0;
+	opp_table->regulator_count = -1;
 
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
@@ -1615,6 +1618,9 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	if (!opp_table)
 		return -ENOMEM;
 
+	/* Fix regulator count for dynamic OPPs */
+	opp_table->regulator_count = 1;
+
 	ret = _opp_add_v1(opp_table, dev, freq, u_volt, true);
 	if (ret)
 		dev_pm_opp_put_opp_table(opp_table);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 38a08805a30c..6eb0198ab63d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -150,12 +150,10 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 			      struct opp_table *opp_table)
 {
 	u32 *microvolt, *microamp = NULL;
-	int supplies, vcount, icount, ret, i, j;
+	int supplies = opp_table->regulator_count, vcount, icount, ret, i, j;
 	struct property *prop = NULL;
 	char name[NAME_MAX];
 
-	supplies = opp_table->regulator_count ? opp_table->regulator_count : 1;
-
 	/* Search for "opp-microvolt-<name>" */
 	if (opp_table->prop_name) {
 		snprintf(name, sizeof(name), "opp-microvolt-%s",
@@ -170,7 +168,13 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 
 		/* Missing property isn't a problem, but an invalid entry is */
 		if (!prop) {
-			if (!opp_table->regulator_count)
+			if (unlikely(supplies == -1)) {
+				/* Initialize regulator_count */
+				opp_table->regulator_count = 0;
+				return 0;
+			}
+
+			if (!supplies)
 				return 0;
 
 			dev_err(dev, "%s: opp-microvolt missing although OPP managing regulators\n",
@@ -179,6 +183,14 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 		}
 	}
 
+	if (unlikely(supplies == -1)) {
+		/* Initialize regulator_count */
+		supplies = opp_table->regulator_count = 1;
+	} else if (unlikely(!supplies)) {
+		dev_err(dev, "%s: opp-microvolt wasn't expected\n", __func__);
+		return -EINVAL;
+	}
+
 	vcount = of_property_count_u32_elems(opp->np, name);
 	if (vcount < 0) {
 		dev_err(dev, "%s: Invalid %s property (%d)\n",
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9c6544b4f4f9..14d732ccad08 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -138,7 +138,9 @@ enum opp_table_access {
  * @prop_name: A name to postfix to many DT properties, while parsing them.
  * @clk: Device's clock handle
  * @regulators: Supply regulators
- * @regulator_count: Number of power supply regulators
+ * @regulator_count: Number of power supply regulators. Its value can be -1
+ * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
+ * property).
  * @genpd_performance_state: Device's power domain support performance state.
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
@@ -176,7 +178,7 @@ struct opp_table {
 	const char *prop_name;
 	struct clk *clk;
 	struct regulator **regulators;
-	unsigned int regulator_count;
+	int regulator_count;
 	bool genpd_performance_state;
 
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
-- 
2.19.1.568.g152ad8e3369a

