Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1620ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6F12146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kb0LyyBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6F12146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbeITEBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:01:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44539 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeITEAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:00:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so3295976plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KNbb/GBRT5l235B0JCuUrzsEESNrHyS5fTToF34GITM=;
        b=kb0LyyBAoMOdq8BVQnvoGN9iZbuEZTsvI+BGU1C2Nbd4tVxnR4nkW+xpV48FIidvwW
         V9fAIAsXEWiLB5gKDmOybT339oXK8ne+05ELmx7mTffsLEes7801R35UJB+176ZVj9r7
         bQJrjdt8aL4wZOPVcT0HKAIvA0ueZm7rAT3fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=KNbb/GBRT5l235B0JCuUrzsEESNrHyS5fTToF34GITM=;
        b=K48rJqM2eq8k/LnpKHzWL0BqGj2e58bt1tldkUU9Ux5JorV3HmVxqg/LaOHsmfFNQ9
         jgKEl6d8+WfJWMEOgnrBOLg5PawECObo/eB+CKm142ovZulu/aE6DIvN2fxsQccCBnlh
         y2zQqmcWYT6gdKYEhxzyaiTCDD9acHGCcOFZyvH6AjbVOdsB5MthVCVlW94P1YWE6Izb
         9RncJL3o32YakVH8yUvp6c+W+1J9h9v/Sb0RvkEd4g5rQc6jgG0yXiw43hq0/HCVBFtb
         64Wh7LBWlTmtZpBkzlL25Gay7HKoD6B62CE7UZV/Bux+dKltuKj1l01uvVOejEIg2ip6
         aDyg==
X-Gm-Message-State: APzg51DK2YPXNgw6LuMFp3CukY2c0qP3OnN/8fke092iGLlq9CfJRwdB
        yde8ZJX6Rywiqfy2CtOvv2brGg==
X-Google-Smtp-Source: ANB0VdZdF3S9vkGNAsHagBLJa4qZHb27TNpH8o7jiOBFVg8zDFFppbC/jesQKGyjDyj8z4QdlHc4JQ==
X-Received: by 2002:a17:902:286a:: with SMTP id e97-v6mr36378195plb.340.1537395647452;
        Wed, 19 Sep 2018 15:20:47 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id a20-v6sm52014829pfc.14.2018.09.19.15.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:46 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/12] OPP: Protect dev_list with opp_table lock
Date:   Wed, 19 Sep 2018 15:20:22 -0700
Message-Id: <3d2556992a878a2210d3be498416aee39e0c32aa.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_list needs to be protected with a lock, else we may have
simultaneous access (addition/removal) to it and that would be racy.
Extend scope of the opp_table lock to protect dev_list as well.

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 21 +++++++++++++++++++--
 drivers/opp/cpu.c  |  2 ++
 drivers/opp/opp.h  |  2 +-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 31ff03dbeb83..9f8aa31265fe 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -48,9 +48,14 @@ static struct opp_device *_find_opp_dev(const struct device *dev,
 static struct opp_table *_find_opp_table_unlocked(struct device *dev)
 {
 	struct opp_table *opp_table;
+	bool found;
 
 	list_for_each_entry(opp_table, &opp_tables, node) {
-		if (_find_opp_dev(dev, opp_table)) {
+		mutex_lock(&opp_table->lock);
+		found = !!_find_opp_dev(dev, opp_table);
+		mutex_unlock(&opp_table->lock);
+
+		if (found) {
 			_get_opp_table_kref(opp_table);
 
 			return opp_table;
@@ -766,6 +771,8 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 
 	/* Initialize opp-dev */
 	opp_dev->dev = dev;
+
+	mutex_lock(&opp_table->lock);
 	list_add(&opp_dev->node, &opp_table->dev_list);
 
 	/* Create debugfs entries for the opp_table */
@@ -773,6 +780,7 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
 			__func__, ret);
+	mutex_unlock(&opp_table->lock);
 
 	return opp_dev;
 }
@@ -791,6 +799,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev)
 	if (!opp_table)
 		return NULL;
 
+	mutex_init(&opp_table->lock);
 	INIT_LIST_HEAD(&opp_table->dev_list);
 
 	opp_dev = _add_opp_dev(dev, opp_table);
@@ -812,7 +821,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev)
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
-	mutex_init(&opp_table->lock);
 	kref_init(&opp_table->kref);
 
 	/* Secure the device table modification */
@@ -854,6 +862,10 @@ static void _opp_table_kref_release(struct kref *kref)
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
 
+	/*
+	 * No need to take opp_table->lock here as we are guaranteed that no
+	 * references to the OPP table are taken at this point.
+	 */
 	opp_dev = list_first_entry(&opp_table->dev_list, struct opp_device,
 				   node);
 
@@ -1716,6 +1728,9 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
 {
 	struct dev_pm_opp *opp, *tmp;
 
+	/* Protect dev_list */
+	mutex_lock(&opp_table->lock);
+
 	/* Find if opp_table manages a single device */
 	if (list_is_singular(&opp_table->dev_list)) {
 		/* Free static OPPs */
@@ -1733,6 +1748,8 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
 	} else {
 		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
 	}
+
+	mutex_unlock(&opp_table->lock);
 }
 
 void _dev_pm_opp_find_and_remove_table(struct device *dev, bool remove_all)
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 2eb5e2e7ff66..36586f66cd83 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -226,8 +226,10 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 	cpumask_clear(cpumask);
 
 	if (opp_table->shared_opp == OPP_TABLE_ACCESS_SHARED) {
+		mutex_lock(&opp_table->lock);
 		list_for_each_entry(opp_dev, &opp_table->dev_list, node)
 			cpumask_set_cpu(opp_dev->dev->id, cpumask);
+		mutex_unlock(&opp_table->lock);
 	} else {
 		cpumask_set_cpu(cpu_dev->id, cpumask);
 	}
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index a9d22aa534c3..88e9f47aadf1 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -126,7 +126,7 @@ enum opp_table_access {
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	table of opps
  * @kref:	for reference count of the table.
- * @lock:	mutex protecting the opp_list.
+ * @lock:	mutex protecting the opp_list and dev_list.
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @shared_opp: OPP is shared between multiple devices.
-- 
2.14.1

