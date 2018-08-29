Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9586C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A4B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A4B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeH2Gbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:31:51 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20892 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726188AbeH2Gbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:31:51 -0400
X-UUID: db866b4374dc446f8ada6e3654d452d3-20180829
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2073692573; Wed, 29 Aug 2018 10:37:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 29 Aug 2018 10:37:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 29 Aug 2018 10:37:09 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] usb: mtu3: fix error of xhci port id when enable U3 dual role
Date:   Wed, 29 Aug 2018 10:36:49 +0800
Message-ID: <c4279eccff765006b78f87bf3c8c9ac94a06c04d.1535509922.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dual role mode is enabled, when switch u3port0 to device mode,
it will affect port id calculation of host(xHCI), specially when
host supports multi U2 ports or U3 ports, so need enable its dual
role mode, and fix it here.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c    | 6 +++++-
 drivers/usb/mtu3/mtu3_hw_regs.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index eecfd06..d045d84 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -107,8 +107,12 @@ static int mtu3_device_enable(struct mtu3 *mtu)
 		(SSUSB_U2_PORT_DIS | SSUSB_U2_PORT_PDN |
 		SSUSB_U2_PORT_HOST_SEL));
 
-	if (mtu->ssusb->dr_mode == USB_DR_MODE_OTG)
+	if (mtu->ssusb->dr_mode == USB_DR_MODE_OTG) {
 		mtu3_setbits(ibase, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_OTG_SEL);
+		if (mtu->is_u3_ip)
+			mtu3_setbits(ibase, SSUSB_U3_CTRL(0),
+				     SSUSB_U3_PORT_DUAL_MODE);
+	}
 
 	return ssusb_check_clocks(mtu->ssusb, check_clk);
 }
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index 6ee3714..a45bb25 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -459,6 +459,7 @@
 
 /* U3D_SSUSB_U3_CTRL_0P */
 #define SSUSB_U3_PORT_SSP_SPEED	BIT(9)
+#define SSUSB_U3_PORT_DUAL_MODE	BIT(7)
 #define SSUSB_U3_PORT_HOST_SEL		BIT(2)
 #define SSUSB_U3_PORT_PDN		BIT(1)
 #define SSUSB_U3_PORT_DIS		BIT(0)
-- 
1.9.1

