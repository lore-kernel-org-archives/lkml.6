Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E98C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCBB2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCBB2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeLGVJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:09:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59892 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbeLGVJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:09:38 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3FACB783EFD07;
        Sat,  8 Dec 2018 05:09:35 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 05:09:25 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 05/14] net: hns3: rename process_hw_error function
Date:   Fri, 7 Dec 2018 21:08:02 +0000
Message-ID: <20181207210811.23844-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181207210811.23844-1-salil.mehta@huawei.com>
References: <20181207210811.23844-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

This patch renames process_hw_error function to
handle_hw_ras_error function to match the purpose
of the function. This is because hw errors reported through
ras and msix interrupts will be handled separately.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c  | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h  | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index a1707b7..9d9f4f9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -454,7 +454,7 @@ struct hnae3_ae_ops {
 	int (*restore_fd_rules)(struct hnae3_handle *handle);
 	void (*enable_fd)(struct hnae3_handle *handle, bool enable);
 	int (*dbg_run_cmd)(struct hnae3_handle *handle, char *cmd_buf);
-	pci_ers_result_t (*process_hw_error)(struct hnae3_ae_dev *ae_dev);
+	pci_ers_result_t (*handle_hw_ras_error)(struct hnae3_ae_dev *ae_dev);
 	bool (*get_hw_reset_stat)(struct hnae3_handle *handle);
 	bool (*ae_dev_resetting)(struct hnae3_handle *handle);
 	unsigned long (*ae_dev_reset_cnt)(struct hnae3_handle *handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index d1b2de2..69142a3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1828,8 +1828,8 @@ static pci_ers_result_t hns3_error_detected(struct pci_dev *pdev,
 		return PCI_ERS_RESULT_NONE;
 	}
 
-	if (ae_dev->ops->process_hw_error)
-		ret = ae_dev->ops->process_hw_error(ae_dev);
+	if (ae_dev->ops->handle_hw_ras_error)
+		ret = ae_dev->ops->handle_hw_ras_error(ae_dev);
 	else
 		return PCI_ERS_RESULT_NONE;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 62fab23..2d07be8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -603,7 +603,7 @@ int hclge_hw_error_set_state(struct hclge_dev *hdev, bool state)
 	return ret;
 }
 
-pci_ers_result_t hclge_process_ras_hw_error(struct hnae3_ae_dev *ae_dev)
+pci_ers_result_t hclge_handle_hw_ras_error(struct hnae3_ae_dev *ae_dev)
 {
 	struct hclge_dev *hdev = ae_dev->priv;
 	struct device *dev = &hdev->pdev->dev;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
index 405739b..9fe1c96 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -59,5 +59,5 @@ struct hclge_hw_error {
 };
 
 int hclge_hw_error_set_state(struct hclge_dev *hdev, bool state);
-pci_ers_result_t hclge_process_ras_hw_error(struct hnae3_ae_dev *ae_dev);
+pci_ers_result_t hclge_handle_hw_ras_error(struct hnae3_ae_dev *ae_dev);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 431d92a..354ac5f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7935,7 +7935,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.restore_fd_rules = hclge_restore_fd_entries,
 	.enable_fd = hclge_enable_fd,
 	.dbg_run_cmd = hclge_dbg_run_cmd,
-	.process_hw_error = hclge_process_ras_hw_error,
+	.handle_hw_ras_error = hclge_handle_hw_ras_error,
 	.get_hw_reset_stat = hclge_get_hw_reset_stat,
 	.ae_dev_resetting = hclge_ae_dev_resetting,
 	.ae_dev_reset_cnt = hclge_ae_dev_reset_cnt,
-- 
2.7.4


