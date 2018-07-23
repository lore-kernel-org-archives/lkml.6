Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1995ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C9720874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4kHHvKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C9720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbeGWFRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:17:21 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38226 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbeGWFRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:17:21 -0400
Received: by mail-pl0-f65.google.com with SMTP id b1-v6so7673548pls.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 21:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C4QDxfwbcSCB7qVJ4ISeVsB/ZWDUU3UoPGKz3WkRL2U=;
        b=P4kHHvKi7cviW0qQtqjWITy1bl+4UL6BfJpFRdzhzg10iQNN0KRzfYFY1C4u2OpkQq
         JbOwdbqmno9BmC1gnLZMGTACzlID9DEaWBMzWL1WFXm+rvkXqUA/gqwJS8qc67NTVTtA
         aFIMd/0fBYd5Gavc7pKomQtXVQAvxK/wHkcT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C4QDxfwbcSCB7qVJ4ISeVsB/ZWDUU3UoPGKz3WkRL2U=;
        b=ElhJJ1z0s0jz2mWBdYO5iovFNMf/9Tm8YFchE9YmuuTSHpmmUYTIG7VfnghbxXvrIw
         HJO/PpAUEPyKmUy/93m0opBvjJpP95zrEHL7OTCiwXpFKkvlfe6bbe4EE/iPisZPQLg/
         mQBCvXoe+QTkU1FonejoqW/VIn1j5GFsmAO/hM8fn/I5vkJqJB0OB4fBpdGz8EmJsnhK
         LoY/u1RO/QO+wGtY6iGVaa0s1LsCZS5BaLoN9HWP7npUIMTEMtaQUNGwRIoHt1XwxJ0X
         Vht3wPIimYzSsSkqU/sUTEW44yhtp+hoiKcVqaUsId5m2jxWJshodXqTKw351wJeRRXT
         fUnw==
X-Gm-Message-State: AOUpUlFREnrlDcTZ8cx3vMHWAH6DsdFjOTBVmbCzUt2876oCbWAkm8OA
        fpVAWoM/L4Zspcot+FX6tZXc
X-Google-Smtp-Source: AAOMgpdB4ACkGjKTvDaL0hvVQ83MQamvF+2HJQ1ZPTFbDfUEspzx9GZ7zUDuEdqFHOIDBd/xubnApw==
X-Received: by 2002:a17:902:a24:: with SMTP id 33-v6mr11292482plo.88.1532319488743;
        Sun, 22 Jul 2018 21:18:08 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:802:a98c:b568:c01f:49a2:2aa5])
        by smtp.gmail.com with ESMTPSA id i20-v6sm13369282pfj.82.2018.07.22.21.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 21:18:08 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: dma: Add binding for Actions Semi Owl SoCs
Date:   Mon, 23 Jul 2018 09:47:40 +0530
Message-Id: <20180723041743.32024-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
References: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Actions Semi Owl SoCs DMA controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/dma/owl-dma.txt       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/owl-dma.txt b/Documentation/devicetree/bindings/dma/owl-dma.txt
new file mode 100644
index 000000000000..dd6ce237b216
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/owl-dma.txt
@@ -0,0 +1,46 @@
+* Actions Semi Owl SoCs DMA controller
+
+This binding follows the generic DMA bindings defined in dma.txt.
+
+Required properties:
+- compatible: Should be "actions,s900-dma".
+- reg: Should contain DMA registers location and length.
+- interrupts: Should contain 4 interrupts shared by all channel.
+- #dma-cells: Must be <1>. Used to represent the number of integer
+              cells in the dmas property of client device.
+- dma-channels: Physical channels supported.
+- dma-requests: Virtual channels supported.
+- clocks: Phandle and Specifier of the clock feeding the DMA controller.
+
+Example:
+
+Controller:
+                dma: dma-controller@e0260000 {
+                        compatible = "actions,s900-dma";
+                        reg = <0x0 0xe0260000 0x0 0x1000>;
+                        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+                                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+                                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+                        #dma-cells = <1>;
+                        dma-channels = <12>;
+                        dma-requests = <46>;
+                        clocks = <&clock CLK_DMAC>;
+                };
+
+Client:
+
+DMA clients connected to the Actions Semi Owl SoCs DMA controller must
+use the format described in the dma.txt file, using a two-cell specifier
+for each channel.
+
+The two cells in order are:
+1. A phandle pointing to the DMA controller.
+2. The channel id.
+
+uart5: serial@e012a000 {
+        ...
+        dma-names = "tx", "rx";
+        dmas = <&dma 26>, <&dma 27>;
+        ...
+};
-- 
2.17.1

