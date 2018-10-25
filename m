Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE45ECDE48
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDB52083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQEuGLEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDB52083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeJYOYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:24:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40010 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeJYOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:24:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so3634985pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fp7IC5dc3v+2e4B0y+2fHWDmlFb+BdqMV9R5pA/jnGE=;
        b=AQEuGLEXC5HVD+HfyO0AkubrRPhqkCTiPbkmY0xJqVZQcWsPp7TTcD8ePYOaPIhgea
         Ik58+zw4R8FDq9Sgk0sh0uyZ4O3iut0XadsE2olMIQm5psc4fFflzy6lDsBqNJM7AL5c
         2Bb3aTXh1EjwTDGImvkLDRN622cVILjjYok1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fp7IC5dc3v+2e4B0y+2fHWDmlFb+BdqMV9R5pA/jnGE=;
        b=cS3i8iK4h8lrWBomUo9NfJZvZtrCRQtYSS6SfSvFIy7gVvOoKyv1zAQOxCCDhY43D/
         6jg0CPzukp6AWW6Cd/z2SijDdoC72YjfdJv4V4MKHU/I3BytiYGVsWuZ33//41WgQFdO
         Ujb9z3FmQQOgZwePupL/Ag/AcJKMx0nJR5xTafaGyQk9v9MwcRTiiz00hZVTAPV956N0
         Y0LXki2r0BWN+9KemwjCpVaL+4FxrMOZ1PZlYgIrC3HsMl+2+oSdPPpURtr3kKKVjnqs
         RQmgAHEKQBanPADRcjqfHDtLiJ/pZvqTVNyrg7W6StYKi2/TxO2rLZnK4yuhv0pP3Iil
         FoWw==
X-Gm-Message-State: AGRZ1gJYngoTBf3FwkPBi9bSqSvCsWlVaPDTq9Ta9220AoGYmuoBIBnx
        TanNxfNDX6tu3ZX1DAPET9aRtGbdeBc=
X-Google-Smtp-Source: AJdET5dA6hJxvXrkTKbVaUNgD3S+5g2G1QS+WtPVMHUEF7WxxVcU6cTBJut28dnbl1iU+CE3wZfG8w==
X-Received: by 2002:a63:9712:: with SMTP id n18-v6mr211308pge.182.1540446812319;
        Wed, 24 Oct 2018 22:53:32 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id z2-v6sm1404750pfm.106.2018.10.24.22.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 22:53:31 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 05/10] OPP: Populate OPPs from "required-opps" property
Date:   Thu, 25 Oct 2018 11:22:42 +0530
Message-Id: <b3896241b434b98b71957a2e56195b9a7a13156c.1540446493.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An earlier commit populated the OPP tables from the "required-opps"
property, this commit populates the individual OPPs. This is repeated
for each OPP in the OPP table and these populated OPPs will be used by
later commits.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  1 +
 drivers/opp/of.c   | 81 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/opp/opp.h  |  6 ++++
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 85174a5c4850..02a69a62dac8 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -976,6 +976,7 @@ static void _opp_kref_release(struct kref *kref)
 	 * frequency/voltage list.
 	 */
 	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_REMOVE, opp);
+	_of_opp_free_required_opps(opp_table, opp);
 	opp_debug_remove_one(opp);
 	list_del(&opp->node);
 	kfree(opp);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index b5605196122a..ffaeefef98ce 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -259,6 +259,77 @@ void _of_clear_opp_table(struct opp_table *opp_table)
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
+	int i;
+
+	if (!required_opps)
+		return;
+
+	for (i = 0; i < opp_table->required_opp_count; i++) {
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
+	struct dev_pm_opp **required_opps;
+	struct opp_table *required_table;
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
+		required_table = opp_table->required_opp_tables[i];
+
+		np = of_parse_required_opp(opp->np, i);
+		if (unlikely(!np)) {
+			ret = -ENODEV;
+			goto free_required_opps;
+		}
+
+		required_opps[i] = _find_opp_of_np(required_table, np);
+		of_node_put(np);
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
@@ -503,6 +574,10 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	new_opp->dynamic = false;
 	new_opp->available = true;
 
+	ret = _of_opp_alloc_required_opps(opp_table, new_opp);
+	if (ret)
+		goto free_opp;
+
 	if (!of_property_read_u32(np, "clock-latency-ns", &val))
 		new_opp->clock_latency_ns = val;
 
@@ -510,14 +585,14 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 
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
@@ -547,6 +622,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ADD, new_opp);
 	return new_opp;
 
+free_required_opps:
+	_of_opp_free_required_opps(opp_table, new_opp);
 free_opp:
 	_opp_free(new_opp);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 024e1be23d37..24b340ad18d1 100644
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
@@ -216,10 +218,14 @@ void _put_opp_list_kref(struct opp_table *opp_table);
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
 void _of_clear_opp_table(struct opp_table *opp_table);
 struct opp_table *_managed_opp(struct device *dev, int index);
+void _of_opp_free_required_opps(struct opp_table *opp_table,
+				struct dev_pm_opp *opp);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
 static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
 static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
+static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
+					      struct dev_pm_opp *opp) {}
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.19.1.568.g152ad8e3369a

