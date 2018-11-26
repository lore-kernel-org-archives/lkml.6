Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D224C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B542089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wO+ZFFZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B542089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbeKZV5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeKZV5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EF322089F;
        Mon, 26 Nov 2018 11:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230195;
        bh=VW7ZsZiVIR638kWftugTZnYF8ORwlHJuGtU78F7RuUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wO+ZFFZGlwfNQCa84FvlsB8U4dfdNLZpbnsCCWORAXphxN5aiqlgwW+e50zp8D2nz
         loHdeer47lGMRcziZZxr2JbUagjgpnANx0oHdAKd+4BsC2KvN4q4Nw2XHz0qBrR83o
         F9itlJ1kWkayT8LL4LLx4cU63ZloTT40j3eBySH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 010/118] net: hns3: bugfix for the initialization of command queues spin lock
Date:   Mon, 26 Nov 2018 11:50:04 +0100
Message-Id: <20181126105100.247930442@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ac13cb2b168e..68026a5ad7e7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -304,6 +304,10 @@ int hclge_cmd_queue_init(struct hclge_dev *hdev)
 {
 	int ret;
 
+	/* Setup the lock for command queue */
+	spin_lock_init(&hdev->hw.cmq.csq.lock);
+	spin_lock_init(&hdev->hw.cmq.crq.lock);
+
 	/* Setup the queue entries for use cmd queue */
 	hdev->hw.cmq.csq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
 	hdev->hw.cmq.crq.desc_num = HCLGE_NIC_CMQ_DESC_NUM;
@@ -337,18 +341,20 @@ int hclge_cmd_init(struct hclge_dev *hdev)
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
 	clear_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
 
+	spin_unlock_bh(&hdev->hw.cmq.crq.lock);
+	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
+
 	ret = hclge_cmd_query_firmware_version(&hdev->hw, &version);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
-- 
2.17.1



