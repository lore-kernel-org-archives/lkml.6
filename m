Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06807C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B25206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B25206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeK2Ni7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:38:59 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40516 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726954AbeK2Ni7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:38:59 -0500
X-UUID: b311b2ecb8634e0cbec4a459f1f20282-20181129
X-UUID: b311b2ecb8634e0cbec4a459f1f20282-20181129
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 435054198; Thu, 29 Nov 2018 10:35:03 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Nov 2018 10:35:01 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Nov 2018 10:35:00 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/5] usb: mtu3: enable hardware remote wakeup from L1 automatically
Date:   Thu, 29 Nov 2018 10:34:33 +0800
Message-ID: <2105ae1c2fede0fd1923e2fdb58ade7b3aa678f6.1543458320.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e178546b79c3d602736a0db2cbfd76f7588e4022.1543458319.git.chunfeng.yun@mediatek.com>
References: <e178546b79c3d602736a0db2cbfd76f7588e4022.1543458319.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable hardware remote wakeup from L1 automatically based on the FIFO
status, instead of manual way.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 3dce5fd9887d..981e4e8c5c13 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -180,7 +180,7 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_LV1IESR, value);
 
 	/* Enable U2 common USB interrupts */
-	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR | LPM_RESUME_INTR;
+	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR;
 	mtu3_writel(mbase, U3D_COMMON_USB_INTR_ENABLE, value);
 
 	if (mtu->is_u3_ip) {
@@ -594,6 +594,8 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_DEVICE_CONF, 0);
 	/* vbus detected by HW */
 	mtu3_clrbits(mbase, U3D_MISC_CTRL, VBUS_FRC_EN | VBUS_ON);
+	/* enable automatical HWRW from L1 */
+	mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, LPM_HRWE);
 }
 
 static irqreturn_t mtu3_link_isr(struct mtu3 *mtu)
@@ -706,12 +708,6 @@ static irqreturn_t mtu3_u2_common_isr(struct mtu3 *mtu)
 	if (u2comm & RESET_INTR)
 		mtu3_gadget_reset(mtu);
 
-	if (u2comm & LPM_RESUME_INTR) {
-		if (!(mtu3_readl(mbase, U3D_POWER_MANAGEMENT) & LPM_HRWE))
-			mtu3_setbits(mbase, U3D_USB20_MISC_CONTROL,
-				     LPM_U3_ACK_EN);
-	}
-
 	return IRQ_HANDLED;
 }
 
-- 
2.19.1

