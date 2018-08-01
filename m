Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F410C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E6420841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E6420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbeHAUH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:07:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46030 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404450AbeHATDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:40 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 412E2104E;
        Wed,  1 Aug 2018 17:00:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 147/336] net: hns3: Fix for CMDQ and Misc. interrupt init order problem
Date:   Wed,  1 Aug 2018 18:48:02 +0200
Message-Id: <20180801165034.765495878@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit eddf04626d1d6d0bcd01ac6a287e49f5ddb90a26 ]

When vf module is loading, the cmd queue initialization should
happen before misc interrupt initialization, otherwise the misc
interrupt handle will cause using uninitialized cmd queue problem.
There is also the same issue when vf module is unloading.

This patch fixes it by adjusting the location of some function.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |   16 +++++++-------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1631,6 +1631,10 @@ static int hclgevf_init_hdev(struct hclg
 
 	hclgevf_state_init(hdev);
 
+	ret = hclgevf_cmd_init(hdev);
+	if (ret)
+		goto err_cmd_init;
+
 	ret = hclgevf_misc_irq_init(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed(%d) to init Misc IRQ(vector0)\n",
@@ -1638,10 +1642,6 @@ static int hclgevf_init_hdev(struct hclg
 		goto err_misc_irq_init;
 	}
 
-	ret = hclgevf_cmd_init(hdev);
-	if (ret)
-		goto err_cmd_init;
-
 	ret = hclgevf_configure(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed(%d) to fetch configuration\n", ret);
@@ -1689,10 +1689,10 @@ static int hclgevf_init_hdev(struct hclg
 	return 0;
 
 err_config:
-	hclgevf_cmd_uninit(hdev);
-err_cmd_init:
 	hclgevf_misc_irq_uninit(hdev);
 err_misc_irq_init:
+	hclgevf_cmd_uninit(hdev);
+err_cmd_init:
 	hclgevf_state_uninit(hdev);
 	hclgevf_uninit_msi(hdev);
 err_irq_init:
@@ -1702,9 +1702,9 @@ err_irq_init:
 
 static void hclgevf_uninit_hdev(struct hclgevf_dev *hdev)
 {
-	hclgevf_cmd_uninit(hdev);
-	hclgevf_misc_irq_uninit(hdev);
 	hclgevf_state_uninit(hdev);
+	hclgevf_misc_irq_uninit(hdev);
+	hclgevf_cmd_uninit(hdev);
 	hclgevf_uninit_msi(hdev);
 	hclgevf_pci_uninit(hdev);
 }


