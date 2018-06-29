Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2316C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B18278BB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyD2OGT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B18278BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936654AbeF2Suz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:50:55 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37338 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933582AbeF2Suu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:50:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so4869843plc.4;
        Fri, 29 Jun 2018 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lE+v0pt0qUxtsD563AOlvgJb3eTiEqGz7kyGQ3Z0e4Q=;
        b=CyD2OGT2V5aS/+v5rI8ZWM7tvQdVA1mmj729OfHFdeBGJOXZm7RZ5UFGrLVuELKCBR
         OS3NDct07rKjvSuscNo7exFKc0gB2+2RZPHwL1wVzQhqUllhgskzx0o0fXJ5EVPnvZnR
         tKIOrK9D4HugMm40FTB9a/YhXvWjlwsKllU9LjOrAd6jHHU7apnxuQlNIlRFfroWXUHM
         4cW5gg6iuDPBCPuNRFK8mKWG8TNJ+4Miic3qz4RRSPs0oCtIH4HnSnktkFQPKAlfj7m0
         NXUPxnpxkAINxA+D/NosBP81AkF3iZWEyyG+HXxG0Yq5hfzPidsm7yrTdmQpGMXDbRAF
         OYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lE+v0pt0qUxtsD563AOlvgJb3eTiEqGz7kyGQ3Z0e4Q=;
        b=HnSMqt9+Nd3iy0xB/4ZuuiN5SUsJHVdO8A29pYM1IA4WexvIVaimTRipytC9Mtgbf1
         i8rNesScZqmBzQUENoeiZGsD9h7dkNtlpu23bl7AmJ9ml7uDtmd5csoFNNZF0lzJpNWt
         jtl5UKksWUKK8iedE4VpXK89iE4SlbTpxx5XlEvu8wv/GJzoqv4Nx9OUwNlK0Q8rHEXo
         rQKP3fBAY1N9OUs0R1+XlX9DQYXhD3PzBEiV9IDesTmLCA4sjbJDO+lxJs89AO5f1eIJ
         jviDMHT0BkS1dbvKu5/8B4d28KZ2vylUcqOljnvKLtVvottEtrLcEfcxcCdKDG/qZ9B7
         JgFw==
X-Gm-Message-State: APt69E0TlmHMPq4yQW2pFY6Ra2OGMKkEsGwmXA7bdkyfPTZoSBz9lgcZ
        845e0+guZjs4KA2gek7uvavreg==
X-Google-Smtp-Source: ADUXVKLrK7hOW+trFJowLll4oqU7P1X5U0IOlUqrgGebFouZct1hAejnp1XF7eIhkLPXIam7Q+cw5A==
X-Received: by 2002:a17:902:ba8a:: with SMTP id k10-v6mr16081744pls.338.1530298249351;
        Fri, 29 Jun 2018 11:50:49 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:50:48 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/17] media: v4l2: async: Allow searching for asd of any type
Date:   Fri, 29 Jun 2018 11:49:46 -0700
Message-Id: <1530298220-5097-3-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generalize v4l2_async_notifier_fwnode_has_async_subdev() to allow
searching for any type of async subdev, not just fwnodes. Rename to
v4l2_async_notifier_has_async_subdev() and pass it an asd pointer.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
Changes since v4:
- none
Changes since v3:
- removed TODO to support asd compare with CUSTOM match type in
  asd_equal().
Changes since v2:
- code optimization in asd_equal(), and remove unneeded braces,
  suggested by Sakari Ailus.
Changes since v1:
- none
---
 drivers/media/v4l2-core/v4l2-async.c | 73 +++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 2b08d03..0e7e529 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -124,6 +124,31 @@ static struct v4l2_async_subdev *v4l2_async_find_match(
 	return NULL;
 }
 
+/* Compare two asd's for equivalence */
+static bool asd_equal(struct v4l2_async_subdev *asd_x,
+		      struct v4l2_async_subdev *asd_y)
+{
+	if (asd_x->match_type != asd_y->match_type)
+		return false;
+
+	switch (asd_x->match_type) {
+	case V4L2_ASYNC_MATCH_DEVNAME:
+		return strcmp(asd_x->match.device_name,
+			      asd_y->match.device_name) == 0;
+	case V4L2_ASYNC_MATCH_I2C:
+		return asd_x->match.i2c.adapter_id ==
+			asd_y->match.i2c.adapter_id &&
+			asd_x->match.i2c.address ==
+			asd_y->match.i2c.address;
+	case V4L2_ASYNC_MATCH_FWNODE:
+		return asd_x->match.fwnode == asd_y->match.fwnode;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 /* Find the sub-device notifier registered by a sub-device driver. */
 static struct v4l2_async_notifier *v4l2_async_find_subdev_notifier(
 	struct v4l2_subdev *sd)
@@ -308,29 +333,22 @@ static void v4l2_async_notifier_unbind_all_subdevs(
 	notifier->parent = NULL;
 }
 
-/* See if an fwnode can be found in a notifier's lists. */
-static bool __v4l2_async_notifier_fwnode_has_async_subdev(
-	struct v4l2_async_notifier *notifier, struct fwnode_handle *fwnode)
+/* See if an async sub-device can be found in a notifier's lists. */
+static bool __v4l2_async_notifier_has_async_subdev(
+	struct v4l2_async_notifier *notifier, struct v4l2_async_subdev *asd)
 {
-	struct v4l2_async_subdev *asd;
+	struct v4l2_async_subdev *asd_y;
 	struct v4l2_subdev *sd;
 
-	list_for_each_entry(asd, &notifier->waiting, list) {
-		if (asd->match_type != V4L2_ASYNC_MATCH_FWNODE)
-			continue;
-
-		if (asd->match.fwnode == fwnode)
+	list_for_each_entry(asd_y, &notifier->waiting, list)
+		if (asd_equal(asd, asd_y))
 			return true;
-	}
 
 	list_for_each_entry(sd, &notifier->done, async_list) {
 		if (WARN_ON(!sd->asd))
 			continue;
 
-		if (sd->asd->match_type != V4L2_ASYNC_MATCH_FWNODE)
-			continue;
-
-		if (sd->asd->match.fwnode == fwnode)
+		if (asd_equal(asd, sd->asd))
 			return true;
 	}
 
@@ -338,32 +356,28 @@ static bool __v4l2_async_notifier_fwnode_has_async_subdev(
 }
 
 /*
- * Find out whether an async sub-device was set up for an fwnode already or
+ * Find out whether an async sub-device was set up already or
  * whether it exists in a given notifier before @this_index.
  */
-static bool v4l2_async_notifier_fwnode_has_async_subdev(
-	struct v4l2_async_notifier *notifier, struct fwnode_handle *fwnode,
+static bool v4l2_async_notifier_has_async_subdev(
+	struct v4l2_async_notifier *notifier, struct v4l2_async_subdev *asd,
 	unsigned int this_index)
 {
 	unsigned int j;
 
 	lockdep_assert_held(&list_lock);
 
-	/* Check that an fwnode is not being added more than once. */
+	/* Check that an asd is not being added more than once. */
 	for (j = 0; j < this_index; j++) {
-		struct v4l2_async_subdev *asd = notifier->subdevs[this_index];
-		struct v4l2_async_subdev *other_asd = notifier->subdevs[j];
+		struct v4l2_async_subdev *asd_y = notifier->subdevs[j];
 
-		if (other_asd->match_type == V4L2_ASYNC_MATCH_FWNODE &&
-		    asd->match.fwnode ==
-		    other_asd->match.fwnode)
+		if (asd_equal(asd, asd_y))
 			return true;
 	}
 
-	/* Check than an fwnode did not exist in other notifiers. */
+	/* Check that an asd does not exist in other notifiers. */
 	list_for_each_entry(notifier, &notifier_list, list)
-		if (__v4l2_async_notifier_fwnode_has_async_subdev(
-			    notifier, fwnode))
+		if (__v4l2_async_notifier_has_async_subdev(notifier, asd))
 			return true;
 
 	return false;
@@ -392,12 +406,11 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
 		case V4L2_ASYNC_MATCH_CUSTOM:
 		case V4L2_ASYNC_MATCH_DEVNAME:
 		case V4L2_ASYNC_MATCH_I2C:
-			break;
 		case V4L2_ASYNC_MATCH_FWNODE:
-			if (v4l2_async_notifier_fwnode_has_async_subdev(
-				    notifier, asd->match.fwnode, i)) {
+			if (v4l2_async_notifier_has_async_subdev(
+				    notifier, asd, i)) {
 				dev_err(dev,
-					"fwnode has already been registered or in notifier's subdev list\n");
+					"asd has already been registered or in notifier's subdev list\n");
 				ret = -EEXIST;
 				goto err_unlock;
 			}
-- 
2.7.4

