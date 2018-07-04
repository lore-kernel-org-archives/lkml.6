Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C79C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B85A21532
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B85A21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934525AbeGDLeY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:34:24 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45960 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932732AbeGDLbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:31:18 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jul 2018 14:34:04 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w64BVEI7031302;
        Wed, 4 Jul 2018 14:31:14 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w64BVEeA024638;
        Wed, 4 Jul 2018 14:31:14 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w64BVEYK024637;
        Wed, 4 Jul 2018 14:31:14 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next 02/10] devlink: Add param get command
Date:   Wed,  4 Jul 2018 14:30:29 +0300
Message-Id: <1530703837-24563-3-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
References: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add param get command which gets data per parameter.
Option to dump the parameters data per device.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 include/uapi/linux/devlink.h |  11 ++
 net/core/devlink.c           | 250 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 261 insertions(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index d814fa6..2ccfe84 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -78,6 +78,8 @@ enum devlink_command {
 	 */
 	DEVLINK_CMD_RELOAD,
 
+	DEVLINK_CMD_PARAM_GET,		/* can dump */
+
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
@@ -248,6 +250,15 @@ enum devlink_attr {
 	DEVLINK_ATTR_PORT_NUMBER,		/* u32 */
 	DEVLINK_ATTR_PORT_SPLIT_SUBPORT_NUMBER,	/* u32 */
 
+	DEVLINK_ATTR_PARAM,			/* nested */
+	DEVLINK_ATTR_PARAM_NAME,		/* string */
+	DEVLINK_ATTR_PARAM_GENERIC,		/* flag */
+	DEVLINK_ATTR_PARAM_TYPE,		/* u8 */
+	DEVLINK_ATTR_PARAM_VALUES_LIST,		/* nested */
+	DEVLINK_ATTR_PARAM_VALUE,		/* nested */
+	DEVLINK_ATTR_PARAM_VALUE_DATA,		/* dynamic */
+	DEVLINK_ATTR_PARAM_VALUE_CMODE,		/* u8 */
+
 	/* add new attributes above here, update the policy in devlink.c */
 
 	__DEVLINK_ATTR_MAX,
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 41b1a5d..b22d412 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -2645,6 +2645,248 @@ static int devlink_param_driver_verify(const struct devlink_param *param)
 	return NULL;
 }
 
+static bool
+devlink_param_cmode_is_supported(const struct devlink_param *param,
+				 enum devlink_param_cmode cmode)
+{
+	return test_bit(cmode, &param->supported_cmodes);
+}
+
+static int devlink_param_get(struct devlink *devlink,
+			     const struct devlink_param *param,
+			     struct devlink_param_gset_ctx *ctx)
+{
+	if (!param->get)
+		return -EOPNOTSUPP;
+	return param->get(devlink, param->id, ctx);
+}
+
+static int
+devlink_param_type_to_nla_type(enum devlink_param_type param_type)
+{
+	switch (param_type) {
+	case DEVLINK_PARAM_TYPE_U8:
+		return NLA_U8;
+	case DEVLINK_PARAM_TYPE_U16:
+		return NLA_U16;
+	case DEVLINK_PARAM_TYPE_U32:
+		return NLA_U32;
+	case DEVLINK_PARAM_TYPE_STRING:
+		return NLA_STRING;
+	case DEVLINK_PARAM_TYPE_BOOL:
+		return NLA_FLAG;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int
+devlink_nl_param_value_fill_one(struct sk_buff *msg,
+				enum devlink_param_type type,
+				enum devlink_param_cmode cmode,
+				union devlink_param_value val)
+{
+	struct nlattr *param_value_attr;
+
+	param_value_attr = nla_nest_start(msg, DEVLINK_ATTR_PARAM_VALUE);
+	if (!param_value_attr)
+		goto nla_put_failure;
+
+	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_VALUE_CMODE, cmode))
+		goto value_nest_cancel;
+
+	switch (type) {
+	case DEVLINK_PARAM_TYPE_U8:
+		if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_VALUE_DATA, val.vu8))
+			goto value_nest_cancel;
+		break;
+	case DEVLINK_PARAM_TYPE_U16:
+		if (nla_put_u16(msg, DEVLINK_ATTR_PARAM_VALUE_DATA, val.vu16))
+			goto value_nest_cancel;
+		break;
+	case DEVLINK_PARAM_TYPE_U32:
+		if (nla_put_u32(msg, DEVLINK_ATTR_PARAM_VALUE_DATA, val.vu32))
+			goto value_nest_cancel;
+		break;
+	case DEVLINK_PARAM_TYPE_STRING:
+		if (nla_put_string(msg, DEVLINK_ATTR_PARAM_VALUE_DATA,
+				   val.vstr))
+			goto value_nest_cancel;
+		break;
+	case DEVLINK_PARAM_TYPE_BOOL:
+		if (val.vbool &&
+		    nla_put_flag(msg, DEVLINK_ATTR_PARAM_VALUE_DATA))
+			goto value_nest_cancel;
+		break;
+	}
+
+	nla_nest_end(msg, param_value_attr);
+	return 0;
+
+value_nest_cancel:
+	nla_nest_cancel(msg, param_value_attr);
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
+static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
+				 struct devlink_param_item *param_item,
+				 enum devlink_command cmd,
+				 u32 portid, u32 seq, int flags)
+{
+	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
+	const struct devlink_param *param = param_item->param;
+	struct devlink_param_gset_ctx ctx;
+	struct nlattr *param_values_list;
+	struct nlattr *param_attr;
+	int nla_type;
+	void *hdr;
+	int err;
+	int i;
+
+	/* Get value from driver part to driverinit configuration mode */
+	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
+		if (!devlink_param_cmode_is_supported(param, i))
+			continue;
+		if (i == DEVLINK_PARAM_CMODE_DRIVERINIT) {
+			if (!param_item->driverinit_value_valid)
+				return -EOPNOTSUPP;
+			param_value[i] = param_item->driverinit_value;
+		} else {
+			ctx.cmode = i;
+			err = devlink_param_get(devlink, param, &ctx);
+			if (err)
+				return err;
+			param_value[i] = ctx.val;
+		}
+	}
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto genlmsg_cancel;
+	param_attr = nla_nest_start(msg, DEVLINK_ATTR_PARAM);
+	if (!param_attr)
+		goto genlmsg_cancel;
+	if (nla_put_string(msg, DEVLINK_ATTR_PARAM_NAME, param->name))
+		goto param_nest_cancel;
+	if (param->generic && nla_put_flag(msg, DEVLINK_ATTR_PARAM_GENERIC))
+		goto param_nest_cancel;
+
+	nla_type = devlink_param_type_to_nla_type(param->type);
+	if (nla_type < 0)
+		goto param_nest_cancel;
+	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_TYPE, nla_type))
+		goto param_nest_cancel;
+
+	param_values_list = nla_nest_start(msg, DEVLINK_ATTR_PARAM_VALUES_LIST);
+	if (!param_values_list)
+		goto param_nest_cancel;
+
+	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
+		if (!devlink_param_cmode_is_supported(param, i))
+			continue;
+		err = devlink_nl_param_value_fill_one(msg, param->type,
+						      i, param_value[i]);
+		if (err)
+			goto values_list_nest_cancel;
+	}
+
+	nla_nest_end(msg, param_values_list);
+	nla_nest_end(msg, param_attr);
+	genlmsg_end(msg, hdr);
+	return 0;
+
+values_list_nest_cancel:
+	nla_nest_end(msg, param_values_list);
+param_nest_cancel:
+	nla_nest_cancel(msg, param_attr);
+genlmsg_cancel:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+static int devlink_nl_cmd_param_get_dumpit(struct sk_buff *msg,
+					   struct netlink_callback *cb)
+{
+	struct devlink_param_item *param_item;
+	struct devlink *devlink;
+	int start = cb->args[0];
+	int idx = 0;
+	int err;
+
+	mutex_lock(&devlink_mutex);
+	list_for_each_entry(devlink, &devlink_list, list) {
+		if (!net_eq(devlink_net(devlink), sock_net(msg->sk)))
+			continue;
+		mutex_lock(&devlink->lock);
+		list_for_each_entry(param_item, &devlink->param_list, list) {
+			if (idx < start) {
+				idx++;
+				continue;
+			}
+			err = devlink_nl_param_fill(msg, devlink, param_item,
+						    DEVLINK_CMD_PARAM_GET,
+						    NETLINK_CB(cb->skb).portid,
+						    cb->nlh->nlmsg_seq,
+						    NLM_F_MULTI);
+			if (err) {
+				mutex_unlock(&devlink->lock);
+				goto out;
+			}
+			idx++;
+		}
+		mutex_unlock(&devlink->lock);
+	}
+out:
+	mutex_unlock(&devlink_mutex);
+
+	cb->args[0] = idx;
+	return msg->len;
+}
+
+static struct devlink_param_item *
+devlink_param_get_from_info(struct devlink *devlink,
+			    struct genl_info *info)
+{
+	char *param_name;
+
+	if (!info->attrs[DEVLINK_ATTR_PARAM_NAME])
+		return NULL;
+
+	param_name = nla_data(info->attrs[DEVLINK_ATTR_PARAM_NAME]);
+	return devlink_param_find_by_name(&devlink->param_list, param_name);
+}
+
+static int devlink_nl_cmd_param_get_doit(struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_param_item *param_item;
+	struct sk_buff *msg;
+	int err;
+
+	param_item = devlink_param_get_from_info(devlink, info);
+	if (!param_item)
+		return -EINVAL;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	err = devlink_nl_param_fill(msg, devlink, param_item,
+				    DEVLINK_CMD_PARAM_GET,
+				    info->snd_portid, info->snd_seq, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
+
+	return genlmsg_reply(msg, info);
+}
+
 static int devlink_param_register_one(struct devlink *devlink,
 				      const struct devlink_param *param)
 {
@@ -2883,6 +3125,14 @@ static void devlink_param_unregister_one(struct devlink *devlink,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK |
 				  DEVLINK_NL_FLAG_NO_LOCK,
 	},
+	{
+		.cmd = DEVLINK_CMD_PARAM_GET,
+		.doit = devlink_nl_cmd_param_get_doit,
+		.dumpit = devlink_nl_cmd_param_get_dumpit,
+		.policy = devlink_nl_policy,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK,
+		/* can be retrieved by unprivileged users */
+	},
 };
 
 static struct genl_family devlink_nl_family __ro_after_init = {
-- 
1.8.3.1

