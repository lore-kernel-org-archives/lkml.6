Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C29C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A92120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZ4mD9OP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A92120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeILNd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:33:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41198 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILNd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:33:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so665197pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a64G58V8et84UbVCYe1qqjcYTUZTiK5vlPsAeWbwcVI=;
        b=XZ4mD9OPrI+JroMzHFWxIqIHmDNgkY8ABearv69nG5wQChTGC5Vn5ysiDsUmyYR1FC
         t4nGKvqw5HfRzckZ7RObiVZxrviux66ZcQEkV1A76xBS5He+RCBSBHABk2fhoX1GbMkg
         VCigB26LGdHcrAYZkTFQ32ie98xqSo1HmchjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a64G58V8et84UbVCYe1qqjcYTUZTiK5vlPsAeWbwcVI=;
        b=IOmYTP8KsJsTjECNuosU1OUeQjrsLJdbyN2E83ND983zZevjJeXC0i421+c+hQasdF
         qQn/UHhdIBJ2q4/mLBYGoe+bGy1WS1VOM+af5FBmK+lYg19qOBrf5eWy/Qh95MXYXwoH
         1cHY3AE2B03tom2QBPNyoDyCPSsMK9nC2+LY/7RAx3pXkMuUljad79Cipgw51qH4D9uL
         kAy+lmgVEi+GtuRFu5S9AfcCKNgiEoX63nrHfU16t+wiFYa2w/YHtKEGI4rqQ8TMUN2k
         Nb/2DgNsH3IUxcSfEqyucfJVyQew8pPYYyXTIj7+oA6CZDQNHzFO/7tZrpMI4SB63FJP
         7Q3w==
X-Gm-Message-State: APzg51DtDAeERO8cXsui6UCsWApKCKEqUC28tosymqDNTnN3HnRUDvaF
        ackVcvk1AFBiEHXjAdvDOkuVvQ==
X-Google-Smtp-Source: ANB0Vdaa31py0iblp1gOUwoX6Nv0j0/DRZ0Y3D1koQ2vDrgOPArwuFkGFV7okirJ2JWY1Mk9xdcUGg==
X-Received: by 2002:a65:6413:: with SMTP id a19-v6mr843673pgv.359.1536740999379;
        Wed, 12 Sep 2018 01:29:59 -0700 (PDT)
Received: from localhost ([122.171.64.45])
        by smtp.gmail.com with ESMTPSA id g21-v6sm916259pfe.41.2018.09.12.01.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:29:58 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] OPP: Parse OPP table's DT properties from _of_init_opp_table()
Date:   Wed, 12 Sep 2018 13:58:43 +0530
Message-Id: <9769f7f5b7772f0a96cf830209544cfb491d24f6.1536736872.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the DT properties present in the OPP table from
_of_init_opp_table(), which is a dedicated routine for DT parsing.

Minor relocation of helpers is required for this.

It is possible now for _managed_opp() to return a partially initialized
OPP table if the OPP table is created via the helpers like
dev_pm_opp_set_supported_hw() and we need another flag to indicate if
the static OPP are already parsed or not to make sure we don't
incorrectly skip initializing the static OPPs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c  | 79 ++++++++++++++++++++++++++++-------------------
 drivers/opp/opp.h |  2 ++
 2 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index a91857d163b2..ebf467b4d99e 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -23,6 +23,24 @@
 
 #include "opp.h"
 
+/*
+ * Returns opp descriptor node for a device node, caller must
+ * do of_node_put().
+ */
+static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np,
+						     int index)
+{
+	/* "operating-points-v2" can be an array for power domain providers */
+	return of_parse_phandle(np, "operating-points-v2", index);
+}
+
+/* Returns opp descriptor node for a device, caller must do of_node_put() */
+struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
+{
+	return _opp_of_get_opp_desc_node(dev->of_node, 0);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
+
 static struct opp_table *_managed_opp(const struct device_node *np)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
@@ -55,22 +73,37 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
 			int index)
 {
-	struct device_node *np;
+	struct device_node *np, *opp_np;
+	u32 val;
 
 	/*
 	 * Only required for backward compatibility with v1 bindings, but isn't
 	 * harmful for other cases. And so we do it unconditionally.
 	 */
 	np = of_node_get(dev->of_node);
-	if (np) {
-		u32 val;
-
-		if (!of_property_read_u32(np, "clock-latency", &val))
-			opp_table->clock_latency_ns_max = val;
-		of_property_read_u32(np, "voltage-tolerance",
-				     &opp_table->voltage_tolerance_v1);
-		of_node_put(np);
-	}
+	if (!np)
+		return;
+
+	if (!of_property_read_u32(np, "clock-latency", &val))
+		opp_table->clock_latency_ns_max = val;
+	of_property_read_u32(np, "voltage-tolerance",
+			     &opp_table->voltage_tolerance_v1);
+
+	/* Get OPP table node */
+	opp_np = _opp_of_get_opp_desc_node(np, index);
+	of_node_put(np);
+
+	if (!opp_np)
+		return;
+
+	if (of_property_read_bool(opp_np, "opp-shared"))
+		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
+	else
+		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
+
+	opp_table->np = opp_np;
+
+	of_node_put(opp_np);
 }
 
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
@@ -250,22 +283,6 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
-/* Returns opp descriptor node for a device node, caller must
- * do of_node_put() */
-static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np,
-						     int index)
-{
-	/* "operating-points-v2" can be an array for power domain providers */
-	return of_parse_phandle(np, "operating-points-v2", index);
-}
-
-/* Returns opp descriptor node for a device, caller must do of_node_put() */
-struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
-{
-	return _opp_of_get_opp_desc_node(dev->of_node, 0);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
-
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @opp_table:	OPP table
@@ -392,6 +409,9 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		/* OPPs are already managed */
 		if (!_add_opp_dev(dev, opp_table))
 			ret = -ENOMEM;
+		else if (!opp_table->parsed_static_opps)
+			goto initialize_static_opps;
+
 		goto put_opp_table;
 	}
 
@@ -399,6 +419,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 	if (!opp_table)
 		return -ENOMEM;
 
+initialize_static_opps:
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
 		count++;
@@ -434,11 +455,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 	if (pstate_count)
 		opp_table->genpd_performance_state = true;
 
-	opp_table->np = opp_np;
-	if (of_property_read_bool(opp_np, "opp-shared"))
-		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
-	else
-		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
+	opp_table->parsed_static_opps = true;
 
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 84aba19531b8..d218fc0a498d 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -129,6 +129,7 @@ enum opp_table_access {
  * @lock:	mutex protecting the opp_list and dev_list.
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
+ * @parsed_static_opps: True if OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @supported_hw: Array of version number to support.
@@ -164,6 +165,7 @@ struct opp_table {
 	/* For backward compatibility with v1 bindings */
 	unsigned int voltage_tolerance_v1;
 
+	bool parsed_static_opps;
 	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
-- 
2.18.0.rc1.242.g61856ae69a2c

