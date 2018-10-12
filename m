Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CA9C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950FA2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhkFqvWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950FA2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeJLSn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:43:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40813 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeJLSn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:43:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id s5-v6so6036191pfj.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tq2uoD3eSZPlHD8aKVhELPwsZk/flECXrnGOvj2sO+4=;
        b=dhkFqvWW+IcaZhMuIMWGePI24oiriSJpj8hf88QLRQhGgSCpE4lkgjex/jBZcBtStb
         K3BMrUCZ6lCJaDOW1tPKR1ag5NYyltBtBQ5wRHQUDscshUWSAFR6zzSj4HbnLD/rV9nF
         oxM29V07NM7soh+riIMnv1VUoQ8lGkTIj2fC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tq2uoD3eSZPlHD8aKVhELPwsZk/flECXrnGOvj2sO+4=;
        b=OsoDlLcU+rSHTtcI/5BPPqUp0acul1d4Kxf8ycBtIpeY/Fyzi5BI6CUl0r57A77Nh8
         W371iIqJVWLa1r4jqmliUZyFUZbpaJu1TaXrtxcMEV7CU5nl04FpHkNRjB9nbzIey/K+
         huhjcC/e925zb8//ziIWPuVYden0VV8hgz2Vlls7/mlXs5L3R/0xGDclX+JRk54PPv3D
         lctOm8aZrnTXFIzucOYhyEqXYR/PpZ8rdziIPuCz4t2tn7tkxRmOnTWpvMWE7Qgfbpd5
         jzW8VLihbBI2Kkb9Ele3spCFROEHQp00XHxV3+pBmAFbP0Clm3mqkppVHavV9Po1R7pa
         Pyuw==
X-Gm-Message-State: ABuFfoikKwowEO8ypV9pnAXJmhl2k5zCCFYKCpRHfnFdhaB+AYBtPqNT
        HK65Q787DhQnoVFVZCeFiU+X6A==
X-Google-Smtp-Source: ACcGV62LvlxKU+CsS8xtoTl9Fp8nNy+5TlKj4fnK6NQ3QHHsjOQEr7a2R8QcNX9bUUGKs4Lw94Q+iA==
X-Received: by 2002:aa7:84cc:: with SMTP id x12-v6mr5661502pfn.220.1539342721372;
        Fri, 12 Oct 2018 04:12:01 -0700 (PDT)
Received: from localhost ([122.171.67.41])
        by smtp.gmail.com with ESMTPSA id z7-v6sm1963133pff.146.2018.10.12.04.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 04:12:00 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/9] OPP: Add dev_pm_opp_{set|put}_genpd_device() helper
Date:   Fri, 12 Oct 2018 16:41:14 +0530
Message-Id: <110c9e13d8d44dfb59577256b1309dddf2ceda12.1539341929.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple generic power domains for a consumer device are supported with
the help of virtual devices, which are created for each consumer device
- genpd pair. These are the device structures which are attached to the
power domain and are required by the OPP core to set the performance
state of the genpd.

The helpers added by this commit are required to be called once for each
of these virtual devices. These are required only if multiple domains
are available for a device, otherwise the actual device structure will
be used instead by the OPP core.

The new helpers also support the complex cases where the consumer device
wouldn't always require all the domains. For example, a camera may
require only one power domain during normal operations but two during
high resolution operations. The consumer driver can call
dev_pm_opp_put_genpd_device(high_resolution_genpd_dev) if it is
currently operating in the normal mode and doesn't have any performance
requirements from the genpd which manages high resolution power
requirements. The consumer driver can later call
dev_pm_opp_set_genpd_device(high_resolution_genpd_dev) once it switches
back to the high resolution mode.

The new helpers differ from other OPP set/put helpers as the new ones
can be called with OPPs initialized for the table as we may need to call
them on the fly because of the complex case explained above. For this
reason it is possible that the genpd_device structure may be used in
parallel while the new helpers are running and a new mutex is added to
protect against that. We didn't use the existing opp_table->lock mutex
as that is widely used in the OPP core and we will need a lock in the
hotpath now, i.e.  while changing OPP and we need to make sure there is
not much contention while doing that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 88 ++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/of.c       | 16 +++++++-
 drivers/opp/opp.h      |  4 ++
 include/linux/pm_opp.h |  8 ++++
 4 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 02a69a62dac8..8d7bf9d83752 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -823,6 +823,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 		return NULL;
 
 	mutex_init(&opp_table->lock);
+	mutex_init(&opp_table->genpd_dev_lock);
 	INIT_LIST_HEAD(&opp_table->dev_list);
 
 	opp_dev = _add_opp_dev(dev, opp_table);
@@ -920,6 +921,7 @@ static void _opp_table_kref_release(struct kref *kref)
 		_remove_opp_dev(opp_dev, opp_table);
 	}
 
+	mutex_destroy(&opp_table->genpd_dev_lock);
 	mutex_destroy(&opp_table->lock);
 	list_del(&opp_table->node);
 	kfree(opp_table);
@@ -1602,6 +1604,92 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
 
+/**
+ * dev_pm_opp_set_genpd_device - Set virtual genpd device for an index
+ * @dev: Consumer device for which the genpd device is getting set.
+ * @genpd_dev: virtual genpd device.
+ * @index: index.
+ *
+ * Multiple generic power domains for a device are supported with the help of
+ * virtual genpd devices, which are created for each consumer device - genpd
+ * pair. These are the device structures which are attached to the power domain
+ * and are required by the OPP core to set the performance state of the genpd.
+ *
+ * This helper will normally be called by the consumer driver of the device
+ * "dev", as only that has details of the genpd devices.
+ *
+ * This helper needs to be called once for each of those virtual devices, but
+ * only if multiple domains are available for a device. Otherwise the original
+ * device structure will be used instead by the OPP core.
+ */
+struct opp_table *dev_pm_opp_set_genpd_device(struct device *dev,
+					      struct device *genpd_device,
+					      int index)
+{
+	struct opp_table *opp_table;
+
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&opp_table->genpd_dev_lock);
+
+	if (unlikely(!opp_table->genpd_devices ||
+		     index >= opp_table->required_opp_count ||
+		     opp_table->genpd_devices[index])) {
+
+		dev_err(dev, "Invalid request to set required device\n");
+		dev_pm_opp_put_opp_table(opp_table);
+		mutex_unlock(&opp_table->genpd_dev_lock);
+
+		return ERR_PTR(-EINVAL);
+	}
+
+	opp_table->genpd_devices[index] = genpd_device;
+	mutex_unlock(&opp_table->genpd_dev_lock);
+
+	return opp_table;
+}
+
+/**
+ * dev_pm_opp_put_genpd_device() - Releases resources blocked for genpd device.
+ * @opp_table: OPP table returned by dev_pm_opp_set_genpd_device().
+ * @genpd_device: virtual genpd device.
+ *
+ * This releases the resource previously acquired with a call to
+ * dev_pm_opp_set_genpd_device(). The consumer driver shall call this helper if
+ * it doesn't want OPP core to update performance state of a power domain
+ * anymore.
+ */
+void dev_pm_opp_put_genpd_device(struct opp_table *opp_table,
+				 struct device *genpd_device)
+{
+	int i;
+
+	/*
+	 * Acquire genpd_dev_lock to make sure genpd_device isn't getting used
+	 * in parallel.
+	 */
+	mutex_lock(&opp_table->genpd_dev_lock);
+
+	for (i = 0; i < opp_table->required_opp_count; i++) {
+		if (opp_table->genpd_devices[i] != genpd_device)
+			continue;
+
+		opp_table->genpd_devices[i] = NULL;
+		dev_pm_opp_put_opp_table(opp_table);
+
+		/* Drop the vote */
+		dev_pm_genpd_set_performance_state(genpd_device, 0);
+		break;
+	}
+
+	mutex_unlock(&opp_table->genpd_dev_lock);
+
+	if (unlikely(i == opp_table->required_opp_count))
+		dev_err(genpd_device, "Failed to find required device entry\n");
+}
+
 /**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
  * @dev:	device for which we do this operation
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index ffaeefef98ce..fd67c9b55d7d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -134,6 +134,7 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
 static void _opp_table_free_required_tables(struct opp_table *opp_table)
 {
 	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
+	struct device **genpd_devices = opp_table->genpd_devices;
 	int i;
 
 	if (!required_opp_tables)
@@ -147,8 +148,10 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
 	}
 
 	kfree(required_opp_tables);
+	kfree(genpd_devices);
 
 	opp_table->required_opp_count = 0;
+	opp_table->genpd_devices = NULL;
 	opp_table->required_opp_tables = NULL;
 }
 
@@ -161,6 +164,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 					     struct device_node *opp_np)
 {
 	struct opp_table **required_opp_tables;
+	struct device **genpd_devices = NULL;
 	struct device_node *required_np, *np;
 	int count, i;
 
@@ -175,11 +179,21 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	if (!count)
 		goto put_np;
 
+	if (count > 1) {
+		genpd_devices = kcalloc(count, sizeof(*genpd_devices),
+					GFP_KERNEL);
+		if (!genpd_devices)
+			goto put_np;
+	}
+
 	required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
 				      GFP_KERNEL);
-	if (!required_opp_tables)
+	if (!required_opp_tables) {
+		kfree(genpd_devices);
 		goto put_np;
+	}
 
+	opp_table->genpd_devices = genpd_devices;
 	opp_table->required_opp_tables = required_opp_tables;
 	opp_table->required_opp_count = count;
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 24b340ad18d1..aea69a24c26b 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -135,6 +135,8 @@ enum opp_table_access {
  * @parsed_static_opps: True if OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
+ * @genpd_dev_lock: Mutex protecting the genpd device pointers.
+ * @genpd_devices: List of virtual devices for multiple genpd support.
  * @required_opp_tables: List of device OPP tables that are required by OPPs in
  *		this table.
  * @required_opp_count: Number of required devices.
@@ -177,6 +179,8 @@ struct opp_table {
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
+	struct mutex genpd_dev_lock;
+	struct device **genpd_devices;
 	struct opp_table **required_opp_tables;
 	unsigned int required_opp_count;
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5d399eeef172..b14600ce078f 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -126,6 +126,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
+struct opp_table *dev_pm_opp_set_genpd_device(struct device *dev, struct device *genpd_device, int index);
+void dev_pm_opp_put_genpd_device(struct opp_table *opp_table, struct device *genpd_device);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -272,6 +274,12 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
 
 static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
 
+static inline struct opp_table *dev_pm_opp_set_genpd_device(struct device *dev, struct device *genpd_device, int index)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void dev_pm_opp_put_genpd_device(struct opp_table *opp_table, struct device *genpd_device) {}
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	return -ENOTSUPP;
-- 
2.18.0.rc1.242.g61856ae69a2c

