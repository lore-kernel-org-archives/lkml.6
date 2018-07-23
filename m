Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321E5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FE820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FE820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbeGWMEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:04:49 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:39958 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388179AbeGWMEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:04:48 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 42979CD71;
        Mon, 23 Jul 2018 14:04:03 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v3 34/35] media: camss: csid: Add support for events triggered by user controls
Date:   Mon, 23 Jul 2018 14:02:51 +0300
Message-Id: <1532343772-27382-35-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
References: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing a user control value can trigger an event to other
users. Add support for that.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csid.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index a581377..b50eb96 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <media/media-entity.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
 #include <media/v4l2-subdev.h>
 
 #include "camss-csid.h"
@@ -1266,6 +1267,8 @@ static int csid_link_setup(struct media_entity *entity,
 
 static const struct v4l2_subdev_core_ops csid_core_ops = {
 	.s_power = csid_set_power,
+	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
 };
 
 static const struct v4l2_subdev_video_ops csid_video_ops = {
@@ -1311,7 +1314,8 @@ int msm_csid_register_entity(struct csid_device *csid,
 
 	v4l2_subdev_init(sd, &csid_v4l2_ops);
 	sd->internal_ops = &csid_v4l2_internal_ops;
-	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
+		     V4L2_SUBDEV_FL_HAS_EVENTS;
 	snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d",
 		 MSM_CSID_NAME, csid->id);
 	v4l2_set_subdevdata(sd, csid);
-- 
2.7.4

