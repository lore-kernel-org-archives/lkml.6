Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FE5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA7C2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5zZPH1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA7C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeKUOK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:10:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40605 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeKUOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:10:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so3374222pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u6fmImAznleIoNGGi0rVkBDi0LpKZQqF8erXbtWcAbM=;
        b=K5zZPH1KcHzjhA4eE8W7WmcxmpSjOll/hziQH4sB7LiHrXNHSWs+zq6ygiyFSHgS26
         Bq9735LfUtjLW9X3EunJo9lb5C1f4dCkl0C+7kC9NyPWJwIjR7Xuj4vLzZmq19/TFg/m
         UcQcxA8Wg8f1xYYiBYe5VK9r7afolShdb6Ua0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u6fmImAznleIoNGGi0rVkBDi0LpKZQqF8erXbtWcAbM=;
        b=AS+u5Ev/O084hQT1qnwxihxWWgB6VA/9h0l0DHD1C3qfhJWpjDUhavZDyg04JZjJML
         3Cn2+S+Vgx5MhuHOlGwAs9DnhSDKc6rs4T9bZaS/BFiELyo1fBlj6ojmIqwTuWedQ2c4
         wjJoNmss7PoFOCW3+ozrF6CF5x3JYBRBplOLNqZZBS6/nzgoTWUv+QrBFGOJ9WKIFhiW
         SiOhiQ7wIRU2TUdsK4wMahyWpy3MqglD0NPsVAdOOl24OOaKvYrjbv0Gs5HP3nuF/YPg
         4qSO94clfJBuBF4RHgZp/PZ9jP6HR8cIGTNNrd5gzeWMsi5UCw/brVj2tzXYfiOrMldL
         wC7g==
X-Gm-Message-State: AA+aEWbvghpfpa1cRb4gDYIyxzszigu2sBuM/Jau2zCHVa1XpdjSEeiA
        3eAHgOzltzbmfZ9WgyRVOesm
X-Google-Smtp-Source: AFSGD/VgHg+w0yRSWkAMnFNeWO80/t6ahJO4R5s0tdPB/VsUc0HyLe0Vy0cdnwilqcfNhrgCp7+HNQ==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7mr5114410plm.212.1542771474453;
        Tue, 20 Nov 2018 19:37:54 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:37:53 -0800 (PST)
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
Subject: [PATCH v2 04/15] dt-bindings: interrupt-controller: Document RDA8810PL intc
Date:   Wed, 21 Nov 2018 09:06:41 +0530
Message-Id: <20181121033652.12247-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
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

