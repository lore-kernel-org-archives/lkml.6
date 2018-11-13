Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9275EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F34F22511
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjULVi9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F34F22511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbeKMPrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbeKMPrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:31 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515C422510;
        Tue, 13 Nov 2018 05:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088263;
        bh=g0SsHdYiaR9so9+z3Dv04K8AvBi+dHFYVF/2285ujqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjULVi9sfNEMX1LFqo2r2B3BtF6swB8vj0o6vqDpuAzhpKx1j1I7o9CQz/HQd0jea
         nQkkdmsY+lCUM7GPL9zpP8v0GXpsxRND9HRazbCRuxaOrc07QIEGfbKAPwzo84U7mG
         NIVYumaV4NYqNtddZKrwKwp16RNBG96v2cqDUwr4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 07/39] net: hns3: bugfix for rtnl_lock's range in the hclgevf_reset()
Date:   Tue, 13 Nov 2018 00:50:21 -0500
Message-Id: <20181113055053.78352-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 29118ab962d5476fdc65fae312ac38db68092d78 ]

Since hclgevf_reset_wait() is used to wait for the hardware to complete
the reset, it is not necessary to hold the rtnl_lock during
hclgevf_reset_wait(). So this patch releases the lock for the duration
of hclgevf_reset_wait().

Fixes: 6988eb2a9b77 ("net: hns3: Add support to reset the enet/ring mgmt layer")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 12aa1f1b99ef..7e22853e5d2a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1052,6 +1052,8 @@ static int hclgevf_reset(struct hclgevf_dev *hdev)
 	/* bring down the nic to stop any ongoing TX/RX */
 	hclgevf_notify_client(hdev, HNAE3_DOWN_CLIENT);
 
+	rtnl_unlock();
+
 	/* check if VF could successfully fetch the hardware reset completion
 	 * status from the hardware
 	 */
@@ -1063,12 +1065,15 @@ static int hclgevf_reset(struct hclgevf_dev *hdev)
 			ret);
 
 		dev_warn(&hdev->pdev->dev, "VF reset failed, disabling VF!\n");
+		rtnl_lock();
 		hclgevf_notify_client(hdev, HNAE3_UNINIT_CLIENT);
 
 		rtnl_unlock();
 		return ret;
 	}
 
+	rtnl_lock();
+
 	/* now, re-initialize the nic client and ae device*/
 	ret = hclgevf_reset_stack(hdev);
 	if (ret)
-- 
2.17.1

