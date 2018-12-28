Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1060C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED912184E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zit6QV3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeL1V4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:56:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44508 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeL1V4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:56:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so10928611pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 13:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOnYdI6yMqe6Kolc8LcsRt72W9JKJj6PmETexZzwaCw=;
        b=Zit6QV3qr/AJY79cn2cqXbWUPGDC9eUT3xNjkQXygl3V2+zgXO11ddB+oeS+joq5dr
         kzRatnhEd89aiAiYzNg9mD4QuMLUa6Bg3Yj/u3ELCapNY7xGRE28K+5ocD0oAzfWjyGg
         JdRPyJvm6Ef+qGAcUBkMwLJtjVkj8cDKol52s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOnYdI6yMqe6Kolc8LcsRt72W9JKJj6PmETexZzwaCw=;
        b=QfdjZSSUb1HqhDA5ehNceM13VtPwsSNdUjc86x77aOrQlvtwUKNMd2wtpBU5o2Loxl
         QrN7KUOisHyfG+W9mo6iMHXx7RxR/YlYP+2ymDAp70E1ltulNO0ZcWJbVHO6BmwPHxIW
         gGoXVpTMN3udgoG4pApsRgy0bEqOhpaJcwZw5vcT5ew5iV7oPzwGC5ohEDkVPo4nrqpu
         jZsUiCQPRBRkuTb3ii6UX+y5bxF2U+kAeidOdivHf+Y6qbvXEYdR1fUltSbdRouEXpxu
         OBLJ16Hca/4RNqo21j/ivYQTGXHOn/0sCLLAp6BtTVG9k2iNrw5MDOH9rCsOKmmVpfLl
         Laow==
X-Gm-Message-State: AA+aEWYjZ6K7esICxK4rQZggrxe+2VyUTFPAPWs4Cx7ms7ieR7dh5idZ
        4vIvobkoMWGSfuIzwgTcgFgeKg==
X-Google-Smtp-Source: ALg8bN6OZVi2smRjTZLHMaRWSuGUF0lGusloYIXMJegHnidSza3sMbUFFnLjDR1UtncS+7MdUAXM/g==
X-Received: by 2002:a62:34c6:: with SMTP id b189mr30355957pfa.229.1546034182230;
        Fri, 28 Dec 2018 13:56:22 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f67sm61824491pfc.141.2018.12.28.13.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 13:56:21 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     robh@kernel.org
Cc:     a.hajda@samsung.com, andy.shevchenko@gmail.com,
        b.zolnierkie@samsung.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, javierm@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, m.szyprowski@samsung.com, rafael@kernel.org
Subject: [PATCH v2] driver core: platform: Add an error message to platform_get_irq*()
Date:   Fri, 28 Dec 2018 13:56:20 -0800
Message-Id: <20181228215620.120672-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A grep of the kernel shows that many drivers print an error message if
they fail to get the irq they're looking for. Furthermore, those drivers
all decide to print the device name, or not, and the irq they were
requesting, or not, etc. Let's consolidate all these error messages into
the API itself, allowing us to get rid of the error messages in each
driver.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * Update error text to indicate irq index instead of IRQn, use %u

 drivers/base/platform.c | 52 +++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4..e7af7cd63d0b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -79,23 +79,18 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
-/**
- * platform_get_irq - get an IRQ for a device
- * @dev: platform device
- * @num: IRQ number index
- */
-int platform_get_irq(struct platform_device *dev, unsigned int num)
+static int __platform_get_irq(struct platform_device *dev, unsigned int num, bool warn)
 {
+	int ret = -ENXIO;
+
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
 	if (!dev || num >= dev->archdata.num_irqs)
-		return -ENXIO;
+		goto error;
 	return dev->archdata.irqs[num];
 #else
 	struct resource *r;
 	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
-		int ret;
-
 		ret = of_irq_get(dev->dev.of_node, num);
 		if (ret > 0 || ret == -EPROBE_DEFER)
 			return ret;
@@ -104,11 +99,11 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
 	if (has_acpi_companion(&dev->dev)) {
 		if (r && r->flags & IORESOURCE_DISABLED) {
-			int ret;
-
 			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
-			if (ret)
+			if (ret > 0 || ret == -EPROBE_DEFER)
 				return ret;
+			if (ret)
+				goto error;
 		}
 	}
 
@@ -122,13 +117,32 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 		struct irq_data *irqd;
 
 		irqd = irq_get_irq_data(r->start);
-		if (!irqd)
-			return -ENXIO;
+		if (!irqd) {
+			ret = -ENXIO;
+			goto error;
+		}
+
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
 #endif
+error:
+	if (warn)
+		dev_err(&dev->dev, "IRQ index %u not found\n", num);
+
+	return ret;
+}
+
+/**
+ * platform_get_irq - get an IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ */
+int platform_get_irq(struct platform_device *dev, unsigned int num)
+{
+	return __platform_get_irq(dev, num, true);
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
@@ -142,7 +156,7 @@ int platform_irq_count(struct platform_device *dev)
 {
 	int ret, nr = 0;
 
-	while ((ret = platform_get_irq(dev, nr)) >= 0)
+	while ((ret = __platform_get_irq(dev, nr, false)) >= 0)
 		nr++;
 
 	if (ret == -EPROBE_DEFER)
@@ -195,7 +209,11 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
 	}
 
 	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
+
+	dev_err(&dev->dev, "IRQ %s not found\n", name);
+	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(platform_get_irq_byname);
 
-- 
Sent by a computer through tubes

