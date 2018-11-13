Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9FAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FAC223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZqysGkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FAC223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbeKMPrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbeKMPrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:35 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D10672250E;
        Tue, 13 Nov 2018 05:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088267;
        bh=JBcLTfaqVPeFRK6ciiLJqd6dMYAQpd+DEE7QOU6ER9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZqysGkKAIpPBa3Xv91JDPu9tDnjtYYJfkbyXVPGQZ95KMFTIpqIc8fj/qfCGwCZH
         ts6LYL0F7CQLedyXrcNZRr+I+JhLSkmhZSJ/klHu2gDh8reh4MyP2Th58/5aeu7gIe
         +ILqtDSjm9e+tyQLrjZhRjXkpbPfta20lobT9cV8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 09/39] net: hns3: bugfix for the initialization of command queue's spin lock
Date:   Tue, 13 Nov 2018 00:50:23 -0500
Message-Id: <20181113055053.78352-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit b2f74dbaf12bf59ff35d451005b3cdee78232ff0 ]

The spin lock of the command queue only need to be initialized once
when the driver initializes the command queue. It is not necessary to
initialize the spin lock when resetting. At the same time, the
modification of the queue member should be performed after acquiring
the lock.

Fixes: 3efb960f056d ("net: hns3: Refactor the initialization of command queue")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index c36d64710fa6..fda9d64bc6e9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -326,6 +326,10 @@ int hclge_cmd_queue_init(struct hclge_dev *hdev)
 {
 	int ret;
 
+	/* Setup the lock for command queue */
+	spin_lock_init(&hdev->hw.cmq.csq.lock);
+	spin_lock_init(&hdev->hw.cmq.crq.lock);
+
 	/* Setup the queue entries for use cmd queue */
 	hdev->hw.cmq.csq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
 	hdev->hw.cmq.crq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
@@ -359,17 +363,19 @@ int hclge_cmd_init(struct hclge_dev *hdev)
 	u32 version;
 	int ret;
 
+	spin_lock_bh(&hdev->hw.cmq.csq.lock);
+	spin_lock_bh(&hdev->hw.cmq.crq.lock);
+
 	hdev->hw.cmq.csq.next_to_clean = 0;
 	hdev->hw.cmq.csq.next_to_use = 0;
 	hdev->hw.cmq.crq.next_to_clean = 0;
 	hdev->hw.cmq.crq.next_to_use = 0;
 
-	/* Setup the lock for command queue */
-	spin_lock_init(&hdev->hw.cmq.csq.lock);
-	spin_lock_init(&hdev->hw.cmq.crq.lock);
-
 	hclge_cmd_init_regs(&hdev->hw);
 
+	spin_unlock_bh(&hdev->hw.cmq.crq.lock);
+	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
+
 	ret = hclge_cmd_query_firmware_version(&hdev->hw, &version);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
-- 
2.17.1

