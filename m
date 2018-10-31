Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB461C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42CA20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dq1z9QQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42CA20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbeKAIIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbeKAIIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11C620821;
        Wed, 31 Oct 2018 23:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027317;
        bh=6VQHARJjCbGbCwGJ182QyQzz46ecWe+REzMowYa1mkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dq1z9QQ5vT6naKP/SUf+NbrQo76+Mj03dIk2NY622cYfftVw3HNAMlFq1/2RqpGc7
         6wHK1FnN1FLwaW3JhcWySctyXMHHBYVXjJD4lT7Jc6tLN79Z/GXVZA8/TIGhEVW81Y
         SppCzVF1wrftII4027dDiA7QzHb2ZPa6Sh5q/s2c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peng Li <lipeng321@huawei.com>,
        Fuyun Liang <liangfuyun1@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 047/126] net: hns3: Check hdev state when getting link status
Date:   Wed, 31 Oct 2018 19:06:35 -0400
Message-Id: <20181031230754.29029-47-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
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
index 8179ecb089b7..15f2dd4824f4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2398,6 +2398,9 @@ static int hclge_get_mac_phy_link(struct hclge_dev *hdev)
 	int mac_state;
 	int link_stat;
 
+	if (test_bit(HCLGE_STATE_DOWN, &hdev->state))
+		return 0;
+
 	mac_state = hclge_get_mac_link_status(hdev);
 
 	if (hdev->hw.mac.phydev) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 12aa1f1b99ef..212c7bf5ea4a 100644
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

