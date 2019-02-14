Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC487C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733712229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pwZNtwDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbfBNOz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:55:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41362 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439539AbfBNOxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so6769868wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
        b=pwZNtwDVFgskTDLFLLn0oLkO162MiONw1Ekf4vyO6UTr70McE4oM3hncY+QtoO0cHn
         slTCyXK4aqSNKvAFSzyyFBc7ij6E3fj/5sReIfZfYUAsIkyktqmUuli1hhr3igJu2WsG
         nhBFUDtKJxZRAjFsH0rmx3uiurmK38wrC8X56zCkz1A0rfWfZpIg0w60t1BOHYndrurg
         IHI9TrG8uzmhYrrlhnoZbjc/kDzEc3UXeycA2M2M3wZWr/PImq+08XB/pl7vtYU/Y58W
         uH+dWi71LUjpwhKwTyU7cEwZNH7Fb0zigoE2E9DDpZ8YZzdo8BBVQwAcvacab2Owc5RT
         qaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
        b=K/a3iTT62Mbpm1yeqeVCLrjGM/QU4bV000ZvkB79CIfrEw9nQg3GYT7Pz7YqgyYoNE
         NY8sSuJlACU0c7Uos9WzSvEkpgt2s8E/6QFopk6H6qrvea2bcUvwqkxcaU1YJHNRh1zl
         Dh+9LoguAoFnJrPn7PSioyVy503ELKBOX/qBprRt1vyWLnNpIEH3VSlRIFhs+v68iYFZ
         atIxIzKaiJzEuD2fJVbXCyUcY8owDSoTh+QzgnHoyAjpLojW8nmbtyYYUtOZUMBCxlSS
         jMPO6qXfnZPB6F+79iO7d1d8nOdRIyaVlv9dmfF05OSp2tcgGWsoGOWoi7wgeEpjhkbV
         5NVg==
X-Gm-Message-State: AHQUAuZ9pXldrHjKjsZT0iggTQzNs8rgiwduKNqvwKD9iV0TsB5ltdDK
        XJ22XUZp78Ol9J2VKgS4jjMd9Q==
X-Google-Smtp-Source: AHgI3Ia8dUSUh5YPbFOWFhMJK7tp8/x/zq3leoFs4A/qCwpv8bC1qot0/UE6SEaCofMVgAgvjeDZyQ==
X-Received: by 2002:adf:f011:: with SMTP id j17mr3204903wro.166.1550155981250;
        Thu, 14 Feb 2019 06:53:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 15/37] irqchip: davinci-aintc: add a new config structure
Date:   Thu, 14 Feb 2019 15:52:09 +0100
Message-Id: <20190214145231.8750-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a config structure that will be used by aintc-based platforms.
It contains the register range resource, number of interrupts and
a list of priorities.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irqchip/irq-davinci-aintc.h | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/linux/irqchip/irq-davinci-aintc.h

diff --git a/include/linux/irqchip/irq-davinci-aintc.h b/include/linux/irqchip/irq-davinci-aintc.h
new file mode 100644
index 000000000000..2b2ace3c1b22
--- /dev/null
+++ b/include/linux/irqchip/irq-davinci-aintc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2019 Texas Instruments
+ */
+
+#ifndef _LINUX_IRQ_DAVINCI_AINTC_
+#define _LINUX_IRQ_DAVINCI_AINTC_
+
+#include <linux/ioport.h>
+
+/**
+ * struct davinci_aintc_config - configuration data for davinci-aintc driver.
+ *
+ * @reg: register range to map
+ * @num_irqs: number of HW interrupts supported by the controller
+ * @prios: an array of size num_irqs containing priority settings for
+ *         each interrupt
+ */
+struct davinci_aintc_config {
+	struct resource reg;
+	unsigned int num_irqs;
+	u8 *prios;
+};
+
+#endif /* _LINUX_IRQ_DAVINCI_AINTC_ */
-- 
2.20.1

