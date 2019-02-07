Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01E0C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40352175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5MpIJPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBGS70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:59:26 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:43319 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfBGS70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:59:26 -0500
Received: by mail-it1-f201.google.com with SMTP id p124so1409520itd.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bM4jn6lNIwgT6TBV8rTyAb6ZLmRRecodhu/3Jy2aaug=;
        b=d5MpIJPcqlgMXmneISZg91mRfxrq2EDmGkrYAdP4raJhgIH7h/CyJDN30VAy7vY3bn
         86dKbtqOzfKvVdH1x9mZhKyB2N0u1sfDf8I4qH9YvZIakIN4Z9oDWWyA3WL0Ejre6mG+
         GJ6xuSoIcsoYCzpR88wwzkWEclrH9qVD43QFL36mF8+x21jBz1yoklkeBfKecsKLbf7m
         kiFU5yrU9tD2mZJtz7oCTUfqKCe7SnSZR8oUAgnRPgyg+b0PbsczyMMN/+S8k/VrECl1
         R3D6cSpHCndzFQ9YEMAl07f48L/5wf6DSKvphTQ034lAOrJE2SrQpuJHgS7uL1Y76ibZ
         j5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bM4jn6lNIwgT6TBV8rTyAb6ZLmRRecodhu/3Jy2aaug=;
        b=UTpdYCOZ1WFW/FfYwplbjgvPXcHvHKpY24XGPufJ+gy5IS4apoeH7QFML/QDCV3LmL
         ufF+snVcx88fQAgAPsxMNfUDRFi1MrqWd2E9tdn5lftYqr+44DcdISjMx02O8alzL9Hz
         eknUp61bDKnLsPwVkNNrOo7eF8f27m2hHJOITAXPqLBwO2jcxiWL8cMoTvODfU9PP6p4
         PL7kpkcoZrERcOCrvfpMbID9qSVIgEoo46quPeze/KNsvgr6LohPIVTgCaiS9Qg6ukIi
         tJbWpjw3OXFDiR2uFXBSnOuzAm5FSLFwxfm4ryLEDDTPqkyDMWEY8BxRe3MQQVnAdFV5
         YNcg==
X-Gm-Message-State: AHQUAubVK0QObUFFhIJGF4hQUnVAM7hPqfIZEMFforEm9Yo44j9mLU87
        j6srUt9qKBGhahRiLZ7RTOgvW43BxBGfVA==
X-Google-Smtp-Source: AHgI3IYf+pX+ukt4U8SVjRz8Zmj/akNha+InGq7PtUN7tJfthIOXXOssY7ov/Ny/gk6rw0O/FzAqWYxLQqS6wA==
X-Received: by 2002:a24:6852:: with SMTP id v79mr6984263itb.29.1549565965674;
 Thu, 07 Feb 2019 10:59:25 -0800 (PST)
Date:   Thu,  7 Feb 2019 10:59:17 -0800
Message-Id: <20190207185917.167829-1-egranata@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH] driver: platform: Add support for GpioInt() ACPI to platform_get_irq()
From:   egranata@google.com
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        dtor@chromium.org, linux-acpi@vger.kernel.org,
        briannorris@chromium.org, Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

ACPI 5 added support for GpioInt resources as a way to provide
information about interrupts mediated via a GPIO controller.

Several device buses (e.g. SPI, I2C) have support for retrieving
an IRQ specified via this type of resource, and providing it
directly to the driver as an IRQ number.
This is not currently done for the platform drivers, as platform_get_irq()
does not try to parse GpioInt() resources.

This commit adds that functionality.

Signed-off-by: Enrico Granata <egranata@chromium.org>
---
 drivers/base/platform.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4d..c50c4f9033aef 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -127,7 +127,17 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
+
+	/*
+	 * If no IRQ was found, try to parse ACPI GpioInt resources
+	 * as a last resort.
+	 */
+	if (has_acpi_companion(&dev->dev))
+		return acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
+
+	return -ENXIO;
 #endif
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
-- 
2.20.1.611.gfbb209baf1-goog

