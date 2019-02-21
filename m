Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C74C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A7F2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2f/oGpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfBUP0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:26:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46812 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfBUP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:26:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id i16so22756891wrs.13;
        Thu, 21 Feb 2019 07:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2mPuomQdxwqWDdG5gE3W/vPTRBsJaygtW8uJE6nsHgs=;
        b=G2f/oGpE/YIvrDT0Wk1FlV4o5enGTcVXPPm7PK5mdHxgjyxlhdy42sNJrVprVsQ9b+
         iN47lTgcqHUu8WpexU3opJs820EiWWgRkkYGd0CyLplROqJxrHOS87bqwU/r6gTSDnx3
         lwLdsO9anfakvo9+3y7mNQWXLzC1xtFcZE94atc4gZxpN5rbyFXRN0g4iiDL79XznpFv
         QqYqyJcGmbMgk2Pk0cyocLPJRTUOE2U74aJzW5HKEuu95Bihbszq7PI/o4UQX0pA3SFI
         VRHRFq/ecA0v6oZ0ZS199zIdk78wTDAc3jBaLlvXmQpqgAH21Pnr2KYfeCAmHnAef3XK
         so4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2mPuomQdxwqWDdG5gE3W/vPTRBsJaygtW8uJE6nsHgs=;
        b=QA+2EMzDILbnYM+VV5VbqLMpdBHMjRg8gGTGBY28jfeDKUqSDFjFyAnEwipvG6esNi
         40Rm5VK7L+wchA7ksvL6Tt3BwMux+JQ4i07DEgfW6znmMEEioDHES+fhmOchGTP7ea6Y
         +6WW0c6pDp5xXEB9GF7c4FgyzHQq/QAwGuqpT17JADf4YoNhu3tifNjMeofgCiP8QIxO
         quFVnRHcNN+waS4vdLyGpQK5USSJ8n+JkaE9zYv2mBNjeo81SCRgo/tY15szJSmMUFyj
         cgCDWYMLYSCLCcyHzBOEIAV1BwZm5lAZseYscGIgTL7oFPAPjIfFPZ/e/TU6T5YPoe1J
         2RuQ==
X-Gm-Message-State: AHQUAuYbspTh9YaPb4K6EHA4TW50Wonbud9094iFrNSvUJ7oE1U+auY6
        YM0zIk1BqYrUs8+aD9DL6bU=
X-Google-Smtp-Source: AHgI3IavC27+If29yMbN0ki/mlVjQGOZP44RCpyWg5wuHEqrcJa7N5Gus1+Ec7txtpD2K9a9bO5FUw==
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr10617956wml.4.1550762759160;
        Thu, 21 Feb 2019 07:25:59 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id a1sm22260280wrq.96.2019.02.21.07.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:25:58 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] reset: add acquired/released state for exclusive reset controls
Date:   Thu, 21 Feb 2019 16:25:53 +0100
Message-Id: <20190221152557.8534-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

There are cases where a driver needs explicit control over a reset line
that is exclusively conneted to its device, but this control has to be
temporarily handed over to the power domain controller to handle reset
requirements during power transitions.
Allow multiple exclusive reset controls to be requested in 'released'
state for the same physical reset line, only one of which can be
acquired at the same time.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/reset/core.c  | 139 ++++++++++++++++++++++++++++++++++++++----
 include/linux/reset.h |  93 ++++++++++++++++++++++------
 2 files changed, 200 insertions(+), 32 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 9582efb70025..1e8a42b16f23 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -34,6 +34,7 @@ static LIST_HEAD(reset_lookup_list);
  * @id: ID of the reset controller in the reset
  *      controller device
  * @refcnt: Number of gets of this reset_control
+ * @acquired: Only one reset_control may be acquired for a given rcdev and id.
  * @shared: Is this a shared (1), or an exclusive (0) reset_control?
  * @deassert_cnt: Number of times this reset line has been deasserted
  * @triggered_count: Number of times this reset line has been reset. Currently
@@ -45,6 +46,7 @@ struct reset_control {
 	struct list_head list;
 	unsigned int id;
 	struct kref refcnt;
+	bool acquired;
 	bool shared;
 	bool array;
 	atomic_t deassert_count;
@@ -63,6 +65,17 @@ struct reset_control_array {
 	struct reset_control *rstc[];
 };
 
+static const char *rcdev_name(struct reset_controller_dev *rcdev)
+{
+	if (rcdev->dev)
+		return dev_name(rcdev->dev);
+
+	if (rcdev->of_node)
+		return rcdev->of_node->full_name;
+
+	return NULL;
+}
+
 /**
  * of_reset_simple_xlate - translate reset_spec to the reset line number
  * @rcdev: a pointer to the reset controller device
@@ -272,6 +285,9 @@ int reset_control_reset(struct reset_control *rstc)
 
 		if (atomic_inc_return(&rstc->triggered_count) != 1)
 			return 0;
+	} else {
+		if (!rstc->acquired)
+			return -EPERM;
 	}
 
 	ret = rstc->rcdev->ops->reset(rstc->rcdev, rstc->id);
@@ -334,6 +350,12 @@ int reset_control_assert(struct reset_control *rstc)
 		 */
 		if (!rstc->rcdev->ops->assert)
 			return -ENOTSUPP;
+
+		if (!rstc->acquired) {
+			WARN(1, "reset %s (ID: %u) is not acquired\n",
+			     rcdev_name(rstc->rcdev), rstc->id);
+			return -EPERM;
+		}
 	}
 
 	return rstc->rcdev->ops->assert(rstc->rcdev, rstc->id);
@@ -369,6 +391,12 @@ int reset_control_deassert(struct reset_control *rstc)
 
 		if (atomic_inc_return(&rstc->deassert_count) != 1)
 			return 0;
+	} else {
+		if (!rstc->acquired) {
+			WARN(1, "reset %s (ID: %u) is not acquired\n",
+			     rcdev_name(rstc->rcdev), rstc->id);
+			return -EPERM;
+		}
 	}
 
 	/*
@@ -406,9 +434,81 @@ int reset_control_status(struct reset_control *rstc)
 }
 EXPORT_SYMBOL_GPL(reset_control_status);
 
+/**
+ * reset_control_acquire() - acquires a reset control for exclusive use
+ * @rstc: reset control
+ *
+ * This is used to explicitly acquire a reset control for exclusive use. Note
+ * that exclusive resets are requested as acquired by default. In order for a
+ * second consumer to be able to control the reset, the first consumer has to
+ * release it first. Typically the easiest way to achieve this is to call the
+ * reset_control_get_exclusive_released() to obtain an instance of the reset
+ * control. Such reset controls are not acquired by default.
+ *
+ * Consumers implementing shared access to an exclusive reset need to follow
+ * a specific protocol in order to work together. Before consumers can change
+ * a reset they must acquire exclusive access using reset_control_acquire().
+ * After they are done operating the reset, they must release exclusive access
+ * with a call to reset_control_release(). Consumers are not granted exclusive
+ * access to the reset as long as another consumer hasn't released a reset.
+ *
+ * See also: reset_control_release()
+ */
+int reset_control_acquire(struct reset_control *rstc)
+{
+	struct reset_control *rc;
+
+	if (!rstc)
+		return 0;
+
+	if (WARN_ON(IS_ERR(rstc)))
+		return -EINVAL;
+
+	mutex_lock(&reset_list_mutex);
+
+	if (rstc->acquired) {
+		mutex_unlock(&reset_list_mutex);
+		return 0;
+	}
+
+	list_for_each_entry(rc, &rstc->rcdev->reset_control_head, list) {
+		if (rstc != rc && rstc->id == rc->id) {
+			if (rc->acquired) {
+				mutex_unlock(&reset_list_mutex);
+				return -EBUSY;
+			}
+		}
+	}
+
+	rstc->acquired = true;
+
+	mutex_unlock(&reset_list_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reset_control_acquire);
+
+/**
+ * reset_control_release() - releases exclusive access to a reset control
+ * @rstc: reset control
+ *
+ * Releases exclusive access right to a reset control previously obtained by a
+ * call to reset_control_acquire(). Until a consumer calls this function, no
+ * other consumers will be granted exclusive access.
+ *
+ * See also: reset_control_acquire()
+ */
+void reset_control_release(struct reset_control *rstc)
+{
+	if (!rstc || WARN_ON(IS_ERR(rstc)))
+		return;
+
+	rstc->acquired = false;
+}
+EXPORT_SYMBOL_GPL(reset_control_release);
+
 static struct reset_control *__reset_control_get_internal(
 				struct reset_controller_dev *rcdev,
-				unsigned int index, bool shared)
+				unsigned int index, bool shared, bool acquired)
 {
 	struct reset_control *rstc;
 
@@ -416,6 +516,14 @@ static struct reset_control *__reset_control_get_internal(
 
 	list_for_each_entry(rstc, &rcdev->reset_control_head, list) {
 		if (rstc->id == index) {
+			/*
+			 * Allow creating a secondary exclusive reset_control
+			 * that is initially not acquired for an already
+			 * controlled reset line.
+			 */
+			if (!rstc->shared && !shared && !acquired)
+				break;
+
 			if (WARN_ON(!rstc->shared || !shared))
 				return ERR_PTR(-EBUSY);
 
@@ -434,6 +542,7 @@ static struct reset_control *__reset_control_get_internal(
 	list_add(&rstc->list, &rcdev->reset_control_head);
 	rstc->id = index;
 	kref_init(&rstc->refcnt);
+	rstc->acquired = acquired;
 	rstc->shared = shared;
 
 	return rstc;
@@ -461,7 +570,7 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 
 struct reset_control *__of_reset_control_get(struct device_node *node,
 				     const char *id, int index, bool shared,
-				     bool optional)
+				     bool optional, bool acquired)
 {
 	struct reset_control *rstc;
 	struct reset_controller_dev *r, *rcdev;
@@ -514,7 +623,7 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
 	}
 
 	/* reset_list_mutex also protects the rcdev's reset_control list */
-	rstc = __reset_control_get_internal(rcdev, rstc_id, shared);
+	rstc = __reset_control_get_internal(rcdev, rstc_id, shared, acquired);
 
 out:
 	mutex_unlock(&reset_list_mutex);
@@ -544,7 +653,7 @@ __reset_controller_by_name(const char *name)
 
 static struct reset_control *
 __reset_control_get_from_lookup(struct device *dev, const char *con_id,
-				bool shared, bool optional)
+				bool shared, bool optional, bool acquired)
 {
 	const struct reset_control_lookup *lookup;
 	struct reset_controller_dev *rcdev;
@@ -574,7 +683,7 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 
 			rstc = __reset_control_get_internal(rcdev,
 							    lookup->index,
-							    shared);
+							    shared, acquired);
 			mutex_unlock(&reset_list_mutex);
 			break;
 		}
@@ -589,13 +698,18 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 }
 
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
-					  int index, bool shared, bool optional)
+					  int index, bool shared, bool optional,
+					  bool acquired)
 {
+	if (WARN_ON(shared && acquired))
+		return ERR_PTR(-EINVAL);
+
 	if (dev->of_node)
 		return __of_reset_control_get(dev->of_node, id, index, shared,
-					      optional);
+					      optional, acquired);
 
-	return __reset_control_get_from_lookup(dev, id, shared, optional);
+	return __reset_control_get_from_lookup(dev, id, shared, optional,
+					       acquired);
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
 
@@ -636,7 +750,7 @@ static void devm_reset_control_release(struct device *dev, void *res)
 
 struct reset_control *__devm_reset_control_get(struct device *dev,
 				     const char *id, int index, bool shared,
-				     bool optional)
+				     bool optional, bool acquired)
 {
 	struct reset_control **ptr, *rstc;
 
@@ -645,7 +759,7 @@ struct reset_control *__devm_reset_control_get(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	rstc = __reset_control_get(dev, id, index, shared, optional);
+	rstc = __reset_control_get(dev, id, index, shared, optional, acquired);
 	if (!IS_ERR(rstc)) {
 		*ptr = rstc;
 		devres_add(dev, ptr);
@@ -672,7 +786,7 @@ int __device_reset(struct device *dev, bool optional)
 	struct reset_control *rstc;
 	int ret;
 
-	rstc = __reset_control_get(dev, NULL, 0, 0, optional);
+	rstc = __reset_control_get(dev, NULL, 0, 0, optional, true);
 	if (IS_ERR(rstc))
 		return PTR_ERR(rstc);
 
@@ -736,7 +850,8 @@ of_reset_control_array_get(struct device_node *np, bool shared, bool optional)
 		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < num; i++) {
-		rstc = __of_reset_control_get(np, NULL, i, shared, optional);
+		rstc = __of_reset_control_get(np, NULL, i, shared, optional,
+					      true);
 		if (IS_ERR(rstc))
 			goto err_rst;
 		resets->rstc[i] = rstc;
diff --git a/include/linux/reset.h b/include/linux/reset.h
index c1901b61ca30..ea9a8a1ce4b1 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -14,18 +14,20 @@ int reset_control_reset(struct reset_control *rstc);
 int reset_control_assert(struct reset_control *rstc);
 int reset_control_deassert(struct reset_control *rstc);
 int reset_control_status(struct reset_control *rstc);
+int reset_control_acquire(struct reset_control *rstc);
+void reset_control_release(struct reset_control *rstc);
 
 struct reset_control *__of_reset_control_get(struct device_node *node,
 				     const char *id, int index, bool shared,
-				     bool optional);
+				     bool optional, bool acquired);
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
 					  int index, bool shared,
-					  bool optional);
+					  bool optional, bool acquired);
 void reset_control_put(struct reset_control *rstc);
 int __device_reset(struct device *dev, bool optional);
 struct reset_control *__devm_reset_control_get(struct device *dev,
 				     const char *id, int index, bool shared,
-				     bool optional);
+				     bool optional, bool acquired);
 
 struct reset_control *devm_reset_control_array_get(struct device *dev,
 						   bool shared, bool optional);
@@ -56,6 +58,15 @@ static inline int reset_control_status(struct reset_control *rstc)
 	return 0;
 }
 
+static inline int reset_control_acquire(struct reset_control *rstc)
+{
+	return 0;
+}
+
+static inline void reset_control_release(struct reset_control *rstc)
+{
+}
+
 static inline void reset_control_put(struct reset_control *rstc)
 {
 }
@@ -68,21 +79,23 @@ static inline int __device_reset(struct device *dev, bool optional)
 static inline struct reset_control *__of_reset_control_get(
 					struct device_node *node,
 					const char *id, int index, bool shared,
-					bool optional)
+					bool optional, bool acquired)
 {
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct reset_control *__reset_control_get(
 					struct device *dev, const char *id,
-					int index, bool shared, bool optional)
+					int index, bool shared, bool optional,
+					bool acquired)
 {
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct reset_control *__devm_reset_control_get(
 					struct device *dev, const char *id,
-					int index, bool shared, bool optional)
+					int index, bool shared, bool optional,
+					bool acquired)
 {
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
@@ -134,7 +147,28 @@ static inline int device_reset_optional(struct device *dev)
 static inline struct reset_control *
 __must_check reset_control_get_exclusive(struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, false, false);
+	return __reset_control_get(dev, id, 0, false, false, true);
+}
+
+/**
+ * reset_control_get_exclusive_released - Lookup and obtain a temoprarily
+ *                                        exclusive reference to a reset
+ *                                        controller.
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ * reset-controls returned by this function must be acquired via
+ * reset_control_acquire() before they can be used and should be released
+ * via reset_control_release() afterwards.
+ *
+ * Use of id names is optional.
+ */
+static inline struct reset_control *
+__must_check reset_control_get_exclusive_released(struct device *dev,
+						  const char *id)
+{
+	return __reset_control_get(dev, id, 0, false, false, false);
 }
 
 /**
@@ -162,19 +196,19 @@ __must_check reset_control_get_exclusive(struct device *dev, const char *id)
 static inline struct reset_control *reset_control_get_shared(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, true, false);
+	return __reset_control_get(dev, id, 0, true, false, false);
 }
 
 static inline struct reset_control *reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, false, true);
+	return __reset_control_get(dev, id, 0, false, true, true);
 }
 
 static inline struct reset_control *reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, true, true);
+	return __reset_control_get(dev, id, 0, true, true, false);
 }
 
 /**
@@ -190,7 +224,7 @@ static inline struct reset_control *reset_control_get_optional_shared(
 static inline struct reset_control *of_reset_control_get_exclusive(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, false, false);
+	return __of_reset_control_get(node, id, 0, false, false, true);
 }
 
 /**
@@ -215,7 +249,7 @@ static inline struct reset_control *of_reset_control_get_exclusive(
 static inline struct reset_control *of_reset_control_get_shared(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, true, false);
+	return __of_reset_control_get(node, id, 0, true, false, false);
 }
 
 /**
@@ -232,7 +266,7 @@ static inline struct reset_control *of_reset_control_get_shared(
 static inline struct reset_control *of_reset_control_get_exclusive_by_index(
 					struct device_node *node, int index)
 {
-	return __of_reset_control_get(node, NULL, index, false, false);
+	return __of_reset_control_get(node, NULL, index, false, false, true);
 }
 
 /**
@@ -260,7 +294,7 @@ static inline struct reset_control *of_reset_control_get_exclusive_by_index(
 static inline struct reset_control *of_reset_control_get_shared_by_index(
 					struct device_node *node, int index)
 {
-	return __of_reset_control_get(node, NULL, index, true, false);
+	return __of_reset_control_get(node, NULL, index, true, false, false);
 }
 
 /**
@@ -279,7 +313,26 @@ static inline struct reset_control *
 __must_check devm_reset_control_get_exclusive(struct device *dev,
 					      const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, false);
+	return __devm_reset_control_get(dev, id, 0, false, false, true);
+}
+
+/**
+ * devm_reset_control_get_exclusive_released - resource managed
+ *                                             reset_control_get_exclusive_released()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_exclusive_released(). For reset controllers
+ * returned from this function, reset_control_put() is called automatically on
+ * driver detach.
+ *
+ * See reset_control_get_exclusive_released() for more information.
+ */
+static inline struct reset_control *
+__must_check devm_reset_control_get_exclusive_released(struct device *dev,
+						       const char *id)
+{
+	return __devm_reset_control_get(dev, id, 0, false, false, false);
 }
 
 /**
@@ -294,19 +347,19 @@ __must_check devm_reset_control_get_exclusive(struct device *dev,
 static inline struct reset_control *devm_reset_control_get_shared(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, true, false);
+	return __devm_reset_control_get(dev, id, 0, true, false, false);
 }
 
 static inline struct reset_control *devm_reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, true);
+	return __devm_reset_control_get(dev, id, 0, false, true, true);
 }
 
 static inline struct reset_control *devm_reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, true, true);
+	return __devm_reset_control_get(dev, id, 0, true, true, false);
 }
 
 /**
@@ -324,7 +377,7 @@ static inline struct reset_control *devm_reset_control_get_optional_shared(
 static inline struct reset_control *
 devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
 {
-	return __devm_reset_control_get(dev, NULL, index, false, false);
+	return __devm_reset_control_get(dev, NULL, index, false, false, true);
 }
 
 /**
@@ -340,7 +393,7 @@ devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
 static inline struct reset_control *
 devm_reset_control_get_shared_by_index(struct device *dev, int index)
 {
-	return __devm_reset_control_get(dev, NULL, index, true, false);
+	return __devm_reset_control_get(dev, NULL, index, true, false, false);
 }
 
 /*
-- 
2.20.1

