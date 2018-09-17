Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4496BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31E9214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31E9214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeIQQXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:23:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeIQQXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:23:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 51D286E5EAF57;
        Mon, 17 Sep 2018 18:56:40 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Mon, 17 Sep 2018 18:56:39 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <bryan.whitehead@microchip.com>,
        <UNGLinuxDriver@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: ethernet: Fix a unused function warning.
Date:   Mon, 17 Sep 2018 18:44:19 +0800
Message-ID: <1537181059-53563-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

drivers/net/ethernet/microchip/lan743x_main.c:2964:12: warning: lan743x_pm_suspend defined but not used [-Wunused-function]
 static int lan743x_pm_suspend(struct device *dev)
drivers/net/ethernet/microchip/lan743x_main.c:2987:12: warning: lan743x_pm_resume defined but not used [-Wunused-function]
 static int lan743x_pm_resume(struct device *dev)

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index e7dce79..001b5f7 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2850,7 +2850,7 @@ static void lan743x_pcidev_shutdown(struct pci_dev *pdev)
 	lan743x_hardware_cleanup(adapter);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static u16 lan743x_pm_wakeframe_crc16(const u8 *buf, int len)
 {
 	return bitrev16(crc16(0xFFFF, buf, len));
@@ -3016,7 +3016,7 @@ static int lan743x_pm_resume(struct device *dev)
 static const struct dev_pm_ops lan743x_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(lan743x_pm_suspend, lan743x_pm_resume)
 };
-#endif /*CONFIG_PM */
+#endif /* CONFIG_PM_SLEEP */
 
 static const struct pci_device_id lan743x_pcidev_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SMSC, PCI_DEVICE_ID_SMSC_LAN7430) },
@@ -3028,7 +3028,7 @@ static int lan743x_pm_resume(struct device *dev)
 	.id_table = lan743x_pcidev_tbl,
 	.probe    = lan743x_pcidev_probe,
 	.remove   = lan743x_pcidev_remove,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	.driver.pm = &lan743x_pm_ops,
 #endif
 	.shutdown = lan743x_pcidev_shutdown,
-- 
1.7.12.4

