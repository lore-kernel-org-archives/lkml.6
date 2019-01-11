Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDABC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBCB21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217090;
	bh=DXZX5eEcjSxvHxq6kmq1A/jqOE7tM1kG/A2w4d5BVSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v96qj+XMSw8W7J6Vf8lHYg7W3ofCH6SRwhaHbXTvvI6xjfacZqeZJzzI7MXoBPGTV
	 py/DzDPTCHTZgFAYlBgQZ0OUELFVi2cskbjll0d6gFw2ujDK95zEnpzdZU20vFRpJa
	 E7bMoTDaCcB1tDc1OI5D3Z+bh8Qkf6elH/ww/1M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389186AbfAKOb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:31:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389170AbfAKObZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6CA12177B;
        Fri, 11 Jan 2019 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217085;
        bh=DXZX5eEcjSxvHxq6kmq1A/jqOE7tM1kG/A2w4d5BVSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QoN56IJVp1qSuCZ7LiYICnARHAwNOusP+UvAqziXyeppzyeIq0wl21Nk7beFvFKlG
         nkvKySz5FKDcCfCSvh1T+Zb6phPiPsG8e/rbAm8DduxvAQTPsHVJmRBo1KUR+8EN/h
         hriXBLYYfajPMLCTeLELYMQ0SzlcMKifHkS6Irig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 037/105] net: hns: Avoid net reset caused by pause frames storm
Date:   Fri, 11 Jan 2019 15:14:08 +0100
Message-Id: <20190111131106.301806697@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index bcd9aaba09b3..f28a639e8393 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1609,11 +1609,19 @@ static int hns_nic_net_stop(struct net_device *ndev)
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
@@ -2193,11 +2201,11 @@ static void hns_nic_service_task(struct work_struct *work)
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



