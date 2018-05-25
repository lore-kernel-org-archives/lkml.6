Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030418AbeEYUcq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:32:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43201 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968417AbeEYUbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:31:24 -0400
X-Google-Smtp-Source: AB8JxZrJpTJhyjhCIJ/fAbstqgIjc9gyoDQrmcj/u6sk219cmqVlhOQTVtDvWdaGMvM8lHvEBxcxUQ==
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
Subject: [PATCH 06/11] PM / devfreq: Add struct devfreq_policy
Date: Fri, 25 May 2018 13:30:38 -0700
Message-Id: <20180525203043.249193-7-mka@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180525203043.249193-1-mka@chromium.org>
References: <20180525203043.249193-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move variables related with devfreq policy changes from struct devfreq
to the new struct devfreq_policy and add a policy field to struct devfreq.

The following variables are moved:

df->min/max_freq           =>   p->user.min/max_freq
df->scaling_min/max_freq   =>   p->devinfo.min/max_freq
df->governor               =>   p->governor
df->governor_name          =>   p->governor_name

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c                 | 136 ++++++++++++----------
 drivers/devfreq/governor_passive.c        |   4 +-
 drivers/devfreq/governor_performance.c    |   2 +-
 drivers/devfreq/governor_powersave.c      |   2 +-
 drivers/devfreq/governor_simpleondemand.c |   7 +-
 include/linux/devfreq.h                   |  38 ++++--
 6 files changed, 108 insertions(+), 81 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 67da4e7b486b..7fd55b49c8ae 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -255,6 +255,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
  */
 int update_devfreq(struct devfreq *devfreq)
 {
+	struct devfreq_policy *policy = &devfreq->policy;
 	struct devfreq_freqs freqs;
 	unsigned long freq, cur_freq, min_freq, max_freq;
 	int err = 0;
@@ -265,11 +266,11 @@ int update_devfreq(struct devfreq *devfreq)
 		return -EINVAL;
 	}
 
-	if (!devfreq->governor)
+	if (!policy->governor)
 		return -EINVAL;
 
 	/* Reevaluate the proper frequency */
-	err = devfreq->governor->get_target_freq(devfreq, &freq);
+	err = policy->governor->get_target_freq(devfreq, &freq);
 	if (err)
 		return err;
 
@@ -280,8 +281,8 @@ int update_devfreq(struct devfreq *devfreq)
 	 * max_freq
 	 * min_freq
 	 */
-	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
-	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
+	max_freq = MIN(policy->devinfo.max_freq, policy->user.max_freq);
+	min_freq = MAX(policy->devinfo.min_freq, policy->user.min_freq);
 
 	if (freq < min_freq) {
 		freq = min_freq;
@@ -493,18 +494,19 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 				 void *devp)
 {
 	struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
+	struct devfreq_policy *policy = &devfreq->policy;
 	int ret;
 
 	mutex_lock(&devfreq->lock);
 
-	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
-	if (!devfreq->scaling_min_freq) {
+	policy->devinfo.min_freq = find_available_min_freq(devfreq);
+	if (!policy->devinfo.min_freq) {
 		mutex_unlock(&devfreq->lock);
 		return -EINVAL;
 	}
 
-	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
-	if (!devfreq->scaling_max_freq) {
+	policy->devinfo.max_freq = find_available_max_freq(devfreq);
+	if (!policy->devinfo.max_freq) {
 		mutex_unlock(&devfreq->lock);
 		return -EINVAL;
 	}
@@ -524,6 +526,7 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 static void devfreq_dev_release(struct device *dev)
 {
 	struct devfreq *devfreq = to_devfreq(dev);
+	struct devfreq_policy *policy = &devfreq->policy;
 
 	mutex_lock(&devfreq_list_lock);
 	if (IS_ERR(find_device_devfreq(devfreq->dev.parent))) {
@@ -534,8 +537,8 @@ static void devfreq_dev_release(struct device *dev)
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
-	if (devfreq->governor)
-		devfreq->governor->event_handler(devfreq,
+	if (policy->governor)
+		policy->governor->event_handler(devfreq,
 						 DEVFREQ_GOV_STOP, NULL);
 
 	if (devfreq->profile->exit)
@@ -559,6 +562,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 				   void *data)
 {
 	struct devfreq *devfreq;
+	struct devfreq_policy *policy;
 	struct devfreq_governor *governor;
 	static atomic_t devfreq_no = ATOMIC_INIT(-1);
 	int err = 0;
@@ -584,13 +588,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
+	policy = &devfreq->policy;
 	mutex_init(&devfreq->lock);
 	mutex_lock(&devfreq->lock);
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
 	devfreq->dev.release = devfreq_dev_release;
 	devfreq->profile = profile;
-	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
+	strncpy(policy->governor_name, governor_name, DEVFREQ_NAME_LEN);
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
@@ -604,21 +609,21 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_lock(&devfreq->lock);
 	}
 
-	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
-	if (!devfreq->scaling_min_freq) {
+	policy->devinfo.min_freq = find_available_min_freq(devfreq);
+	if (!policy->devinfo.min_freq) {
 		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
-	devfreq->min_freq = devfreq->scaling_min_freq;
+	policy->user.min_freq = policy->devinfo.min_freq;
 
-	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
-	if (!devfreq->scaling_max_freq) {
+	policy->devinfo.max_freq = find_available_max_freq(devfreq);
+	if (!policy->devinfo.max_freq) {
 		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
-	devfreq->max_freq = devfreq->scaling_max_freq;
+	policy->user.max_freq = policy->devinfo.max_freq;
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
@@ -646,7 +651,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	mutex_lock(&devfreq_list_lock);
 	list_add(&devfreq->node, &devfreq_list);
 
-	governor = find_devfreq_governor(devfreq->governor_name);
+	governor = find_devfreq_governor(policy->governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
 			__func__);
@@ -654,9 +659,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 
-	devfreq->governor = governor;
-	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
-						NULL);
+	policy->governor = governor;
+	err = policy->governor->event_handler(devfreq, DEVFREQ_GOV_START,
+					      NULL);
 	if (err) {
 		dev_err(dev, "%s: Unable to start governor for the device\n",
 			__func__);
@@ -817,10 +822,10 @@ int devfreq_suspend_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
-	if (!devfreq->governor)
+	if (!devfreq->policy.governor)
 		return 0;
 
-	return devfreq->governor->event_handler(devfreq,
+	return devfreq->policy.governor->event_handler(devfreq,
 				DEVFREQ_GOV_SUSPEND, NULL);
 }
 EXPORT_SYMBOL(devfreq_suspend_device);
@@ -838,10 +843,10 @@ int devfreq_resume_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
-	if (!devfreq->governor)
+	if (!devfreq->policy.governor)
 		return 0;
 
-	return devfreq->governor->event_handler(devfreq,
+	return devfreq->policy.governor->event_handler(devfreq,
 				DEVFREQ_GOV_RESUME, NULL);
 }
 EXPORT_SYMBOL(devfreq_resume_device);
@@ -875,30 +880,31 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 	list_for_each_entry(devfreq, &devfreq_list, node) {
 		int ret = 0;
 		struct device *dev = devfreq->dev.parent;
+		struct devfreq_policy *policy = &devfreq->policy;
 
-		if (!strncmp(devfreq->governor_name, governor->name,
+		if (!strncmp(policy->governor_name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
 			/* The following should never occur */
-			if (devfreq->governor) {
+			if (policy->governor) {
 				dev_warn(dev,
 					 "%s: Governor %s already present\n",
-					 __func__, devfreq->governor->name);
-				ret = devfreq->governor->event_handler(devfreq,
+					 __func__, policy->governor->name);
+				ret = policy->governor->event_handler(devfreq,
 							DEVFREQ_GOV_STOP, NULL);
 				if (ret) {
 					dev_warn(dev,
 						 "%s: Governor %s stop = %d\n",
 						 __func__,
-						 devfreq->governor->name, ret);
+						 policy->governor->name, ret);
 				}
 				/* Fall through */
 			}
-			devfreq->governor = governor;
-			ret = devfreq->governor->event_handler(devfreq,
+			policy->governor = governor;
+			ret = policy->governor->event_handler(devfreq,
 						DEVFREQ_GOV_START, NULL);
 			if (ret) {
 				dev_warn(dev, "%s: Governor %s start=%d\n",
-					 __func__, devfreq->governor->name,
+					 __func__, policy->governor->name,
 					 ret);
 			}
 		}
@@ -937,24 +943,25 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 	list_for_each_entry(devfreq, &devfreq_list, node) {
 		int ret;
 		struct device *dev = devfreq->dev.parent;
+		struct devfreq_policy *policy = &devfreq->policy;
 
-		if (!strncmp(devfreq->governor_name, governor->name,
+		if (!strncmp(policy->governor_name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
 			/* we should have a devfreq governor! */
-			if (!devfreq->governor) {
+			if (!policy->governor) {
 				dev_warn(dev, "%s: Governor %s NOT present\n",
 					 __func__, governor->name);
 				continue;
 				/* Fall through */
 			}
-			ret = devfreq->governor->event_handler(devfreq,
+			ret = policy->governor->event_handler(devfreq,
 						DEVFREQ_GOV_STOP, NULL);
 			if (ret) {
 				dev_warn(dev, "%s: Governor %s stop=%d\n",
-					 __func__, devfreq->governor->name,
+					 __func__, policy->governor->name,
 					 ret);
 			}
-			devfreq->governor = NULL;
+			policy->governor = NULL;
 		}
 	}
 
@@ -969,16 +976,17 @@ EXPORT_SYMBOL(devfreq_remove_governor);
 static ssize_t governor_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	if (!to_devfreq(dev)->governor)
+	if (!to_devfreq(dev)->policy.governor)
 		return -EINVAL;
 
-	return sprintf(buf, "%s\n", to_devfreq(dev)->governor->name);
+	return sprintf(buf, "%s\n", to_devfreq(dev)->policy.governor->name);
 }
 
 static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	struct devfreq *df = to_devfreq(dev);
+	struct devfreq_policy *policy = &df->policy;
 	int ret;
 	char str_governor[DEVFREQ_NAME_LEN + 1];
 	struct devfreq_governor *governor;
@@ -993,29 +1001,29 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		ret = PTR_ERR(governor);
 		goto out;
 	}
-	if (df->governor == governor) {
+	if (policy->governor == governor) {
 		ret = 0;
 		goto out;
-	} else if ((df->governor && df->governor->immutable) ||
+	} else if ((policy->governor && policy->governor->immutable) ||
 					governor->immutable) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (df->governor) {
-		ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
+	if (policy->governor) {
+		ret = policy->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
 		if (ret) {
 			dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
-				 __func__, df->governor->name, ret);
+				 __func__, policy->governor->name, ret);
 			goto out;
 		}
 	}
-	df->governor = governor;
-	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
-	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
+	policy->governor = governor;
+	strncpy(policy->governor_name, governor->name, DEVFREQ_NAME_LEN);
+	ret = policy->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 	if (ret)
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
-			 __func__, df->governor->name, ret);
+			 __func__, policy->governor->name, ret);
 out:
 	mutex_unlock(&devfreq_list_lock);
 
@@ -1030,6 +1038,7 @@ static ssize_t available_governors_show(struct device *d,
 					char *buf)
 {
 	struct devfreq *df = to_devfreq(d);
+	struct devfreq_policy *policy = &df->policy;
 	ssize_t count = 0;
 
 	mutex_lock(&devfreq_list_lock);
@@ -1038,9 +1047,9 @@ static ssize_t available_governors_show(struct device *d,
 	 * The devfreq with immutable governor (e.g., passive) shows
 	 * only own governor.
 	 */
-	if (df->governor->immutable) {
+	if (policy->governor->immutable) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
-				   "%s ", df->governor_name);
+				   "%s ", policy->governor_name);
 	/*
 	 * The devfreq device shows the registered governor except for
 	 * immutable governors such as passive governor .
@@ -1100,17 +1109,18 @@ static ssize_t polling_interval_store(struct device *dev,
 				      const char *buf, size_t count)
 {
 	struct devfreq *df = to_devfreq(dev);
+	struct devfreq_policy *policy = &df->policy;
 	unsigned int value;
 	int ret;
 
-	if (!df->governor)
+	if (!policy->governor)
 		return -EINVAL;
 
 	ret = sscanf(buf, "%u", &value);
 	if (ret != 1)
 		return -EINVAL;
 
-	df->governor->event_handler(df, DEVFREQ_GOV_INTERVAL, &value);
+	policy->governor->event_handler(df, DEVFREQ_GOV_INTERVAL, &value);
 	ret = count;
 
 	return ret;
@@ -1131,7 +1141,7 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&df->lock);
 
 	if (value) {
-		if (value > df->max_freq) {
+		if (value > df->policy.user.max_freq) {
 			ret = -EINVAL;
 			goto unlock;
 		}
@@ -1139,7 +1149,7 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 		value = df->profile->freq_table[df->profile->max_state - 1];
 	}
 
-	df->min_freq = value;
+	df->policy.user.min_freq = value;
 	update_devfreq(df);
 	ret = count;
 unlock:
@@ -1150,9 +1160,10 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	struct devfreq *df = to_devfreq(dev);
+	struct devfreq_policy *policy = &to_devfreq(dev)->policy;
 
-	return sprintf(buf, "%lu\n", MAX(df->scaling_min_freq, df->min_freq));
+	return sprintf(buf, "%lu\n",
+		       MAX(policy->devinfo.min_freq, policy->user.min_freq));
 }
 
 static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
@@ -1169,15 +1180,15 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&df->lock);
 
 	if (!value) {
-		value = df->profile->freq_table[0];
+		value = df->policy.user.min_freq;
 	} else {
-		if (value < df->min_freq) {
+		if (value < df->policy.user.min_freq) {
 			ret = -EINVAL;
 			goto unlock;
 		}
 	}
 
-	df->max_freq = value;
+	df->policy.user.max_freq = value;
 	update_devfreq(df);
 	ret = count;
 unlock:
@@ -1189,9 +1200,10 @@ static DEVICE_ATTR_RW(min_freq);
 static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	struct devfreq *df = to_devfreq(dev);
+	struct devfreq_policy *policy = &to_devfreq(dev)->policy;
 
-	return sprintf(buf, "%lu\n", MIN(df->scaling_max_freq, df->max_freq));
+	return sprintf(buf, "%lu\n",
+		       MIN(policy->devinfo.max_freq, policy->user.max_freq));
 }
 static DEVICE_ATTR_RW(max_freq);
 
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 3bc29acbd54e..e0987c749ec2 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -99,12 +99,12 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
 {
 	int ret;
 
-	if (!devfreq->governor)
+	if (!devfreq->policy.governor)
 		return -EINVAL;
 
 	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
 
-	ret = devfreq->governor->get_target_freq(devfreq, &freq);
+	ret = devfreq->policy.governor->get_target_freq(devfreq, &freq);
 	if (ret < 0)
 		goto out;
 
diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index a8e3478b3c43..e5767bdbf77d 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -20,7 +20,7 @@ static int devfreq_performance_func(struct devfreq *df,
 	 * target callback should be able to get floor value as
 	 * said in devfreq.h
 	 */
-	*freq = df->scaling_max_freq;
+	*freq = df->policy.devinfo.max_freq;
 	return 0;
 }
 
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index 8696efd32e5a..86184b3a572a 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -20,7 +20,7 @@ static int devfreq_powersave_func(struct devfreq *df,
 	 * target callback should be able to get ceiling value as
 	 * said in devfreq.h
 	 */
-	*freq = df->scaling_min_freq;
+	*freq = df->policy.devinfo.min_freq;
 	return 0;
 }
 
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 805fee09c754..076f9f8e33b2 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -23,6 +23,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 {
 	int err;
 	struct devfreq_dev_status *stat;
+	struct devfreq_policy *policy = &df->policy;
 	unsigned long long a, b;
 	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
 	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
@@ -46,7 +47,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 
 	/* Assume MAX if it is going to be divided by zero */
 	if (stat->total_time == 0) {
-		*freq = df->scaling_max_freq;
+		*freq = policy->devinfo.max_freq;
 		return 0;
 	}
 
@@ -59,13 +60,13 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	/* Set MAX if it's busy enough */
 	if (stat->busy_time * 100 >
 	    stat->total_time * dfso_upthreshold) {
-		*freq = df->scaling_max_freq;
+		*freq = policy->devinfo.max_freq;
 		return 0;
 	}
 
 	/* Set MAX if we do not know the initial frequency */
 	if (stat->current_frequency == 0) {
-		*freq = df->scaling_max_freq;
+		*freq = policy->devinfo.max_freq;
 		return 0;
 	}
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 3aae5b3af87c..9bf23b976f4d 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -109,6 +109,30 @@ struct devfreq_dev_profile {
 	unsigned int max_state;
 };
 
+/**
+ * struct devfreq_freq_limits - Devfreq frequency limits
+ * @min_freq:	minimum frequency
+ * @max_freq:	maximum frequency
+ */
+struct devfreq_freq_limits {
+	unsigned long min_freq;
+	unsigned long max_freq;
+};
+
+/**
+ * struct devfreq_policy - Devfreq policy
+ * @user:	frequency limits requested by the user
+ * @devinfo:	frequency limits of the device (available OPPs)
+ * @governor:	method how to choose frequency based on the usage.
+ * @governor_name:	devfreq governor name for use with this devfreq
+ */
+struct devfreq_policy {
+	struct devfreq_freq_limits user;
+	struct devfreq_freq_limits devinfo;
+	const struct devfreq_governor *governor;
+	char governor_name[DEVFREQ_NAME_LEN];
+};
+
 /**
  * struct devfreq - Device devfreq structure
  * @node:	list node - contains the devices with devfreq that have been
@@ -117,8 +141,6 @@ struct devfreq_dev_profile {
  * @dev:	device registered by devfreq class. dev.parent is the device
  *		using devfreq.
  * @profile:	device-specific devfreq profile
- * @governor:	method how to choose frequency based on the usage.
- * @governor_name:	devfreq governor name for use with this devfreq
  * @nb:		notifier block used to notify devfreq object that it should
  *		reevaluate operable frequencies. Devfreq users may use
  *		devfreq.nb to the corresponding register notifier call chain.
@@ -126,10 +148,7 @@ struct devfreq_dev_profile {
  * @previous_freq:	previously configured frequency value.
  * @data:	Private data of the governor. The devfreq framework does not
  *		touch this.
- * @min_freq:	Limit minimum frequency requested by user (0: none)
- * @max_freq:	Limit maximum frequency requested by user (0: none)
- * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
- * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
+ * @policy:		Policy for frequency adjustments
  * @stop_polling:	 devfreq polling status of a device.
  * @total_trans:	Number of devfreq transitions
  * @trans_table:	Statistics of devfreq transitions
@@ -151,8 +170,6 @@ struct devfreq {
 	struct mutex lock;
 	struct device dev;
 	struct devfreq_dev_profile *profile;
-	const struct devfreq_governor *governor;
-	char governor_name[DEVFREQ_NAME_LEN];
 	struct notifier_block nb;
 	struct delayed_work work;
 
@@ -161,10 +178,7 @@ struct devfreq {
 
 	void *data; /* private data for governors */
 
-	unsigned long min_freq;
-	unsigned long max_freq;
-	unsigned long scaling_min_freq;
-	unsigned long scaling_max_freq;
+	struct devfreq_policy policy;
 	bool stop_polling;
 
 	/* information for device frequency transition */
-- 
2.17.0.921.gf22659ad46-goog
