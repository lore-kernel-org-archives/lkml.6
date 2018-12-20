Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B68C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32782176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbeLTMuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:50:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16615 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728966AbeLTMuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:50:54 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AB3072A9331DF;
        Thu, 20 Dec 2018 20:50:49 +0800 (CST)
Received: from dessert.huawei.com (10.69.192.158) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Dec 2018 20:50:41 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <felipe.balbi@linux.intel.com>
CC:     Zeng Tao <prime.zeng@hisilicon.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: dwc3: gadget: don't remove the request if bus-expired
Date:   Fri, 21 Dec 2018 04:53:50 +0800
Message-ID: <1545339230-10520-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have already returned EAGAIN for bus-expiry, and it's designed to
start with a future Frame number and start the transfer again. So we
should not remove the request for that case.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/usb/dwc3/gadget.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2ecde30..16a6e3c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1250,7 +1250,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 	}
 
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-	if (ret < 0) {
+	if (ret < 0 && ret != -EAGAIN) {
 		/*
 		 * FIXME we need to iterate over the list of requests
 		 * here and stop, unmap, free and del each of the linked
@@ -1259,10 +1259,9 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		if (req->trb)
 			memset(req->trb, 0, sizeof(struct dwc3_trb));
 		dwc3_gadget_del_and_unmap_request(dep, req, ret);
-		return ret;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
-- 
2.7.4

