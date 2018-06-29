Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199AEC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE4727B33
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MLNvcr1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE4727B33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933738AbeF2GVa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:21:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43833 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754613AbeF2GUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:20:11 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so3733863pfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7p1A7z4Vn09G1lmhenJN0/W2ncsp/nbi2IYjY6GsVLM=;
        b=MLNvcr1dbLaC1xg5sPo6raj7cUKfARaHDwI5BrybEhHJxPiW1A1GC9tkT/cukUbsd/
         89yYLlRA1u9emJXgkAwfQaSoNy0SzaLfPS3AmRFPHXRBWJiSSy+2iVJL8ZyfMIoOXe2S
         iS7F8UFWJbZr2N57FRkhQxCpJFmB1K+wJd8OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7p1A7z4Vn09G1lmhenJN0/W2ncsp/nbi2IYjY6GsVLM=;
        b=GbQdu/tASYK4Y/Z2WG7XHBEk0IZ8N16UGN9CnUdzu4ZmNooFw3mqlwesrEK5yJDbIy
         AQo/OvgVqWtc43GKlgHrMjiCf/k/sd5U0Z9CzZ1s5ZrYM2U2kqa6tl5x+ryb/o/jDYMm
         y32F7dIKElBunHn5JyCYTg7wiwtImBIM9JlI8Olpk1m2PRWL4LpDRRIBIqkFuQjSKoJI
         eXsA3SOXsCZYWoyChAsDnHIIRml9RN5J0B/O4/ckOq3+ZakGN1YfxZdeWiu/jKtHwEvd
         tfurAHXHlJs7zFtmVHhmmw0PyewPpT16ziwRh+gt0yWY7x9NTO5U8y/65uj71BzQAR8F
         SLyQ==
X-Gm-Message-State: APt69E2tPLQhTW95HR03e9mQv5lTZdxnfPrI/5mZ+7Xcr9IS2Ouhf9Fe
        AJgqC060Az0UDZxP5j07vz61qQ==
X-Google-Smtp-Source: ADUXVKKCAAUp9xaOasonA4F4WciLudXX7CKU7n/1W2cMvbGvFcabtC3fYMOAkXfvK50DdjaKci3erg==
X-Received: by 2002:a65:62cd:: with SMTP id m13-v6mr11430291pgv.280.1530253210643;
        Thu, 28 Jun 2018 23:20:10 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id y81-v6sm21434600pfd.178.2018.06.28.23.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 23:20:10 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] OPP: Populate OPPs from "required-opps" property
Date:   Fri, 29 Jun 2018 11:49:35 +0530
Message-Id: <ba61fa8806c61a3408caed3074890371a07acb03.1530252803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An earlier commit populated the OPP tables from the "required-opps"
property, this commit populates the individual OPPs. This is repeated
for each OPP in the OPP table and these populated OPPs will be used by
later commits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  1 +
 drivers/opp/of.c   | 93 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/opp/opp.h  |  6 +++
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 22c927c5e4ea..acc34c238fd6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -906,6 +906,7 @@ static void _opp_kref_release(struct kref *kref)
 	 * frequency/voltage list.
 	 */
 	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_REMOVE, opp);
+	_of_opp_free_required_opps(opp_table, opp);
 	opp_debug_remove_one(opp);
 	list_del(&opp->node);
 	kfree(opp);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index b639195a1e3d..ffefccfdbc26 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -244,6 +244,89 @@ void _of_clear_opp_table(struct opp_table *opp_table)
 	_opp_table_free_required_tables(opp_table);
 }
 
+/*
+ * Release all resources previously acquired with a call to
+ * _of_opp_alloc_required_opps().
+ */
+void _of_opp_free_required_opps(struct opp_table *opp_table,
+				struct dev_pm_opp *opp)
+{
+	struct dev_pm_opp **required_opps = opp->required_opps;
+	int i, count = opp_table->required_opp_count;
+
+	if (!count)
+		return;
+
+	for (i = 0; i < count; i++) {
+		if (!required_opps[i])
+			break;
+
+		/* Put the reference back */
+		dev_pm_opp_put(required_opps[i]);
+	}
+
+	kfree(required_opps);
+	opp->required_opps = NULL;
+}
+
+/* Populate all required OPPs which are part of "required-opps" list */
+static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
+				       struct dev_pm_opp *opp)
+{
+	struct dev_pm_opp *temp_opp, **required_opps;
+	struct opp_table *temp_table;
+	struct device_node *np;
+	int i, ret, count = opp_table->required_opp_count;
+
+	if (!count)
+		return 0;
+
+	required_opps = kcalloc(count, sizeof(*required_opps), GFP_KERNEL);
+	if (!required_opps)
+		return -ENOMEM;
+
+	opp->required_opps = required_opps;
+
+	for (i = 0; i < count; i++) {
+		temp_table = opp_table->required_opp_tables[i];
+
+		np = of_parse_phandle(opp->np, "required-opps", i);
+		if (unlikely(!np)) {
+			pr_err("%s: Unable to parse required-opps: %pOF (%d)\n",
+			       __func__, opp->np, i);
+			ret = -ENODEV;
+			goto free_required_opps;
+		}
+
+		mutex_lock(&temp_table->lock);
+
+		list_for_each_entry(temp_opp, &temp_table->opp_list, node) {
+			if (temp_opp->np == np) {
+				/* Take a reference to the OPP */
+				dev_pm_opp_get(temp_opp);
+				required_opps[i] = temp_opp;
+				break;
+			}
+		}
+
+		mutex_unlock(&temp_table->lock);
+
+		if (!required_opps[i]) {
+			pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
+			       __func__, opp->np, i);
+			ret = -ENODEV;
+			goto free_required_opps;
+		}
+	}
+
+	return 0;
+
+free_required_opps:
+	_of_opp_free_required_opps(opp_table, opp);
+
+	return ret;
+}
+
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
 {
@@ -482,6 +565,10 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	new_opp->dynamic = false;
 	new_opp->available = true;
 
+	ret = _of_opp_alloc_required_opps(opp_table, new_opp);
+	if (ret)
+		goto free_opp;
+
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
@@ -489,14 +576,14 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 
 	ret = opp_parse_supplies(new_opp, dev, opp_table);
 	if (ret)
-		goto free_opp;
+		goto free_required_opps;
 
 	ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
 	if (ret) {
 		/* Don't return error for duplicate OPPs */
 		if (ret == -EBUSY)
 			ret = 0;
-		goto free_opp;
+		goto free_required_opps;
 	}
 
 	/* OPP to select on device suspend */
@@ -526,6 +613,8 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ADD, new_opp);
 	return 0;
 
+free_required_opps:
+	_of_opp_free_required_opps(opp_table, new_opp);
 free_opp:
 	_opp_free(new_opp);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index fea70c71cc99..9efdc3e4840c 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -63,6 +63,7 @@ extern struct list_head opp_tables;
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
  *		frequency from any other OPP's frequency.
+ * @required_opps: List of OPPs that are required by this OPP.
  * @opp_table:	points back to the opp_table struct this opp belongs to
  * @np:		OPP's device node.
  * @dentry:	debugfs dentry pointer (per opp)
@@ -84,6 +85,7 @@ struct dev_pm_opp {
 
 	unsigned long clock_latency_ns;
 
+	struct dev_pm_opp **required_opps;
 	struct opp_table *opp_table;
 
 	struct device_node *np;
@@ -210,9 +212,13 @@ struct opp_table *_add_opp_table(struct device *dev);
 #ifdef CONFIG_OF
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev);
 void _of_clear_opp_table(struct opp_table *opp_table);
+void _of_opp_free_required_opps(struct opp_table *opp_table,
+				struct dev_pm_opp *opp);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev) {}
 static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
+static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
+					      struct dev_pm_opp *opp) {}
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.18.0.rc1.242.g61856ae69a2c

