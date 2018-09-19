Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6AEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6894A20867
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVliWPLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6894A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbeITEA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:00:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38946 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387399AbeITEAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:00:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so3300416plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HX5eDqLq6MnZX9E6B4v/vOFT0a/x+hzpVnpPDmao/5Y=;
        b=iVliWPLgAZaeCvinWz/oXkCKCEBJw1rChrOeNhddY1LOHXqe/CHuwAQXYj44J7S12i
         25l3DV1zAWvCPZDDN2CY767iL2caYnqVIbfSnFHr2mi9KdLXlxPYhe3FgFRarJGxxYIf
         F4zcVTyNjt0kBVeOH86pNmt/0oVYwvXw5XY0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HX5eDqLq6MnZX9E6B4v/vOFT0a/x+hzpVnpPDmao/5Y=;
        b=ncWtmbuuNw6yI9sQXeJbqS1RX1ifM8h4n9WJEEIChyrGLuNw5rdC/F8QJEWwCcGFz8
         dm1gnyLpjX93O8JQh46TWOaiYemeSQiPoMsMkO/9TVP8ZPcbP3Cnx2+7GrfYnF7wvSzG
         oGI0HwPIWzNg2GZbemJKSXBdt06gQa1Z7V74DWbF20YQEqX5NEe1Hhb/eTLTXx0PxZkF
         4xIzVLdo8XH4UOO7GKLuCwqJS/V1mgmQFVhUrbu7vWnQWJeCL790kOzqjZB1isYtydEf
         RgY8zkLAUqL+E3aWzbV+ARR8MPje2stqtu47ejwVSaeNS0ZOir81fQvF9Yqhkyuy3PYG
         r2rg==
X-Gm-Message-State: APzg51DVTQoMmBK31zkMAIu8jIvyDm0S4U7uEkK3kHkpdH2IA2Ib8X18
        P7yc0s8OfrvUPl7yUorqz0Kvaw==
X-Google-Smtp-Source: ANB0VdaMzdZ9LY/xeffQPA75Z+yo0kf4CNQySawO/f+ejIe+5cFIcLO87WkvQwHghoOSuTg5GbeNRQ==
X-Received: by 2002:a17:902:e281:: with SMTP id cf1-v6mr36276933plb.86.1537395653568;
        Wed, 19 Sep 2018 15:20:53 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id x9-v6sm33824822pfd.31.2018.09.19.15.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:52 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/12] OPP: Create separate kref for static OPPs list
Date:   Wed, 19 Sep 2018 15:20:26 -0700
Message-Id: <d0e8ae6c26da7b9436775dfd9768d7a821ed47b7.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static OPPs don't always get freed with the OPP table, it can happen
before that as well. For example, if the OPP table is first created
using helpers like dev_pm_opp_set_supported_hw() and the OPPs are
created at a later point. Now when the OPPs are removed, the OPP table
stays until the time dev_pm_opp_put_supported_hw() is called.

Later patches will streamline the freeing of OPP table and that requires
the static OPPs to get freed with help of a separate kernel reference.
This patch prepares for that by creating a separate kref for static OPPs
list.

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 33 ++++++++++++++++++++++++++++++++-
 drivers/opp/of.c   |  7 +++++++
 drivers/opp/opp.h  |  3 +++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2a6976265580..b555121b878b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -892,6 +892,33 @@ static void _opp_table_kref_release(struct kref *kref)
 	mutex_unlock(&opp_table_lock);
 }
 
+void _opp_remove_all_static(struct opp_table *opp_table)
+{
+	struct dev_pm_opp *opp, *tmp;
+
+	list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
+		if (!opp->dynamic)
+			dev_pm_opp_put(opp);
+	}
+
+	opp_table->parsed_static_opps = false;
+}
+
+static void _opp_table_list_kref_release(struct kref *kref)
+{
+	struct opp_table *opp_table = container_of(kref, struct opp_table,
+						   list_kref);
+
+	_opp_remove_all_static(opp_table);
+	mutex_unlock(&opp_table_lock);
+}
+
+void _put_opp_list_kref(struct opp_table *opp_table)
+{
+	kref_put_mutex(&opp_table->list_kref, _opp_table_list_kref_release,
+		       &opp_table_lock);
+}
+
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table)
 {
 	kref_put_mutex(&opp_table->kref, _opp_table_kref_release,
@@ -1746,8 +1773,11 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
 	/* Find if opp_table manages a single device */
 	if (list_is_singular(&opp_table->dev_list)) {
 		/* Free static OPPs */
+		_put_opp_list_kref(opp_table);
+
+		/* Free dynamic OPPs */
 		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
-			if (remove_all || !opp->dynamic)
+			if (remove_all)
 				dev_pm_opp_put(opp);
 		}
 
@@ -1758,6 +1788,7 @@ void _dev_pm_opp_remove_table(struct opp_table *opp_table, struct device *dev,
 		if (opp_table->genpd_performance_state)
 			dev_pm_genpd_set_performance_state(dev, 0);
 	} else {
+		_put_opp_list_kref(opp_table);
 		_remove_opp_dev(_find_opp_dev(dev, opp_table), opp_table);
 	}
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 4a19f76880d3..aaa4bab69846 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -411,6 +411,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 			ret = -ENOMEM;
 		else if (!opp_table->parsed_static_opps)
 			goto initialize_static_opps;
+		else
+			kref_get(&opp_table->list_kref);
 
 		goto put_opp_table;
 	}
@@ -420,6 +422,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 		return -ENOMEM;
 
 initialize_static_opps:
+	kref_init(&opp_table->list_kref);
+
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
 		count++;
@@ -437,6 +441,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 	/* There should be one of more OPP defined */
 	if (WARN_ON(!count)) {
 		ret = -ENOENT;
+		_put_opp_list_kref(opp_table);
 		goto put_opp_table;
 	}
 
@@ -491,6 +496,8 @@ static int _of_add_opp_table_v1(struct device *dev)
 	if (!opp_table)
 		return -ENOMEM;
 
+	kref_init(&opp_table->list_kref);
+
 	val = prop->value;
 	while (nr) {
 		unsigned long freq = be32_to_cpup(val++) * 1000;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index b04c2b511c4d..9274116c90e4 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -126,6 +126,7 @@ enum opp_table_access {
  * @dev_list:	list of devices that share these OPPs
  * @opp_list:	table of opps
  * @kref:	for reference count of the table.
+ * @list_kref:	for reference count of the OPP list.
  * @lock:	mutex protecting the opp_list and dev_list.
  * @np:		struct device_node pointer for opp's DT node.
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
@@ -157,6 +158,7 @@ struct opp_table {
 	struct list_head dev_list;
 	struct list_head opp_list;
 	struct kref kref;
+	struct kref list_kref;
 	struct mutex lock;
 
 	struct device_node *np;
@@ -200,6 +202,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *o
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of, int last_cpu);
 struct opp_table *_add_opp_table(struct device *dev);
+void _put_opp_list_kref(struct opp_table *opp_table);
 
 #ifdef CONFIG_OF
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
-- 
2.14.1

