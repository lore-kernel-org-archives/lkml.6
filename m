Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4FA54C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F07208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVP2GAFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F07208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965246AbeFNOIY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965230AbeFNOIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:08:20 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E3F6208CB;
        Thu, 14 Jun 2018 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985300;
        bh=iJbhnUE+60zIlmos4rFbH14BxmIeyYIsr6b24M6gzBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVP2GAFDUsplt3ZVSHnOhA8huKua4zX2uxIW5mi9RcKBGBQXk0N0eXVTIvOb+kRw/
         2zZ46PR/zIZRidihBNDNT1i2KZnzOeFWoTJLkgKMGkF3yieLC+UlZXdLiLI5NqVaOP
         9/DXxM7m1oekHmU0ZFIPHXwKTcD13M3sTXQJJXQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.16 22/43] usb: gadget: udc: renesas_usb3: should call devm_phy_get() before add udc
Date:   Thu, 14 Jun 2018 16:04:26 +0200
Message-Id: <20180614132136.540945157@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132135.111973468@linuxfoundation.org>
References: <20180614132135.111973468@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 003bc1dee216b1fb8e02040a95672bea0f1fe797 upstream.

This patch fixes an issue that this driver cannot call phy_init()
if a gadget driver is alreadly loaded because usb_add_gadget_udc()
might call renesas_usb3_start() via .udc_start.
This patch also revises the typo (s/an optional/optional/).

Fixes: 279d4bc64060 ("usb: gadget: udc: renesas_usb3: add support for generic phy")
Cc: <stable@vger.kernel.org> # v4.15+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/renesas_usb3.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2632,6 +2632,14 @@ static int renesas_usb3_probe(struct pla
 	if (ret < 0)
 		goto err_alloc_prd;
 
+	/*
+	 * This is optional. So, if this driver cannot get a phy,
+	 * this driver will not handle a phy anymore.
+	 */
+	usb3->phy = devm_phy_get(&pdev->dev, "usb");
+	if (IS_ERR(usb3->phy))
+		usb3->phy = NULL;
+
 	pm_runtime_enable(&pdev->dev);
 	ret = usb_add_gadget_udc(&pdev->dev, &usb3->gadget);
 	if (ret < 0)
@@ -2641,14 +2649,6 @@ static int renesas_usb3_probe(struct pla
 	if (ret < 0)
 		goto err_dev_create;
 
-	/*
-	 * This is an optional. So, if this driver cannot get a phy,
-	 * this driver will not handle a phy anymore.
-	 */
-	usb3->phy = devm_phy_get(&pdev->dev, "usb");
-	if (IS_ERR(usb3->phy))
-		usb3->phy = NULL;
-
 	usb3->workaround_for_vbus = priv->workaround_for_vbus;
 
 	renesas_usb3_debugfs_init(usb3, &pdev->dev);


