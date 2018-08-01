Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26123C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC60D2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEgcGi/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC60D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbeHATu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:50:56 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42328 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732257AbeHATuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:50:54 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so9149959plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bcvpf2JwZdjv59xkZ4zzQ6yiuLiqFtQKkQsfAovx0i4=;
        b=AEgcGi/NSYUb3SrrIYbvxL4yOApCmS2HwxjW6cUjssRzKVt1QPJm/6zV2v0pork9+I
         GmdwVShfrtnA2HSfFwihY5Cgt+yGG3ob9cfbm+EQUGuOlGf7RUymyybZ3hHwgZtd9iME
         rEk+ypJ92X4wTJjCOnELTCYSJ0DCCftDv5/Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bcvpf2JwZdjv59xkZ4zzQ6yiuLiqFtQKkQsfAovx0i4=;
        b=XoH/RRdgmNWUVczu/VLnpLNoGa+fgFncBEMazJhWj5U5XL9DYQ8xuYxWa9M6iIMnmS
         pyjXqiXGBGkpuswRMjPBWr/Y/oXWISJfyk//5XwUuSofKnpS2Uo3Uq5bx5OFQ/cC2Hum
         0qMItW5JBuXbZ3kBeqMtBR1FlnI0wHlfUi8WiOmLg+rqHC2byEbefw8NiJmvKk1DDiZK
         6nSOBuj7XD588fwbunPu86HzF7vVHgPriE1RO3HcbrjbJEej+W38H6DB2T/8zTm8PPMS
         kVqTGcLAeSJ+MmUoNAVFNY0LYtXvHZpivw91bTNQJ5f71NIEAsg/JAJFQJQfhFmd9a8f
         r3IQ==
X-Gm-Message-State: AOUpUlHmsv0+LHDeOmvr6EwSgu0qtTarGg4CyhhnGhI1jrygd3hwowna
        rFaofl8o8xdVdro9n/Q1DKgE
X-Google-Smtp-Source: AAOMgpdUuoLoMzZeIMClT/daaHqqSNU31wcrGAX5WoMl52Oq2OtsHijDQRKZUmvm5Wy3/8EftZ4flA==
X-Received: by 2002:a17:902:74c2:: with SMTP id f2-v6mr25276510plt.260.1533146640760;
        Wed, 01 Aug 2018 11:04:00 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c1:5a70:e532:a47d:7290:5aa6])
        by smtp.gmail.com with ESMTPSA id x80-v6sm12961649pfe.129.2018.08.01.11.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 11:03:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 1/6] dt-bindings: i2c: Add binding for Actions Semiconductor Owl I2C controller
Date:   Wed,  1 Aug 2018 23:32:27 +0530
Message-Id: <20180801180232.23680-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
References: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Actions Semiconductor Owl I2C controller

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/i2c-owl.txt       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
new file mode 100644
index 000000000000..b743fe444e9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
@@ -0,0 +1,27 @@
+Actions Semiconductor Owl I2C controller
+
+Required properties:
+
+- compatible        : Should be "actions,s900-i2c".
+- reg               : Offset and length of the register set for the device.
+- #address-cells    : Should be 1.
+- #size-cells       : Should be 0.
+- interrupts        : A single interrupt specifier.
+- clocks            : Phandle of the clock feeding the I2C controller.
+
+Optional properties:
+
+- clock-frequency   : Desired I2C bus clock frequency in Hz. As only Normal and
+                      Fast modes are supported, possible values are 100000 and
+                      400000.
+Examples:
+
+        i2c0: i2c@e0170000 {
+                compatible = "actions,s900-i2c";
+                reg = <0 0xe0170000 0 0x1000>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&clock CLK_I2C0>;
+                clock-frequency = <100000>;
+        };
-- 
2.17.1

