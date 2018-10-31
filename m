Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A23ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6115020664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="barcdA2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6115020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeKAIsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbeKAIG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6231420821;
        Wed, 31 Oct 2018 23:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027207;
        bh=TUnXhI48oaPfDy/oQ4SSiNhnBxSo98XCW7v+gTXWXkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=barcdA2mqeU5M+v5l4pSKbg5N4UZar5SJMPVUxt9s7lkrEo1YONOfrX1p65wkpoWr
         +jRyVeuG+vv/dy9ugIgXWEm/qdDWD4yfkGw1xEAP6uXI598MyIQ5DQ1ikiMQeXHz2W
         +OXImbC9Ki9yP1Ak+BMsxLWn/uLY2lt60sH7XukI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 070/146] net: hns3: Fix ping exited problem when doing lp selftest
Date:   Wed, 31 Oct 2018 19:04:25 -0400
Message-Id: <20181031230541.28822-70-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 3f8601f0f5716c4e63a9f215bbc581df42859d61 ]

When ping is runnig and user executes the loopback selftest, the
ping cmd will stop and exit.

This patch fixes it by using the hns3_nic_net_open/stop to offline
the netdev when doing loopback selftest.

Fixes: c39c4d98dc65 ("net: hns3: Add mac loopback selftest support in hns3 driver")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index f70ee6910ee2..9684ad015c42 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -309,7 +309,7 @@ static void hns3_self_test(struct net_device *ndev,
 			h->flags & HNAE3_SUPPORT_SERDES_LOOPBACK;
 
 	if (if_running)
-		dev_close(ndev);
+		ndev->netdev_ops->ndo_stop(ndev);
 
 #if IS_ENABLED(CONFIG_VLAN_8021Q)
 	/* Disable the vlan filter for selftest does not support it */
@@ -347,7 +347,7 @@ static void hns3_self_test(struct net_device *ndev,
 #endif
 
 	if (if_running)
-		dev_open(ndev);
+		ndev->netdev_ops->ndo_open(ndev);
 }
 
 static int hns3_get_sset_count(struct net_device *netdev, int stringset)
-- 
2.17.1

