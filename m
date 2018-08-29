Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73081C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4A720852
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4A720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeH2Gby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:31:54 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:12106 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726209AbeH2Gby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:31:54 -0400
X-UUID: 50ad90b0f15046b180454d92b6b0fc3e-20180829
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1252612081; Wed, 29 Aug 2018 10:37:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 29 Aug 2018 10:37:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 29 Aug 2018 10:37:10 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/2] usb: mtu3: disable vbus rise/fall interrupts of ltssm
Date:   Wed, 29 Aug 2018 10:36:50 +0800
Message-ID: <72ee83112167ceb394ec5d89a824be866a7a21f0.1535509922.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c4279eccff765006b78f87bf3c8c9ac94a06c04d.1535509922.git.chunfeng.yun@mediatek.com>
References: <c4279eccff765006b78f87bf3c8c9ac94a06c04d.1535509922.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vbus rise & fall interrupts are used to enable and disable
U3 function of device automatically, this cause some issues when
class driver is initialized as deactivated, and will skip over
software-controlled connect by pullup(), but UDC wants to keep
disconnect until usb_gadget_activate() is called which calls
pullup() if needed. So we disable vbus rise & fall interrupts
and just use pullup() to enable & disable U3 function, and reset
mtu3 state when disconnect instead when vbus fall.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c   |  4 ++--
 drivers/usb/mtu3/mtu3_gadget.c | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index d045d84..ae70b9b 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -185,8 +185,8 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 
 	if (mtu->is_u3_ip) {
 		/* Enable U3 LTSSM interrupts */
-		value = HOT_RST_INTR | WARM_RST_INTR | VBUS_RISE_INTR |
-		    VBUS_FALL_INTR | ENTER_U3_INTR | EXIT_U3_INTR;
+		value = HOT_RST_INTR | WARM_RST_INTR |
+			ENTER_U3_INTR | EXIT_U3_INTR;
 		mtu3_writel(mbase, U3D_LTSSM_INTR_ENABLE, value);
 	}
 
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index 5c60a8c..bbcd333 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -585,6 +585,17 @@ static int mtu3_gadget_stop(struct usb_gadget *g)
 	.udc_stop = mtu3_gadget_stop,
 };
 
+static void mtu3_state_reset(struct mtu3 *mtu)
+{
+	mtu->address = 0;
+	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
+	mtu->may_wakeup = 0;
+	mtu->u1_enable = 0;
+	mtu->u2_enable = 0;
+	mtu->delayed_status = false;
+	mtu->test_mode = false;
+}
+
 static void init_hw_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 		u32 epnum, u32 is_in)
 {
@@ -702,6 +713,7 @@ void mtu3_gadget_disconnect(struct mtu3 *mtu)
 		spin_lock(&mtu->lock);
 	}
 
+	mtu3_state_reset(mtu);
 	usb_gadget_set_state(&mtu->g, USB_STATE_NOTATTACHED);
 }
 
@@ -712,12 +724,6 @@ void mtu3_gadget_reset(struct mtu3 *mtu)
 	/* report disconnect, if we didn't flush EP state */
 	if (mtu->g.speed != USB_SPEED_UNKNOWN)
 		mtu3_gadget_disconnect(mtu);
-
-	mtu->address = 0;
-	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
-	mtu->may_wakeup = 0;
-	mtu->u1_enable = 0;
-	mtu->u2_enable = 0;
-	mtu->delayed_status = false;
-	mtu->test_mode = false;
+	else
+		mtu3_state_reset(mtu);
 }
-- 
1.9.1

