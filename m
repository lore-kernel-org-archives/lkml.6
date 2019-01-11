Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B3C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FD021841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216894;
	bh=9yZzEDH6AISU5BVVWPxjPOGMXqwORxtAXsLEnHe+39g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ypI6xJeXC9z/jE+fUAwZC09danF4TnJItgORuqEnR4v8ZMfs6/k+8lKHu07jwyyV
	 deJlnHxmmI7yPa/f/PqCnA34yg0HACCP4zh+pOIqTxX5gsVtI7CUP/ycd6asp2jqiS
	 Pm2VgHASjdojsLY/VQW2O7naCOUg8UrYcy5H8UX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388481AbfAKO2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:28:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388464AbfAKO2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:28:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 070FF2063F;
        Fri, 11 Jan 2019 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216887;
        bh=9yZzEDH6AISU5BVVWPxjPOGMXqwORxtAXsLEnHe+39g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkE3Tmg5y7kvSKM0tCVdAmJdnLUBMcZJVKYXk8nroCBvB8iOh0i4D4A17qwx9RTUa
         X36mexwU/27ovlhot+jq5ETMlxHGYN6kSffSTUnkWTlss2A389hg0d3LGU9vaATi+A
         tMzYz0KWY6Dd7JPksMD2atcuSYtYtwKQBh5vBDwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 20/63] net: hns: All ports can not work when insmod hns ko after rmmod.
Date:   Fri, 11 Jan 2019 15:14:23 +0100
Message-Id: <20190111131049.084813255@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



