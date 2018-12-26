Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93531218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864934;
	bh=S0NC9yGQhGIGmCatCt8I4mQimRdefcd9swjNVB18ce4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=urxM9sCWgJsjL6M9i19WePhh5Sh2+Qxz+XwDemtCkzWhKylb3psLhkCzCLODr89lD
	 mgid4CbVoOyXgkVlnxjqkghNAQp7fjdfX5H17UMp8rLvdGhbYb0cgADIkl95YMOgze
	 ZSqzTgFB3lBO2lraaGkKCFvSXU6aXskq65mpn658=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbeLZWyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:54:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbeLZWyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 318B6214D8;
        Wed, 26 Dec 2018 22:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864888;
        bh=S0NC9yGQhGIGmCatCt8I4mQimRdefcd9swjNVB18ce4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0AzNYd/rovW7J/mw/dPV06J7VhZN0KwFWkSfkC/OHXfb8Ql2g3Lu4SKMGuTStUag
         iueE6gW/5aqUUj4ZxV8+Zx28MuGi0aqvgdXn7lGTGPd+3M9ntIrgFfY4bWJlBG+cIV
         alagmEoJM8wYeLlE+aC0VtnILENIb/jzpzmpWgBE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 28/35] net: hns: Add mac pcs config when enable|disable mac
Date:   Wed, 26 Dec 2018 17:41:35 -0500
Message-Id: <20181226224142.150866-28-sashal@kernel.org>
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
index 02a03bccde7b..95967470d423 100644
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
index bf0c5a60f5f1..6f3ec2f1535d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
@@ -528,6 +528,7 @@
 #define GMAC_LD_LINK_COUNTER_REG		0x01D0UL
 #define GMAC_LOOP_REG				0x01DCUL
 #define GMAC_RECV_CONTROL_REG			0x01E0UL
+#define GMAC_PCS_RX_EN_REG			0x01E4UL
 #define GMAC_VLAN_CODE_REG			0x01E8UL
 #define GMAC_RX_OVERRUN_CNT_REG			0x01ECUL
 #define GMAC_RX_LENGTHFIELD_ERR_CNT_REG		0x01F4UL
-- 
2.19.1

