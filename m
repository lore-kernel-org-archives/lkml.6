Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779DFC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3962120862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3962120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436647AbeHATSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:18:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436528AbeHATSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E7881F19;
        Wed,  1 Aug 2018 16:55:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 058/336] net: hns3: Fix for phy not link up problem after resetting
Date:   Wed,  1 Aug 2018 18:46:33 +0200
Message-Id: <20180801165031.294068442@linuxfoundation.org>
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

[ Upstream commit 9617f66867b09b326cc932416be2431c5b91c8d8 ]

When resetting, phy_state_machine may be accessing the phy through
firmware if the phy is not stopped or disconnected, which will
cause firemware timeout problem because the firmware is busy
processing the reset request.

This patch fixes it by disabling the phy when resetting.

Fixes: b940aeae0ed6 ("net: hns3: never send command queue message to IMP when reset")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3787,9 +3787,6 @@ static int hclge_ae_start(struct hnae3_h
 	/* reset tqp stats */
 	hclge_reset_tqp_stats(handle);
 
-	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
-		return 0;
-
 	ret = hclge_mac_start_phy(hdev);
 	if (ret)
 		return ret;
@@ -3806,8 +3803,10 @@ static void hclge_ae_stop(struct hnae3_h
 	del_timer_sync(&hdev->service_timer);
 	cancel_work_sync(&hdev->service_task);
 
-	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state)) {
+		hclge_mac_stop_phy(hdev);
 		return;
+	}
 
 	for (i = 0; i < vport->alloc_tqps; i++)
 		hclge_tqp_enable(hdev, i, 0, false);


