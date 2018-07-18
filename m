Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAC8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9BC2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxwL5nwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9BC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbeGRUs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:48:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45620 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeGRUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:48:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id 94-v6so2515517ple.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C4QDxfwbcSCB7qVJ4ISeVsB/ZWDUU3UoPGKz3WkRL2U=;
        b=SxwL5nwuLJAU6wglAbFMjHAzucuB8O0I8yWtC37TapucrKD7KZ2DnKCH2gT5KhzYpI
         oFCgkAFQwIV3SOXZlnnN5SE/hlHAvArQEnxCFPyOYkVcCc5Hv3OcOKnbl0C4lNfc4L6l
         +jnhsyPNOoqdHZ8bB7Fqz2ehdX0UIqE1WQWog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C4QDxfwbcSCB7qVJ4ISeVsB/ZWDUU3UoPGKz3WkRL2U=;
        b=fy1B4uykTMAJivek2e6AcWrtpsmj/NnQxfqbeewDP+yxVLIh5Qc6nwNXwUknIBQmO5
         UA7MZWQZe7ptHzas7kGhjjfqgEaXvT8/BclLOCIcuh0xGz/TuYHxJHgmYK4t1WphxCNh
         Ng4NH70tGGG+/thrkioKERGhtvzvxmoGfzvJGI2jZ55ufeg/uJ3sDmvvQhBJqmuCtVCt
         A7nkRCwNsbwqElDmHwU+qYeFqyvXlSJbEPMhd6b0mFZQwcyb08pf8165xhHMQPUHwtTH
         8XbytzE+UkS/t78Wgf1VisVN7PD5K6P2D/mNTnkjVnA6CwcWpBmYsal/1hUw4kfutSue
         GduA==
X-Gm-Message-State: AOUpUlEmAz3Nxw7V7azSwOdExyUc4LTCK/tXiexfyqT79mcvKQ9J7kNe
        y/vPzMix6oBiOhv2lZRnlKw7
X-Google-Smtp-Source: AAOMgpezqNB4R0jDfGt4HZGZfHh3I1D3AKW/Am+lQ+5ESWbj3I7uF/RSJ/BWz6xRl0ZIonYlF4JNrA==
X-Received: by 2002:a17:902:201:: with SMTP id 1-v6mr7330898plc.310.1531944537193;
        Wed, 18 Jul 2018 13:08:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:628d:5c0b:b467:58cc:4c91:39b3])
        by smtp.gmail.com with ESMTPSA id c7-v6sm6924697pfh.25.2018.07.18.13.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 13:08:56 -0700 (PDT)
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
Subject: [PATCH 1/4] dt-bindings: dma: Add binding for Actions Semi Owl SoCs
Date:   Thu, 19 Jul 2018 01:37:06 +0530
Message-Id: <20180718200709.27102-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718200709.27102-1-manivannan.sadhasivam@linaro.org>
References: <20180718200709.27102-1-manivannan.sadhasivam@linaro.org>
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

