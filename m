Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81274C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5430C2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlJdw/uG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeLRIHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:07:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46726 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbeLRIHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:07:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so7430813pgp.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k96hsxZolu1sa/Mqv9NhVh1bJBzRAtxF7fEifhZ67Nk=;
        b=AlJdw/uGz7czICwip0ZrTr6cytQi+WuqGoK8Q4UAWR1xoSCWyM01f4JHZQfZVAh8V3
         28eRju5jVt+QgYmhyV04LXH19DGed8R3Aas1MlVsV/pxHq5wkHPKo76/muGeO+BpnJ0y
         3SFc7WmmnDpKoLk7oEvrOHrHSMKld7/ss6VJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k96hsxZolu1sa/Mqv9NhVh1bJBzRAtxF7fEifhZ67Nk=;
        b=WLFzXaQG1BZvnvAa9gDru7aZsThQ7dFFAmS+YsR3dwrfdX+4xTg2QryizEJRApGH6q
         ujUV1mfcsbggzcQ/1xZuCxf98+qVXirBBaGLgEnceQ6T7O5+9sTwUZKj04R0P1ADj/bH
         zLBHnNn/VN+jkSM1A5OWcm6ghKqBr/GzEY94CWwGOBLtku7n93hLK8fRH4G5tORN+2L4
         WvX8V3FTTlHwJhFVDEgD62Y+YOcwa5U8Z9kHLbTVkFMmUMV79rt0JznSbo/R5se+V7lG
         6QBQ1NRGOF+KvStMBLiP4rR9dA0q0hVfNkXtd94ndA2RrtBHpo2Tk+mOpaPfwnk2qrbn
         qWLA==
X-Gm-Message-State: AA+aEWYQ1u00Re8qXRMcGmdis93sg7TwKJ2Z+1QT+3WKbBb+ooe6Hh8F
        rBA8BO3RxNeDb561P5839pLI
X-Google-Smtp-Source: AFSGD/WnNDgfAlNIocxOUgnw+OlEO21Ineonsurmn17j12sYazsxrWIyyCVy3D6ufwJHJ+fho0nnaA==
X-Received: by 2002:a63:2054:: with SMTP id r20mr14819276pgm.328.1545120429504;
        Tue, 18 Dec 2018 00:07:09 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 00:07:08 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 11/11] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date:   Tue, 18 Dec 2018 13:35:27 +0530
Message-Id: <20181218080527.10801-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for RDA Micro SoC architecture with myself
as the maintainer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c3fbbb361f8..7f2ae2ed53f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1945,6 +1945,20 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/RDA MICRO ARCHITECTURE
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

