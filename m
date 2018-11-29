Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B549A206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B549A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeK2NkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:40:18 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:58308 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727026AbeK2NkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:40:18 -0500
X-UUID: e29afa4e0c6f4de180d226a13561d01f-20181129
X-UUID: e29afa4e0c6f4de180d226a13561d01f-20181129
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 141887268; Thu, 29 Nov 2018 10:35:06 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Nov 2018 10:35:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Nov 2018 10:35:04 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 5/5] usb: mtu3: clear SOFTCONN when clear USB3_EN if work as HS mode
Date:   Thu, 29 Nov 2018 10:34:36 +0800
Message-ID: <8b9d260a3aebc4ce4aaf1b87ef3c2e83a7c55355.1543458321.git.chunfeng.yun@mediatek.com>
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

When the controller supports SS mode, but works as HS mode, the
SOFTCONN will not be cleared automatically when clear USB3_EN
by default, this cause an issue that can't disconnect from host,
so clear SOFTCONN when clear USB3_EN when the class driver want
to disable the D+ pullup.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c    | 2 ++
 drivers/usb/mtu3/mtu3_hw_regs.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index b6b20949d63a..4fee200795a5 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -586,6 +586,8 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 		mtu3_clrbits(mbase, U3D_LTSSM_CTRL, SOFT_U3_EXIT_EN);
 		/* automatically build U2 link when U3 detect fail */
 		mtu3_setbits(mbase, U3D_USB2_TEST_MODE, U2U3_AUTO_SWITCH);
+		/* auto clear SOFT_CONN when clear USB3_EN if work as HS */
+		mtu3_setbits(mbase, U3D_U3U2_SWITCH_CTRL, SOFTCON_CLR_AUTO_EN);
 	}
 
 	mtu3_set_speed(mtu);
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index d11fcd64c19d..1d65b7476f23 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -268,6 +268,8 @@
 #define U3D_LTSSM_INTR_ENABLE	(SSUSB_USB3_MAC_CSR_BASE + 0x013C)
 #define U3D_LTSSM_INTR		(SSUSB_USB3_MAC_CSR_BASE + 0x0140)
 
+#define U3D_U3U2_SWITCH_CTRL	(SSUSB_USB3_MAC_CSR_BASE + 0x0170)
+
 /*---------------- SSUSB_USB3_MAC_CSR FIELD DEFINITION ----------------*/
 
 /* U3D_LTSSM_CTRL */
@@ -302,6 +304,9 @@
 #define SS_DISABLE_INTR		BIT(1)
 #define SS_INACTIVE_INTR	BIT(0)
 
+/* U3D_U3U2_SWITCH_CTRL */
+#define SOFTCON_CLR_AUTO_EN	BIT(0)
+
 /*---------------- SSUSB_USB3_SYS_CSR REGISTER DEFINITION ----------------*/
 
 #define U3D_LINK_UX_INACT_TIMER	(SSUSB_USB3_SYS_CSR_BASE + 0x020C)
-- 
2.19.1

