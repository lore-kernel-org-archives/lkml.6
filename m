Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F12C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08E020869
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWCLKJxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08E020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeJYWsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbeJYWsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:36 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04EA320868;
        Thu, 25 Oct 2018 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476940;
        bh=6ZFcpRwWtMQQ+xYMQBsilrxxHyBsJBopmVESxGeT7gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWCLKJxaCgLAei7G7jnVunrlrpUfawbVm8852Ij5hvyTrS3xGa/KrPuwEe0pAgWJW
         JFcC1eE202K8VliRiT80xzteDPBA8v+pbuqpC4bvKhkH4yg+b+nJ1U/m/Y7BtuPSEA
         e/qQnK/iuMW0EVtsgyeJHbfdj2WUkm2xB8jqdCl4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vignesh R <vigneshr@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 51/98] usb: dwc3: omap: remove IRQ_NOAUTOEN used with shared irq
Date:   Thu, 25 Oct 2018 10:13:36 -0400
Message-Id: <20181025141423.213774-51-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit ee249b4554947de3be77be4e9e6077b20c0fe055 ]

IRQ_NOAUTOEN cannot be used with shared IRQs, since commit 04c848d39879
("genirq: Warn when IRQ_NOAUTOEN is used with shared interrupts") and
kernel now throws a warn dump. But OMAP DWC3 driver uses this flag. As
per commit 12a7f17fac5b ("usb: dwc3: omap: fix race of pm runtime with
irq handler in probe") that introduced this flag, PM runtime can race
with IRQ handler when deferred probing happens due to extcon,
therefore IRQ_NOAUTOEN needs to be set so that irq is not enabled until
extcon is registered.

Remove setting of IRQ_NOAUTOEN and move the registration of
shared irq to a point after dwc3_omap_extcon_register() and
of_platform_populate(). This avoids possibility of probe deferring and
above said race condition.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-omap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index f221cb479e14..8e69150776f5 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -512,15 +512,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 
 	/* check the DMA Status */
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
-	irq_set_status_flags(omap->irq, IRQ_NOAUTOEN);
-	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
-					dwc3_omap_interrupt_thread, IRQF_SHARED,
-					"dwc3-omap", omap);
-	if (ret) {
-		dev_err(dev, "failed to request IRQ #%d --> %d\n",
-				omap->irq, ret);
-		goto err1;
-	}
 
 	ret = dwc3_omap_extcon_register(omap);
 	if (ret < 0)
@@ -532,8 +523,15 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
+					dwc3_omap_interrupt_thread, IRQF_SHARED,
+					"dwc3-omap", omap);
+	if (ret) {
+		dev_err(dev, "failed to request IRQ #%d --> %d\n",
+			omap->irq, ret);
+		goto err1;
+	}
 	dwc3_omap_enable_irqs(omap);
-	enable_irq(omap->irq);
 	return 0;
 
 err2:
-- 
2.17.1

