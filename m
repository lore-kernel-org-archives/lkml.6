Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912E6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4A720839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4A720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeHaOJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:09:11 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:10591 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727785AbeHaOJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:09:11 -0400
X-UUID: 7880285d912b41eaa97208533bba9b42-20180831
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1568471139; Fri, 31 Aug 2018 18:02:15 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 31 Aug 2018 18:02:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 31 Aug 2018 18:02:06 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v5] usb: core: phy: clean up return value check about devm_of_phy_get_by_index()
Date:   Fri, 31 Aug 2018 18:01:54 +0800
Message-ID: <18d8d311a32497abce39c796b353a878a13b09b6.1535709565.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ERR() instead of IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
never return NULL value;
But still need ignore the error of -ENODEV, for more information, please
refer to:
[0] https://lkml.org/lkml/2018/4/19/88
[1] https://patchwork.kernel.org/patch/10160181/

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
---
V5: add Reviewed-by: Johan Hovold <johan@kernel.org>
V4: modify the patch subject suggested by Johan
V3: abandon the ternary operator suggested by Johan
V2: keep the -ENODEV check
---

 drivers/usb/core/phy.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 9879767..38b2c77 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -23,10 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
 				   struct list_head *list)
 {
 	struct usb_phy_roothub *roothub_entry;
-	struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
+	struct phy *phy;
 
-	if (IS_ERR_OR_NULL(phy)) {
-		if (!phy || PTR_ERR(phy) == -ENODEV)
+	phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
+	if (IS_ERR(phy)) {
+		if (PTR_ERR(phy) == -ENODEV)
 			return 0;
 		else
 			return PTR_ERR(phy);
-- 
1.9.1

