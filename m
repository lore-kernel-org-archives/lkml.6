Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A8FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BDA21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865049;
	bh=djTMATMsxsiwBVs7xASDGeeSscCIEAkEBmTslHBpks0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+1TJBRi2OE3+BOwxhFBLCfnhlznT67h5YHkT0BzQP30dhuZuKIBgnByUCrg/Glaz
	 FcaHfkqLaC7Z9T7vj4Ml/OQY37Ksgf3xT8xog5Q8wS1LT8eVeohyT1ZONpaXs7nA62
	 OffzlkI/o9jl08fKJQd9FZCsHQ4pFAcZ8zX5ktS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbeLZW52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:57:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbeLZW5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:57:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8740214D8;
        Wed, 26 Dec 2018 22:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865044;
        bh=djTMATMsxsiwBVs7xASDGeeSscCIEAkEBmTslHBpks0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLoc/2Ymn7/P3ctKM8E50Ylko0/Cw07swExtvWYL0C4NvG8TjgQetNXKt/l4i6di/
         buKb2AUW0JzUr7LUUCeMBMptGyKMZTqpT+xahiFcD0Hey+KxGIbMnx/AbRR6Iuj7v2
         MaB1r3dMfArhCTU7SXXgEg2jLTgS8hbByBrhmkUo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 13/21] net: hns: Avoid net reset caused by pause frames storm
Date:   Wed, 26 Dec 2018 17:54:51 -0500
Message-Id: <20181226225501.151365-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226225501.151365-1-sashal@kernel.org>
References: <20181226225501.151365-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit a57275d35576fdd89d8c771eedf1e7cf97e0dfa6 ]

There will be a large number of MAC pause frames on the net,
which caused tx timeout of net device. And then the net device
was reset to try to recover it. So that is not useful, and will
cause some other problems.

So need doubled ndev->watchdog_timeo if device watchdog occurred
until watchdog_timeo up to 40s and then try resetting to recover
it.

When collecting dfx information such as hardware registers when tx timeout.
Some registers for count were cleared when read. So need move this task
before update net state which also read the count registers.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 52d9b9947f47..ff68727cbe55 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1051,11 +1051,19 @@ static int hns_nic_net_stop(struct net_device *ndev)
 }
 
 static void hns_tx_timeout_reset(struct hns_nic_priv *priv);
+#define HNS_TX_TIMEO_LIMIT (40 * HZ)
 static void hns_nic_net_timeout(struct net_device *ndev)
 {
 	struct hns_nic_priv *priv = netdev_priv(ndev);
 
-	hns_tx_timeout_reset(priv);
+	if (ndev->watchdog_timeo < HNS_TX_TIMEO_LIMIT) {
+		ndev->watchdog_timeo *= 2;
+		netdev_info(ndev, "watchdog_timo changed to %d.\n",
+			    ndev->watchdog_timeo);
+	} else {
+		ndev->watchdog_timeo = HNS_NIC_TX_TIMEOUT;
+		hns_tx_timeout_reset(priv);
+	}
 }
 
 static int hns_nic_do_ioctl(struct net_device *netdev, struct ifreq *ifr,
@@ -1345,11 +1353,11 @@ static void hns_nic_service_task(struct work_struct *work)
 		= container_of(work, struct hns_nic_priv, service_task);
 	struct hnae_handle *h = priv->ae_handle;
 
+	hns_nic_reset_subtask(priv);
 	hns_nic_update_link_status(priv->netdev);
 	h->dev->ops->update_led_status(h);
 	hns_nic_update_stats(priv->netdev);
 
-	hns_nic_reset_subtask(priv);
 	hns_nic_service_event_complete(priv);
 }
 
-- 
2.19.1

