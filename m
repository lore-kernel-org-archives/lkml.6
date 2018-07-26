Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C6CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CB520673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFNP6N7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CB520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeGZGWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:22:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33855 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeGZGWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:22:31 -0400
Received: by mail-pl0-f67.google.com with SMTP id f6-v6so267170plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 22:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cd73XDFSEX1ohFky7INlC/9VLpbnqGIbt7UvK7l2ck8=;
        b=eFNP6N7V6aIoYgAMyiitFxhkkt67YY7Csf6xHenNKQLZ90wtONE6+Kgq2sicf2OZqG
         TC181NEbxPRb3GjrWMWx25OIIXyh6spnz5HUZvl/iZjidtfWFbUVsJIAx3OfGK/Lt1Ao
         QwAofelgW5ZnaHJQNtMwGL9+wCSTiKBjevGD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cd73XDFSEX1ohFky7INlC/9VLpbnqGIbt7UvK7l2ck8=;
        b=XTgz9dVQrry8w1p/9YMIAXOGZf/D1cQ48CEy7q8gSVb2CwrRynWyWEG/oc4lGlVwbs
         8MZvXWMHFXJfsMQv7+LSk3v8RPyuLqRGqmSLAKXHXLjrhgDTHU03UOE0EZq34L2On+6o
         I9bBe+J5n3eJrZstSp+xXjQIDSzYqncKlnOiuQuGHczCE2bcFu8U3eJf/EFBfPQj098N
         Oy3CEqJoCai43GpyY0zTGRPi0Ii70NweYekeECfujxR04QqXyI2RL32yefp5wxuKM88F
         7vq/iXHEYOMRfAd2h8DbTaKI2jVyqu0SGLra0tR3hX+cQF3rrJ7nKN1yHfKpMLKiOcoN
         X5ZQ==
X-Gm-Message-State: AOUpUlHuczdNAb3qnNSjlrrvbGZ9GD4LCYQIvlFnIpEZAqnfauY0fpi2
        ISM3rQ3Q6OYujNh86gm2fh0lTiO75Q==
X-Google-Smtp-Source: AAOMgpc5cWrjrWlKIzqoBmQvOmZcCVe8PEJ3U7hIUjXAFW3+YenIQ7p8DxC3cPEJ1BzsYXWkQVr2Iw==
X-Received: by 2002:a17:902:3081:: with SMTP id v1-v6mr534683plb.266.1532581649190;
        Wed, 25 Jul 2018 22:07:29 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6208:6a6e:a8cb:6394:3bdf:2b97])
        by smtp.gmail.com with ESMTPSA id y4-v6sm492540pfm.137.2018.07.25.22.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 22:07:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org, dmaengine@vger.kernel.org,
        liuwei@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: dmaengine: Add binding for Actions Semi Owl SoCs
Date:   Thu, 26 Jul 2018 10:36:55 +0530
Message-Id: <20180726050658.1399-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726050658.1399-1-manivannan.sadhasivam@linaro.org>
References: <20180726050658.1399-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Actions Semi Owl SoCs DMA controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/dma/owl-dma.txt       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/owl-dma.txt b/Documentation/devicetree/bindings/dma/owl-dma.txt
new file mode 100644
index 000000000000..03e9bb12b75f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/owl-dma.txt
@@ -0,0 +1,47 @@
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
+- dma-requests: Number of DMA request signals supported by the controller.
+                Refer to Documentation/devicetree/bindings/dma/dma.txt
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

