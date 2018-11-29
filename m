Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43416C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1F220832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1F220832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeK2NjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:39:03 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33887 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727237AbeK2NjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:39:02 -0500
X-UUID: 6118f19e448d4f0a8f4596c9f3077339-20181129
X-UUID: 6118f19e448d4f0a8f4596c9f3077339-20181129
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 782366003; Thu, 29 Nov 2018 10:35:04 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Nov 2018 10:35:02 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Nov 2018 10:35:01 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 3/5] usb: mtu3: fix the issue about SetFeature(U1/U2_Enable)
Date:   Thu, 29 Nov 2018 10:34:34 +0800
Message-ID: <5a0875cb70e168cf2cc74f2357e9935561a11401.1543458321.git.chunfeng.yun@mediatek.com>
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

Fix the issue: device doesn't accept LGO_U1/U2:
1. set SW_U1/U2_ACCEPT_ENABLE to eanble controller to accept LGO_U1/U2
    by default;
2. enable/disable controller to initiate requests for transition into
    U1/U2 by SW_U1/U2_REQUEST_ENABLE instead of SW_U1/U2_ACCEPT_ENABLE;

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c       | 4 +++-
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 981e4e8c5c13..1ffc0bc31c1d 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -578,8 +578,10 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 	if (mtu->is_u3_ip) {
 		/* disable LGO_U1/U2 by default */
 		mtu3_clrbits(mbase, U3D_LINK_POWER_CONTROL,
-				SW_U1_ACCEPT_ENABLE | SW_U2_ACCEPT_ENABLE |
 				SW_U1_REQUEST_ENABLE | SW_U2_REQUEST_ENABLE);
+		/* enable accept LGO_U1/U2 link command from host */
+		mtu3_setbits(mbase, U3D_LINK_POWER_CONTROL,
+				SW_U1_ACCEPT_ENABLE | SW_U2_ACCEPT_ENABLE);
 		/* device responses to u3_exit from host automatically */
 		mtu3_clrbits(mbase, U3D_LTSSM_CTRL, SOFT_U3_EXIT_EN);
 		/* automatically build U2 link when U3 detect fail */
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 25216e79cd6e..3c464d8ae023 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -336,9 +336,9 @@ static int ep0_handle_feature_dev(struct mtu3 *mtu,
 
 		lpc = mtu3_readl(mbase, U3D_LINK_POWER_CONTROL);
 		if (set)
-			lpc |= SW_U1_ACCEPT_ENABLE;
+			lpc |= SW_U1_REQUEST_ENABLE;
 		else
-			lpc &= ~SW_U1_ACCEPT_ENABLE;
+			lpc &= ~SW_U1_REQUEST_ENABLE;
 		mtu3_writel(mbase, U3D_LINK_POWER_CONTROL, lpc);
 
 		mtu->u1_enable = !!set;
@@ -351,9 +351,9 @@ static int ep0_handle_feature_dev(struct mtu3 *mtu,
 
 		lpc = mtu3_readl(mbase, U3D_LINK_POWER_CONTROL);
 		if (set)
-			lpc |= SW_U2_ACCEPT_ENABLE;
+			lpc |= SW_U2_REQUEST_ENABLE;
 		else
-			lpc &= ~SW_U2_ACCEPT_ENABLE;
+			lpc &= ~SW_U2_REQUEST_ENABLE;
 		mtu3_writel(mbase, U3D_LINK_POWER_CONTROL, lpc);
 
 		mtu->u2_enable = !!set;
-- 
2.19.1

