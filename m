Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F41214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F41214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJJVby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:31:54 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:49411 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726920AbeJJVby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:31:54 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 Oct 2018 15:14:44 +0200
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w9AD9scw003289;
        Wed, 10 Oct 2018 16:09:54 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w9AD9rtK022237;
        Wed, 10 Oct 2018 16:09:53 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w9AD9rSn022236;
        Wed, 10 Oct 2018 16:09:53 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net 2/3] devlink: Fix param cmode driverinit for string type
Date:   Wed, 10 Oct 2018 16:09:26 +0300
Message-Id: <1539176967-22172-3-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1539176967-22172-1-git-send-email-moshe@mellanox.com>
References: <1539176967-22172-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driverinit configuration mode value is held by devlink to enable the
driver fetch the value after reload command. In case the param type is
string devlink should copy the value from driver string buffer to
devlink string buffer on devlink_param_driverinit_value_set() and
vice-versa on devlink_param_driverinit_value_get().

Fixes: ec01aeb1803e ("devlink: Add support for get/set driverinit value")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
---
 net/core/devlink.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index d808af7..1a0de16 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -3105,7 +3105,10 @@ static int devlink_nl_cmd_param_set_doit(struct sk_buff *skb,
 		return -EOPNOTSUPP;
 
 	if (cmode == DEVLINK_PARAM_CMODE_DRIVERINIT) {
-		param_item->driverinit_value = value;
+		if (param->type == DEVLINK_PARAM_TYPE_STRING)
+			strcpy(param_item->driverinit_value.vstr, value.vstr);
+		else
+			param_item->driverinit_value = value;
 		param_item->driverinit_value_valid = true;
 	} else {
 		if (!param->set)
@@ -4545,7 +4548,10 @@ int devlink_param_driverinit_value_get(struct devlink *devlink, u32 param_id,
 					      DEVLINK_PARAM_CMODE_DRIVERINIT))
 		return -EOPNOTSUPP;
 
-	*init_val = param_item->driverinit_value;
+	if (param_item->param->type == DEVLINK_PARAM_TYPE_STRING)
+		strcpy(init_val->vstr, param_item->driverinit_value.vstr);
+	else
+		*init_val = param_item->driverinit_value;
 
 	return 0;
 }
@@ -4576,7 +4582,10 @@ int devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
 					      DEVLINK_PARAM_CMODE_DRIVERINIT))
 		return -EOPNOTSUPP;
 
-	param_item->driverinit_value = init_val;
+	if (param_item->param->type == DEVLINK_PARAM_TYPE_STRING)
+		strcpy(param_item->driverinit_value.vstr, init_val.vstr);
+	else
+		param_item->driverinit_value = init_val;
 	param_item->driverinit_value_valid = true;
 
 	devlink_param_notify(devlink, param_item, DEVLINK_CMD_PARAM_NEW);
-- 
1.8.3.1

