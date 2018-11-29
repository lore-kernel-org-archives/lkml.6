Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D85C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0FB206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0FB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeK2NjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:39:05 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:44553 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727619AbeK2NjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:39:04 -0500
X-UUID: e9ef9038344143468c31332f1e8b427b-20181129
X-UUID: e9ef9038344143468c31332f1e8b427b-20181129
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 273399762; Thu, 29 Nov 2018 10:35:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Nov 2018 10:35:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Nov 2018 10:34:53 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/5] usb: mtu3: remove QMU checksum
Date:   Thu, 29 Nov 2018 10:34:32 +0800
Message-ID: <e178546b79c3d602736a0db2cbfd76f7588e4022.1543458319.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMU checksum calculation is redundant, mostly used by debug,
so remove it here.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c |  2 --
 drivers/usb/mtu3/mtu3_qmu.c  | 26 --------------------------
 2 files changed, 28 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index ae70b9bfd797..3dce5fd9887d 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -592,8 +592,6 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 	mtu3_clrbits(mbase, U3D_LINK_RESET_INFO, WTCHRP_MSK);
 	/* U2/U3 detected by HW */
 	mtu3_writel(mbase, U3D_DEVICE_CONF, 0);
-	/* enable QMU 16B checksum */
-	mtu3_setbits(mbase, U3D_QCR0, QMU_CS16B_EN);
 	/* vbus detected by HW */
 	mtu3_clrbits(mbase, U3D_MISC_CTRL, VBUS_FRC_EN | VBUS_ON);
 }
diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index ff62ba232177..73ac042c45a8 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -154,27 +154,6 @@ void mtu3_gpd_ring_free(struct mtu3_ep *mep)
 	memset(ring, 0, sizeof(*ring));
 }
 
-/*
- * calculate check sum of a gpd or bd
- * add "noinline" and "mb" to prevent wrong calculation
- */
-static noinline u8 qmu_calc_checksum(u8 *data)
-{
-	u8 chksum = 0;
-	int i;
-
-	data[1] = 0x0;  /* set checksum to 0 */
-
-	mb();	/* ensure the gpd/bd is really up-to-date */
-	for (i = 0; i < QMU_CHECKSUM_LEN; i++)
-		chksum += data[i];
-
-	/* Default: HWO=1, @flag[bit0] */
-	chksum += 1;
-
-	return 0xFF - chksum;
-}
-
 void mtu3_qmu_resume(struct mtu3_ep *mep)
 {
 	struct mtu3 *mtu = mep->mtu;
@@ -260,7 +239,6 @@ static int mtu3_prepare_tx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	if (req->zero)
 		gpd->ext_flag |= GPD_EXT_FLAG_ZLP;
 
-	gpd->chksum = qmu_calc_checksum((u8 *)gpd);
 	gpd->flag |= GPD_FLAGS_HWO;
 
 	mreq->gpd = gpd;
@@ -295,7 +273,6 @@ static int mtu3_prepare_rx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	gpd->next_gpd = cpu_to_le32(lower_32_bits(enq_dma));
 	ext_addr |= GPD_EXT_NGP(upper_32_bits(enq_dma));
 	gpd->rx_ext_addr = cpu_to_le16(ext_addr);
-	gpd->chksum = qmu_calc_checksum((u8 *)gpd);
 	gpd->flag |= GPD_FLAGS_HWO;
 
 	mreq->gpd = gpd;
@@ -323,7 +300,6 @@ int mtu3_qmu_start(struct mtu3_ep *mep)
 		/* set QMU start address */
 		write_txq_start_addr(mbase, epnum, ring->dma);
 		mtu3_setbits(mbase, MU3D_EP_TXCR0(epnum), TX_DMAREQEN);
-		mtu3_setbits(mbase, U3D_QCR0, QMU_TX_CS_EN(epnum));
 		/* send zero length packet according to ZLP flag in GPD */
 		mtu3_setbits(mbase, U3D_QCR1, QMU_TX_ZLP(epnum));
 		mtu3_writel(mbase, U3D_TQERRIESR0,
@@ -338,7 +314,6 @@ int mtu3_qmu_start(struct mtu3_ep *mep)
 	} else {
 		write_rxq_start_addr(mbase, epnum, ring->dma);
 		mtu3_setbits(mbase, MU3D_EP_RXCR0(epnum), RX_DMAREQEN);
-		mtu3_setbits(mbase, U3D_QCR0, QMU_RX_CS_EN(epnum));
 		/* don't expect ZLP */
 		mtu3_clrbits(mbase, U3D_QCR3, QMU_RX_ZLP(epnum));
 		/* move to next GPD when receive ZLP */
@@ -441,7 +416,6 @@ static void qmu_tx_zlp_error_handler(struct mtu3 *mtu, u8 epnum)
 
 	/* by pass the current GDP */
 	gpd_current->flag |= GPD_FLAGS_BPS;
-	gpd_current->chksum = qmu_calc_checksum((u8 *)gpd_current);
 	gpd_current->flag |= GPD_FLAGS_HWO;
 
 	/*enable DMAREQEN, switch back to QMU mode */
-- 
2.19.1

