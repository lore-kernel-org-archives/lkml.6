Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077E0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB63121852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5Oa3zfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeLRPEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:04:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38523 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeLRPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:04:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so7953484plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0jyh8TbRs+ubBftXUDu/ZeKR3wTzPoQdZ/y0YGX+yt4=;
        b=D5Oa3zfVcAufguxSRzGRil09A8Zh04Xom2E0ByjblKOSRs6lYPjhNGtxmLEbRO8oJ3
         QavOgFqqqDHwTEuq3nNEwKyW9JQwbh/mVkv9xc4dp5uEqrjF+gIKN+eagAdqmqQwU4E8
         uLU/B9pKY5la5s/4V0EZATDJRZ05fEcF7qk8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0jyh8TbRs+ubBftXUDu/ZeKR3wTzPoQdZ/y0YGX+yt4=;
        b=fM89LM9xpgVigShq33FPS4j3hO55zL8xMRX9TVBiGskKPLoEwEP3RZwHwaOgeFYY3H
         vHYhjV90wHl9y5/65l7bjloE8g6SoNui3hiHVhoXFEiTE7IPmV2Mcw49YMxPIm4N/4pm
         zcOu6buqbVgjpp7I44f5ZtuexzZqLQsxwRXYM97Qhj4CxdkZNaV69gHT9/xzVkzxKWjH
         okxXMJYXSGhFbruBgteZFlbEc9w1MUEdqyb/v0UZBByT+4qtRI3POUNJG/Tws/bnpH1Y
         iZuV3mFzdU4zxfKygeEjnIiRpys+6La6P8i3mnL12XIY4x9G+tkQaJVNhlbJT49WRe9s
         +zkQ==
X-Gm-Message-State: AA+aEWbG0Z+Jd628UcX649easwZtfNWupBVGaUT4k/1SjrdsEqVUsGCY
        QqsPF637PD2d9B3f1buHOTY4
X-Google-Smtp-Source: AFSGD/VyU784cM7cGnfB1aooBbjFAv1aJg6D7/Z6N2CMXMr5r5RAkWIl3cWKMw7FgKAckum2B5UzOA==
X-Received: by 2002:a17:902:ba89:: with SMTP id k9mr16974772pls.189.1545145469147;
        Tue, 18 Dec 2018 07:04:29 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:04:28 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 11/11] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date:   Tue, 18 Dec 2018 20:32:38 +0530
Message-Id: <20181218150238.23010-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3318f30903b2..da2149949fd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1950,6 +1950,20 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
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

