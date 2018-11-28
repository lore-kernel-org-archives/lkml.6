Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05698C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CE82081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SK785JAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CE82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeK2Aza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:55:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46282 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbeK2Aza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:55:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so10182836pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTOWvfrx0BsJZxmGzOshOzTkCx1AKkW+EAS4P/Cqekc=;
        b=SK785JAAAO/9+uAZAXkEOvcg4cIA/nAspbe3vrMc4EiYmsqyANbLPETDmNiVfQu8sa
         x19/SPHk4K3zQbZ+If321OCpWeq1hYrYPUegiIVvwlDcdWDKRZMNZUvf5VoyzMVH2wyd
         S4KMCXe0TCQTqfWbZxIHfu8t3SOzd0ZQ3ThKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTOWvfrx0BsJZxmGzOshOzTkCx1AKkW+EAS4P/Cqekc=;
        b=rTq2IMVlq7kqytI+xIRZkGoMfsUiUAYrNRrNk0P5zaHkjMBTXapfidnD+cClkmpZeb
         c177QWkrxwKqwfqce2oUlYWlhI2BE+hVCQ/bhF4nTKkhak3qi653vgQ8SGknxGthd6jR
         mpGrfBUvgAepPsHtrp4iExT8njLV9WX4a1zttyLoEzyxZGfdQfc5TgXzeJWrdidd1ngX
         41gjHwugN7+nYmDyc1zcYg0UTriMSCuwz1PREvEuTyFbgbbhmmUZtGwSiDcQKSbqbCFZ
         P1q7HdkHe59MEIsp3/amfl2PhpLCDeXDP51zsvnGiF2oDjqq8v37RmQEmU7+mhLQxNbl
         r8TA==
X-Gm-Message-State: AA+aEWZaAviIYBJVs7uFRAhHpSFB0z87C4T4q99Sq4tp1DPaRTYumdHo
        Gl4Xd9ZxaAgUg8ZgW0RiMdfc
X-Google-Smtp-Source: AFSGD/Ws8vdN+IYvkP9uWFFdWHhRi43gO7ku0nVchrPStXkD2+03POWuoLNR0Aby4bKhiOZNavVRqw==
X-Received: by 2002:a62:6385:: with SMTP id x127mr18848789pfb.15.1543413226288;
        Wed, 28 Nov 2018 05:53:46 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:53:45 -0800 (PST)
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
Subject: [PATCH v3 15/15] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date:   Wed, 28 Nov 2018 19:21:06 +0530
Message-Id: <20181128135106.9255-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
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

