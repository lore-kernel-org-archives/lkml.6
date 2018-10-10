Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D97BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7BB2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7BB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeJJVby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:31:54 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:49403 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726896AbeJJVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:31:53 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 Oct 2018 15:14:43 +0200
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w9AD9rvq003286;
        Wed, 10 Oct 2018 16:09:53 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w9AD9q1n022235;
        Wed, 10 Oct 2018 16:09:52 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w9AD9qot022234;
        Wed, 10 Oct 2018 16:09:52 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net 1/3] devlink: Fix param set handling for string type
Date:   Wed, 10 Oct 2018 16:09:25 +0300
Message-Id: <1539176967-22172-2-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1539176967-22172-1-git-send-email-moshe@mellanox.com>
References: <1539176967-22172-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case devlink param type is string, it needs to copy the string value
it got from the input to devlink_param_value.

Fixes: e3b7ca18ad7b ("devlink: Add param set command")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
---
 include/net/devlink.h |  2 +-
 net/core/devlink.c    | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index b9b89d6..b0e17c0 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -311,7 +311,7 @@ enum devlink_param_type {
 	u8 vu8;
 	u16 vu16;
 	u32 vu32;
-	const char *vstr;
+	char vstr[DEVLINK_PARAM_MAX_STRING_VALUE];
 	bool vbool;
 };
 
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 8c0ed22..d808af7 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -2995,6 +2995,8 @@ static int devlink_nl_cmd_param_get_dumpit(struct sk_buff *msg,
 				  struct genl_info *info,
 				  union devlink_param_value *value)
 {
+	int len;
+
 	if (param->type != DEVLINK_PARAM_TYPE_BOOL &&
 	    !info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA])
 		return -EINVAL;
@@ -3010,10 +3012,13 @@ static int devlink_nl_cmd_param_get_dumpit(struct sk_buff *msg,
 		value->vu32 = nla_get_u32(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]);
 		break;
 	case DEVLINK_PARAM_TYPE_STRING:
-		if (nla_len(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]) >
-		    DEVLINK_PARAM_MAX_STRING_VALUE)
+		len = strnlen(nla_data(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]),
+			      nla_len(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]));
+		if (len == nla_len(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]) ||
+		    len >= DEVLINK_PARAM_MAX_STRING_VALUE)
 			return -EINVAL;
-		value->vstr = nla_data(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]);
+		strcpy(value->vstr,
+		       nla_data(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]));
 		break;
 	case DEVLINK_PARAM_TYPE_BOOL:
 		value->vbool = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA] ?
-- 
1.8.3.1

