Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30107C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBAF2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864079;
	bh=B0lbM9czQ9xAGdWMs+bnilcsJ+hxMJcvUGLnuxYu6tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fmcQ0WwjqTmms7oHPAnYVK0L527gQ0lzj8mudjG3NTyr4XOIh+zKxYmk/UMMIWI/Q
	 lrHj5rH2zRXmfrxwq+fJSAp7Jqr0OZU6BUlF0LD3SH3u0KDBoMPfDvmnQvCunbuDT3
	 hkji8ZQ7jGkvjeWHBhAstfpb4udjSnzGbsD2BJfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbeLZWlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbeLZWlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D8A32054F;
        Wed, 26 Dec 2018 22:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864074;
        bh=B0lbM9czQ9xAGdWMs+bnilcsJ+hxMJcvUGLnuxYu6tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9w8zaTW9wRzOYpQrlGjG700wL2yBkTvzBJkje+vlfoPYVONSJIO0CsEyCpQhZOgI
         xBx8SK8HSUvvfMaK+Iav+scxDUnpZ+9iWphldZr8/X60hNReD5ALa6BzZS5C2Dz2cA
         p9K6mP4oT+0Sv7HARzbs2wLAnpv+EYZYVi1XgSG4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 41/59] net: hns: Add mac pcs config when enable|disable mac
Date:   Wed, 26 Dec 2018 17:38:21 -0500
Message-Id: <20181226223839.150262-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 726ae5c9e5f0c18eca8ea5296b526242c3e89822 ]

In some case, when mac enable|disable and adjust link, may cause hard to
link(or abnormal) between mac and phy. This patch adds the code for rx PCS
to avoid this bug.

Disable the rx PCS when driver disable the gmac, and enable the rx PCS
when driver enable the mac.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c | 14 ++++++++++----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
index 8c7bc5cf193c..5e8930d02f50 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -67,11 +67,14 @@ static void hns_gmac_enable(void *mac_drv, enum mac_commom_mode mode)
 	struct mac_driver *drv = (struct mac_driver *)mac_drv;
 
 	/*enable GE rX/tX */
-	if ((mode == MAC_COMM_MODE_TX) || (mode == MAC_COMM_MODE_RX_AND_TX))
+	if (mode == MAC_COMM_MODE_TX || mode == MAC_COMM_MODE_RX_AND_TX)
 		dsaf_set_dev_bit(drv, GMAC_PORT_EN_REG, GMAC_PORT_TX_EN_B, 1);
 
-	if ((mode == MAC_COMM_MODE_RX) || (mode == MAC_COMM_MODE_RX_AND_TX))
+	if (mode == MAC_COMM_MODE_RX || mode == MAC_COMM_MODE_RX_AND_TX) {
+		/* enable rx pcs */
+		dsaf_set_dev_bit(drv, GMAC_PCS_RX_EN_REG, 0, 0);
 		dsaf_set_dev_bit(drv, GMAC_PORT_EN_REG, GMAC_PORT_RX_EN_B, 1);
+	}
 }
 
 static void hns_gmac_disable(void *mac_drv, enum mac_commom_mode mode)
@@ -79,11 +82,14 @@ static void hns_gmac_disable(void *mac_drv, enum mac_commom_mode mode)
 	struct mac_driver *drv = (struct mac_driver *)mac_drv;
 
 	/*disable GE rX/tX */
-	if ((mode == MAC_COMM_MODE_TX) || (mode == MAC_COMM_MODE_RX_AND_TX))
+	if (mode == MAC_COMM_MODE_TX || mode == MAC_COMM_MODE_RX_AND_TX)
 		dsaf_set_dev_bit(drv, GMAC_PORT_EN_REG, GMAC_PORT_TX_EN_B, 0);
 
-	if ((mode == MAC_COMM_MODE_RX) || (mode == MAC_COMM_MODE_RX_AND_TX))
+	if (mode == MAC_COMM_MODE_RX || mode == MAC_COMM_MODE_RX_AND_TX) {
+		/* disable rx pcs */
+		dsaf_set_dev_bit(drv, GMAC_PCS_RX_EN_REG, 0, 1);
 		dsaf_set_dev_bit(drv, GMAC_PORT_EN_REG, GMAC_PORT_RX_EN_B, 0);
+	}
 }
 
 /* hns_gmac_get_en - get port enable
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
index 5ae3d017ddbc..ae97b203f73b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
@@ -534,6 +534,7 @@
 #define GMAC_LD_LINK_COUNTER_REG		0x01D0UL
 #define GMAC_LOOP_REG				0x01DCUL
 #define GMAC_RECV_CONTROL_REG			0x01E0UL
+#define GMAC_PCS_RX_EN_REG			0x01E4UL
 #define GMAC_VLAN_CODE_REG			0x01E8UL
 #define GMAC_RX_OVERRUN_CNT_REG			0x01ECUL
 #define GMAC_RX_LENGTHFIELD_ERR_CNT_REG		0x01F4UL
-- 
2.19.1

