Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AED2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DB52054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863870;
	bh=TAj/Eybiew2CSzZRdVsqZ/MI16jR5U76FF29bFYtuOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D2ETmWgSpsfg+mr6t0nKqa0EGdmBYFy1G7PPny924Nz//HWd/gnAY9ZR26rh0Nd/1
	 X3ICl+xFbwbj0KhbYSg6A9VeJVBRHYQcjtXWhiPOLLcu60szt/hqYvzaEivVI0Nl6f
	 f41jd/8YwIaKK0m6LL8satuNXxkiVU459T2UXVtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeLZWhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbeLZWhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D0242054F;
        Wed, 26 Dec 2018 22:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863866;
        bh=TAj/Eybiew2CSzZRdVsqZ/MI16jR5U76FF29bFYtuOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwUBBPZDwacgEFz3o2YSM8jLVubY2zq9Jh46iRd9H54XJDj0WoPFLlRQz9Cxq/qnK
         3/tkmnJ7oRxWmeoIJPfDPBLUCkJUUs2Vd7QhXOBUwxWC7OeMbJs+2gyZMIhquGFII1
         EDp+n/zvqDQYG0amAsv9Ks/L/rYXjhIpM16ppjzc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 62/97] net: hns: Add mac pcs config when enable|disable mac
Date:   Wed, 26 Dec 2018 17:35:22 -0500
Message-Id: <20181226223557.149329-62-sashal@kernel.org>
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
index 09e4061d1fa6..aa2c25d7a61d 100644
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
index f171d11b9b44..b9733b0b8482 100644
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

