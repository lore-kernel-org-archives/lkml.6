Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31038C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B060127755
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="buYo29t2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B060127755
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030368AbeF1SMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:12:08 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42077 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967683AbeF1SL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:11:59 -0400
Received: by mail-pg0-f65.google.com with SMTP id c10-v6so2812061pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aNqyghA/+YELYPCfAy6P30ix4otp9ywUK1kCBsmdfz8=;
        b=buYo29t2qO4dqkxFWlnyU0cv4pdxbR8W4ZyI3eRLOuTO4VfdKxpNd9XM3Zzec0dVtY
         LLfxgqioskBofSVwTFIsd26xpBLmjsH05COyplIglPW+aHXzYxo2jLBREuIxQTYxV6Gd
         A92EyNTS5dPNGtZf8NKx4tobcpXMcM1q5GMVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aNqyghA/+YELYPCfAy6P30ix4otp9ywUK1kCBsmdfz8=;
        b=CYvg7LttE0iMOZrSslHF+FeX7XKl65WnCQbyv2uYgBwlg5L2ivz52B1oi52u2KFK27
         algFtcCaPn8lf4ndzAScXDSsHPUp4coOGpp0x7s51D+Yp+c7R2o5o69MxHPUqfSjA7KP
         Nv9t3zBPpEXxb7FVVCK1764h/+DKTE4VkzaB59CBL3B1l1zIkPZlKbudUlHFQEi5Dal3
         kCEpx746mzzgVa7zpe+tG2KrGtB4OSiat7zkmoOUU7ZIcLk31ZMKbT8Qxdv+ocgEigi7
         qU256b8705xgn0kNwaHougR6Zx+uqhFqp/r/3s4MmWxYnHgF62sTKjaZuM6hXwcczaKu
         5IZA==
X-Gm-Message-State: APt69E16rrYjYnXWIBfFMERPXNPBwQcJ0CCn/P6+uWdD7Bw+BoxMxbkF
        KiGK+CTeVz0ry0YuZb0v9lll
X-Google-Smtp-Source: AAOMgpcELhip9VUF/N/Rld/vRdzC+J/NaFGgKbdKdyvrvsPAe0ARl/gUeiZ2Yb6D2tPlWNKuDhtZuA==
X-Received: by 2002:a62:5601:: with SMTP id k1-v6mr11193384pfb.212.1530209518745;
        Thu, 28 Jun 2018 11:11:58 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7141:9f8e:c1c3:7dd1:e694:9dc2])
        by smtp.gmail.com with ESMTPSA id o13-v6sm13293132pgn.93.2018.06.28.11.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:11:58 -0700 (PDT)
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
Subject: [PATCH v2 1/6] dt-bindings: i2c: Add binding for Actions Semi OWL I2C controller
Date:   Thu, 28 Jun 2018 23:40:37 +0530
Message-Id: <20180628181042.2239-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Actions Semi OWL I2C controller

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-owl.txt       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
new file mode 100644
index 000000000000..9b691968cffd
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
@@ -0,0 +1,27 @@
+OWL I2C controller
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

