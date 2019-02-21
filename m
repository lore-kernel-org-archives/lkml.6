Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBA4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572322147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJcxlD2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfBULaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:30:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34036 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfBUL34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:29:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id d15so6899178plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 03:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RtHEYciGp3wZ5IC0stPd9CIwj1alFGW6YIZIibelFE=;
        b=HJcxlD2+L3p4W0nDT7+XS3EOC61KgQtsQk2X0ochBuuG//m+LuB+9m8/PLQCP1orA/
         qziCxAw4fF2s3edkKvvJLsNygAQD0QlY0FOzb4AjnKOXtVsqXlFDKJzk69BQcB4LBWEn
         L5q6fc0F4NsC3giNoU7tOcgzldDr8yTZ9EruGbF0cTNswN66zKNJCa5qehU8zBoG1n91
         /9mHfA9IkvQxixHNhAXDJrXQ8XdeQ430PTcqPtyka8eX2t06FIw7vnGYEm8MncNcbpAg
         sihzzQFvOcqWFcpISCoO2KxBLNnzVaxnLNIx24n1oy8QndkpIsNheyXEU+EK6CB31d0T
         E/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RtHEYciGp3wZ5IC0stPd9CIwj1alFGW6YIZIibelFE=;
        b=CMmUfLMczrlJ42DYNYKTJevT7NTcTv6/oN825+2RXRqKUsu0S4KzSttQ+xYMM+NCrz
         U5CteZGgr6VMCJuf7vjBXID7jfXHQHQjF+47ovkMdG/EJYM/emavSXRsIAip9LzOsfVh
         LHGsyiz7dzBtNpYzrSxKzIZGhc5oPoFZnrPtCMEqTzuzjWOXLSDG2rsvwhya/icgBdZ+
         neKCLj2NFR2yC1YQMSCIJMoX2VrNCwr5EpCMIKWZBHI8X5kGhDzoYFYJR2JM8kUhNTLj
         stIs6kXVHIIuPm8oiFsvn3/dBrUVI+oAD/0ldYNWyfm1vd7vZqrBLmOIAJ8ClpIwQGR1
         HIrA==
X-Gm-Message-State: AHQUAuYU5mp/sjqbHFGWPZV3GfAWAu6EJpIlUK8vHqpM2X3Y8HSR/Dkw
        G8mt7CTxMslBjHYw707tMvEFEQ==
X-Google-Smtp-Source: AHgI3Ia9WDqOGjZItYQ/v70xYdRp9QqkTYvLFcTefsxuTLslRCmaMZBPJMWmSp++ua1rgjD4ymRdXQ==
X-Received: by 2002:a17:902:8602:: with SMTP id f2mr42552253plo.263.1550748595870;
        Thu, 21 Feb 2019 03:29:55 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id n1sm42134336pfi.123.2019.02.21.03.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:29:55 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, Qais.Yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/5] PM / QoS: Add support for MIN/MAX frequency constraints
Date:   Thu, 21 Feb 2019 16:59:29 +0530
Message-Id: <bf5dfb65ce605a11ded18edcd7c140c3d6a11d68.1550748118.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1550748118.git.viresh.kumar@linaro.org>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the min-frequency and max-frequency device
constraints, which will be used by the cpufreq core to begin with.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/qos.c | 103 +++++++++++++++++++++++++++++++++------
 include/linux/pm_qos.h   |  18 +++++++
 2 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index fda7266970e9..30fe1e98b343 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -155,6 +155,14 @@ static int apply_constraint(struct dev_pm_qos_request *req,
 			req->dev->power.set_latency_tolerance(req->dev, value);
 		}
 		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = pm_qos_update_target(&qos->min_frequency,
+					   &req->data.pnode, action, value);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = pm_qos_update_target(&qos->max_frequency,
+					   &req->data.pnode, action, value);
+		break;
 	case DEV_PM_QOS_FLAGS:
 		ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
 					  action, value);
@@ -183,12 +191,11 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	if (!qos)
 		return -ENOMEM;
 
-	n = kzalloc(sizeof(*n), GFP_KERNEL);
+	n = kzalloc(3 * sizeof(*n), GFP_KERNEL);
 	if (!n) {
 		kfree(qos);
 		return -ENOMEM;
 	}
-	BLOCKING_INIT_NOTIFIER_HEAD(n);
 
 	c = &qos->resume_latency;
 	plist_head_init(&c->list);
@@ -197,6 +204,7 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 	c->notifiers = n;
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
 
 	c = &qos->latency_tolerance;
 	plist_head_init(&c->list);
@@ -205,6 +213,24 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 
+	c = &qos->min_frequency;
+	plist_head_init(&c->list);
+	c->target_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	c->default_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	c->no_constraint_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	c->type = PM_QOS_MAX;
+	c->notifiers = ++n;
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
+
+	c = &qos->max_frequency;
+	plist_head_init(&c->list);
+	c->target_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
+	c->default_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
+	c->no_constraint_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
+	c->type = PM_QOS_MIN;
+	c->notifiers = ++n;
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
+
 	INIT_LIST_HEAD(&qos->flags.list);
 
 	spin_lock_irq(&dev->power.lock);
@@ -258,11 +284,25 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
+
 	c = &qos->latency_tolerance;
 	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
+
+	c = &qos->min_frequency;
+	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
+		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE);
+		memset(req, 0, sizeof(*req));
+	}
+
+	c = &qos->max_frequency;
+	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
+		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
+		memset(req, 0, sizeof(*req));
+	}
+
 	f = &qos->flags;
 	list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
@@ -374,6 +414,8 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 	switch(req->type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 	case DEV_PM_QOS_LATENCY_TOLERANCE:
+	case DEV_PM_QOS_MIN_FREQUENCY:
+	case DEV_PM_QOS_MAX_FREQUENCY:
 		curr_value = req->data.pnode.prio;
 		break;
 	case DEV_PM_QOS_FLAGS:
@@ -486,9 +528,6 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 {
 	int ret = 0;
 
-	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
-		return -EINVAL;
-
 	mutex_lock(&dev_pm_qos_mtx);
 
 	if (IS_ERR(dev->power.qos))
@@ -496,10 +535,28 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 	else if (!dev->power.qos)
 		ret = dev_pm_qos_constraints_allocate(dev);
 
-	if (!ret)
+	if (ret)
+		goto unlock;
+
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
 		ret = blocking_notifier_chain_register(dev->power.qos->resume_latency.notifiers,
 						       notifier);
+		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = blocking_notifier_chain_register(dev->power.qos->min_frequency.notifiers,
+						       notifier);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = blocking_notifier_chain_register(dev->power.qos->max_frequency.notifiers,
+						       notifier);
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
 
+unlock:
 	mutex_unlock(&dev_pm_qos_mtx);
 	return ret;
 }
@@ -520,20 +577,35 @@ int dev_pm_qos_remove_notifier(struct device *dev,
 			       struct notifier_block *notifier,
 			       enum dev_pm_qos_req_type type)
 {
-	int retval = 0;
-
-	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
-		return -EINVAL;
+	int ret = 0;
 
 	mutex_lock(&dev_pm_qos_mtx);
 
 	/* Silently return if the constraints object is not present. */
-	if (!IS_ERR_OR_NULL(dev->power.qos))
-		retval = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
-							    notifier);
+	if (IS_ERR_OR_NULL(dev->power.qos))
+		goto unlock;
 
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		ret = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
+							 notifier);
+		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = blocking_notifier_chain_unregister(dev->power.qos->min_frequency.notifiers,
+							 notifier);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = blocking_notifier_chain_unregister(dev->power.qos->max_frequency.notifiers,
+							 notifier);
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
+
+unlock:
 	mutex_unlock(&dev_pm_qos_mtx);
-	return retval;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_remove_notifier);
 
@@ -593,6 +665,9 @@ static void __dev_pm_qos_drop_user_request(struct device *dev,
 		req = dev->power.qos->flags_req;
 		dev->power.qos->flags_req = NULL;
 		break;
+	default:
+		WARN_ON(1);
+		return;
 	}
 	__dev_pm_qos_remove_request(req);
 	kfree(req);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 55814d48c39c..3f994283a5ae 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -40,6 +40,8 @@ enum pm_qos_flags_status {
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS	PM_QOS_LATENCY_ANY_NS
 #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0
+#define PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE	0
+#define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE	(-1)
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
@@ -58,6 +60,8 @@ struct pm_qos_flags_request {
 enum dev_pm_qos_req_type {
 	DEV_PM_QOS_RESUME_LATENCY = 1,
 	DEV_PM_QOS_LATENCY_TOLERANCE,
+	DEV_PM_QOS_MIN_FREQUENCY,
+	DEV_PM_QOS_MAX_FREQUENCY,
 	DEV_PM_QOS_FLAGS,
 };
 
@@ -99,10 +103,14 @@ struct pm_qos_flags {
 struct dev_pm_qos {
 	struct pm_qos_constraints resume_latency;
 	struct pm_qos_constraints latency_tolerance;
+	struct pm_qos_constraints min_frequency;
+	struct pm_qos_constraints max_frequency;
 	struct pm_qos_flags flags;
 	struct dev_pm_qos_request *resume_latency_req;
 	struct dev_pm_qos_request *latency_tolerance_req;
 	struct dev_pm_qos_request *flags_req;
+	struct dev_pm_qos_request *min_frequency_req;
+	struct dev_pm_qos_request *max_frequency_req;
 };
 
 /* Action requested to pm_qos_update_target */
@@ -185,6 +193,12 @@ static inline s32 dev_pm_qos_raw_read_value(struct device *dev,
 	case DEV_PM_QOS_RESUME_LATENCY:
 		return IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
 			: pm_qos_read_value(&qos->resume_latency);
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		return IS_ERR_OR_NULL(qos) ? PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE
+			: pm_qos_read_value(&qos->min_frequency);
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		return IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE
+			: pm_qos_read_value(&qos->max_frequency);
 	default:
 		WARN_ON(1);
 		return 0;
@@ -256,6 +270,10 @@ static inline s32 dev_pm_qos_raw_read_value(struct device *dev,
 	switch type {
 	case DEV_PM_QOS_RESUME_LATENCY:
 		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
 	default:
 		WARN_ON(1);
 		return 0;
-- 
2.21.0.rc0.269.g1a574e7a288b

