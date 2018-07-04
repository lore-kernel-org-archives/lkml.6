Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFAAC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BBE208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BBE208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934439AbeGDLcO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:32:14 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46035 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934117AbeGDLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:31:24 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jul 2018 14:34:10 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w64BVL0k031428;
        Wed, 4 Jul 2018 14:31:21 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w64BVLU7024659;
        Wed, 4 Jul 2018 14:31:21 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w64BVLoj024658;
        Wed, 4 Jul 2018 14:31:21 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 09/10] devlink: Add enable_sriov boolean generic parameter
Date:   Wed,  4 Jul 2018 14:30:36 +0300
Message-Id: <1530703837-24563-10-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
References: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

enable_sriov - Enables Single-Root Input/Output Virtualization(SR-IOV)
characteristic of the device.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 include/net/devlink.h | 4 ++++
 net/core/devlink.c    | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index a1c230d..8ed57138 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -358,6 +358,7 @@ struct devlink_param_item {
 enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_INT_ERR_RESET,
 	DEVLINK_PARAM_GENERIC_ID_MAX_MACS,
+	DEVLINK_PARAM_GENERIC_ID_ENABLE_SRIOV,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -370,6 +371,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_MAX_MACS_NAME "max_macs"
 #define DEVLINK_PARAM_GENERIC_MAX_MACS_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_ENABLE_SRIOV_NAME "enable_sriov"
+#define DEVLINK_PARAM_GENERIC_ENABLE_SRIOV_TYPE DEVLINK_PARAM_TYPE_BOOL
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 5bbd0aa..470f3db 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -2615,7 +2615,11 @@ static int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info)
 		.name = DEVLINK_PARAM_GENERIC_MAX_MACS_NAME,
 		.type = DEVLINK_PARAM_GENERIC_MAX_MACS_TYPE,
 	},
-
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_ENABLE_SRIOV,
+		.name = DEVLINK_PARAM_GENERIC_ENABLE_SRIOV_NAME,
+		.type = DEVLINK_PARAM_GENERIC_ENABLE_SRIOV_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
1.8.3.1

