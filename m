Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60515ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFDC20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpkRgRu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFDC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbeGSSaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:30:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35736 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731979AbeGSSaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:30:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so4421430pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bcvpf2JwZdjv59xkZ4zzQ6yiuLiqFtQKkQsfAovx0i4=;
        b=FpkRgRu4dZleXRYQhUHMPXQ3tgX+QkA1HLbi1Opbp7v/6nxT4vkJadaVL0yMYCO4ew
         YR/DxkQ71DKCwjncumnjEA/Fjj1v1a4o8nfniQBK7GSlsrd48GVwdYwCN7fwxM67zCAV
         g49q0LYpVGbGS4G/CVrpfITQ6EAb62JdtM6kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bcvpf2JwZdjv59xkZ4zzQ6yiuLiqFtQKkQsfAovx0i4=;
        b=Sbz2WP/88wfrF0Hr4tZWF17iAk2KzL4ol/MGFRW2VBYV6vnLppOcjH+/8uMdX8A/sP
         zT4eAs2Bd7PyZq82qy134bvlhFpPlZCGuwyKh5VaWHTk7IUQ/TMVBDSZZ605u+4+wXBX
         n5kApKkbmfwtqF+32OGQ1CiXbFD+9QsHDrpszigGnryVbxnsMCikRIqL5/MiTm5sdbHX
         ZCBXk2fEouKTcBKld/AYoBZcFhWt9D0FIFmsJud/Sb76MO62qJa83JweEa7+dyQ+U9hL
         tbDu6mCXBWyyRBUf0CVy5f1Aok3/5ePp6h5n137Ca4rkcTTGec+spDBp5iqeRm8YzkXG
         MCQg==
X-Gm-Message-State: AOUpUlGABjEFrnLpj+ny1CsZKv0f5e/Ksa47y+MpAtwelRAL2JtKM8BQ
        rLMmdBcAQ9XElwO0C4IHZ709
X-Google-Smtp-Source: AAOMgpcHavmKsGP3XLtSMtxmmVq8QuURM4nOgCeqxFk9mBNAMogh7FDBKM5afHsxw92sQvmu+bAx8w==
X-Received: by 2002:a62:843:: with SMTP id c64-v6mr10540670pfd.14.1532022354235;
        Thu, 19 Jul 2018 10:45:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6081:b056:55fa:fd42:61de:739])
        by smtp.gmail.com with ESMTPSA id h2-v6sm10114639pgc.90.2018.07.19.10.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 10:45:53 -0700 (PDT)
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
Subject: [PATCH v5 1/6] dt-bindings: i2c: Add binding for Actions Semiconductor Owl I2C controller
Date:   Thu, 19 Jul 2018 23:14:00 +0530
Message-Id: <20180719174405.7210-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
References: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
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

