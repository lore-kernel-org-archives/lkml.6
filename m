Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82FBC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6B922507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq5lfuiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6B922507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbeKMPqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:46:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeKMPqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:46:34 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 976772250F;
        Tue, 13 Nov 2018 05:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088206;
        bh=OSqQDjCyr8VHPno/ZYnDH9ISfZGCQcowfFcFa2+S+vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kq5lfuiHlsCUww9roDBiCal1HoY4aDDlRH2jwBZlIkzNBZiB1unm5nB+RJ6H337F/
         DnD5pgvFKHOBp4s2/c+1lyplWILiTP9suJIFrl3GqbxcNrJQqxc1bFZ5Y0ZFZ/RtNo
         WqA+nz2jdTWmQBhdTgaYuTvIskAXEWDNrqJxZraI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/44] net: hns3: bugfix for handling mailbox while the command queue reinitialized
Date:   Tue, 13 Nov 2018 00:49:16 -0500
Message-Id: <20181113054950.77898-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113054950.77898-1-sashal@kernel.org>
References: <20181113054950.77898-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 3c88ed1d798da355859ca083d3884a16ce0841f2 ]

In a multi-core machine, the mailbox service and reset service
will be executed at the same time. The reset service will re-initialize
the command queue, before that, the mailbox handler can only get some
invalid messages.

The HCLGE_STATE_CMD_DISABLE flag means that the command queue is not
available and needs to be reinitialized. Therefore, when the mailbox
handler recognizes this flag, it should not process the command.

Fixes: dde1a86e93ca ("net: hns3: Add mailbox support to PF driver")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index f34851c91eb3..e08e82020402 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -458,6 +458,12 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 
 	/* handle all the mailbox requests in the queue */
 	while (!hclge_cmd_crq_empty(&hdev->hw)) {
+		if (test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state)) {
+			dev_warn(&hdev->pdev->dev,
+				 "command queue needs re-initializing\n");
+			return;
+		}
+
 		desc = &crq->desc[crq->next_to_use];
 		req = (struct hclge_mbx_vf_to_pf_cmd *)desc->data;
 
-- 
2.17.1

