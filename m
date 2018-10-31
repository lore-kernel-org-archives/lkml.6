Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FEBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C634320664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPu4OIZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C634320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbeKAIhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729996AbeKAIIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40AE20840;
        Wed, 31 Oct 2018 23:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027318;
        bh=wQCunkimjRfJsWlVZJElw7eDKwQ5/GHTnupsgtHqQNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPu4OIZTV87ybKWi9qj70J09IPHVCYq01KFW8K/PknJfBbjmgZdxmqFg42p2HUGcR
         J5SzXahG+kn8GiShCRE1hwhW7dBv8Hc4M5K7NPQe3WH4/ANck13aaNQn1TvwuDY6LU
         8KkACdwyOpAEOIkFPL1MmPAqDVBxWB4GD89rZYGY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fuyun Liang <liangfuyun1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 048/126] net: hns3: Set STATE_DOWN bit of hdev state when stopping net
Date:   Wed, 31 Oct 2018 19:06:36 -0400
Message-Id: <20181031230754.29029-48-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

[ Upstream commit 2f7e489611bc685b8e00aba436032a8aac6cac57 ]

We clear STATE_DOWN bit of hdev state when starting net, but do not set
it again when stopping net. It causes that the net is down, but hdev state
is still up. STATE_DOWN bit of hdev state should be set when stopping net.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 15f2dd4824f4..73b04e11ec0b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3794,6 +3794,8 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 	struct hclge_dev *hdev = vport->back;
 	int i;
 
+	set_bit(HCLGE_STATE_DOWN, &hdev->state);
+
 	del_timer_sync(&hdev->service_timer);
 	cancel_work_sync(&hdev->service_task);
 	clear_bit(HCLGE_STATE_SERVICE_SCHED, &hdev->state);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 212c7bf5ea4a..6090a7cd83e1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1442,6 +1442,8 @@ static void hclgevf_ae_stop(struct hnae3_handle *handle)
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	int i, queue_id;
 
+	set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
+
 	for (i = 0; i < hdev->num_tqps; i++) {
 		/* Ring disable */
 		queue_id = hclgevf_get_queue_id(handle->kinfo.tqp[i]);
-- 
2.17.1

