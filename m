Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E7EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2E9213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJDr6Sfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2E9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeKUOMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:12:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36814 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeKUOMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:12:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id y6-v6so3387077plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTOWvfrx0BsJZxmGzOshOzTkCx1AKkW+EAS4P/Cqekc=;
        b=hJDr6SfwqwXmLpxBMawMo3t9tZdCNcz5Ibwy3+xGs+3yYtQbI+D5FqveSwbrlfGXsh
         IxHYL7J6SeyAtBp7SF5pM4YD66IyibTQ6eT/yeOzJLA7sJA8ldKz1i2YbOCtzP9d3QpX
         jyv+JrtAes/a3WJZMHLe0k9IsilRWCU6mxI2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTOWvfrx0BsJZxmGzOshOzTkCx1AKkW+EAS4P/Cqekc=;
        b=pWyJ3Zw7DRUv6Yyl0Wa0l5pCdbzsEF1VgFPkQKcqtiCvnZxDi+oj9QxrHUdCMFLFfb
         Bq4ZfxomXarX5yQbLo9TdbriyBxlzODVwvEHMSKJ7+Iweu2iAkbdVXWFGgeRWCloOvuO
         i4/Nj/Ox63+5uzABImp1+99f8lug+ZaeMszBPlbvUXhfo5nqpb6xJbPpqbsn+WJv8XTV
         e8rotk23VB4TSyc58d4hfAM6tEdEQDegHvSqM84SIAygyecYrMUOtWC5bY6mEvHqqWHQ
         utcOx5rYkT3Ze2fhnnBYtkFCNGDqF+zCBJHju5trDGiNOIH76rlkjT/sO5gKr5UT8fOM
         ODQg==
X-Gm-Message-State: AA+aEWb6Diyg4YO7ysyH0torMCebRqPAitsaTh8s9jUDHG2pgwDlov/V
        z3yWFG6EzLriRCpHBtYQavY7
X-Google-Smtp-Source: AFSGD/Xi4Hg7ko9o4lEGK+yHenIjUwyU29/LcfjDW9tyzqByLz1/BstRsAU8RENKxV2Z4/UuyXcUcQ==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3-v6mr5039743plk.208.1542771586612;
        Tue, 20 Nov 2018 19:39:46 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:39:46 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 15/15] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date:   Wed, 21 Nov 2018 09:06:52 +0530
Message-Id: <20181121033652.12247-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
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
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c3fbbb361f8..7a5ae685a638 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1945,6 +1945,20 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/RDA MICRO ARCHITECTURE
+M:	Andreas Färber <afaerber@suse.de>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
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

