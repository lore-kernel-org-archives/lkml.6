Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209CAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 03:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83AA2080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 03:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfABDdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 22:33:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17073 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727478AbfABDdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 22:33:35 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 408A12D85A95;
        Wed,  2 Jan 2019 11:33:32 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 2 Jan 2019 11:33:24 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <xuechaojing@huawei.com>,
        <netdev@vger.kernel.org>, <wulike1@huawei.com>,
        <chiqijun@huawei.com>, <fy.wang@huawei.com>, <tony.qu@huawei.com>,
        <luoshaokai@huawei.com>
Subject: [PATCH 1/1] net-next/hinic:add shutdown callback
Date:   Tue, 1 Jan 2019 19:39:33 +0000
Message-ID: <20190101193933.27361-1-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no shutdown callback, our board will report pcie UNF errors
after restarting. This patch add shutdown callback for hinic.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 6d48dc62a44b..da323b9e1f62 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -1106,6 +1106,11 @@ static void hinic_remove(struct pci_dev *pdev)
 	dev_info(&pdev->dev, "HiNIC driver - removed\n");
 }
 
+static void hinic_shutdown(struct pci_dev *pdev)
+{
+	pci_disable_device(pdev);
+}
+
 static const struct pci_device_id hinic_pci_table[] = {
 	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_QUAD_PORT_25GE), 0},
 	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_DUAL_PORT_25GE), 0},
@@ -1119,6 +1124,7 @@ static struct pci_driver hinic_driver = {
 	.id_table       = hinic_pci_table,
 	.probe          = hinic_probe,
 	.remove         = hinic_remove,
+	.shutdown       = hinic_shutdown,
 };
 
 module_pci_driver(hinic_driver);
-- 
2.17.1

