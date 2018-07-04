Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF310C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E20B208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E20B208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934500AbeGDLcP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:32:15 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46028 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934121AbeGDLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:31:24 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jul 2018 14:34:07 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w64BVIUc031349;
        Wed, 4 Jul 2018 14:31:18 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w64BVI9n024644;
        Wed, 4 Jul 2018 14:31:18 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w64BVHa5024643;
        Wed, 4 Jul 2018 14:31:17 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next 05/10] devlink: Add devlink notifications support for params
Date:   Wed,  4 Jul 2018 14:30:32 +0300
Message-Id: <1530703837-24563-6-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
References: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devlink_param_notify() function to support devlink param notifications.
Add notification call to devlink param set, register and unregister
functions.
Add devlink_param_value_changed() function to enable the driver notify
devlink on value change. Driver should use this function after value was
changed on any configuration mode part to driverinit.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 include/net/devlink.h        |  7 +++++++
 include/uapi/linux/devlink.h |  2 ++
 net/core/devlink.c           | 50 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 3302e43..792edaa 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -507,6 +507,7 @@ int devlink_param_driverinit_value_get(struct devlink *devlink, u32 param_id,
 				       union devlink_param_value *init_val);
 int devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
 				       union devlink_param_value init_val);
+void devlink_param_value_changed(struct devlink *devlink, u32 param_id);
 
 #else
 
@@ -729,6 +730,12 @@ static inline bool devlink_dpipe_table_counter_enabled(struct devlink *devlink,
 	return -EOPNOTSUPP;
 }
 
+static inline void
+devlink_param_value_changed(struct devlink *devlink, u32 param_id)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 #endif /* _NET_DEVLINK_H_ */
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index ea0623e..68641fb 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -80,6 +80,8 @@ enum devlink_command {
 
 	DEVLINK_CMD_PARAM_GET,		/* can dump */
 	DEVLINK_CMD_PARAM_SET,
+	DEVLINK_CMD_PARAM_NEW,
+	DEVLINK_CMD_PARAM_DEL,
 
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 3af08f4..89d948f 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -2828,6 +2828,28 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 	return -EMSGSIZE;
 }
 
+static void devlink_param_notify(struct devlink *devlink,
+				 struct devlink_param_item *param_item,
+				 enum devlink_command cmd)
+{
+	struct sk_buff *msg;
+	int err;
+
+	WARN_ON(cmd != DEVLINK_CMD_PARAM_NEW && cmd != DEVLINK_CMD_PARAM_DEL);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+	err = devlink_nl_param_fill(msg, devlink, param_item, cmd, 0, 0, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
+				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+}
+
 static int devlink_nl_cmd_param_get_dumpit(struct sk_buff *msg,
 					   struct netlink_callback *cb)
 {
@@ -3019,6 +3041,7 @@ static int devlink_nl_cmd_param_set_doit(struct sk_buff *skb,
 			return err;
 	}
 
+	devlink_param_notify(devlink, param_item, DEVLINK_CMD_PARAM_NEW);
 	return 0;
 }
 
@@ -3042,6 +3065,7 @@ static int devlink_param_register_one(struct devlink *devlink,
 	param_item->param = param;
 
 	list_add_tail(&param_item->list, &devlink->param_list);
+	devlink_param_notify(devlink, param_item, DEVLINK_CMD_PARAM_NEW);
 	return 0;
 }
 
@@ -3053,6 +3077,7 @@ static void devlink_param_unregister_one(struct devlink *devlink,
 	param_item = devlink_param_find_by_name(&devlink->param_list,
 						param->name);
 	WARN_ON(!param_item);
+	devlink_param_notify(devlink, param_item, DEVLINK_CMD_PARAM_DEL);
 	list_del(&param_item->list);
 	kfree(param_item);
 }
@@ -4039,10 +4064,35 @@ int devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
 	param_item->driverinit_value = init_val;
 	param_item->driverinit_value_valid = true;
 
+	devlink_param_notify(devlink, param_item, DEVLINK_CMD_PARAM_NEW);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(devlink_param_driverinit_value_set);
 
+/**
+ *	devlink_param_value_changed - notify devlink on a parameter's value
+ *				      change. Should be called by the driver
+ *				      right after the change.
+ *
+ *	@devlink: devlink
+ *	@param_id: parameter ID
+ *
+ *	This function should be used by the driver to notify devlink on value
+ *	change, excluding driverinit configuration mode.
+ *	For driverinit configuration mode driver should use the function
+ *	devlink_param_driverinit_value_set() instead.
+ */
+void devlink_param_value_changed(struct devlink *devlink, u32 param_id)
+{
+	struct devlink_param_item *param_item;
+
+	param_item = devlink_param_find_by_id(&devlink->param_list, param_id);
+	WARN_ON(!param_item);
+
+	devlink_param_notify(devlink, param_item, DEVLINK_CMD_PARAM_NEW);
+}
+EXPORT_SYMBOL_GPL(devlink_param_value_changed);
+
 static int __init devlink_module_init(void)
 {
 	return genl_register_family(&devlink_nl_family);
-- 
1.8.3.1

