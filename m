Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EDEC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C127321779
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C127321779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbeHGN7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:59:01 -0400
Received: from bran.ispras.ru ([83.149.199.196]:28308 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbeHGN7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:59:01 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 9558E203C9;
        Tue,  7 Aug 2018 14:45:01 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Yang <leoyang.li@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] usb: gadget: fotg210-udc: Fix memory leak of fotg210->ep[i]
Date:   Tue,  7 Aug 2018 14:44:48 +0300
Message-Id: <20180807114448.28065-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no deallocation of fotg210->ep[i] elements, allocated at
fotg210_udc_probe.

The patch adds deallocation of fotg210->ep array elements and simplifies
error path of fotg210_udc_probe().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index 53a48f561458..587c5037ff07 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -1063,12 +1063,15 @@ static const struct usb_gadget_ops fotg210_gadget_ops = {
 static int fotg210_udc_remove(struct platform_device *pdev)
 {
 	struct fotg210_udc *fotg210 = platform_get_drvdata(pdev);
+	int i;
 
 	usb_del_gadget_udc(&fotg210->gadget);
 	iounmap(fotg210->reg);
 	free_irq(platform_get_irq(pdev, 0), fotg210);
 
 	fotg210_ep_free_request(&fotg210->ep[0]->ep, fotg210->ep0_req);
+	for (i = 0; i < FOTG210_MAX_NUM_EP; i++)
+		kfree(fotg210->ep[i]);
 	kfree(fotg210);
 
 	return 0;
@@ -1099,7 +1102,7 @@ static int fotg210_udc_probe(struct platform_device *pdev)
 	/* initialize udc */
 	fotg210 = kzalloc(sizeof(struct fotg210_udc), GFP_KERNEL);
 	if (fotg210 == NULL)
-		goto err_alloc;
+		goto err;
 
 	for (i = 0; i < FOTG210_MAX_NUM_EP; i++) {
 		_ep[i] = kzalloc(sizeof(struct fotg210_ep), GFP_KERNEL);
@@ -1111,7 +1114,7 @@ static int fotg210_udc_probe(struct platform_device *pdev)
 	fotg210->reg = ioremap(res->start, resource_size(res));
 	if (fotg210->reg == NULL) {
 		pr_err("ioremap error.\n");
-		goto err_map;
+		goto err_alloc;
 	}
 
 	spin_lock_init(&fotg210->lock);
@@ -1159,7 +1162,7 @@ static int fotg210_udc_probe(struct platform_device *pdev)
 	fotg210->ep0_req = fotg210_ep_alloc_request(&fotg210->ep[0]->ep,
 				GFP_KERNEL);
 	if (fotg210->ep0_req == NULL)
-		goto err_req;
+		goto err_map;
 
 	fotg210_init(fotg210);
 
@@ -1187,12 +1190,14 @@ static int fotg210_udc_probe(struct platform_device *pdev)
 	fotg210_ep_free_request(&fotg210->ep[0]->ep, fotg210->ep0_req);
 
 err_map:
-	if (fotg210->reg)
-		iounmap(fotg210->reg);
+	iounmap(fotg210->reg);
 
 err_alloc:
+	for (i = 0; i < FOTG210_MAX_NUM_EP; i++)
+		kfree(fotg210->ep[i]);
 	kfree(fotg210);
 
+err:
 	return ret;
 }
 
-- 
2.18.0

