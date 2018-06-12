Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7F099C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAD52086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAD52086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933136AbeFLGvL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:51:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51297 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753677AbeFLGvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:51:10 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 994DE60F08653;
        Tue, 12 Jun 2018 14:51:06 +0800 (CST)
Received: from dessert.huawei.com (10.69.192.158) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.382.0; Tue, 12 Jun 2018 14:50:59 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <hminas@synopsys.com>
CC:     <prime.zeng@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: dwc2: gadget: fix packet drop issue in dwc2_gadget_handle_nak
Date:   Tue, 12 Jun 2018 22:49:06 +0800
Message-ID: <1528814947-27098-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ISOC transfer, when the NAK interrupt happens, we shouldn't complete
a usb request, the current flow will complete one usb request with no
hardware transfer, this will lead to a packet drop on the usb bus.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/usb/dwc2/gadget.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index f0d9ccf..fbe65f6 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -2817,9 +2817,6 @@ static void dwc2_gadget_handle_nak(struct dwc2_hsotg_ep *hs_ep)
 
 		tmp = dwc2_hsotg_read_frameno(hsotg);
 		if (using_desc_dma(hsotg)) {
-			dwc2_hsotg_complete_request(hsotg, hs_ep,
-						    get_ep_head(hs_ep), 0);
-
 			hs_ep->target_frame = tmp;
 			dwc2_gadget_incr_frame_num(hs_ep);
 			dwc2_gadget_start_isoc_ddma(hs_ep);
-- 
2.7.4

