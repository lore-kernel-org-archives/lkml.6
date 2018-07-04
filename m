Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF25EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CD821532
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CD821532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934052AbeGDLbU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:31:20 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45938 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932594AbeGDLbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:31:18 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jul 2018 14:34:03 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w64BVDf7031262;
        Wed, 4 Jul 2018 14:31:13 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w64BVDva024635;
        Wed, 4 Jul 2018 14:31:13 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w64BVDUv024634;
        Wed, 4 Jul 2018 14:31:13 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next 01/10] devlink: Add devlink_param register and unregister
Date:   Wed,  4 Jul 2018 14:30:28 +0300
Message-Id: <1530703837-24563-2-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
References: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define configuration parameters data structure.
Add functions to register and unregister the driver supported
configuration parameters table.
For each parameter registered, the driver should fill all the parameter's
fields. In case the only supported configuration mode is "driverinit"
the parameter's get()/set() functions are not required and should be set
to NULL, for any other configuration mode, these functions are required
and should be set by the driver.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 include/net/devlink.h        |  85 +++++++++++++++++++++++++
 include/uapi/linux/devlink.h |  10 +++
 net/core/devlink.c           | 148 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index e336ea9..4a0687a 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -27,6 +27,7 @@ struct devlink {
 	struct list_head sb_list;
 	struct list_head dpipe_table_list;
 	struct list_head resource_list;
+	struct list_head param_list;
 	struct devlink_dpipe_headers *dpipe_headers;
 	const struct devlink_ops *ops;
 	struct device *dev;
@@ -295,6 +296,68 @@ struct devlink_resource {
 
 #define DEVLINK_RESOURCE_ID_PARENT_TOP 0
 
+#define DEVLINK_PARAM_MAX_STRING_VALUE 32
+enum devlink_param_type {
+	DEVLINK_PARAM_TYPE_U8,
+	DEVLINK_PARAM_TYPE_U16,
+	DEVLINK_PARAM_TYPE_U32,
+	DEVLINK_PARAM_TYPE_STRING,
+	DEVLINK_PARAM_TYPE_BOOL,
+};
+
+union devlink_param_value {
+	u8 vu8;
+	u16 vu16;
+	u32 vu32;
+	const char *vstr;
+	bool vbool;
+};
+
+struct devlink_param_gset_ctx {
+	union devlink_param_value val;
+	enum devlink_param_cmode cmode;
+};
+
+/**
+ * struct devlink_param - devlink configuration parameter data
+ * @name: name of the parameter
+ * @generic: indicates if the parameter is generic or driver specific
+ * @type: parameter type
+ * @supported_cmodes: bitmap of supported configuration modes
+ * @get: get parameter value, used for runtime and permanent
+ *       configuration modes
+ * @set: set parameter value, used for runtime and permanent
+ *       configuration modes
+ *
+ * This struct should be used by the driver to fill the data for
+ * a parameter it registers.
+ */
+struct devlink_param {
+	u32 id;
+	const char *name;
+	bool generic;
+	enum devlink_param_type type;
+	unsigned long supported_cmodes;
+	int (*get)(struct devlink *devlink, u32 id,
+		   struct devlink_param_gset_ctx *ctx);
+	int (*set)(struct devlink *devlink, u32 id,
+		   struct devlink_param_gset_ctx *ctx);
+};
+
+struct devlink_param_item {
+	struct list_head list;
+	const struct devlink_param *param;
+	union devlink_param_value driverinit_value;
+	bool driverinit_value_valid;
+};
+
+enum devlink_param_generic_id {
+
+	/* add new param generic ids above here*/
+	__DEVLINK_PARAM_GENERIC_ID_MAX,
+	DEVLINK_PARAM_GENERIC_ID_MAX = __DEVLINK_PARAM_GENERIC_ID_MAX - 1,
+};
+
 struct devlink_ops {
 	int (*reload)(struct devlink *devlink, struct netlink_ext_ack *extack);
 	int (*port_type_set)(struct devlink_port *devlink_port,
@@ -430,6 +493,12 @@ void devlink_resource_occ_get_register(struct devlink *devlink,
 				       void *occ_get_priv);
 void devlink_resource_occ_get_unregister(struct devlink *devlink,
 					 u64 resource_id);
+int devlink_params_register(struct devlink *devlink,
+			    const struct devlink_param *params,
+			    size_t params_count);
+void devlink_params_unregister(struct devlink *devlink,
+			       const struct devlink_param *params,
+			       size_t params_count);
 
 #else
 
@@ -622,6 +691,22 @@ static inline bool devlink_dpipe_table_counter_enabled(struct devlink *devlink,
 {
 }
 
+static inline int
+devlink_params_register(struct devlink *devlink,
+			const struct devlink_param *params,
+			size_t params_count)
+{
+	return 0;
+}
+
+static inline void
+devlink_params_unregister(struct devlink *devlink,
+			  const struct devlink_param *params,
+			  size_t params_count)
+{
+
+}
+
 #endif
 
 #endif /* _NET_DEVLINK_H_ */
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 75cb545..d814fa6 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -142,6 +142,16 @@ enum devlink_port_flavour {
 				   */
 };
 
+enum devlink_param_cmode {
+	DEVLINK_PARAM_CMODE_RUNTIME,
+	DEVLINK_PARAM_CMODE_DRIVERINIT,
+	DEVLINK_PARAM_CMODE_PERMANENT,
+
+	/* Add new configuration modes above */
+	__DEVLINK_PARAM_CMODE_MAX,
+	DEVLINK_PARAM_CMODE_MAX = __DEVLINK_PARAM_CMODE_MAX - 1
+};
+
 enum devlink_attr {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_ATTR_UNSPEC,
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 2209970..41b1a5d 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -2604,6 +2604,82 @@ static int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info)
 	return devlink->ops->reload(devlink, info->extack);
 }
 
+static const struct devlink_param devlink_param_generic[] = {};
+
+static int devlink_param_generic_verify(const struct devlink_param *param)
+{
+	/* verify it match generic parameter by id and name */
+	if (param->id > DEVLINK_PARAM_GENERIC_ID_MAX)
+		return -EINVAL;
+	if (strcmp(param->name, devlink_param_generic[param->id].name))
+		return -ENOENT;
+
+	WARN_ON(param->type != devlink_param_generic[param->id].type);
+
+	return 0;
+}
+
+static int devlink_param_driver_verify(const struct devlink_param *param)
+{
+	int i;
+
+	if (param->id <= DEVLINK_PARAM_GENERIC_ID_MAX)
+		return -EINVAL;
+	/* verify no such name in generic params */
+	for (i = 0; i <= DEVLINK_PARAM_GENERIC_ID_MAX; i++)
+		if (!strcmp(param->name, devlink_param_generic[i].name))
+			return -EEXIST;
+
+	return 0;
+}
+
+static struct devlink_param_item *
+devlink_param_find_by_name(struct list_head *param_list,
+			   const char *param_name)
+{
+	struct devlink_param_item *param_item;
+
+	list_for_each_entry(param_item, param_list, list)
+		if (!strcmp(param_item->param->name, param_name))
+			return param_item;
+	return NULL;
+}
+
+static int devlink_param_register_one(struct devlink *devlink,
+				      const struct devlink_param *param)
+{
+	struct devlink_param_item *param_item;
+
+	if (devlink_param_find_by_name(&devlink->param_list,
+				       param->name))
+		return -EEXIST;
+
+	if (param->supported_cmodes == BIT(DEVLINK_PARAM_CMODE_DRIVERINIT))
+		WARN_ON(param->get || param->set);
+	else
+		WARN_ON(!param->get || !param->set);
+
+	param_item = kzalloc(sizeof(*param_item), GFP_KERNEL);
+	if (!param_item)
+		return -ENOMEM;
+	param_item->param = param;
+
+	list_add_tail(&param_item->list, &devlink->param_list);
+	return 0;
+}
+
+static void devlink_param_unregister_one(struct devlink *devlink,
+					 const struct devlink_param *param)
+{
+	struct devlink_param_item *param_item;
+
+	param_item = devlink_param_find_by_name(&devlink->param_list,
+						param->name);
+	WARN_ON(!param_item);
+	list_del(&param_item->list);
+	kfree(param_item);
+}
+
 static const struct nla_policy devlink_nl_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING },
@@ -2845,6 +2921,7 @@ struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size)
 	INIT_LIST_HEAD(&devlink->sb_list);
 	INIT_LIST_HEAD_RCU(&devlink->dpipe_table_list);
 	INIT_LIST_HEAD(&devlink->resource_list);
+	INIT_LIST_HEAD(&devlink->param_list);
 	mutex_init(&devlink->lock);
 	return devlink;
 }
@@ -3434,6 +3511,77 @@ void devlink_resource_occ_get_unregister(struct devlink *devlink,
 }
 EXPORT_SYMBOL_GPL(devlink_resource_occ_get_unregister);
 
+/**
+ *	devlink_params_register - register configuration parameters
+ *
+ *	@devlink: devlink
+ *	@params: configuration parameters array
+ *	@params_count: number of parameters provided
+ *
+ *	Register the configuration parameters supported by the driver.
+ */
+int devlink_params_register(struct devlink *devlink,
+			    const struct devlink_param *params,
+			    size_t params_count)
+{
+	const struct devlink_param *param = params;
+	int i;
+	int err;
+
+	mutex_lock(&devlink->lock);
+	for (i = 0; i < params_count; i++, param++) {
+		if (!param || !param->name || !param->supported_cmodes) {
+			err = -EINVAL;
+			goto rollback;
+		}
+		if (param->generic) {
+			err = devlink_param_generic_verify(param);
+			if (err)
+				goto rollback;
+		} else {
+			err = devlink_param_driver_verify(param);
+			if (err)
+				goto rollback;
+		}
+		err = devlink_param_register_one(devlink, param);
+		if (err)
+			goto rollback;
+	}
+
+	mutex_unlock(&devlink->lock);
+	return 0;
+
+rollback:
+	if (!i)
+		goto unlock;
+	for (param--; i > 0; i--, param--)
+		devlink_param_unregister_one(devlink, param);
+unlock:
+	mutex_unlock(&devlink->lock);
+	return err;
+}
+EXPORT_SYMBOL_GPL(devlink_params_register);
+
+/**
+ *	devlink_params_unregister - unregister configuration parameters
+ *	@devlink: devlink
+ *	@params: configuration parameters to unregister
+ *	@params_count: number of parameters provided
+ */
+void devlink_params_unregister(struct devlink *devlink,
+			       const struct devlink_param *params,
+			       size_t params_count)
+{
+	const struct devlink_param *param = params;
+	int i;
+
+	mutex_lock(&devlink->lock);
+	for (i = 0; i < params_count; i++, param++)
+		devlink_param_unregister_one(devlink, param);
+	mutex_unlock(&devlink->lock);
+}
+EXPORT_SYMBOL_GPL(devlink_params_unregister);
+
 static int __init devlink_module_init(void)
 {
 	return genl_register_family(&devlink_nl_family);
-- 
1.8.3.1

