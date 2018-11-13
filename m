Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64688C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FDE22511
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2oP1pLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FDE22511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeKMPre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732013AbeKMPrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:33 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98E02251A;
        Tue, 13 Nov 2018 05:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088265;
        bh=Udc2cppiU5qddOKN+qoJFUbrLmkfrzOCrULISgBPhrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2oP1pLHw4dngDWqa8Uvn/iB5Q6AruBaWFgJT4XYQZZVp+pOjnQt5TmuZYzyKLHZg
         95vbgNbnvVONBpIibRZUnoxdhi6aQgXFdz1zq3agN1ahAoHjjuWaX7wthFCj11TvCD
         WTSowFYUBCLnORAt0hfzp7IfjOmJCE3olRyZbYns=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 08/39] net: hns3: bugfix for rtnl_lock's range in the hclge_reset()
Date:   Tue, 13 Nov 2018 00:50:22 -0500
Message-Id: <20181113055053.78352-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit a963052e539887df481d4d3a6ad4c92ca6461852 ]

Since hclge_reset_wait() is used to wait for the hardware to complete
the reset, it is not necessary to hold the rtnl_lock during
hclge_reset_wait(). So this patch releases the lock for the duration
of hclge_reset_wait().

Fixes: 6d4fab39533f ("net: hns3: Reset net device with rtnl_lock")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 13f43b74fd6d..de85a31106e7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2827,14 +2827,17 @@ static void hclge_reset(struct hclge_dev *hdev)
 	/* perform reset of the stack & ae device for a client */
 	rtnl_lock();
 	hclge_notify_client(hdev, HNAE3_DOWN_CLIENT);
+	rtnl_unlock();
 
 	if (!hclge_reset_wait(hdev)) {
+		rtnl_lock();
 		hclge_notify_client(hdev, HNAE3_UNINIT_CLIENT);
 		hclge_reset_ae_dev(hdev->ae_dev);
 		hclge_notify_client(hdev, HNAE3_INIT_CLIENT);
 
 		hclge_clear_reset_cause(hdev);
 	} else {
+		rtnl_lock();
 		/* schedule again to check pending resets later */
 		set_bit(hdev->reset_type, &hdev->reset_pending);
 		hclge_reset_task_schedule(hdev);
-- 
2.17.1

