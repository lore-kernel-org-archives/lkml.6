Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D70AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D3F2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xq9K0vBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D3F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeKAIGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbeKAIGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795F920838;
        Wed, 31 Oct 2018 23:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027192;
        bh=TTjCUnPJDGuhmRb2xYi40FY4zM+khh+9KWaT41NpfP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xq9K0vBpLpwym8xjXy14TM29Q34lm8IzNbYoWxRK4lm5r+Z5B2uqYOyKr5CnNsb2g
         gl/CTdetmHXfgi9LjoNpav8x9KZJAjzkNm5mOMrN0YDeEe43qXFvU/Aeiq/glhHVPL
         SDsxc44IkvGF3K51Wz1hZm38+x66HhXU3qX1dKRI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peng Li <lipeng321@huawei.com>,
        Fuyun Liang <liangfuyun1@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 055/146] net: hns3: Check hdev state when getting link status
Date:   Wed, 31 Oct 2018 19:04:10 -0400
Message-Id: <20181031230541.28822-55-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

[ Upstream commit 582d37bbb613b8ad86bf82845d3a74a02a5a0fa1 ]

By default, HW link status is up. If hclge_update_link_status is called
before net up, driver will print "link up". It is not suitable. hdev
state check is needed when getting link status.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 3 +++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 023910abc831..0c64089c914f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2362,6 +2362,9 @@ static int hclge_get_mac_phy_link(struct hclge_dev *hdev)
 	int mac_state;
 	int link_stat;
 
+	if (test_bit(HCLGE_STATE_DOWN, &hdev->state))
+		return 0;
+
 	mac_state = hclge_get_mac_link_status(hdev);
 
 	if (hdev->hw.mac.phydev) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 9c0091f2addf..d78064bb718a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -299,6 +299,9 @@ void hclgevf_update_link_status(struct hclgevf_dev *hdev, int link_state)
 
 	client = handle->client;
 
+	link_state =
+		test_bit(HCLGEVF_STATE_DOWN, &hdev->state) ? 0 : link_state;
+
 	if (link_state != hdev->hw.mac.link) {
 		client->ops->link_status_change(handle, !!link_state);
 		hdev->hw.mac.link = link_state;
-- 
2.17.1

