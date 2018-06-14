Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 90C69C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6B0208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2Eq2oyyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6B0208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964942AbeFNOGz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964880AbeFNOGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:53 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6B89208E0;
        Thu, 14 Jun 2018 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985213;
        bh=Y81vvtrsxngfUcyrGJ9FIyoTIYJXsh8gq0ddtgSEknU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Eq2oyynqa59FTL2jWFk+SFHgayNbgRHPH8d90p69vbv5RoxBIaZVbzLJlU+7oTBv
         KP3Mk8TZDbeg8nr266Ik8P/HcigGHoVSH0Ceabz91L+lH3GYyFMZuxSmR6MK3fbyfG
         D8YTsZpz1k+5xAD2WTqjdq/TBrgsXmIPo6DJqU78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.17 21/45] usb: gadget: udc: renesas_usb3: should call pm_runtime_enable() before add udc
Date:   Thu, 14 Jun 2018 16:04:12 +0200
Message-Id: <20180614132127.909846893@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit d998844016b24a8d71b9aa5eae7e51d70f2de438 upstream.

This patch fixes an issue that this driver causes panic if a gadget
driver is already loaded because usb_add_gadget_udc() might call
renesas_usb3_start() via .udc_start, and then pm_runtime_get_sync()
in renesas_usb3_start() doesn't work correctly.
Note that the usb3_to_dev() macro should not be called at this timing
because the macro uses the gadget structure.

Fixes: cf06df3fae28 ("usb: gadget: udc: renesas_usb3: move pm_runtime_{en,dis}able()")
Cc: <stable@vger.kernel.org> # v4.15+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/renesas_usb3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2632,6 +2632,7 @@ static int renesas_usb3_probe(struct pla
 	if (ret < 0)
 		goto err_alloc_prd;
 
+	pm_runtime_enable(&pdev->dev);
 	ret = usb_add_gadget_udc(&pdev->dev, &usb3->gadget);
 	if (ret < 0)
 		goto err_add_udc;
@@ -2653,7 +2654,6 @@ static int renesas_usb3_probe(struct pla
 	renesas_usb3_debugfs_init(usb3, &pdev->dev);
 
 	dev_info(&pdev->dev, "probed%s\n", usb3->phy ? " with phy" : "");
-	pm_runtime_enable(usb3_to_dev(usb3));
 
 	return 0;
 


