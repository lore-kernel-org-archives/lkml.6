Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B63C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0988120832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSMu2IzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0988120832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeK2Axn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:53:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41799 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbeK2Axn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:53:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so10196248pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u6fmImAznleIoNGGi0rVkBDi0LpKZQqF8erXbtWcAbM=;
        b=NSMu2IzXjhP+ZJp4DxZgYnFWRXmBCSGPjplbSG739y56PGyJ+smjo6ipDhf6sZsG8b
         dkYy76V5OUXPbRfBrZYB00+vBC5NoWpClDv3ptNfTa4BIlKXPofMmIBlQWlkAYfwMMRQ
         HvD09bJ7eBI8axNS/l+j5/g0cArGLhY9/VgRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u6fmImAznleIoNGGi0rVkBDi0LpKZQqF8erXbtWcAbM=;
        b=qYv3Vq79ZNs63Pjzp02TbLbECF2V8qLXEr0JTqcRgCynQLqS3OYbCrV5ORy29E6i2b
         HsOvZwdMGKluEN4VqsDagxBZq/PvS+xqEAOnrW5tIPBLGwbwSTz6MAbcrmhmqJ+081zt
         5L2OLTC8SwJQfq3u5RrIueJ9a0bm9jewUh0Sn54C4RlAvCka0r3EQkUcGm+xsV/Bihc6
         qdMb/sOzCwVjT/vKRLNTymvbsmW7HCZx4QeORY4FAx417OOQidpCrA4tvpvKqBvLrfbU
         34zQDhOngguf+dibHPLSl9G+9WyqB5HW5k8SdIqr+fbB7wJ2lkKp49GjqaVjTIoCynPm
         NPzA==
X-Gm-Message-State: AA+aEWY5XCP105KecOIoL5ZxRQcPu6kPVDcSMfhK7NHoTG0t0Ie98JMs
        4WFN+GMXONS5ChpyZwSThogn
X-Google-Smtp-Source: AFSGD/XV+jbGcQCKQOgZEU8BMm4pGH+tdFzn+ycu26oqnjeM7X/0RkntghlTMX777Sh4l7tD0L5/Yg==
X-Received: by 2002:a62:5950:: with SMTP id n77mr23081507pfb.128.1543413119530;
        Wed, 28 Nov 2018 05:51:59 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:51:58 -0800 (PST)
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
Subject: [PATCH v3 04/15] dt-bindings: interrupt-controller: Document RDA8810PL intc
Date:   Wed, 28 Nov 2018 19:20:55 +0530
Message-Id: <20181128135106.9255-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document interrupt controller in RDA Micro RDA8810PL SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../interrupt-controller/rda,8810pl-intc.txt  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
new file mode 100644
index 000000000000..e0062aebf025
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
@@ -0,0 +1,61 @@
+RDA Micro RDA8810PL Interrupt Controller
+
+The interrupt controller in RDA8810PL SoC is a custom interrupt controller
+which supports up to 32 interrupts.
+
+Required properties:
+
+- compatible: Should be "rda,8810pl-intc".
+- reg: Specifies base physical address of the registers set.
+- interrupt-controller: Identifies the node as an interrupt controller.
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2.
+
+The interrupt sources are as follows:
+
+ID	Name
+------------
+0:	PULSE_DUMMY
+1:	I2C
+2:	NAND_NFSC
+3:	SDMMC1
+4:	SDMMC2
+5:	SDMMC3
+6:	SPI1
+7:	SPI2
+8:	SPI3
+9:	UART1
+10:	UART2
+11:	UART3
+12:	GPIO1
+13:	GPIO2
+14:	GPIO3
+15:	KEYPAD
+16:	TIMER
+17:	TIMEROS
+18:	COMREG0
+19:	COMREG1
+20:	USB
+21:	DMC
+22:	DMA
+23:	CAMERA
+24:	GOUDA
+25:	GPU
+26:	VPU_JPG
+27:	VPU_HOST
+28:	VOC
+29:	AUIFC0
+30:	AUIFC1
+31:	L2CC
+
+Example:
+		apb@20800000 {
+			compatible = "simple-bus";
+			...
+			intc: interrupt-controller@0 {
+				compatible = "rda,8810pl-intc";
+				reg = <0x0 0x1000>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
-- 
2.17.1

