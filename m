Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD3EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080412054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863850;
	bh=cwTU9thINR0TdpCFKtCL21+GE4EJA4dB9DtIRvZeE58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ggk6GknGFY2Zr2K+ZH243aTcGdfD7y+zBGPi/pYdRpdMe6H9K7i+PgJdi1JgERmqm
	 FNAamR5tlCcJ7owPcnUZIs3HWlvFif+MwmWWgM9ei/7+A6xN7NOYse9UkGD48KJzTM
	 zO3ngNsDEz2j9QY6lw6ymHGVYqBNh972UNd7o3po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeLZWh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:37:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbeLZWh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B622054F;
        Wed, 26 Dec 2018 22:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863845;
        bh=cwTU9thINR0TdpCFKtCL21+GE4EJA4dB9DtIRvZeE58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=edQN4ESmizHQOjLUEelEczW/gzVIn2v6PS9zDBXXcbioA+PFgwGWeK8r190FM8VKj
         IZJtSHy57hBsCsCGc3dgnO+JJC2ALzKAhKCdjsn8rPV5Vn9wgWly+SkRjLRzIRNCEu
         RhPsE9nKUczLwR0FwNjNYmap9NU/lbfbIMb0a1rk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 55/97] net: hns: All ports can not work when insmod hns ko after rmmod.
Date:   Wed, 26 Dec 2018 17:35:15 -0500
Message-Id: <20181226223557.149329-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
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
index 6ed6f142427e..cfdc92de9dc0 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -778,6 +778,17 @@ static int hns_mac_register_phy(struct hns_mac_cb *mac_cb)
 	return rc;
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
@@ -1117,7 +1128,11 @@ void hns_mac_uninit(struct dsaf_device *dsaf_dev)
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
index 28e907831b0e..c205a0e4b64b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1186,6 +1186,9 @@ int hns_nic_init_phy(struct net_device *ndev, struct hnae_handle *h)
 	if (h->phy_if == PHY_INTERFACE_MODE_XGMII)
 		phy_dev->autoneg = false;
 
+	if (h->phy_if == PHY_INTERFACE_MODE_SGMII)
+		phy_stop(phy_dev);
+
 	return 0;
 }
 
-- 
2.19.1

