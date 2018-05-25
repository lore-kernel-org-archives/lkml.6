Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030298AbeEYUba (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:31:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:32769 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030260AbeEYUbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:31:25 -0400
X-Google-Smtp-Source: AB8JxZrA5WqSGGVlxcDzLV/sYWnH5RNMMB9yRuDLm07u1w0fh/SO4Lje75T4xy5i7uWJQMFhQSm5YA==
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 07/11] PM / devfreg: Add support policy notifiers
Date: Fri, 25 May 2018 13:30:39 -0700
Message-Id: <20180525203043.249193-8-mka@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180525203043.249193-1-mka@chromium.org>
References: <20180525203043.249193-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
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
 drivers/devfreq/devfreq.c | 47 +++++++++++++++++++++-------
 include/linux/devfreq.h   | 66 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7fd55b49c8ae..939b91f3a7e3 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -72,6 +72,20 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 	return ERR_PTR(-ENODEV);
 }
 
+/**
+ * dev_to_devfreq() - find devfreq struct using device pointer
+ * @dev:	device pointer used to lookup device devfreq.
+ */
+struct devfreq *dev_to_devfreq(struct device *dev) {
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
@@ -269,20 +283,21 @@ int update_devfreq(struct devfreq *devfreq)
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
@@ -645,6 +660,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->last_stat_updated = jiffies;
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
+	srcu_init_notifier_head(&devfreq->policy_notifier_list);
 
 	mutex_unlock(&devfreq->lock);
 
@@ -1432,7 +1448,7 @@ EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
  * devfreq_register_notifier() - Register a driver with devfreq
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to register.
- * @list:	DEVFREQ_TRANSITION_NOTIFIER.
+ * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
  */
 int devfreq_register_notifier(struct devfreq *devfreq,
 				struct notifier_block *nb,
@@ -1448,6 +1464,10 @@ int devfreq_register_notifier(struct devfreq *devfreq,
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
@@ -1460,7 +1480,7 @@ EXPORT_SYMBOL(devfreq_register_notifier);
  * devfreq_unregister_notifier() - Unregister a driver with devfreq
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to be unregistered.
- * @list:	DEVFREQ_TRANSITION_NOTIFIER.
+ * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
  */
 int devfreq_unregister_notifier(struct devfreq *devfreq,
 				struct notifier_block *nb,
@@ -1476,6 +1496,11 @@ int devfreq_unregister_notifier(struct devfreq *devfreq,
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
index 9bf23b976f4d..4a6ed61bbe49 100644
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
@@ -240,6 +250,46 @@ extern void devm_devfreq_unregister_notifier(struct device *dev,
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
+	return;
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
@@ -394,10 +444,26 @@ static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
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
2.17.0.921.gf22659ad46-goog
