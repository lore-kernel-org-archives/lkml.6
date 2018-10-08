Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995E3C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A652064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xpkH7sjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A652064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbeJIBwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbeJIBwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:52:11 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B62A21479;
        Mon,  8 Oct 2018 18:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023947;
        bh=AxqRLH3z8g9dyOTiuZnsLrGMFkuuY/Rb7vX1qSq9U+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xpkH7sjKzX6vkAaJ2uc4SzQv1Y46xunxYW01Ie4Fi4OQPOOC4vNx4sqFeBzNKeV4R
         mSl8kPvYZbrBla588HH2t7tN1g6DtwY/CJ445MUF3FQCpkDrUqBpzwAksanPnq0pOt
         7SaovcRQYsiY+tnnoEiZgsR1h2VtKSEkFzbdt848=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Vasilyev <vasilyev@ispras.ru>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 27/59] usb: gadget: fotg210-udc: Fix memory leak of fotg210->ep[i]
Date:   Mon,  8 Oct 2018 20:31:34 +0200
Message-Id: <20181008175549.715155043@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
References: <20181008175546.620836256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit c37bd52836296ecc9a0fc8060b819089aebdbcde ]

There is no deallocation of fotg210->ep[i] elements, allocated at
fotg210_udc_probe.

The patch adds deallocation of fotg210->ep array elements and simplifies
error path of fotg210_udc_probe().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/fotg210-udc.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -1066,12 +1066,15 @@ static struct usb_gadget_ops fotg210_gad
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
@@ -1102,7 +1105,7 @@ static int fotg210_udc_probe(struct plat
 	/* initialize udc */
 	fotg210 = kzalloc(sizeof(struct fotg210_udc), GFP_KERNEL);
 	if (fotg210 == NULL)
-		goto err_alloc;
+		goto err;
 
 	for (i = 0; i < FOTG210_MAX_NUM_EP; i++) {
 		_ep[i] = kzalloc(sizeof(struct fotg210_ep), GFP_KERNEL);
@@ -1114,7 +1117,7 @@ static int fotg210_udc_probe(struct plat
 	fotg210->reg = ioremap(res->start, resource_size(res));
 	if (fotg210->reg == NULL) {
 		pr_err("ioremap error.\n");
-		goto err_map;
+		goto err_alloc;
 	}
 
 	spin_lock_init(&fotg210->lock);
@@ -1162,7 +1165,7 @@ static int fotg210_udc_probe(struct plat
 	fotg210->ep0_req = fotg210_ep_alloc_request(&fotg210->ep[0]->ep,
 				GFP_KERNEL);
 	if (fotg210->ep0_req == NULL)
-		goto err_req;
+		goto err_map;
 
 	fotg210_init(fotg210);
 
@@ -1190,12 +1193,14 @@ err_req:
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
 


