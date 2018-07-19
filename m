Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316D0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34DE206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4vZuKRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34DE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbeGSSaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:30:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35772 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbeGSSaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:30:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so4421918pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=h4vZuKRNXdW3oOo8fZ2we6a4IvDeeDeY55HLfiry6cXfCm21I7Lm1zc0hnQ3Hj5uiI
         cXs6VHxIbd2cCHRcYZ6X1M7qxgi7PzGhLSdw/rRUqabR6Y27pfJEppX7uwOserLUZZVf
         vCbqyh+o2YJ7NJkf4usBtIuiMsP6hpARmBlts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=Td2btsXQ1KV9YU5i8EQ/vxnU0wn5s1K3bgGg5x8soa22yrOEUh+2+xamlFJ6UE9bKc
         7LyLGaxz46SDo3L0s4MnTaC19gf+XsWugEkwL80fwh4k3J00Vdz+KjbIB5wLV9QcfGp+
         U/hRNmgeh6lCJWTQnb2Dbg1FVQoMBQF7vHBO1srwpYHZ5S5UFLsrTY/F32HLXKRAK0L8
         3PnRh9Lhh4+Zbq85Jq/xCai1IVLT9QB/w2XDKiJvNp0ijt3CMR64mb7b5doXa4XO6yrW
         V3etjmfZXrn2dx9K7gWsT0PcZ5LtNH/HS5L/+/Y3oxjxMWnrP1SIZNsc90a6WvAr92wj
         MnqQ==
X-Gm-Message-State: AOUpUlHrKDBWntbgufcXJoi9LyfS7mvWuQq+8UuV2IezO+ySQxLqD2BQ
        yAkjy+u20oPZ3MzekKSn43EC
X-Google-Smtp-Source: AAOMgpdJhG+CUAOR0ssMUjsRa6qUqQnZnIkq2eOHkPFxF7l8OoDcfXf7qWwO9ozrJxvX07GVLvBPyQ==
X-Received: by 2002:a63:5c10:: with SMTP id q16-v6mr10896378pgb.452.1532022364509;
        Thu, 19 Jul 2018 10:46:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6081:b056:55fa:fd42:61de:739])
        by smtp.gmail.com with ESMTPSA id h2-v6sm10114639pgc.90.2018.07.19.10.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 10:46:03 -0700 (PDT)
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
Subject: [PATCH v5 2/6] arm64: dts: actions: Add pinctrl definition for S900 I2C controller
Date:   Thu, 19 Jul 2018 23:14:01 +0530
Message-Id: <20180719174405.7210-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
References: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
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

