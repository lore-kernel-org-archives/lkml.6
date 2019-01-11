Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04856C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC262133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217100;
	bh=6hfM0QvCVRM246k6i6h8NC6/FU9QBms7zSK00ym5LU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gdAlqGvY7o0Habi9b5kr/c9ahVispNZdSE0IKgNmEr7eVapc/SrwPs0M/vGQkcqu3
	 rRQ05+4Mgr7Vm23b0AyhhSrxMguufQhgRh3PF9+gDFzHyX0us5es2iW6cC882Wmr7a
	 5VS2X+t5jWSyYoqGwtYXhztyoBL292d1BmdWlVkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbfAKObk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:51172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389190AbfAKObb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154BF2133F;
        Fri, 11 Jan 2019 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217090;
        bh=6hfM0QvCVRM246k6i6h8NC6/FU9QBms7zSK00ym5LU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1ViCkoeVRlGMn0lBMXDyzKcS2QbPATNrHaQ61NDVRuwY1pTtuizDtkC1D+vF4NIL
         Sj95B0qT9XvV4W/MxrJ3yQZA4LoLveUYKq8er1qvyQ23t4hnXI9Xz6Tsk3LgpgJvSM
         rMxyH5EAflP7VAGSxVjkT7zQ/7/1vTSaqQWATa/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 039/105] net: hns: Add mac pcs config when enable|disable mac
Date:   Fri, 11 Jan 2019 15:14:10 +0100
Message-Id: <20190111131106.464502562@linuxfoundation.org>
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



