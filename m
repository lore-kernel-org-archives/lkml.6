Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52467C4161B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A972087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A972087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJJVbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:31:55 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:49424 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726902AbeJJVby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:31:54 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 Oct 2018 15:14:45 +0200
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w9AD9sJG003298;
        Wed, 10 Oct 2018 16:09:54 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w9AD9sEk022240;
        Wed, 10 Oct 2018 16:09:54 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w9AD9sgu022239;
        Wed, 10 Oct 2018 16:09:54 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net 3/3] devlink: Add helper function for safely copy string param
Date:   Wed, 10 Oct 2018 16:09:27 +0300
Message-Id: <1539176967-22172-4-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1539176967-22172-1-git-send-email-moshe@mellanox.com>
References: <1539176967-22172-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devlink string param buffer is allocated at the size of
DEVLINK_PARAM_MAX_STRING_VALUE. Add helper function which makes sure
this size is not exceeded.
Renamed DEVLINK_PARAM_MAX_STRING_VALUE to
__DEVLINK_PARAM_MAX_STRING_VALUE to emphasize that it should be used by
devlink only. The driver should use the helper function instead to
verify it doesn't exceed the allowed length.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
---
 include/net/devlink.h | 12 ++++++++++--
 net/core/devlink.c    | 19 ++++++++++++++++++-
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index b0e17c0..99efc15 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -298,7 +298,7 @@ struct devlink_resource {
 
 #define DEVLINK_RESOURCE_ID_PARENT_TOP 0
 
-#define DEVLINK_PARAM_MAX_STRING_VALUE 32
+#define __DEVLINK_PARAM_MAX_STRING_VALUE 32
 enum devlink_param_type {
 	DEVLINK_PARAM_TYPE_U8,
 	DEVLINK_PARAM_TYPE_U16,
@@ -311,7 +311,7 @@ enum devlink_param_type {
 	u8 vu8;
 	u16 vu16;
 	u32 vu32;
-	char vstr[DEVLINK_PARAM_MAX_STRING_VALUE];
+	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
 	bool vbool;
 };
 
@@ -553,6 +553,8 @@ int devlink_param_driverinit_value_get(struct devlink *devlink, u32 param_id,
 int devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
 				       union devlink_param_value init_val);
 void devlink_param_value_changed(struct devlink *devlink, u32 param_id);
+void devlink_param_value_str_fill(union devlink_param_value *dst_val,
+				  const char *src);
 struct devlink_region *devlink_region_create(struct devlink *devlink,
 					     const char *region_name,
 					     u32 region_max_snapshots,
@@ -789,6 +791,12 @@ static inline bool devlink_dpipe_table_counter_enabled(struct devlink *devlink,
 {
 }
 
+static inline void
+devlink_param_value_str_fill(union devlink_param_value *dst_val,
+			     const char *src)
+{
+}
+
 static inline struct devlink_region *
 devlink_region_create(struct devlink *devlink,
 		      const char *region_name,
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 1a0de16..6bc4293 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -3015,7 +3015,7 @@ static int devlink_nl_cmd_param_get_dumpit(struct sk_buff *msg,
 		len = strnlen(nla_data(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]),
 			      nla_len(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]));
 		if (len == nla_len(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]) ||
-		    len >= DEVLINK_PARAM_MAX_STRING_VALUE)
+		    len >= __DEVLINK_PARAM_MAX_STRING_VALUE)
 			return -EINVAL;
 		strcpy(value->vstr,
 		       nla_data(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]));
@@ -4618,6 +4618,23 @@ void devlink_param_value_changed(struct devlink *devlink, u32 param_id)
 EXPORT_SYMBOL_GPL(devlink_param_value_changed);
 
 /**
+ *	devlink_param_value_str_fill - Safely fill-up the string preventing
+ *				       from overflow of the preallocated buffer
+ *
+ *	@dst_val: destination devlink_param_value
+ *	@src: source buffer
+ */
+void devlink_param_value_str_fill(union devlink_param_value *dst_val,
+				  const char *src)
+{
+	size_t len;
+
+	len = strlcpy(dst_val->vstr, src, __DEVLINK_PARAM_MAX_STRING_VALUE);
+	WARN_ON(len >= __DEVLINK_PARAM_MAX_STRING_VALUE);
+}
+EXPORT_SYMBOL_GPL(devlink_param_value_str_fill);
+
+/**
  *	devlink_region_create - create a new address region
  *
  *	@devlink: devlink
-- 
1.8.3.1

