Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC952C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B5D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3osEZ3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B5D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbeITEBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:01:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36482 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387460AbeITEBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:01:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so3357193pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FGjzVhkQGPOODLqAXRdoaHZm4n2l5c0zwlvyqWMhwuw=;
        b=a3osEZ3sHowHWjU78Z2zkw3YpuUItl/Yoh4wmulmmJDKNHQ3lp3Dbe2TntakK96VCQ
         DhSc6Zkvb5Pgo8QlXVP/JW0mum/05dyz13mMThJVeKiSbRnZbv9wa//6BenKqDIQcdEI
         MLX3cNzrrg51ZD9vTtSY70F1UuFfmJKQ9b59Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FGjzVhkQGPOODLqAXRdoaHZm4n2l5c0zwlvyqWMhwuw=;
        b=Yd6SQ9fL7lP2M9ZKAMw0qh9hJLLWXyW+qk4OifrxKWzwIGswwXQNLFFNpJA5U+vX8c
         frorBwf/w6m+5pNVrGhxiKKuDnr5LraEsao04nNNIEh5egu6C22cTBqi0fNoqSs0zlKV
         W2+0i8z/k/oHKt7jI7yPzgLa2uBzoDLn1kz+25zLizrLs40qmq1Cj2m0coV4Y38yezts
         xpdoqrpaAF4LaH3z5eZ+aq2fx30iI/ikwF+WYBfshHZqMP27olxN5FJ2r4mGqdPZSwPa
         oSk3KmcpdP5YWageczuybz64nEtxCQyrFclWPyPitDFMX4+Zk2Ny+lMygR4n97v6YZns
         ujvA==
X-Gm-Message-State: APzg51Cpv8JhGdQP8nh0B7gYVW9nEcwtIX0RThVEL3UbQ1jZHfhOKprD
        Dbp+um6s7px8T/b9M/+rOwFaWQ==
X-Google-Smtp-Source: ANB0VdYr4472Fk9sjTEL+bGEBu5U0/cqXD+U0GdhXLXBcq1nrQdmD9YZeAvNJkaMit7RnSoyOfD5ew==
X-Received: by 2002:a63:7a50:: with SMTP id j16-v6mr97237pgn.112.1537395658493;
        Wed, 19 Sep 2018 15:20:58 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id v26-v6sm30312412pfe.57.2018.09.19.15.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 10/12] OPP: Use a single mechanism to free the OPP table
Date:   Wed, 19 Sep 2018 15:20:29 -0700
Message-Id: <cdd6ed90cdb6c2fd982909501f0a109274147fb4.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are two separate ways to free the OPP table based on how
it is created in the first place.

We call _dev_pm_opp_remove_table() to free the static and/or dynamic
OPP, OPP list devices, etc. This is done for the case where the OPP
table is added while initializing the OPPs, like via the path
dev_pm_opp_of_add_table().

We also call dev_pm_opp_put_opp_table() in some cases which eventually
frees the OPP table structure once the reference count reaches 0. This
is used by the first case as well as other cases like
dev_pm_opp_set_regulators() where the OPPs aren't necessarily
initialized at this point.

This whole thing is a bit unclear and messy and obstruct any further
cleanup/fixup of OPP core.

This patch tries to streamline this by keeping a single path for OPP
table destruction, i.e. dev_pm_opp_put_opp_table().

All the cleanup happens in _opp_table_kref_release() now after the
reference count reaches 0. _dev_pm_opp_remove_table() is removed as it
isn't required anymore.

We don't drop the reference to the OPP table after creating it from
_of_add_opp_table_v{1|2}() anymore and the same is dropped only when we
try to remove them.

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 54 ++++++++++++++++--------------------------------------
 drivers/opp/of.c   | 32 ++++++++++++++++++--------------
 drivers/opp/opp.h  |  2 +-
 3 files changed, 35 insertions(+), 53 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2319ad4a0177..d3e33fd32694 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -867,23 +867,24 @@ struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev,
 static void _opp_table_kref_release(struct kref *kref)
 {
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
-	struct opp_device *opp_dev;
+	struct opp_device *opp_dev, *temp;
 
 	/* Release clk */
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
 
-	/*
-	 * No need to take opp_table->lock here as we are guaranteed that no
-	 * references to the OPP table are taken at this point.
-	 */
-	opp_dev = list_first_entry(&opp_table->dev_list, struct opp_device,
-				   node);
+	WARN_ON(!list_empty(&opp_table->opp_list));
 
-	_remove_opp_dev(opp_dev, opp_table);
+	list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node) {
+		/*
+		 * The OPP table is getting removed, drop the performance state
+		 * constraints.
+		 */
+		if (opp_table->genpd_performance_state)
+			dev_pm_genpd_set_performance_state((struct device *)(opp_dev->dev), 0);
 
-	/* dev_list must be empty now */
-	WARN_ON(!list_empty(&opp_table->dev_list));
+		_remove_opp_dev(opp_dev, opp_table);
+	}
 
 	mutex_destroy(&opp_table->lock);
 	list_del(&opp_table->node);
@@ -1758,33 +1759,6 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
 }
 EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
 
-/*
- * Free OPPs either created using static entries present in DT.
- */
-void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev)
-{
-	/* Protect dev_list */
-	mutex_lock(&opp_table->lock);
-
-	/* Find if opp_table manages a single device */
-	if (list_is_singular(&opp_table->dev_list)) {
-		/* Free static OPPs */
-		_put_opp_list_kref(opp_table);
-
-		/*
-		 * The OPP table is getting removed, drop the performance state
-		 * constraints.
-		 */
-		if (opp_table->genpd_performance_state)
-			dev_pm_genpd_set_performance_state(dev, 0);
-	} else {
-		_put_opp_list_kref(opp_table);
-		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
-	}
-
-	mutex_unlock(&opp_table->lock);
-}
-
 void _dev_pm_opp_find_and_remove_table(struct device *dev)
 {
 	struct opp_table *opp_table;
@@ -1802,8 +1776,12 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
 		return;
 	}
 
-	_dev_pm_opp_remove_table(opp_table, dev);
+	_put_opp_list_kref(opp_table);
+
+	/* Drop reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
 
+	/* Drop reference taken while the OPP table was added */
 	dev_pm_opp_put_opp_table(opp_table);
 }
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 861cc75de329..ae0436eaa911 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -407,14 +407,17 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 	opp_table = _managed_opp(opp_np);
 	if (opp_table) {
 		/* OPPs are already managed */
-		if (!_add_opp_dev(dev, opp_table))
+		if (!_add_opp_dev(dev, opp_table)) {
 			ret = -ENOMEM;
-		else if (!opp_table->parsed_static_opps)
-			goto initialize_static_opps;
-		else
+			goto put_opp_table;
+		}
+
+		if (opp_table->parsed_static_opps) {
 			kref_get(&opp_table->list_kref);
+			return 0;
+		}
 
-		goto put_opp_table;
+		goto initialize_static_opps;
 	}
 
 	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
@@ -432,17 +435,15 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
-			_dev_pm_opp_remove_table(opp_table, dev);
 			of_node_put(np);
-			goto put_opp_table;
+			goto put_list_kref;
 		}
 	}
 
 	/* There should be one of more OPP defined */
 	if (WARN_ON(!count)) {
 		ret = -ENOENT;
-		_put_opp_list_kref(opp_table);
-		goto put_opp_table;
+		goto put_list_kref;
 	}
 
 	list_for_each_entry(opp, &opp_table->opp_list, node)
@@ -453,8 +454,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
 		ret = -ENOENT;
-		_dev_pm_opp_remove_table(opp_table, dev);
-		goto put_opp_table;
+		goto put_list_kref;
 	}
 
 	if (pstate_count)
@@ -462,6 +462,10 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 
 	opp_table->parsed_static_opps = true;
 
+	return 0;
+
+put_list_kref:
+	_put_opp_list_kref(opp_table);
 put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
 
@@ -507,13 +511,13 @@ static int _of_add_opp_table_v1(struct device *dev)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
-			_dev_pm_opp_remove_table(opp_table, dev);
-			break;
+			_put_opp_list_kref(opp_table);
+			dev_pm_opp_put_opp_table(opp_table);
+			return ret;
 		}
 		nr -= 2;
 	}
 
-	dev_pm_opp_put_opp_table(opp_table);
 	return ret;
 }
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 98dd7d39e1ad..f9fbb7553fc4 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -190,11 +190,11 @@ struct opp_table {
 
 /* Routines internal to opp core */
 void dev_pm_opp_get(struct dev_pm_opp *opp);
+void _opp_remove_all_static(struct opp_table *opp_table);
 void _get_opp_table_kref(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
-void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev);
 void _dev_pm_opp_find_and_remove_table(struct device *dev);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
-- 
2.14.1

