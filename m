Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EF4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151A6218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865055;
	bh=Bpb0Tu6+7xvYdql3WtgYnVQ2/Ut01iSe4YjKmjYZKpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lm81LUCltomHVkalLJoO/p+RhrCflSunF+iMa+DOvaHnxg8LRuNWhV5vC+revvdqK
	 NSD6NEGq47hkblDcscDGSXTm2lUm30/ErTL2DuhL48JrpHnQf0ovjWKG3YASa4x1k/
	 +Tof55vgINK4tRjo8U8qfZNv6EVfKv+y7RYdogaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbeLZW5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbeLZW53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:57:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB7822070B;
        Wed, 26 Dec 2018 22:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865048;
        bh=Bpb0Tu6+7xvYdql3WtgYnVQ2/Ut01iSe4YjKmjYZKpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqoJu5ck/Ai/rBu46Pg3uNmnSLuqce6ZO6Pc2WM8JNEOmj2brCVvEx7E/7gjxxSCc
         sG50safR2vPHaSEJedDdIkAbmgyvSfFYE/MSa1HiqEs+c64bQYQohX0ZVU9CJpdCtw
         R0YC/GTazvfpZ2gy0XmQuUplqv9fO8C3iuGd0Ndo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 14/21] net: hns: Add mac pcs config when enable|disable mac
Date:   Wed, 26 Dec 2018 17:54:52 -0500
Message-Id: <20181226225501.151365-14-sashal@kernel.org>
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
index b8517b00e706..2a03f833e14d 100644
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
 
 /**
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
index 9ff2881f933d..259786e0c3be 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
@@ -506,6 +506,7 @@
 #define GMAC_LD_LINK_COUNTER_REG		0x01D0UL
 #define GMAC_LOOP_REG				0x01DCUL
 #define GMAC_RECV_CONTROL_REG			0x01E0UL
+#define GMAC_PCS_RX_EN_REG			0x01E4UL
 #define GMAC_VLAN_CODE_REG			0x01E8UL
 #define GMAC_RX_OVERRUN_CNT_REG			0x01ECUL
 #define GMAC_RX_LENGTHFIELD_ERR_CNT_REG		0x01F4UL
-- 
2.19.1

