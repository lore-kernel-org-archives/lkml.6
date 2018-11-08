Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD81ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646A520844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu/9G7hP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646A520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbeKIHmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731583AbeKIHml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:41 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0686208E3;
        Thu,  8 Nov 2018 22:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714710;
        bh=GxHKogsm2XdXDy+ZB+nM4FxL87yXI9fAPfenNiiEBtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tu/9G7hPh8NXstxKrsNerhOWB2cqyYA+ZO9vShaXlU0ckFXYWwsCZEvpEdjH/FbNu
         jg5TqmLZ+07j14IoAuJLfRLvrasLdTjNmDeWoUzK3bHPAmiMWORA9qfFqNMsTgv1GF
         gHhDV+oB3sgkF+RMZDQR2O+x/G7hcjhtQRWcJ9DA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh R <vigneshr@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 081/171] usb: dwc3: omap: remove IRQ_NOAUTOEN used with shared irq
Date:   Thu,  8 Nov 2018 13:50:51 -0800
Message-Id: <20181108215133.398471864@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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



