Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C85C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7FB244FE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsfNWhf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7FB244FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031487AbeGARYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:24:04 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46320 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965875AbeGARX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:23:58 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so6798502pld.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=YsfNWhf8iMxCGRYDJ9O4Pqs0HloPgbMBO0z3Bj2JC2qYpcKnlfY3+17XhH3hHvkMt3
         J42cVf5kHo7uPGoTzlmq9Hwj7XZgO0J5E+tVGI1HuO3Hb3Ia3hNHX2vqhgVvDjLarsUl
         RhmGSIQDJwGObo+PuJU2Sv38mL6zJY5FSyk9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=hOOvDNqrDE3sS7i9zIBAVJ3oueLOL++SRw2yyWb1V9j/qxwFrd+Ciqk/2RjX6fSS0a
         Udx+GOaaJ7bi0Vd9qxtWVBKZ5UjwQaVT81cfErybv1TNTKqcmWcG4ls8k8hzguCYpWWI
         xQubMNEY5+4IrKArpwRSUETbjZ4pxUroFGXv89bz8l2CPfl+uVVudWjxGB1szCWUdTRr
         xj1iH3f2wZ/j+aVAu7uFSrHSbzUjwW4aYepQEmn2caXJUvrWWCcDtuaDID6QzB/ccwWl
         5IxI2d8ZF3rWTanAPH+unmTFAHbMZTHpVSqg/G8u5TpcEmje8Rcg3WjLQNzuSGiJ3taH
         SKUQ==
X-Gm-Message-State: APt69E3TgdvKebcdJUU3fZZrGCwhke2nPmG7okvuQIi809+eB5cENRfv
        VsmSS9KX9IvnDb3zIdoH7OyI
X-Google-Smtp-Source: ADUXVKJtU31UFMeQUsCbNIsP4E+KFOQiGrXdGSz8XVeQHMBVV6JffcqWi1Jxp+nn4Swj2UeXcABbcw==
X-Received: by 2002:a17:902:b418:: with SMTP id x24-v6mr22792424plr.2.1530465837721;
        Sun, 01 Jul 2018 10:23:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:900:ea77:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id f10-v6sm17989836pgr.30.2018.07.01.10.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 10:23:57 -0700 (PDT)
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
Subject: [PATCH v4 2/6] arm64: dts: actions: Add pinctrl definition for S900 I2C controller
Date:   Sun,  1 Jul 2018 22:53:01 +0530
Message-Id: <20180701172305.15663-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
References: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
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

