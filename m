Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C025C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5C0206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5C0206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeK2Njv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:39:51 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:51328 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726954AbeK2Njv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:39:51 -0500
X-UUID: 239ddc64af494d2a95b9adaf15cbd510-20181129
X-UUID: 239ddc64af494d2a95b9adaf15cbd510-20181129
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2140613272; Thu, 29 Nov 2018 10:35:05 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Nov 2018 10:35:03 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Nov 2018 10:35:03 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 4/5] usb: mtu3: enable SETUPENDISR interrupt
Date:   Thu, 29 Nov 2018 10:34:35 +0800
Message-ID: <93297cec234cfa1c9bc733f9ba5ea933f9ce51f1.1543458321.git.chunfeng.yun@mediatek.com>
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

If the controller receives a new SETUP during SETUP data stage,
and will generate SETUPENDISR interrupt, the driver should abort
the current SETUP command and process the new one.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c       | 2 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 6 +++++-
 drivers/usb/mtu3/mtu3_hw_regs.h    | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 1ffc0bc31c1d..b6b20949d63a 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -484,7 +484,7 @@ void mtu3_ep0_setup(struct mtu3 *mtu)
 	mtu3_writel(mtu->mac_base, U3D_EP0CSR, csr);
 
 	/* Enable EP0 interrupt */
-	mtu3_writel(mtu->mac_base, U3D_EPIESR, EP0ISR);
+	mtu3_writel(mtu->mac_base, U3D_EPIESR, EP0ISR | SETUPENDISR);
 }
 
 static int mtu3_mem_alloc(struct mtu3 *mtu)
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 3c464d8ae023..7cb7ac980446 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -692,9 +692,13 @@ irqreturn_t mtu3_ep0_isr(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_EPISR, int_status); /* W1C */
 
 	/* only handle ep0's */
-	if (!(int_status & EP0ISR))
+	if (!(int_status & (EP0ISR | SETUPENDISR)))
 		return IRQ_NONE;
 
+	/* abort current SETUP, and process new one */
+	if (int_status & SETUPENDISR)
+		mtu->ep0_state = MU3D_EP0_STATE_SETUP;
+
 	csr = mtu3_readl(mbase, U3D_EP0CSR);
 
 	dev_dbg(mtu->dev, "%s csr=0x%x\n", __func__, csr);
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index a45bb253939f..d11fcd64c19d 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -104,6 +104,7 @@
 
 /* U3D_EPISR */
 #define EPRISR(x)		(BIT(16) << (x))
+#define SETUPENDISR		BIT(16)
 #define EPTISR(x)		(BIT(0) << (x))
 #define EP0ISR			BIT(0)
 
-- 
2.19.1

