Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D2FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EE12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YniCNrr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EE12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeLJRgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:36:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45555 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeLJRgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:36:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so5265306pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FUp8E+CGlwLSF4T3S4rK0JomvyH9YIEf7Nh63jsMMN0=;
        b=YniCNrr3AFiAc9wcGv6ZuUDdPSCcJKWLJ0BjQ23qA5T2fdfJdWtkDXfmFJD4Rqls5L
         GAUXoZA5BvyuH36Wtn8Oz+dUU045BE49wofRDchzZkLEmKT573wD+3naAQsizLPIQewg
         WwwRWmURRZrKfr6xX+FqT1RtgfyeMbyw9Dv4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FUp8E+CGlwLSF4T3S4rK0JomvyH9YIEf7Nh63jsMMN0=;
        b=KkO1bjjbrQJjECv4RHgElo5b5IPWOl6jjDC4yGmo98fsuIT8SKiQxfzDazERLR4v7G
         2xhx/prviEmvkNG66MbRFTVOiUeOEUAjN5XJrpNJ57eXy/V6GDyDxkADuyz+eXW9hWc/
         8MaB9vrRtNhO7F5TCCFLIUkH2E9k8met67AazVJcffOt9AKgAP02sGs1yfDo1rLgJVU0
         xAfeAZl2twViGN2LdtRHA1t6AM0ErJvD1ScoI9/GMCrIHWSZzTjTOHWi2z1a1Obmm+cG
         g81++NGl5yNFdpMtmZiyh8hfvwepIwWCmq979tRKVPnuZVOHWZUZaYuCBW8N340zHagm
         2L1g==
X-Gm-Message-State: AA+aEWa0Ne64Jq89j50KqMSj+qa9/cjm3Eg5g1KxldnHvzOiIVu0vs74
        78C6vr96Z42cbNWlJY5Gr5Wk
X-Google-Smtp-Source: AFSGD/V1O1sE9JfOU8jfvEe9jiXGzIdE3BLB5mf8Tjjr6nCnIkOZPrttdEIWOhGWoe2kB8MUQT/MDQ==
X-Received: by 2002:a62:6cc8:: with SMTP id h191mr13752965pfc.89.1544463398965;
        Mon, 10 Dec 2018 09:36:38 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:36:38 -0800 (PST)
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
Subject: [PATCH v4 04/15] dt-bindings: interrupt-controller: Document RDA8810PL intc
Date:   Mon, 10 Dec 2018 23:05:39 +0530
Message-Id: <20181210173550.29643-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document interrupt controller in RDA Micro RDA8810PL SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

