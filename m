Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2148C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5079923DB9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5079923DB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeFVGdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:33:31 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19178 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751047AbeFVGd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:33:29 -0400
X-UUID: baf8e7adb53f46d6a5075439345d8db4-20180622
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 156758884; Fri, 22 Jun 2018 14:33:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 22 Jun 2018 14:33:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 22 Jun 2018 14:33:21 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/2] usb: core: phy: fix return value checking about devm_of_phy_get_by_index()
Date:   Fri, 22 Jun 2018 14:33:06 +0800
Message-ID: <644d00edd2932c1a0d0a1bf368dd25427d1d9f64.1529647619.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4c338a129ab14ab41949da5e3c21aed0d77dff8d.1529647619.git.chunfeng.yun@mediatek.com>
References: <4c338a129ab14ab41949da5e3c21aed0d77dff8d.1529647619.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. use IS_ERR() but not IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
    never return NULL value;
2. devm_of_phy_get_by_index() should not fail for a valid index

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/core/phy.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 9879767..0f972e1 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -23,14 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
 				   struct list_head *list)
 {
 	struct usb_phy_roothub *roothub_entry;
-	struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
+	struct phy *phy;
 
-	if (IS_ERR_OR_NULL(phy)) {
-		if (!phy || PTR_ERR(phy) == -ENODEV)
-			return 0;
-		else
-			return PTR_ERR(phy);
-	}
+	phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
 
 	roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
 	if (!roothub_entry)
-- 
1.9.1

