Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E58C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912952082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3bOoblA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912952082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeLJRiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:38:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42874 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbeLJRiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:38:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so5723465pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L2eV2hqdutu4ir5j3LLCjolH3gJjyj+3j8k2gdmQdYQ=;
        b=U3bOoblAbInzfGegDoqhu/9kzokD3qYrXQEvRqPoXjgdQbBSoVsM6t8qPvVWWB6d1e
         clFu4aY8URJegm/tiF/A5fS0ktOg9ojkNK/CJhdqLWmIHnO/bQxGidPqezZ5lq9g8kZ2
         phoYjERqhnlslQijiijN9QmD/PuLX2NhDcfsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2eV2hqdutu4ir5j3LLCjolH3gJjyj+3j8k2gdmQdYQ=;
        b=O+0pufA4qSOxlvFKMEM+G+zUPCgzf46N1Bw/j/MvwuAkzxBruXM4J8BqTLP7qkXeWt
         js/GZmxhvOU0lLaLN9VdDOq/vat4vWy34z7IE6LKOj19AdbsdmwDVF8cnnacAmK5Iagi
         AXXfL0NNedCTG0QbapWhgwDl2hGE9AkaXYRA+QrJdr9B9gBxn+PZCbT9fXGlTAfJk243
         6rdSXFtXRVbBC5N26/D6ZC2SNTF6EYUxZHNh/E9X6hXG6nPkCrf84bXp9q5OCGcksLK2
         yCMpFOtX/IVDQEXIkG5JSzT9rOWRDyOLjJU4eMX5ufxPY8gOQRHWpKPYnEBa0fu3aaNG
         rfNg==
X-Gm-Message-State: AA+aEWYOoXJJp0tzumYP6qlbdWUdwRspuHdKwK1kT4fxlV1pCUiRtz3E
        zkv1ewpqrY96bAuljT4OgTjz
X-Google-Smtp-Source: AFSGD/XxM+bjkbXbopbHPNceRfGRUiDM+u2u1wyu/fT/vDmKU7El5RY98fcKsK+PHEMwlH0st05b8A==
X-Received: by 2002:a62:a99:: with SMTP id 25mr12973568pfk.121.1544463497072;
        Mon, 10 Dec 2018 09:38:17 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:38:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 15/15] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date:   Mon, 10 Dec 2018 23:05:50 +0530
Message-Id: <20181210173550.29643-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for RDA Micro SoC architecture with myself
and Andreas Färber as the maintainers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c3fbbb361f8..6411fb222590 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1945,6 +1945,21 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/RDA MICRO ARCHITECTURE
+M:	Andreas Färber <afaerber@suse.de>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/rda8810pl-*
+F:	drivers/clocksource/timer-rda.c
+F:	drivers/irqchip/irq-rda-intc.c
+F:	drivers/tty/serial/rda-uart.c
+F:	Documentation/devicetree/bindings/arm/rda.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
+F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
+F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
+
 ARM/REALTEK ARCHITECTURE
 M:	Andreas Färber <afaerber@suse.de>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.17.1

