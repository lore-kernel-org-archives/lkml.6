Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFF6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A51620862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A51620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408060AbeHATUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:20:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52954 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436605AbeHATSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:40 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4D7B4F1F;
        Wed,  1 Aug 2018 16:55:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 059/336] net: hns3: Fix for service_task not running problem after resetting
Date:   Wed,  1 Aug 2018 18:46:34 +0200
Message-Id: <20180801165031.332665181@linuxfoundation.org>
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

[ Upstream commit f5be79673fc4c925708c99ec37d77e0a2c3cd30b ]

When hclge_ae_stop is called during resetting, it will cancel the
service_task by calling cancel_work_sync, which may cause the
service_task to exit without clearing HCLGE_STATE_SERVICE_SCHED
bit. If this happens, the service_task will never run again.

This patch fixes this problem by clearing it after calling
cancel_work_sync in hclge_ae_stop.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |    1 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3802,6 +3802,7 @@ static void hclge_ae_stop(struct hnae3_h
 
 	del_timer_sync(&hdev->service_timer);
 	cancel_work_sync(&hdev->service_task);
+	clear_bit(HCLGE_STATE_SERVICE_SCHED, &hdev->state);
 
 	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state)) {
 		hclge_mac_stop_phy(hdev);
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1323,6 +1323,7 @@ static void hclgevf_ae_stop(struct hnae3
 	hclgevf_reset_tqp_stats(handle);
 	del_timer_sync(&hdev->service_timer);
 	cancel_work_sync(&hdev->service_task);
+	clear_bit(HCLGEVF_STATE_SERVICE_SCHED, &hdev->state);
 	hclgevf_update_link_status(hdev, 0);
 }
 


