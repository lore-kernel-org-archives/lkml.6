Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E04AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E3B20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWNP9+16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E3B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeILNdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:33:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45483 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeILNdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:33:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id j8-v6so612857pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5K1iJfqCM5hIrFK8wsKvsyblTx8byAQ2qMnGR+MYBnc=;
        b=WWNP9+16Q6w6a9ObSV5yFXy4NZC8+D8pCNCf/EyLKZcePLCPJzMiT7hat05dplXjTU
         92cSNpgtI3afDLSDD+H4AHKb7eRMK6I0OMgjoJNRlPb8O/5j1XEjL88ZK77BO1+Xl1yJ
         pya2C5Gxn5wHXUHiMVM396bZMjVmtV5X1UbIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5K1iJfqCM5hIrFK8wsKvsyblTx8byAQ2qMnGR+MYBnc=;
        b=fE0pRqVWFLLRtIlTkyEOrkx1NsG120zywmCsK0YURjP/H14Lc7F4Ji5w5Gv9CLufSc
         PhGsnW7hA+4hDn97vW25pJTuvrK+zf3tG+/9EBpQ9HRGmq+9Nr4R6yPKWXTdpfN7BUba
         Cujucs29i/hiYM4rPYAWOswfErl9625/Qo8WfpZPJOsjV8CT5oQKQYEXU790vus1EYSO
         bCVSudULrRD018kPSpEdb7q7b7SwGXJ8Olof42nP3ntFZOAo5Efg0Itn85zjUQu+NxkO
         j5+viYdpVi6KGQGkRB1wAaHyIsCjmLAVJ9dm/ccI4vdXO2OP8HJSa38SXtVPXzkJhXK3
         JWeQ==
X-Gm-Message-State: APzg51CBSYEyGen8mvFjYBlhGjJ0axSNlIfaFwxZztpo4tYb7HPxEjeo
        9iXgGKgpMrgIpCD6oRvYB9AN8A==
X-Google-Smtp-Source: ANB0VdbY+/LOvJfgY1q1HeQozJ0s5swXJSEMT+YRDImqQzdjy6XYhMz8wwOGcfULNhoZH44ifeI2pw==
X-Received: by 2002:a17:902:6ac5:: with SMTP id i5-v6mr904729plt.232.1536740993019;
        Wed, 12 Sep 2018 01:29:53 -0700 (PDT)
Received: from localhost ([122.171.64.45])
        by smtp.gmail.com with ESMTPSA id i7-v6sm601315pgs.17.2018.09.12.01.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:29:52 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] OPP: Protect dev_list with opp_table lock
Date:   Wed, 12 Sep 2018 13:58:41 +0530
Message-Id: <547f728dc5f4d9f27dae0a85517d5b2502b3b03d.1536736872.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_list needs to be protected with a lock, else we may have
simultaneous access (addition/removal) to it and that would be racy.
Extend scope of the opp_table lock to protect dev_list as well.

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
index 0c0910709435..2868a022a040 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -222,8 +222,10 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
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
index 7c540fd063b2..e0866b1c1f1b 100644
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
2.18.0.rc1.242.g61856ae69a2c

