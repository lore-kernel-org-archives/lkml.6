Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC67EC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A9220811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A9220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbeLNI36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:29:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeLNI36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:29:58 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7F973D1C09A30;
        Fri, 14 Dec 2018 16:29:54 +0800 (CST)
Received: from dessert.huawei.com (10.69.192.158) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Dec 2018 16:29:47 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <balbi@kernel.org>
CC:     <liangshengjun@hisilicon.com>, Zeng Tao <prime.zeng@hisilicon.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by IRQ latency
Date:   Sat, 15 Dec 2018 00:32:58 +0800
Message-ID: <1544805179-2248-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it's a busy system, some times when we start an isoc transfer, the
framenumber get from the event buffer may be already elasped, in this
 case, we will get all the packets dropped due to miss isoc. And we turn
into transfer nothing, to fix this issue, we need to fix the framenumber
to make sure that it's not out of date.

Signed-off-by: Liang Shengjun <liangshengjun@hisilicon.com>
Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/usb/dwc3/core.h   |  3 +++
 drivers/usb/dwc3/gadget.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5bfb625..8742d96 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -452,6 +452,9 @@
 
 #define DWC3_DSTS_RXFIFOEMPTY		BIT(17)
 
+#define DWC3_EVENT_PRAM_MAX_SOFFN      0x3fff
+#define DWC3_EVENT_PRAM_SOFFN_MASK     0x3fff
+
 #define DWC3_DSTS_SOFFN_MASK		(0x3fff << 3)
 #define DWC3_DSTS_SOFFN(n)		(((n) & DWC3_DSTS_SOFFN_MASK) >> 3)
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 9f92ee0..b63bd72 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1263,6 +1263,15 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
 	return DWC3_DSTS_SOFFN(reg);
 }
 
+static bool __dwc3_gadget_target_frame_elapsed(struct dwc3_ep *dep)
+{
+	u16 cframe =  __dwc3_gadget_get_frame(dep->dwc);
+	u16 eframe = dep->frame_number & DWC3_EVENT_PRAM_SOFFN_MASK;
+
+	return (((eframe - cframe) & DWC3_EVENT_PRAM_SOFFN_MASK)
+		> DWC3_EVENT_PRAM_MAX_SOFFN / 2);
+}
+
 static void __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 {
 	if (list_empty(&dep->pending_list)) {
@@ -1272,6 +1281,9 @@ static void __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 		return;
 	}
 
+	while (__dwc3_gadget_target_frame_elapsed(dep))
+		dep->frame_number = DWC3_ALIGN_FRAME(dep);
+
 	dep->frame_number = DWC3_ALIGN_FRAME(dep);
 	__dwc3_gadget_kick_transfer(dep);
 }
-- 
2.7.4

