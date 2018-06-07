Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1FWNCC11GVuYCQAAmS7hNA
	; Thu, 07 Jun 2018 18:13:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 203B9608B8; Thu,  7 Jun 2018 18:13:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 62C61605A2;
	Thu,  7 Jun 2018 18:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62C61605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936106AbeFGSNH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:13:07 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33116 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934260AbeFGSNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:13:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so5136199pgq.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bv1mx3ZPmwZ/MCh/3pCoHnmHrXwITtJGwDjVmsE9zKU=;
        b=X7/x6Nqn3frE1IfRwtiTHamP6L3sdw1wtYOQFVS890eaqJ/bQStJA+o8iOSo/uUiqg
         m1bra+Yq9rBAU7lVlvte18rAiyR34hoIdwuSfM2i+3t/70IhhiORs+Z89e0BfSQpX9uh
         sXMfBCg+VQ3JVnGgevoWfL4ckThlYeS2GCKtm8E489NlUSzypCkvXZ5R2YCipN1N1xiZ
         tuXne1mMuJ9EJTi91N6fVKbcLnTxMNQiynjOaVh2LV+GXZqxkA12Qxym49oWQoX6WeJ7
         iumTMTGxcTnd+2c7iEFKcxnWiMJCpFFNy3JEw87DUja9nQUaL2FJ9xq3UiEf3X+ExCb9
         2nWA==
X-Gm-Message-State: APt69E2RMfk+XfZSYpnHzdGjT+XSREdAvwA+LJ9gaIDgQUcICp3bEGiM
        OT3jW/6AvnemhPM+nZCku1OEPg==
X-Google-Smtp-Source: ADUXVKLmEr3dH/kmgxtA3w6+9Tjzy0JlbvVGPNUVyKQFE0a9a84CUWRewZaOYNphA9mRXTtHzXjfEA==
X-Received: by 2002:a63:8f4f:: with SMTP id r15-v6mr2472628pgn.210.1528395179135;
        Thu, 07 Jun 2018 11:12:59 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5029002pfn.36.2018.06.07.11.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:12:58 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 05/11] PM / devfreg: Add support for policy notifiers
Date: Thu,  7 Jun 2018 11:12:08 -0700
Message-Id: <20180607181214.30338-6-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Policy notifiers are called before a frequency change and may narrow
the min/max frequency range in devfreq_policy, which is used to adjust
the target frequency if it is beyond this range.

Also add a few helpers:
 - devfreq_verify_within_[dev_]limits()
    - should be used by the notifiers for policy adjustments.
 - dev_to_devfreq()
    - lookup a devfreq strict from a device pointer

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
PM / devfreg: Add support for policy notifiers

Changes in v2:
- removed pointless return at the end of devfreq_verify_within_limit()

 drivers/devfreq/devfreq.c | 48 ++++++++++++++++++++++-------
 include/linux/devfreq.h   | 65 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 21604d6ae2b8..4cbaa7ad1972 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -72,6 +72,21 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 	return ERR_PTR(-ENODEV);
 }
 
+/**
+ * dev_to_devfreq() - find devfreq struct using device pointer
+ * @dev:	device pointer used to lookup device devfreq.
+ */
+struct devfreq *dev_to_devfreq(struct device *dev)
+{
+	struct devfreq *devfreq;
+
+	mutex_lock(&devfreq_list_lock);
+	devfreq = find_device_devfreq(dev);
+	mutex_unlock(&devfreq_list_lock);
+
+	return devfreq;
+}
+
 static unsigned long find_available_min_freq(struct devfreq *devfreq)
 {
 	struct dev_pm_opp *opp;
@@ -269,20 +284,21 @@ int update_devfreq(struct devfreq *devfreq)
 	if (!policy->governor)
 		return -EINVAL;
 
+	policy->min = policy->devinfo.min_freq;
+	policy->max = policy->devinfo.max_freq;
+
+	srcu_notifier_call_chain(&devfreq->policy_notifier_list,
+				DEVFREQ_ADJUST, policy);
+
 	/* Reevaluate the proper frequency */
 	err = policy->governor->get_target_freq(devfreq, &freq);
 	if (err)
 		return err;
 
-	/*
-	 * Adjust the frequency with user freq, QoS and available freq.
-	 *
-	 * List from the highest priority
-	 * max_freq
-	 * min_freq
-	 */
-	max_freq = MIN(policy->devinfo.max_freq, policy->user.max_freq);
-	min_freq = MAX(policy->devinfo.min_freq, policy->user.min_freq);
+	/* Adjust the frequency */
+
+	max_freq = MIN(policy->max, policy->user.max_freq);
+	min_freq = MAX(policy->min, policy->user.min_freq);
 
 	if (freq < min_freq) {
 		freq = min_freq;
@@ -645,6 +661,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->last_stat_updated = jiffies;
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
+	srcu_init_notifier_head(&devfreq->policy_notifier_list);
 
 	mutex_unlock(&devfreq->lock);
 
@@ -1445,7 +1462,7 @@ EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
  * devfreq_register_notifier() - Register a driver with devfreq
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to register.
- * @list:	DEVFREQ_TRANSITION_NOTIFIER.
+ * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
  */
 int devfreq_register_notifier(struct devfreq *devfreq,
 				struct notifier_block *nb,
@@ -1461,6 +1478,10 @@ int devfreq_register_notifier(struct devfreq *devfreq,
 		ret = srcu_notifier_chain_register(
 				&devfreq->transition_notifier_list, nb);
 		break;
+	case DEVFREQ_POLICY_NOTIFIER:
+		ret = srcu_notifier_chain_register(
+				&devfreq->policy_notifier_list, nb);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -1473,7 +1494,7 @@ EXPORT_SYMBOL(devfreq_register_notifier);
  * devfreq_unregister_notifier() - Unregister a driver with devfreq
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to be unregistered.
- * @list:	DEVFREQ_TRANSITION_NOTIFIER.
+ * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
  */
 int devfreq_unregister_notifier(struct devfreq *devfreq,
 				struct notifier_block *nb,
@@ -1489,6 +1510,11 @@ int devfreq_unregister_notifier(struct devfreq *devfreq,
 		ret = srcu_notifier_chain_unregister(
 				&devfreq->transition_notifier_list, nb);
 		break;
+	case DEVFREQ_POLICY_NOTIFIER:
+		ret = srcu_notifier_chain_unregister(
+				&devfreq->policy_notifier_list, nb);
+		break;
+
 	default:
 		ret = -EINVAL;
 	}
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 9bf23b976f4d..8a4c0f10a394 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -33,6 +33,10 @@
 #define	DEVFREQ_PRECHANGE		(0)
 #define DEVFREQ_POSTCHANGE		(1)
 
+#define DEVFREQ_POLICY_NOTIFIER		1
+
+#define	DEVFREQ_ADJUST			0
+
 struct devfreq;
 struct devfreq_governor;
 
@@ -121,12 +125,16 @@ struct devfreq_freq_limits {
 
 /**
  * struct devfreq_policy - Devfreq policy
+ * @min:	minimum frequency (adjustable by policy notifiers)
+ * @min:	maximum frequency (adjustable by policy notifiers)
  * @user:	frequency limits requested by the user
  * @devinfo:	frequency limits of the device (available OPPs)
  * @governor:	method how to choose frequency based on the usage.
  * @governor_name:	devfreq governor name for use with this devfreq
  */
 struct devfreq_policy {
+	unsigned long min;
+	unsigned long max;
 	struct devfreq_freq_limits user;
 	struct devfreq_freq_limits devinfo;
 	const struct devfreq_governor *governor;
@@ -155,6 +163,7 @@ struct devfreq_policy {
  * @time_in_state:	Statistics of devfreq states
  * @last_stat_updated:	The last time stat updated
  * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
+ * @policy_notifier_list: list head of DEVFREQ_POLICY_NOTIFIER notifier
  *
  * This structure stores the devfreq information for a give device.
  *
@@ -188,6 +197,7 @@ struct devfreq {
 	unsigned long last_stat_updated;
 
 	struct srcu_notifier_head transition_notifier_list;
+	struct srcu_notifier_head policy_notifier_list;
 };
 
 struct devfreq_freqs {
@@ -240,6 +250,45 @@ extern void devm_devfreq_unregister_notifier(struct device *dev,
 extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 						int index);
 
+/**
+ * devfreq_verify_within_limits() - Adjust a devfreq policy if needed to make
+ *                                  sure its min/max values are within a
+ *                                  specified range.
+ * @policy:	the policy
+ * @min:	the minimum frequency
+ * @max:	the maximum frequency
+ */
+static inline void devfreq_verify_within_limits(struct devfreq_policy *policy,
+		unsigned int min, unsigned int max)
+{
+	if (policy->min < min)
+		policy->min = min;
+	if (policy->max < min)
+		policy->max = min;
+	if (policy->min > max)
+		policy->min = max;
+	if (policy->max > max)
+		policy->max = max;
+	if (policy->min > policy->max)
+		policy->min = policy->max;
+}
+
+/**
+ * devfreq_verify_within_dev_limits() - Adjust a devfreq policy if needed to
+ *                                      make sure its min/max values are within
+ *                                      the frequency range supported by the
+ *                                      device.
+ * @policy:	the policy
+ */
+static inline void
+devfreq_verify_within_dev_limits(struct devfreq_policy *policy)
+{
+	devfreq_verify_within_limits(policy, policy->devinfo.min_freq,
+			policy->devinfo.max_freq);
+}
+
+struct devfreq *dev_to_devfreq(struct device *dev);
+
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
  * struct devfreq_simple_ondemand_data - void *data fed to struct devfreq
@@ -394,10 +443,26 @@ static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline void devfreq_verify_within_limits(struct defreq_policy *policy,
+		unsigned int min, unsigned int max)
+{
+}
+
+static inline void
+devfreq_verify_within_dev_limits(struct cpufreq_policy *policy)
+{
+}
+
 static inline int devfreq_update_stats(struct devfreq *df)
 {
 	return -EINVAL;
 }
+
+static inline struct devfreq *dev_to_devfreq(struct device *dev)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_PM_DEVFREQ */
 
 #endif /* __LINUX_DEVFREQ_H__ */
-- 
2.18.0.rc1.242.g61856ae69a-goog
