Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61770C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F291427C85
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuFHuxnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F291427C85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966019AbeF2S4S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:56:18 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33353 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933750AbeF2Suy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:50:54 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so4875563plb.0;
        Fri, 29 Jun 2018 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZmJIhIRVz2+Mv/TNWhdgj3v4VSekIbrzKsm5fVhIAjw=;
        b=UuFHuxnrEqjR/6S8KcB5DoTGkBCX6uUhh5prKjorlFLg+eoOB8MqC7aRW78ISpp0rZ
         3x6ZloTPdZ1v3iNtg67SjQIZMcQ9BclMbxphugp+BcQazWYrZ7X75AD0bBlZN+2mF73g
         yDbrSUrgKtoZDcsAlyRYICFp+Xkd48aHEEv/mtRXPjOp/+iRWdgCDaPXMfJiezoyC5bg
         2lTI+RPM1J8IxvLozKKed2+5+OlTWlAfLbp/KLUelrkbB6dktD/0aXEj8HJ6lHOH/MmA
         vLag3UQxnxzc5jsTR/2DytSn/dvx6kYF/wJUcJWARE2uHuMh78Y7rKPH+kfL6epvcIbA
         U5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZmJIhIRVz2+Mv/TNWhdgj3v4VSekIbrzKsm5fVhIAjw=;
        b=ui3mP01iOK1RLcC5xhzNe5KxWaKXNwYPaFMGObGrs5nLomtwoJj0JuKr1bB1hDSEZc
         Qpbe04d3kFR215yE0bnIeC/WTZ/7+EsdCAn71MXQk7IPXxpD61LgA6vX8VPD2a1mCYkP
         iqhqNpDvcdxtvC6rOgSSWtVwyuzx7a9wGsTO9E2lP7fnIXNMYn9DcHe12ddL84hEGz+Q
         ZXylsHqGCwtceRN7144ht0hqlA/NE4+UyDqd2s9f8mizCGLwTv8SxyjH/U4bX8GPD07Q
         2dcRu1dIqaV5JD0vAwCKeL4gFTrGG1w1kgnMXT8KGdPgC36huWiyNEDqx8gqzFzPk34H
         i0RA==
X-Gm-Message-State: APt69E3cIkUdpfbQU2iGaBizOqSjdY/VSys8rQHlj6YOK1U0FazoKmMF
        NZu859zPMlBbdNQEuahoJ6708A==
X-Google-Smtp-Source: ADUXVKLptNfat8/fujNTJ1gvy06bxn10uy2J8hLXW/PIT2pyEoAy0t33wAbEhnZTzJgeNFWp4QuFAQ==
X-Received: by 2002:a17:902:be0b:: with SMTP id r11-v6mr16593955pls.182.1530298253616;
        Fri, 29 Jun 2018 11:50:53 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:50:52 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/17] media: v4l2: async: Add v4l2_async_notifier_add_subdev
Date:   Fri, 29 Jun 2018 11:49:47 -0700
Message-Id: <1530298220-5097-4-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2_async_notifier_add_subdev() adds an asd to the notifier. It checks
that no other equivalent asd's have already been added to this notifier's
asd list, or to other registered notifier's waiting or done lists, and
increments num_subdevs.

v4l2_async_notifier_add_subdev() does not make use of the notifier subdevs
array, otherwise it would have to re-allocate the array every time the
function was called. In place of the subdevs array, the function adds
the newly allocated asd to a new master asd_list. The function will
return error with a WARN() if it is ever called with the subdevs array
allocated.

In v4l2_async_notifier_has_async_subdev(), __v4l2_async_notifier_register(),
and v4l2_async_notifier_cleanup(), maintain backward compatibility with
the subdevs array, by alternatively operate on the subdevs array or a
non-empty notifier->asd_list.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
Changes since v4:
- none
Changes since v3:
- init notifier lists after the sanity checks.
Changes since v2:
- add a NULL asd pointer check to v4l2_async_notifier_asd_valid().
Changes since v1:
- none
---
 drivers/media/v4l2-core/v4l2-async.c | 206 +++++++++++++++++++++++++++--------
 include/media/v4l2-async.h           |  26 ++++-
 2 files changed, 187 insertions(+), 45 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 0e7e529..48d66ae 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -363,16 +363,26 @@ static bool v4l2_async_notifier_has_async_subdev(
 	struct v4l2_async_notifier *notifier, struct v4l2_async_subdev *asd,
 	unsigned int this_index)
 {
+	struct v4l2_async_subdev *asd_y;
 	unsigned int j;
 
 	lockdep_assert_held(&list_lock);
 
 	/* Check that an asd is not being added more than once. */
-	for (j = 0; j < this_index; j++) {
-		struct v4l2_async_subdev *asd_y = notifier->subdevs[j];
-
-		if (asd_equal(asd, asd_y))
-			return true;
+	if (notifier->subdevs) {
+		for (j = 0; j < this_index; j++) {
+			asd_y = notifier->subdevs[j];
+			if (asd_equal(asd, asd_y))
+				return true;
+		}
+	} else {
+		j = 0;
+		list_for_each_entry(asd_y, &notifier->asd_list, asd_list) {
+			if (j++ >= this_index)
+				break;
+			if (asd_equal(asd, asd_y))
+				return true;
+		}
 	}
 
 	/* Check that an asd does not exist in other notifiers. */
@@ -383,10 +393,46 @@ static bool v4l2_async_notifier_has_async_subdev(
 	return false;
 }
 
-static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
+static int v4l2_async_notifier_asd_valid(struct v4l2_async_notifier *notifier,
+					 struct v4l2_async_subdev *asd,
+					 unsigned int this_index)
 {
 	struct device *dev =
 		notifier->v4l2_dev ? notifier->v4l2_dev->dev : NULL;
+
+	if (!asd)
+		return -EINVAL;
+
+	switch (asd->match_type) {
+	case V4L2_ASYNC_MATCH_CUSTOM:
+	case V4L2_ASYNC_MATCH_DEVNAME:
+	case V4L2_ASYNC_MATCH_I2C:
+	case V4L2_ASYNC_MATCH_FWNODE:
+		if (v4l2_async_notifier_has_async_subdev(notifier, asd,
+							 this_index))
+			return -EEXIST;
+		break;
+	default:
+		dev_err(dev, "Invalid match type %u on %p\n",
+			asd->match_type, asd);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void __v4l2_async_notifier_init(struct v4l2_async_notifier *notifier)
+{
+	lockdep_assert_held(&list_lock);
+
+	INIT_LIST_HEAD(&notifier->asd_list);
+	INIT_LIST_HEAD(&notifier->waiting);
+	INIT_LIST_HEAD(&notifier->done);
+	notifier->lists_initialized = true;
+}
+
+static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
+{
 	struct v4l2_async_subdev *asd;
 	int ret;
 	int i;
@@ -394,34 +440,40 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
 	if (notifier->num_subdevs > V4L2_MAX_SUBDEVS)
 		return -EINVAL;
 
-	INIT_LIST_HEAD(&notifier->waiting);
-	INIT_LIST_HEAD(&notifier->done);
-
 	mutex_lock(&list_lock);
 
-	for (i = 0; i < notifier->num_subdevs; i++) {
-		asd = notifier->subdevs[i];
+	if (!notifier->lists_initialized)
+		__v4l2_async_notifier_init(notifier);
 
-		switch (asd->match_type) {
-		case V4L2_ASYNC_MATCH_CUSTOM:
-		case V4L2_ASYNC_MATCH_DEVNAME:
-		case V4L2_ASYNC_MATCH_I2C:
-		case V4L2_ASYNC_MATCH_FWNODE:
-			if (v4l2_async_notifier_has_async_subdev(
-				    notifier, asd, i)) {
-				dev_err(dev,
-					"asd has already been registered or in notifier's subdev list\n");
-				ret = -EEXIST;
-				goto err_unlock;
-			}
-			break;
-		default:
-			dev_err(dev, "Invalid match type %u on %p\n",
-				asd->match_type, asd);
+	if (!list_empty(&notifier->asd_list)) {
+		/*
+		 * Caller must have either used v4l2_async_notifier_add_subdev
+		 * to add asd's to notifier->asd_list, or provided the
+		 * notifier->subdevs array, but not both.
+		 */
+		if (WARN_ON(notifier->subdevs)) {
 			ret = -EINVAL;
 			goto err_unlock;
 		}
-		list_add_tail(&asd->list, &notifier->waiting);
+
+		i = 0;
+		list_for_each_entry(asd, &notifier->asd_list, asd_list) {
+			ret = v4l2_async_notifier_asd_valid(notifier, asd, i++);
+			if (ret)
+				goto err_unlock;
+
+			list_add_tail(&asd->list, &notifier->waiting);
+		}
+	} else if (notifier->subdevs) {
+		for (i = 0; i < notifier->num_subdevs; i++) {
+			asd = notifier->subdevs[i];
+
+			ret = v4l2_async_notifier_asd_valid(notifier, asd, i);
+			if (ret)
+				goto err_unlock;
+
+			list_add_tail(&asd->list, &notifier->waiting);
+		}
 	}
 
 	ret = v4l2_async_notifier_try_all_subdevs(notifier);
@@ -511,36 +563,102 @@ void v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier)
 }
 EXPORT_SYMBOL(v4l2_async_notifier_unregister);
 
-void v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
+static void __v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
 {
+	struct v4l2_async_subdev *asd, *tmp;
 	unsigned int i;
 
-	if (!notifier || !notifier->max_subdevs)
+	if (!notifier)
 		return;
 
-	for (i = 0; i < notifier->num_subdevs; i++) {
-		struct v4l2_async_subdev *asd = notifier->subdevs[i];
+	if (notifier->subdevs) {
+		if (!notifier->max_subdevs)
+			return;
 
-		switch (asd->match_type) {
-		case V4L2_ASYNC_MATCH_FWNODE:
-			fwnode_handle_put(asd->match.fwnode);
-			break;
-		default:
-			WARN_ON_ONCE(true);
-			break;
+		for (i = 0; i < notifier->num_subdevs; i++) {
+			asd = notifier->subdevs[i];
+
+			switch (asd->match_type) {
+			case V4L2_ASYNC_MATCH_FWNODE:
+				fwnode_handle_put(asd->match.fwnode);
+				break;
+			default:
+				break;
+			}
+
+			kfree(asd);
 		}
 
-		kfree(asd);
+		notifier->max_subdevs = 0;
+		kvfree(notifier->subdevs);
+		notifier->subdevs = NULL;
+	} else if (notifier->lists_initialized) {
+		list_for_each_entry_safe(asd, tmp,
+					 &notifier->asd_list, asd_list) {
+			switch (asd->match_type) {
+			case V4L2_ASYNC_MATCH_FWNODE:
+				fwnode_handle_put(asd->match.fwnode);
+				break;
+			default:
+				break;
+			}
+
+			list_del(&asd->asd_list);
+			kfree(asd);
+		}
 	}
 
-	notifier->max_subdevs = 0;
 	notifier->num_subdevs = 0;
+}
+
+void v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
+{
+	mutex_lock(&list_lock);
 
-	kvfree(notifier->subdevs);
-	notifier->subdevs = NULL;
+	__v4l2_async_notifier_cleanup(notifier);
+
+	mutex_unlock(&list_lock);
 }
 EXPORT_SYMBOL_GPL(v4l2_async_notifier_cleanup);
 
+int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
+				   struct v4l2_async_subdev *asd)
+{
+	int ret;
+
+	mutex_lock(&list_lock);
+
+	if (notifier->num_subdevs >= V4L2_MAX_SUBDEVS) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	/*
+	 * If caller uses this function, it cannot also allocate and
+	 * place asd's in the notifier->subdevs array.
+	 */
+	if (WARN_ON(notifier->subdevs)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (!notifier->lists_initialized)
+		__v4l2_async_notifier_init(notifier);
+
+	ret = v4l2_async_notifier_asd_valid(notifier, asd,
+					    notifier->num_subdevs);
+	if (ret)
+		goto unlock;
+
+	list_add_tail(&asd->asd_list, &notifier->asd_list);
+	notifier->num_subdevs++;
+
+unlock:
+	mutex_unlock(&list_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_subdev);
+
 int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 {
 	struct v4l2_async_notifier *subdev_notifier;
@@ -614,7 +732,7 @@ void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
 	mutex_lock(&list_lock);
 
 	__v4l2_async_notifier_unregister(sd->subdev_notifier);
-	v4l2_async_notifier_cleanup(sd->subdev_notifier);
+	__v4l2_async_notifier_cleanup(sd->subdev_notifier);
 	kfree(sd->subdev_notifier);
 	sd->subdev_notifier = NULL;
 
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 1592d32..6e752ef 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -73,6 +73,8 @@ enum v4l2_async_match_type {
  * @match.custom.priv:
  *		Driver-specific private struct with match parameters
  *		to be used if %V4L2_ASYNC_MATCH_CUSTOM.
+ * @asd_list:	used to add struct v4l2_async_subdev objects to the
+ *		master notifier->asd_list
  * @list:	used to link struct v4l2_async_subdev objects, waiting to be
  *		probed, to a notifier->waiting list
  *
@@ -98,6 +100,7 @@ struct v4l2_async_subdev {
 
 	/* v4l2-async core private: not to be used by drivers */
 	struct list_head list;
+	struct list_head asd_list;
 };
 
 /**
@@ -127,9 +130,11 @@ struct v4l2_async_notifier_operations {
  * @v4l2_dev:	v4l2_device of the root notifier, NULL otherwise
  * @sd:		sub-device that registered the notifier, NULL otherwise
  * @parent:	parent notifier
+ * @asd_list:	master list of struct v4l2_async_subdev, replaces @subdevs
  * @waiting:	list of struct v4l2_async_subdev, waiting for their drivers
  * @done:	list of struct v4l2_subdev, already probed
  * @list:	member in a global list of notifiers
+ * @lists_initialized: list_head's have been initialized
  */
 struct v4l2_async_notifier {
 	const struct v4l2_async_notifier_operations *ops;
@@ -139,12 +144,29 @@ struct v4l2_async_notifier {
 	struct v4l2_device *v4l2_dev;
 	struct v4l2_subdev *sd;
 	struct v4l2_async_notifier *parent;
+	struct list_head asd_list;
 	struct list_head waiting;
 	struct list_head done;
 	struct list_head list;
+	bool lists_initialized;
 };
 
 /**
+ * v4l2_async_notifier_add_subdev - Add an async subdev to the
+ *				notifier's master asd_list.
+ *
+ * @notifier: pointer to &struct v4l2_async_notifier
+ * @asd: pointer to &struct v4l2_async_subdev
+ *
+ * This can be used before registering a notifier to add an
+ * asd to the notifiers master asd_list. If the caller uses
+ * this method to compose an asd list, it must never allocate
+ * or place asd's in the @subdevs array.
+ */
+int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
+				   struct v4l2_async_subdev *asd);
+
+/**
  * v4l2_async_notifier_register - registers a subdevice asynchronous notifier
  *
  * @v4l2_dev: pointer to &struct v4l2_device
@@ -177,7 +199,9 @@ void v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier);
  * Release memory resources related to a notifier, including the async
  * sub-devices allocated for the purposes of the notifier but not the notifier
  * itself. The user is responsible for calling this function to clean up the
- * notifier after calling @v4l2_async_notifier_parse_fwnode_endpoints or
+ * notifier after calling
+ * @v4l2_async_notifier_add_subdev,
+ * @v4l2_async_notifier_parse_fwnode_endpoints or
  * @v4l2_fwnode_reference_parse_sensor_common.
  *
  * There is no harm from calling v4l2_async_notifier_cleanup in other
-- 
2.7.4

