Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E466C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EE220879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EE220879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeI3BKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 21:10:51 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:40874 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeI3BKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 21:10:50 -0400
Received: from svr-orw-mbx-02.mgc.mentorg.com ([147.34.90.202])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g6KB2-0000Pq-Iu from Steve_Longerbeam@mentor.com ; Sat, 29 Sep 2018 11:41:16 -0700
Received: from mappy.world.mentorg.com (147.34.91.1) by
 svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Sat, 29 Sep 2018 11:41:13 -0700
From:   Steve Longerbeam <steve_longerbeam@mentor.com>
To:     <linux-media@vger.kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 02/17] media: v4l2: async: Allow searching for asd of any type
Date:   Sat, 29 Sep 2018 11:40:37 -0700
Message-ID: <20180929184052.19479-3-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929184052.19479-1-steve_longerbeam@mentor.com>
References: <20180929184052.19479-1-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generalize v4l2_async_notifier_fwnode_has_async_subdev() to allow
searching for any type of async subdev, not just fwnodes. Rename to
v4l2_async_notifier_has_async_subdev() and pass it an asd pointer.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
Changes since v6:
- elaborate on comment for asd_equal(), suggested by Mauro Chehab.
- whitespace checkpatch fixes, suggested by Mauro.
- made an error message more clear in __v4l2_async_notifier_register(),
  suggested by Mauro.
Changes since v5:
- none
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
 drivers/media/v4l2-core/v4l2-async.c | 77 +++++++++++++++++-----------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 2b08d03b251d..f09d354b96a0 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -124,6 +124,31 @@ static struct v4l2_async_subdev *v4l2_async_find_match(
 	return NULL;
 }
 
+/* Compare two async sub-device descriptors for equivalence */
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
@@ -308,29 +333,23 @@ static void v4l2_async_notifier_unbind_all_subdevs(
 	notifier->parent = NULL;
 }
 
-/* See if an fwnode can be found in a notifier's lists. */
-static bool __v4l2_async_notifier_fwnode_has_async_subdev(
-	struct v4l2_async_notifier *notifier, struct fwnode_handle *fwnode)
+/* See if an async sub-device can be found in a notifier's lists. */
+static bool
+__v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
+				       struct v4l2_async_subdev *asd)
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
 
@@ -338,32 +357,29 @@ static bool __v4l2_async_notifier_fwnode_has_async_subdev(
 }
 
 /*
- * Find out whether an async sub-device was set up for an fwnode already or
+ * Find out whether an async sub-device was set up already or
  * whether it exists in a given notifier before @this_index.
  */
-static bool v4l2_async_notifier_fwnode_has_async_subdev(
-	struct v4l2_async_notifier *notifier, struct fwnode_handle *fwnode,
-	unsigned int this_index)
+static bool
+v4l2_async_notifier_has_async_subdev(struct v4l2_async_notifier *notifier,
+				     struct v4l2_async_subdev *asd,
+				     unsigned int this_index)
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
@@ -392,12 +408,11 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
 		case V4L2_ASYNC_MATCH_CUSTOM:
 		case V4L2_ASYNC_MATCH_DEVNAME:
 		case V4L2_ASYNC_MATCH_I2C:
-			break;
 		case V4L2_ASYNC_MATCH_FWNODE:
-			if (v4l2_async_notifier_fwnode_has_async_subdev(
-				    notifier, asd->match.fwnode, i)) {
+			if (v4l2_async_notifier_has_async_subdev(notifier,
+								 asd, i)) {
 				dev_err(dev,
-					"fwnode has already been registered or in notifier's subdev list\n");
+					"subdev descriptor already listed in this or other notifiers\n");
 				ret = -EEXIST;
 				goto err_unlock;
 			}
-- 
2.17.1

