Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC1BC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0A320899
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0A320899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934463AbeGDLeX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:34:23 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45963 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932758AbeGDLbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:31:18 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jul 2018 14:34:05 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w64BVGLB031308;
        Wed, 4 Jul 2018 14:31:16 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w64BVFGE024640;
        Wed, 4 Jul 2018 14:31:15 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w64BVFVZ024639;
        Wed, 4 Jul 2018 14:31:15 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next 03/10] devlink: Add param set command
Date:   Wed,  4 Jul 2018 14:30:30 +0300
Message-Id: <1530703837-24563-4-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
References: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add param set command to set value for a parameter.
Value can be set to any of the supported configuration modes.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 include/net/devlink.h        |   4 ++
 include/uapi/linux/devlink.h |   1 +
 net/core/devlink.c           | 134 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 4a0687a..8806275 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -328,6 +328,7 @@ struct devlink_param_gset_ctx {
  *       configuration modes
  * @set: set parameter value, used for runtime and permanent
  *       configuration modes
+ * @validate: validate input value is applicable (within value range, etc.)
  *
  * This struct should be used by the driver to fill the data for
  * a parameter it registers.
@@ -342,6 +343,9 @@ struct devlink_param {
 		   struct devlink_param_gset_ctx *ctx);
 	int (*set)(struct devlink *devlink, u32 id,
 		   struct devlink_param_gset_ctx *ctx);
+	int (*validate)(struct devlink *devlink, u32 id,
+			union devlink_param_value val,
+			struct netlink_ext_ack *extack);
 };
 
 struct devlink_param_item {
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 2ccfe84..ea0623e 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -79,6 +79,7 @@ enum devlink_command {
 	DEVLINK_CMD_RELOAD,
 
 	DEVLINK_CMD_PARAM_GET,		/* can dump */
+	DEVLINK_CMD_PARAM_SET,
 
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
diff --git a/net/core/devlink.c b/net/core/devlink.c
index b22d412..0cd7a42 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -2661,6 +2661,15 @@ static int devlink_param_get(struct devlink *devlink,
 	return param->get(devlink, param->id, ctx);
 }
 
+static int devlink_param_set(struct devlink *devlink,
+			     const struct devlink_param *param,
+			     struct devlink_param_gset_ctx *ctx)
+{
+	if (!param->set)
+		return -EOPNOTSUPP;
+	return param->set(devlink, param->id, ctx);
+}
+
 static int
 devlink_param_type_to_nla_type(enum devlink_param_type param_type)
 {
@@ -2847,6 +2856,69 @@ static int devlink_nl_cmd_param_get_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
+static int
+devlink_param_type_get_from_info(struct genl_info *info,
+				 enum devlink_param_type *param_type)
+{
+	if (!info->attrs[DEVLINK_ATTR_PARAM_TYPE])
+		return -EINVAL;
+
+	switch (nla_get_u8(info->attrs[DEVLINK_ATTR_PARAM_TYPE])) {
+	case NLA_U8:
+		*param_type = DEVLINK_PARAM_TYPE_U8;
+		break;
+	case NLA_U16:
+		*param_type = DEVLINK_PARAM_TYPE_U16;
+		break;
+	case NLA_U32:
+		*param_type = DEVLINK_PARAM_TYPE_U32;
+		break;
+	case NLA_STRING:
+		*param_type = DEVLINK_PARAM_TYPE_STRING;
+		break;
+	case NLA_FLAG:
+		*param_type = DEVLINK_PARAM_TYPE_BOOL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+devlink_param_value_get_from_info(const struct devlink_param *param,
+				  struct genl_info *info,
+				  union devlink_param_value *value)
+{
+	if (param->type != DEVLINK_PARAM_TYPE_BOOL &&
+	    !info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA])
+		return -EINVAL;
+
+	switch (param->type) {
+	case DEVLINK_PARAM_TYPE_U8:
+		value->vu8 = nla_get_u8(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]);
+		break;
+	case DEVLINK_PARAM_TYPE_U16:
+		value->vu16 = nla_get_u16(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]);
+		break;
+	case DEVLINK_PARAM_TYPE_U32:
+		value->vu32 = nla_get_u32(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]);
+		break;
+	case DEVLINK_PARAM_TYPE_STRING:
+		if (nla_len(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]) >
+		    DEVLINK_PARAM_MAX_STRING_VALUE)
+			return -EINVAL;
+		value->vstr = nla_data(info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA]);
+		break;
+	case DEVLINK_PARAM_TYPE_BOOL:
+		value->vbool = info->attrs[DEVLINK_ATTR_PARAM_VALUE_DATA] ?
+			       true : false;
+		break;
+	}
+	return 0;
+}
+
 static struct devlink_param_item *
 devlink_param_get_from_info(struct devlink *devlink,
 			    struct genl_info *info)
@@ -2887,6 +2959,58 @@ static int devlink_nl_cmd_param_get_doit(struct sk_buff *skb,
 	return genlmsg_reply(msg, info);
 }
 
+static int devlink_nl_cmd_param_set_doit(struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	enum devlink_param_type param_type;
+	struct devlink_param_gset_ctx ctx;
+	enum devlink_param_cmode cmode;
+	struct devlink_param_item *param_item;
+	const struct devlink_param *param;
+	union devlink_param_value value;
+	int err = 0;
+
+	param_item = devlink_param_get_from_info(devlink, info);
+	if (!param_item)
+		return -EINVAL;
+	param = param_item->param;
+	err = devlink_param_type_get_from_info(info, &param_type);
+	if (err)
+		return err;
+	if (param_type != param->type)
+		return -EINVAL;
+	err = devlink_param_value_get_from_info(param, info, &value);
+	if (err)
+		return err;
+	if (param->validate) {
+		err = param->validate(devlink, param->id, value, info->extack);
+		if (err)
+			return err;
+	}
+
+	if (!info->attrs[DEVLINK_ATTR_PARAM_VALUE_CMODE])
+		return -EINVAL;
+	cmode = nla_get_u8(info->attrs[DEVLINK_ATTR_PARAM_VALUE_CMODE]);
+	if (!devlink_param_cmode_is_supported(param, cmode))
+		return -EOPNOTSUPP;
+
+	if (cmode == DEVLINK_PARAM_CMODE_DRIVERINIT) {
+		param_item->driverinit_value = value;
+		param_item->driverinit_value_valid = true;
+	} else {
+		if (!param->set)
+			return -EOPNOTSUPP;
+		ctx.val = value;
+		ctx.cmode = cmode;
+		err = devlink_param_set(devlink, param, &ctx);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int devlink_param_register_one(struct devlink *devlink,
 				      const struct devlink_param *param)
 {
@@ -2942,6 +3066,9 @@ static void devlink_param_unregister_one(struct devlink *devlink,
 	[DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED] = { .type = NLA_U8 },
 	[DEVLINK_ATTR_RESOURCE_ID] = { .type = NLA_U64},
 	[DEVLINK_ATTR_RESOURCE_SIZE] = { .type = NLA_U64},
+	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING },
+	[DEVLINK_ATTR_PARAM_TYPE] = { .type = NLA_U8 },
+	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = { .type = NLA_U8 },
 };
 
 static const struct genl_ops devlink_nl_ops[] = {
@@ -3133,6 +3260,13 @@ static void devlink_param_unregister_one(struct devlink *devlink,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK,
 		/* can be retrieved by unprivileged users */
 	},
+	{
+		.cmd = DEVLINK_CMD_PARAM_SET,
+		.doit = devlink_nl_cmd_param_set_doit,
+		.policy = devlink_nl_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK,
+	},
 };
 
 static struct genl_family devlink_nl_family __ro_after_init = {
-- 
1.8.3.1

