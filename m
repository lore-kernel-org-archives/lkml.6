Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B033FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8CF2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XgZahOjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBGSu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:50:56 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56997 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGSuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:50:55 -0500
Received: by mail-pg1-f202.google.com with SMTP id d3so484484pgv.23
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 10:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bM4jn6lNIwgT6TBV8rTyAb6ZLmRRecodhu/3Jy2aaug=;
        b=XgZahOjLbWi0qFlr4JujyDUN48deMRm8AyLGK2gsx+8DbvmIKgqDisMr6bOTFN3wb0
         gqNZfaELpNgzhtfadFVYsj3SjS1a/DvcXhUWQjQnawfrU2ZIeK9NlX88xl6Q4ylpy4d4
         hQcb9RBqgkS3nyIxaBGlhptxs0niOJ5+Dd3DPuZUbJMMcFKbm5tUpxD8lU8yhnq94XCZ
         bF4L73RQNKDl+iWfmSg2j+41jWRqNYzLxO7zzqF6sNnUHUPFmIbLfzHYO7WE9DFrYIRr
         W9XnN7L+nBhJciyguir8ELaCcHOsdtpHVC+SZHK+JMdPvWRbVzpbkwfBwJiuYTBaUaEV
         F4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bM4jn6lNIwgT6TBV8rTyAb6ZLmRRecodhu/3Jy2aaug=;
        b=rzW3LnM8ItrItVkcTyLAI0qzeoUHd3GR1CFBwjQ86dUGMKPOceVHkK/noYvIzmz+jh
         DgmYTqcivM2ZiASnd+iyaqtTRD3bIT0w1v+8xO+Vh0kmqX4HjB6hLarylzM+gjDzjhro
         YjfOV6wZ9+tz+to78eWvWKGNrW+oplzJzdtOoA67Pl5z2Facj8NxOTdxcXZMYvTzroGJ
         6BmZ727jpsXmy4RUtNUmvszm9EFaFKH8N/ARfnGH76Levou6LOOokCQahXiScUesKekM
         kVYqTld7UPPpC/WtCeQwHlTxcQkCbui86zKcu1Qj1mETO0WXfDqiL+YgxzR0+jy9JuWY
         SX2g==
X-Gm-Message-State: AHQUAuaITmSLJ85nk4zthPm+aTlvd9d1ymf6NbCE9YVWAepRxHEfH37G
        weGkpDoYvI3ZLQgm3wfsJYodo9UHPL3Khw==
X-Google-Smtp-Source: AHgI3IZV8NHD8JBWSEBW3IQTyvv2WGU4dsO2wc2vBlNG+vLRKeEjgmRBILu9Ix/ks6YGLotY5wklnVORQBhgAg==
X-Received: by 2002:a63:6901:: with SMTP id e1mr3350421pgc.68.1549565454895;
 Thu, 07 Feb 2019 10:50:54 -0800 (PST)
Date:   Thu,  7 Feb 2019 10:50:43 -0800
Message-Id: <20190207185043.158981-1-egranata@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH] driver: platform: Add support for GpioInt() ACPI to platform_get_irq()
From:   egranata@google.com
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        dtor@chromium.org, briannorris@chromium.org,
        Enrico Granata <egranata@chromium.org>
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

