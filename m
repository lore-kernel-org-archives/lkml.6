Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E825C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AB02083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SovSX1LI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AB02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbeHATv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:51:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35006 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbeHATv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:51:26 -0400
Received: by mail-pl0-f68.google.com with SMTP id w3-v6so9155728plq.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=SovSX1LIT/1jxUkHQwKdsBbNJtUX0OMhBqgXlURwDXvOLYMqhXk5dtbSfH/KyzErpO
         IHMKOncLSa4zZtwMzbAU3f/Dt1lzKA+Y/0b034g6w+dXUAs3mNeVD6slzD2M8AI4z4cE
         H3DHrdRWlbzw62+e3lTiSSFG/2lqrM0XI0KxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=ewHKErnJe+Sy8FsiJYeOVUX17VIIoQAZi7qSI28j6XK8gV+4GNduPdkHRkCNNNBc5H
         iu3yPqXxRDvr1rFCppjDm45aVC0b1C6HW51E+nNQlY0K7bwkqAULpXLHUiAubdqtUzpb
         qrbYOLmVmyl5fADWF9vxD6cmAnjp9bPXdWKwwWRhku3Y6buAMMqeEzoYuawLlvSvYUPX
         gJPLgatLKRKUUOuzfjamzlBDdypJOkV0CyzCFePvAeKPwiV0FvdSxLYPnMv4zIoSfFSU
         r233Ca+sEnasowDU/t1TDyMqr4iU1+Iw+9hFLaRK8e5WmpO0+HPC5+fnSnFKRJgUlTjZ
         KasA==
X-Gm-Message-State: AOUpUlEtXGsP4u8UzViPC3maDcBJCA5RwSZMh8R7g4d9+9iUw5DFhXf9
        MNhtXzDmXskpK3F2VmKzhbZTIOkWcA==
X-Google-Smtp-Source: AAOMgpe4jOFTviGzxn4Zq0gXvoxJaLdFu2WX8RkUKy1nxJJb0I3zftZa4OcXfPBIlUsQya/UuGNs1w==
X-Received: by 2002:a17:902:64d7:: with SMTP id y23-v6mr25564724pli.53.1533146672054;
        Wed, 01 Aug 2018 11:04:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c1:5a70:e532:a47d:7290:5aa6])
        by smtp.gmail.com with ESMTPSA id x80-v6sm12961649pfe.129.2018.08.01.11.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 11:04:11 -0700 (PDT)
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
Subject: [PATCH v8 2/6] arm64: dts: actions: Add pinctrl definition for S900 I2C controller
Date:   Wed,  1 Aug 2018 23:32:28 +0530
Message-Id: <20180801180232.23680-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
References: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
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

