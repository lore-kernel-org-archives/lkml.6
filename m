Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE9CC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD4A2509F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANrnDkzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD4A2509F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbeF3NeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 09:34:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39154 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeF3NeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 09:34:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id s21-v6so5460775pfm.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=ANrnDkzrqkNdQV0htvGPfOF9tOuJu3aSyY2EikwWVdXmi+s8NmFO0MOECVtZSzL87m
         XJiecyhFzVQpJFCCWdX/kTegmkbqLQ1EjqQ+0j/GdjxKm6+immUNk3+unyDKmtAHTg+p
         TzhPuPFEFOw61lL9oQABA0rxFPsc5pqc5Msfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=ZRt0VpXAve5Co+pSKd9fc1xkIE4prIorHUhl3WJQPeYZrgkbJZFq3UO/0GqvUa2qqd
         XFX+jyS9Vmc0WLVDkMd7VITnooFTmDUKRntjeOQoEiIdie8+5yZIoZ0O8vLyPV/h45u4
         eRUdV7OzTlR8xteaNsD3j10TjB6jdSy2mXXV9s4cWEyXhZWG3E0/1APE0CzQLJpqq+op
         sL+6wKGMOe4zi0B7jFBOSvbvxWY0PKe84HVWmjBhoCEur3/Y4fHHHST37e4YvcCCYF+w
         q8jTVPldR0Np7tYalgxFcStif5r0c526GXdloLMcVF+ZhoT3ULTs1pEkSOgjfvy8OMYt
         Vh7A==
X-Gm-Message-State: APt69E2dgf9h++u6O2JjgzEoHMyKTBQkoILEoltkb1CmwvyLe3WoHHPI
        kUMkqGM0zsGgRKKQlh+n2htU
X-Google-Smtp-Source: AAOMgpekzBM0J0BDdECiWapePq6xUecGbYEWKf8RR8cRb19gkLclwlZ08IjgB+5f/mr4Y5BvzPzz2A==
X-Received: by 2002:a62:4695:: with SMTP id o21-v6mr12704866pfi.176.1530365655776;
        Sat, 30 Jun 2018 06:34:15 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73ca:b257:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id m10-v6sm18738778pgq.89.2018.06.30.06.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 06:34:15 -0700 (PDT)
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
Subject: [PATCH v3 3/6] arm64: dts: actions: Add pinctrl definition for S900 I2C controller
Date:   Sat, 30 Jun 2018 19:03:27 +0530
Message-Id: <20180630133330.23858-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl definition for Actions Semiconductor S900 I2C controller.
Pinctrl definitions are only available for I2C0, I2C1, and I2C2.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../dts/actions/s900-bubblegum-96-pins.dtsi   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi b/arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
new file mode 100644
index 000000000000..95e8b31071f9
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+&pinctrl {
+
+	i2c0_default: i2c0_default {
+		pinmux {
+			groups = "i2c0_mfp";
+			function = "i2c0";
+		};
+		pinconf {
+			pins = "i2c0_sclk", "i2c0_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c1_default: i2c1_default {
+		pinconf {
+			pins = "i2c1_sclk", "i2c1_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c2_default: i2c2_default {
+		pinconf {
+			pins = "i2c2_sclk", "i2c2_sdata";
+			bias-pull-up;
+		};
+	};
+};
-- 
2.17.1

