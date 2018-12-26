Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66585C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3759A218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864871;
	bh=ieJ5D2ufdi2fWWnnZ+jrugG5gOXnRwaYKa+6o8yK5cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IS2DBgvie8YJuw2BqoOv8i916uUAsyHZStrYufv5Ze+3LDO3WQ0mRPObVw3BYgNAO
	 gUOtSSnUR0o/f7FiVgcttg6hodMmQPU7gK6hd3IcTpiP8oA17Vfq9E3BFU4Ouxrwgh
	 JcEFSm2ZqOkc9Fa0JfETzda9ZPEdLtFn6El/QVOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeLZWya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:54:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730100AbeLZWy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67AA214D8;
        Wed, 26 Dec 2018 22:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864866;
        bh=ieJ5D2ufdi2fWWnnZ+jrugG5gOXnRwaYKa+6o8yK5cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IbkyY5HXpvS9cpMeOofXYTk5fQjBNQ9vp1KOIF1DrUGyw/0nRlcUc+JAcxioX4Ffs
         aDtMF13uqHmemYmdT+ZMg+5EnOjCYuIQncGC/2OJUQv0pqIrJpixQDqLI/WEhkoD2G
         gNA5OFE0OtnSYYFQCnQzgMFjKhGDF2dD5ZedmHkM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 21/35] net: hns: All ports can not work when insmod hns ko after rmmod.
Date:   Wed, 26 Dec 2018 17:41:28 -0500
Message-Id: <20181226224142.150866-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 308c6cafde0147616da45e3a928adae55c428deb ]

There are two test cases:
1. Remove the 4 modules:hns_enet_drv/hns_dsaf/hnae/hns_mdio,
   and install them again, must use "ifconfig down/ifconfig up"
   command pair to bring port to work.

   This patch calls phy_stop function when init phy to fix this bug.

2. Remove the 2 modules:hns_enet_drv/hns_dsaf, and install them again,
   all ports can not use anymore, because of the phy devices register
   failed(phy devices already exists).

   Phy devices are registered when hns_dsaf installed, this patch
   removes them when hns_dsaf removed.

The two cases are sometimes related, fixing the second case also requires
fixing the first case, so fix them together.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 15 +++++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_enet.c     |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index ec8c738af726..b6429be2b8bd 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -724,6 +724,17 @@ static void hns_mac_register_phy(struct hns_mac_cb *mac_cb)
 			mac_cb->mac_id, addr);
 }
 
+static void hns_mac_remove_phydev(struct hns_mac_cb *mac_cb)
+{
+	if (!to_acpi_device_node(mac_cb->fw_port) || !mac_cb->phy_dev)
+		return;
+
+	phy_device_remove(mac_cb->phy_dev);
+	phy_device_free(mac_cb->phy_dev);
+
+	mac_cb->phy_dev = NULL;
+}
+
 #define MAC_MEDIA_TYPE_MAX_LEN		16
 
 static const struct {
@@ -1030,7 +1041,11 @@ void hns_mac_uninit(struct dsaf_device *dsaf_dev)
 	int max_port_num = hns_mac_get_max_port_num(dsaf_dev);
 
 	for (i = 0; i < max_port_num; i++) {
+		if (!dsaf_dev->mac_cb[i])
+			continue;
+
 		dsaf_dev->misc_op->cpld_reset_led(dsaf_dev->mac_cb[i]);
+		hns_mac_remove_phydev(dsaf_dev->mac_cb[i]);
 		dsaf_dev->mac_cb[i] = NULL;
 	}
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 92ed6534ceae..12d90c04931b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1079,6 +1079,9 @@ int hns_nic_init_phy(struct net_device *ndev, struct hnae_handle *h)
 	if (h->phy_if == PHY_INTERFACE_MODE_XGMII)
 		phy_dev->autoneg = false;
 
+	if (h->phy_if == PHY_INTERFACE_MODE_SGMII)
+		phy_stop(phy_dev);
+
 	return 0;
 }
 
-- 
2.19.1

