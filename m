Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A642BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A7120673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DC6gZu3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A7120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbeGZREU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:04:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44011 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731949AbeGZREU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:04:20 -0400
Received: by mail-pl0-f65.google.com with SMTP id x6-v6so1000731plv.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=DC6gZu3jfWRhlaATLhMnFFP04tmIDsx0VsdYvuwkDrWcBQrmghBqV61XGG5wxF39F8
         lkAOUeAvBaWtjXzkN8fniu2YiKWimvhHZZFmj7vofEN5iTC047bZ+oXbJeZ7DQJcKao8
         yK3rA5M8hHxXm/YeV+ZYIInDRsSWMA6qs7emo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=dq2+DtXcld3E2R9kYsIzAcSBK9gIcL/CiBdvzpYc5UblvGNTS80iGfFetaI51bjp/F
         y1N5xyi/qalMjCfqYJkzFT43BxXXwQjqeFLGKZUL2WA19YIi/asG0FS+4w++sDKoTyvz
         +QjT9zmsX5pYFoDDFU5lMycXQMIksiTfyPkBTsfZ2M4pC9tWhnzlABdJsg3RaVTeTCGM
         8aSy63mo9Z56xpSnu/0fm2onehBkVjB0/HXvZTBSvfG6v2geJDGId0nC1YHZDCPsm6rN
         z1c/3ThT8J3dfAS7Jsyp2/x92qoa076/4gZPgNAhDWp2R14aB7KcC2RiA02GRN7F65h1
         PwjQ==
X-Gm-Message-State: AOUpUlHOyq/2/FTqhUIFdgmLgbgGRTB92SM4aEsj8rdGeKWsqARMApDi
        FUuT8WXP2VhV6Cn+vM6GSjR1
X-Google-Smtp-Source: AAOMgpcJQ1oBi/1KMGxGtYQfVHm8vgV1qNwkT3p22y54vy23gLYDzashuCluL+42N1btxb/lYC1jpg==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38-v6mr2463010plg.107.1532620014463;
        Thu, 26 Jul 2018 08:46:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:628e:aef6:6d51:3501:dada:e06d])
        by smtp.gmail.com with ESMTPSA id z11-v6sm3755322pff.162.2018.07.26.08.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 08:46:53 -0700 (PDT)
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
Subject: [PATCH v7 2/6] arm64: dts: actions: Add pinctrl definition for S900 I2C controller
Date:   Thu, 26 Jul 2018 21:15:59 +0530
Message-Id: <20180726154603.5089-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
References: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
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

