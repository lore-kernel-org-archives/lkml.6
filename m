Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02EFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2D620673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qan4PZdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2D620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbeGZREI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:04:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38551 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731856AbeGZREI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:04:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3-v6so1414925pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bcvpf2JwZdjv59xkZ4zzQ6yiuLiqFtQKkQsfAovx0i4=;
        b=Qan4PZdZzY53hQ+6gh/+gQK0PvtEuDvcDTEUbMwFrHvW0nb34W6jUq/lbBSFYwZXOD
         o91EGS/Q8qF/CCRL8ISSy2n1ro5AZ/4zPvD/eLBjLJ+LF2321Ue2YKgAWQzAhXMb3qCd
         yLfU/k9PklEu4wVOzKRRMR1nRgDSPou7Nq6pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bcvpf2JwZdjv59xkZ4zzQ6yiuLiqFtQKkQsfAovx0i4=;
        b=WkY0R0bv0ASQjLbIElV2GKGzimzajzuBLV3tqj1cwzWAJZZTekYjObGs1sNXMk190f
         ErCOBhoFSsfG96zWOnMx4FJLzkuRWaV4nxPhksIsZl2KHpHJl4VK5pCWdcIyUcjZbwcs
         FtoU/bMN0h3xRKZdXwrKLrD+ZQZlI7Vq5M7Oq6F+l7hR80+XNKts2Tj9aa4vQG2DAJed
         i6g0rr/9rCnqGEditWo7rjuikL9cmz0+Ab5/2EA18tY+WPImGynhzwWs8EnhWkgoXRR6
         5jSP3kJ9NC67k2lvv7l0MTswcxMQK6CVWz26da7C3lk+MYz8zvqdMQ/zXqRijCZZy9wH
         M2sw==
X-Gm-Message-State: AOUpUlEFq8YhQyPb4U+9Tlor5/91HkYJu4io9xLo/OtlZ3XFjm0gZvTa
        a83xqRI9LebAlEuiDbJxxnuC
X-Google-Smtp-Source: AAOMgpd9DsOp0xsqrFXCdCUXm72rZ43QM5HhP7aZfkJyPWJwsjhDxrcyngucNEmbMydTWVn3eln21Q==
X-Received: by 2002:a63:4283:: with SMTP id p125-v6mr2520935pga.142.1532620003047;
        Thu, 26 Jul 2018 08:46:43 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:628e:aef6:6d51:3501:dada:e06d])
        by smtp.gmail.com with ESMTPSA id z11-v6sm3755322pff.162.2018.07.26.08.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 08:46:42 -0700 (PDT)
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
Subject: [PATCH v7 1/6] dt-bindings: i2c: Add binding for Actions Semiconductor Owl I2C controller
Date:   Thu, 26 Jul 2018 21:15:58 +0530
Message-Id: <20180726154603.5089-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
References: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
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

