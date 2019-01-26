Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF831C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C856D218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfAZIns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 03:43:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfAZInq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 03:43:46 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 332AF417ACCA17B1A7BA;
        Sat, 26 Jan 2019 16:43:44 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sat, 26 Jan 2019 16:43:33 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net 1/3] net: hns: Fix for missing of_node_put() after of_parse_phandle()
Date:   Sat, 26 Jan 2019 17:18:25 +0800
Message-ID: <1548494307-63594-2-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548494307-63594-1-git-send-email-lipeng321@huawei.com>
References: <1548494307-63594-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

In hns enet driver, we use of_parse_handle() to get hold of the
device node related to "ae-handle" but we have missed to put
the node reference using of_node_put() after we are done using
the node. This patch fixes it.

Note:
This problem is stated in Link: https://lkml.org/lkml/2018/12/22/217

Fixes: 48189d6aaf1e ("net: hns: enet specifies a reference to dsaf")
Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 5b33238..60e7d7a 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2418,6 +2418,8 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
 out_notify_fail:
 	(void)cancel_work_sync(&priv->service_task);
 out_read_prop_fail:
+	/* safe for ACPI FW */
+	of_node_put(to_of_node(priv->fwnode));
 	free_netdev(ndev);
 	return ret;
 }
@@ -2447,6 +2449,9 @@ static int hns_nic_dev_remove(struct platform_device *pdev)
 	set_bit(NIC_STATE_REMOVING, &priv->state);
 	(void)cancel_work_sync(&priv->service_task);
 
+	/* safe for ACPI FW */
+	of_node_put(to_of_node(priv->fwnode));
+
 	free_netdev(ndev);
 	return 0;
 }
-- 
1.9.1

