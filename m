Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB669C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0EF208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0EF208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934265AbeGDLb0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:31:26 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46016 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933596AbeGDLbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:31:23 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jul 2018 14:34:06 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w64BVHsb031345;
        Wed, 4 Jul 2018 14:31:17 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w64BVH3m024642;
        Wed, 4 Jul 2018 14:31:17 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w64BVG9S024641;
        Wed, 4 Jul 2018 14:31:16 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next 04/10] devlink: Add support for get/set driverinit value
Date:   Wed,  4 Jul 2018 14:30:31 +0300
Message-Id: <1530703837-24563-5-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
References: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"driverinit" configuration mode value is held by devlink to enable
the driver query the value after reload. Two additional functions
added to help the driver get/set the value from/to devlink:
devlink_param_driverinit_value_set() and
devlink_param_driverinit_value_get().

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 include/net/devlink.h | 18 ++++++++++++
 net/core/devlink.c    | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 8806275..3302e43 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -503,6 +503,10 @@ int devlink_params_register(struct devlink *devlink,
 void devlink_params_unregister(struct devlink *devlink,
 			       const struct devlink_param *params,
 			       size_t params_count);
+int devlink_param_driverinit_value_get(struct devlink *devlink, u32 param_id,
+				       union devlink_param_value *init_val);
+int devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
+				       union devlink_param_value init_val);
 
 #else
 
@@ -711,6 +715,20 @@ static inline bool devlink_dpipe_table_counter_enabled(struct devlink *devlink,
 
 }
 
+static inline int
+devlink_param_driverinit_value_get(struct devlink *devlink, u32 param_id,
+				   union devlink_param_value *init_val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int
+devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
+				   union devlink_param_value init_val)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 #endif /* _NET_DEVLINK_H_ */
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 0cd7a42..3af08f4 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -2645,6 +2645,17 @@ static int devlink_param_driver_verify(const struct devlink_param *param)
 	return NULL;
 }
 
+static struct devlink_param_item *
+devlink_param_find_by_id(struct list_head *param_list, u32 param_id)
+{
+	struct devlink_param_item *param_item;
+
+	list_for_each_entry(param_item, param_list, list)
+		if (param_item->param->id == param_id)
+			return param_item;
+	return NULL;
+}
+
 static bool
 devlink_param_cmode_is_supported(const struct devlink_param *param,
 				 enum devlink_param_cmode cmode)
@@ -3966,6 +3977,72 @@ void devlink_params_unregister(struct devlink *devlink,
 }
 EXPORT_SYMBOL_GPL(devlink_params_unregister);
 
+/**
+ *	devlink_param_driverinit_value_get - get configuration parameter
+ *					     value for driver initializing
+ *
+ *	@devlink: devlink
+ *	@param_id: parameter ID
+ *	@init_val: value of parameter in driverinit configuration mode
+ *
+ *	This function should be used by the driver to get driverinit
+ *	configuration for initialization after reload command.
+ */
+int devlink_param_driverinit_value_get(struct devlink *devlink, u32 param_id,
+				       union devlink_param_value *init_val)
+{
+	struct devlink_param_item *param_item;
+
+	if (!devlink->ops || !devlink->ops->reload)
+		return -EOPNOTSUPP;
+
+	param_item = devlink_param_find_by_id(&devlink->param_list, param_id);
+	if (!param_item)
+		return -EINVAL;
+
+	if (!param_item->driverinit_value_valid ||
+	    !devlink_param_cmode_is_supported(param_item->param,
+					      DEVLINK_PARAM_CMODE_DRIVERINIT))
+		return -EOPNOTSUPP;
+
+	*init_val = param_item->driverinit_value;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devlink_param_driverinit_value_get);
+
+/**
+ *	devlink_param_driverinit_value_set - set value of configuration
+ *					     parameter for driverinit
+ *					     configuration mode
+ *
+ *	@devlink: devlink
+ *	@param_id: parameter ID
+ *	@init_val: value of parameter to set for driverinit configuration mode
+ *
+ *	This function should be used by the driver to set driverinit
+ *	configuration mode default value.
+ */
+int devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
+				       union devlink_param_value init_val)
+{
+	struct devlink_param_item *param_item;
+
+	param_item = devlink_param_find_by_id(&devlink->param_list, param_id);
+	if (!param_item)
+		return -EINVAL;
+
+	if (!devlink_param_cmode_is_supported(param_item->param,
+					      DEVLINK_PARAM_CMODE_DRIVERINIT))
+		return -EOPNOTSUPP;
+
+	param_item->driverinit_value = init_val;
+	param_item->driverinit_value_valid = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devlink_param_driverinit_value_set);
+
 static int __init devlink_module_init(void)
 {
 	return genl_register_family(&devlink_nl_family);
-- 
1.8.3.1

