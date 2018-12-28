Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470CBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C9D20874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbeL1K2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:28:05 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:10795 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730344AbeL1K2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:28:04 -0500
X-UUID: c2e64387311a4d66bb304d5030e54b95-20181228
X-UUID: c2e64387311a4d66bb304d5030e54b95-20181228
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1042852339; Fri, 28 Dec 2018 18:27:57 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Dec 2018 18:27:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Dec 2018 18:27:54 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] usb: devio: update max count of DPs per interval for ISOC
Date:   Fri, 28 Dec 2018 18:27:44 +0800
Message-ID: <1545992864-9530-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host shall be able to accept and send up to 96 DPs for
devices operating at Gen 2 speed.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/core/devio.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index a75bc0b8a50f..82c16210e34c 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1564,12 +1564,10 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 		}
 		for (totlen = u = 0; u < number_of_packets; u++) {
 			/*
-			 * arbitrary limit need for USB 3.0
-			 * bMaxBurst (0~15 allowed, 1~16 packets)
-			 * bmAttributes (bit 1:0, mult 0~2, 1~3 packets)
-			 * sizemax: 1024 * 16 * 3 = 49152
+			 * arbitrary limit need for USB 3.1 Gen2
+			 * sizemax: 96 DPs at SSP, 96 * 1024 = 98304
 			 */
-			if (isopkt[u].length > 49152) {
+			if (isopkt[u].length > 98304) {
 				ret = -EINVAL;
 				goto error;
 			}
-- 
2.19.1

