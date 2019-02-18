Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134CEC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCAA218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499143;
	bh=quNCvzGIU96CJq+FR9mToXy5bTrxXg3RWaps1G3rxPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gJUGiX5l9dPQj9Wg9gJAQV7GZ2/VKAbT0NKzIpBVXMBp/i/9Qd683VIWxzatYcD/4
	 aid1qnmrS6ufNSqIoZvZv5GmRdyKFl7XqH0CUShfkbyKZjtL+yyaDuU7Wd9jsg6kAn
	 Hyiuaj9Cl3MynxMrnmB0/mlMeUR64VjNwP0UXu7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392044AbfBROMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:12:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392035AbfBROMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:12:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2670218AD;
        Mon, 18 Feb 2019 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499141;
        bh=quNCvzGIU96CJq+FR9mToXy5bTrxXg3RWaps1G3rxPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFIYVCKpmx4ZTjwkH6UQbO2Hj9vxiAXsGCYiX4/2vkSeqgo0e1FAX/6YMVETb2brB
         2o4XQ/TSSPrOCL8w/6eoEPSGdXHK/f3FqdTse7nFfdHpspPJp8L3PRZQnJYEPAZMlG
         xzHj+lWndwDldIBwYf3CV7CjWwJ/pxDg/eYki+94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 3.18 090/108] usb: host: ehci-msm: fix handling platform_get_irq result
Date:   Mon, 18 Feb 2019 14:44:26 +0100
Message-Id: <20190218133523.741516939@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <a.hajda@samsung.com>

commit 0c43e9d835b003d862a5f76e3affcc1f973fb3c0 upstream.

The function can return negative values.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/ehci-msm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -80,12 +80,12 @@ static int ehci_msm_probe(struct platfor
 		return  -ENOMEM;
 	}
 
-	hcd->irq = platform_get_irq(pdev, 0);
-	if (hcd->irq < 0) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to get IRQ resource\n");
-		ret = hcd->irq;
 		goto put_hcd;
 	}
+	hcd->irq = ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {


