Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CD9C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22346223B7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22346223B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeHJFG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:06:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725198AbeHJFG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:06:59 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 165CC78942133;
        Fri, 10 Aug 2018 10:39:12 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Fri, 10 Aug 2018
 10:39:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <jiri@mellanox.com>, <idosch@mellanox.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] mlxsw: core: remove unnecessary function mlxsw_core_driver_put
Date:   Fri, 10 Aug 2018 10:37:30 +0800
Message-ID: <20180810023730.13140-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function mlxsw_core_driver_put only traverse mlxsw_core_driver_list
to find the matched mlxsw_driver,but never used it.
So it can be removed safely.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index b5d5e57..81533d7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -726,15 +726,6 @@ static struct mlxsw_driver *mlxsw_core_driver_get(const char *kind)
 	return mlxsw_driver;
 }
 
-static void mlxsw_core_driver_put(const char *kind)
-{
-	struct mlxsw_driver *mlxsw_driver;
-
-	spin_lock(&mlxsw_core_driver_list_lock);
-	mlxsw_driver = __driver_find(kind);
-	spin_unlock(&mlxsw_core_driver_list_lock);
-}
-
 static int mlxsw_devlink_port_split(struct devlink *devlink,
 				    unsigned int port_index,
 				    unsigned int count,
@@ -1082,7 +1073,6 @@ int mlxsw_core_bus_device_register(const struct mlxsw_bus_info *mlxsw_bus_info,
 	if (!reload)
 		devlink_free(devlink);
 err_devlink_alloc:
-	mlxsw_core_driver_put(device_kind);
 	return err;
 }
 EXPORT_SYMBOL(mlxsw_core_bus_device_register);
@@ -1090,7 +1080,6 @@ EXPORT_SYMBOL(mlxsw_core_bus_device_register);
 void mlxsw_core_bus_device_unregister(struct mlxsw_core *mlxsw_core,
 				      bool reload)
 {
-	const char *device_kind = mlxsw_core->bus_info->device_kind;
 	struct devlink *devlink = priv_to_devlink(mlxsw_core);
 
 	if (mlxsw_core->reload_fail)
@@ -1111,7 +1100,6 @@ void mlxsw_core_bus_device_unregister(struct mlxsw_core *mlxsw_core,
 		return;
 reload_fail:
 	devlink_free(devlink);
-	mlxsw_core_driver_put(device_kind);
 }
 EXPORT_SYMBOL(mlxsw_core_bus_device_unregister);
 
-- 
2.7.0


