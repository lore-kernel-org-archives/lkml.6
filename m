Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCA8C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A88724C70
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDEu058g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A88724C70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeFWQMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:12:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37939 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeFWQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:12:36 -0400
Received: by mail-pg0-f68.google.com with SMTP id c9-v6so4256986pgf.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 09:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J1OYTWw+kcNsg7QWXAtAWguxWjrzRt996LRNo3FbPBM=;
        b=WDEu058gnmVH2PzDN7liFPmKJUCcc+sSqEgVM8hwdhGztI8pZz2tD//SWZ/njL19Un
         2+FsIkE7+4FjmLk6tiAq1AN0q5vji2T5XhvrXMcHQvUNy7F+d/zBBtjfcRP9Bn9/2lv5
         Ijq/2pmbJkDQplY4lQHGzRvaE/mL4Gp4dfiZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J1OYTWw+kcNsg7QWXAtAWguxWjrzRt996LRNo3FbPBM=;
        b=Dc0XzzwKtZPvkWEeDZXoYotrFSWUszpwA4jpHa33ccdvXZgiLyYVG6yb6UVlJe+Xs+
         iLhiPPHJxG84rzDM3xo+8/k8TQl/KvmV3cAUKpS2RweQ3gJNBMpcYAc97lh/fC5iL4S0
         TqM6zA7MkNUDPF8SrLWu2yXEfaeD9vFbgJ5s7PvGGjp+YwH5OOPm8pEi0r/vFmxoOMCN
         +zCcuSQqsASMSXS4rWfmvTOUVhhj5sWW3GEzVm9nMFjPYkrhBnJjaqFjdB0XUw/KYg3d
         UU1mSdjLmaQry19NZBdVthIEBVt6eueZOPZvnExa9Gf2hq9l/1qTXvVy/jR1k2JvA+Qz
         aAww==
X-Gm-Message-State: APt69E0nVmltQZ2V7sDJYxONtGQKP1WKKqmiG9x8zXxd4N8Mf3zlr9U6
        40Ml+4kbtqmSsuGmHuM5nuCg
X-Google-Smtp-Source: ADUXVKLKeP+rWSxq+tD/qOsBGwRuX6d/BRaWM40Y+LZ8DM6VqPSvMW2RTUxncRZRv9uCx6mUdHwSoQ==
X-Received: by 2002:a65:5348:: with SMTP id w8-v6mr5371168pgr.247.1529770355527;
        Sat, 23 Jun 2018 09:12:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:100:fa16:6549:5166:32c7:2dab])
        by smtp.gmail.com with ESMTPSA id n26-v6sm2732745pfi.168.2018.06.23.09.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 09:12:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de,
        linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/5] arm64: dts: actions: Add pinctrl definition for S900 I2C controller
Date:   Sat, 23 Jun 2018 21:41:45 +0530
Message-Id: <20180623161147.15672-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
References: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl definition for Actions Semi S900 I2C controller. Pinctrl
definitions are only available for I2C0, I2C1, and I2C2.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../dts/actions/s900-bubblegum-96-pins.dtsi   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi b/arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
new file mode 100644
index 000000000000..e46ae187b27e
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

