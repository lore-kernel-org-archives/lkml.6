Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0E6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4740206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtQCuulE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4740206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407204AbeKTDgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:36:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34008 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406987AbeKTDgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:36:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so14897486plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jR8jqkNYSDl0WkyGt3f6ZbMvtSjkCAlWkbZwvvthT4Q=;
        b=AtQCuulEmbyxqFCrr8YT3Yj0qbNwCan7xmvvis0aYZjuuPPiFVnXdf28v8y0y2yfLD
         J/EmXrfxunY2ERgp6QqjW87tNaShRqY8hdLWanK8A5gkr4mHMenKPjGrHMmWDSk9mMGc
         qf0+bP3tSQ8F65kcyDXcObanpXL0Zz4FP+8o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jR8jqkNYSDl0WkyGt3f6ZbMvtSjkCAlWkbZwvvthT4Q=;
        b=WdR8OaNsJdhiBTWor7go0wfGwtxZ0q7JAyg/HxIKtpnxOOl83I4DkFYdx0M/Szp1pn
         FXJKnAO5wXby9UhJhFDvtpVhkshy0wKCJwpvigZd6z1M6/AyxwIgM9+6Kj6nCh5ERA+o
         mI7R0M06BeKzBhXO5uTP2Pxk8z4NVyjtnuI4pEzEmCfDzLV94DUxbi4MONfjqLz0TE0Y
         U836DP4VF5ZpjfZzxt94xDidPS3bQvs0R4rpipF7O2cdkSYz3xOgQbLi2P0fNRJeKaIm
         U2RP09UTSszrlLPtkDvuEEiBDl1qQBjZRoRelicP+GTy5/3bLKho3FQ6cJYyrNTYtByw
         9HEQ==
X-Gm-Message-State: AGRZ1gI+ZbBY27ihtrcaE2R57Ypx1X/ddoCnfv1Y8p1z6ukGcdWSbbaX
        L6uqesQUGoMTxeY3sj1hRRZs
X-Google-Smtp-Source: AJdET5dV4HQOR/46m8yQRRxsWqK1bWhoSbBUJdTllxxpu81CyKwC/7HPnLHbpzVtlDnJRFmjRYNshA==
X-Received: by 2002:a17:902:5a4d:: with SMTP id f13mr23896113plm.49.1542647505288;
        Mon, 19 Nov 2018 09:11:45 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:11:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/16] dt-bindings: interrupt-controller: Document RDA8810PL intc
Date:   Mon, 19 Nov 2018 22:39:30 +0530
Message-Id: <20181119170939.19153-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
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
index 000000000000..ed53ad0574a7
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
+			intc: interrupt-controller {
+				compatible = "rda,8810pl-intc";
+				reg = <0x0 0x1000>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
-- 
2.17.1

