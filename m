Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42550ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB6320867
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxjJqa1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB6320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbeITEAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:00:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33633 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbeITEAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:00:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so93034pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6ebVYraCbWvrsnGm3xtUNzVrcWRfL2zqlZLpD6LOi2s=;
        b=dxjJqa1vvwPFcHa03u/ywqzWZVjSAg+zQ0FUfhWhg+CmV6zWPXiDg3FTuIg/a0YyKI
         4YVIOIxjGAif2hAns3p6bTfCickHn0wwirtX58hXnPGGb1t/6shCyxGqOmSI8z+8eZVK
         dmbmYz3dZ2xnncmMbnMPyAifJLoOg2CG1zSzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6ebVYraCbWvrsnGm3xtUNzVrcWRfL2zqlZLpD6LOi2s=;
        b=B1vXiyfF4mVgwfFRgkIdppZashqcKWuA78kjJwecBm6JaTbHKAB8ni1b328bmHd+m2
         mAkC9lRK7qfgiR2AydgK7p+PAqPY1sAzO60dlC9FkK7EtYsbFl7H6TeHOnLoED616JH5
         cZHniOMbrxV26ZFvTME/uh6GHX2Fk8kpFA6UDTQ2G+YmjlwlWdfNexqGYi8LC01wZlbP
         tJFMikMCHiWxSScrGqg9KD7gReJFu90Q9BgFGIQpJsl2SspBLDLfie85I7ISKCwlE8Cy
         lSiAngREsC71U6wA7izYxdwLlEytJHppgTzW6A9j4kQBZkOiaF1ukPkCpHuZGsCFjGL1
         RQFQ==
X-Gm-Message-State: APzg51CmGx0NIzc7gvnK8f5gaxrH5rU6/C0tCmAmiKVQCmua+VsYcbN7
        UDob00Gz9x8M1m08+4WgfLqB4w==
X-Google-Smtp-Source: ANB0VdaEj/eLZDr/amGlqwY/1hmlKGRwTKBTzK6zP/15g6546upj42Yc4ps0qiPIJmkXUuJYRhYZig==
X-Received: by 2002:a62:438f:: with SMTP id l15-v6mr38615178pfi.196.1537395650494;
        Wed, 19 Sep 2018 15:20:50 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id u184-v6sm41809554pgd.46.2018.09.19.15.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:49 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/12] OPP: Parse OPP table's DT properties from _of_init_opp_table()
Date:   Wed, 19 Sep 2018 15:20:24 -0700
Message-Id: <f06ed90e7051a3a50c2172001c86ff9645e5c2ba.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
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

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c  | 79 +++++++++++++++++++++++++++++++++----------------------
 drivers/opp/opp.h |  2 ++
 2 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1a9e1242a2a7..4a19f76880d3 100644
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
index b235e76fc8cc..b04c2b511c4d 100644
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
2.14.1

