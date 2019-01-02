Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C1CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6266218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XKnTc2qU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfABSvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:51:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34357 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfABSvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:51:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so14860565plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 10:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HKfEMnbHSewczzLJZOpgSyzV+WfqxvtlV1fTobNlf4=;
        b=XKnTc2qUAm+sCV7kK4NKXgSyuqPV1e5GiKvz+NemSyIzAra40nrc/k1rxC42ZPfY5n
         ZXOLM/7sdPYDYGzn451hL0jzau1BHQjsctrODfAq28QVgetdr61j4q9ZOtOoR6PnlE2R
         0sw2TrTjrtnSjSyadvTvgYT2EKxZ74A2JNoc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HKfEMnbHSewczzLJZOpgSyzV+WfqxvtlV1fTobNlf4=;
        b=pGs4dD8UjJqYFh09W9dD2GSbrQVIur9TEEzHuhV7oP/MklnPCqEaLIGyKQvQDHj4yf
         mrGUpYjwAYGSeO2GcdL6JW9Vmy1H+lGoPTCuIMzUy86CMxNh433fziwzqqEP5CxYvoB8
         gLm4GimWonq4o/c/25fmo8q11kor2IbdQiJuqu7K9k5ZII9D2Zw9dcrokUlb037cGI+s
         HD3jKy0OLOF5Uz7dCLrZRXaY3y3iW7aERgXsaQQ61jZ3s0Fx9jlQDemG/a/vNKhyAEaz
         89yvG4QzoIoWfg5JneC/LJMy8cgviiGaLRy4Kae/moqagJM8n1gstsAp6j8Kbxpax/3Z
         YM7Q==
X-Gm-Message-State: AJcUukenNdY9yRcYZVN3rPt7jYdlyB46OOhE6vI5Sqi//c9FstTKnkgN
        7FJbEEnIAsC2yOga+MJHdjby/A==
X-Google-Smtp-Source: ALg8bN5no1yyoBihkGJA9F0mZVUp6PXHb/nR8kM7g7OL0ckcxVQi06jhMcP1bZX40gyQP26tOdWhUg==
X-Received: by 2002:a17:902:9047:: with SMTP id w7mr44696541plz.270.1546455068444;
        Wed, 02 Jan 2019 10:51:08 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c7sm78250800pfa.24.2019.01.02.10.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 10:51:07 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     robh@kernel.org
Cc:     a.hajda@samsung.com, andy.shevchenko@gmail.com,
        b.zolnierkie@samsung.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, javierm@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, m.szyprowski@samsung.com, rafael@kernel.org
Subject: [PATCH v3] driver core: platform: Add an error message to platform_get_irq*()
Date:   Wed,  2 Jan 2019 10:51:06 -0800
Message-Id: <20190102185106.56913-1-swboyd@chromium.org>
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

Changes from v2:
 * Don't refactor platform_get_irq(), just wrap it

Changes from v1:
 * Update error text to indicate irq index instead of IRQn, use %u

 drivers/base/platform.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4..388461306dd4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -79,12 +79,7 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
-/**
- * platform_get_irq - get an IRQ for a device
- * @dev: platform device
- * @num: IRQ number index
- */
-int platform_get_irq(struct platform_device *dev, unsigned int num)
+static int __platform_get_irq(struct platform_device *dev, unsigned int num)
 {
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
@@ -130,6 +125,22 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	return r ? r->start : -ENXIO;
 #endif
 }
+
+/**
+ * platform_get_irq - get an IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ */
+int platform_get_irq(struct platform_device *dev, unsigned int num)
+{
+	int ret;
+
+	ret = __platform_get_irq(dev, num);
+	if (ret < 0 && ret != -EPROBE_DEFER)
+		dev_err(&dev->dev, "IRQ index %u not found\n", num);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
 /**
@@ -142,7 +153,7 @@ int platform_irq_count(struct platform_device *dev)
 {
 	int ret, nr = 0;
 
-	while ((ret = platform_get_irq(dev, nr)) >= 0)
+	while ((ret = __platform_get_irq(dev, nr)) >= 0)
 		nr++;
 
 	if (ret == -EPROBE_DEFER)
@@ -195,7 +206,11 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
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

