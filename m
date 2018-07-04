Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D2AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9AF208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9AF208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934279AbeGDLdd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:33:33 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46023 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934102AbeGDLbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:31:23 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jul 2018 14:34:08 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w64BVIAC031381;
        Wed, 4 Jul 2018 14:31:18 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w64BVIBf024648;
        Wed, 4 Jul 2018 14:31:18 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w64BVITo024647;
        Wed, 4 Jul 2018 14:31:18 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next 06/10] devlink: Add generic parameters internal_err_reset and max_macs
Date:   Wed,  4 Jul 2018 14:30:33 +0300
Message-Id: <1530703837-24563-7-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
References: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 first generic parameters to devlink configuration parameters set:
internal_err_reset - When set enables reset device on internal errors.
max_macs - max number of MACs per ETH port.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 include/net/devlink.h | 31 +++++++++++++++++++++++++++++++
 net/core/devlink.c    | 14 +++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 792edaa..a1c230d 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -356,12 +356,43 @@ struct devlink_param_item {
 };
 
 enum devlink_param_generic_id {
+	DEVLINK_PARAM_GENERIC_ID_INT_ERR_RESET,
+	DEVLINK_PARAM_GENERIC_ID_MAX_MACS,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
 	DEVLINK_PARAM_GENERIC_ID_MAX = __DEVLINK_PARAM_GENERIC_ID_MAX - 1,
 };
 
+#define DEVLINK_PARAM_GENERIC_INT_ERR_RESET_NAME "internal_error_reset"
+#define DEVLINK_PARAM_GENERIC_INT_ERR_RESET_TYPE DEVLINK_PARAM_TYPE_BOOL
+
+#define DEVLINK_PARAM_GENERIC_MAX_MACS_NAME "max_macs"
+#define DEVLINK_PARAM_GENERIC_MAX_MACS_TYPE DEVLINK_PARAM_TYPE_U32
+
+#define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
+{									\
+	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
+	.name = DEVLINK_PARAM_GENERIC_##_id##_NAME,			\
+	.type = DEVLINK_PARAM_GENERIC_##_id##_TYPE,			\
+	.generic = true,						\
+	.supported_cmodes = _cmodes,					\
+	.get = _get,							\
+	.set = _set,							\
+	.validate = _validate,						\
+}
+
+#define DEVLINK_PARAM_DRIVER(_id, _name, _type, _cmodes, _get, _set, _validate)	\
+{									\
+	.id = _id,							\
+	.name = _name,							\
+	.type = _type,							\
+	.supported_cmodes = _cmodes,					\
+	.get = _get,							\
+	.set = _set,							\
+	.validate = _validate,						\
+}
+
 struct devlink_ops {
 	int (*reload)(struct devlink *devlink, struct netlink_ext_ack *extack);
 	int (*port_type_set)(struct devlink_port *devlink_port,
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 89d948f..5bbd0aa 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -2604,7 +2604,19 @@ static int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info)
 	return devlink->ops->reload(devlink, info->extack);
 }
 
-static const struct devlink_param devlink_param_generic[] = {};
+static const struct devlink_param devlink_param_generic[] = {
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_INT_ERR_RESET,
+		.name = DEVLINK_PARAM_GENERIC_INT_ERR_RESET_NAME,
+		.type = DEVLINK_PARAM_GENERIC_INT_ERR_RESET_TYPE,
+	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_MAX_MACS,
+		.name = DEVLINK_PARAM_GENERIC_MAX_MACS_NAME,
+		.type = DEVLINK_PARAM_GENERIC_MAX_MACS_TYPE,
+	},
+
+};
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
 {
-- 
1.8.3.1

