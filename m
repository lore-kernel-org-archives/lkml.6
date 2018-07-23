Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225DAECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F9220858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHJFhobt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F9220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbeGWEka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:40:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39698 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbeGWEka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:40:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so11220295pgs.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 20:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=UHJFhobtUx21zDLqM5NJ2aXrXb1GhQ0ThkEgKq4aIQTYifOHYkIJTQi4q+Ttz0KJVT
         Bhw0cqw4K1pAOeKKFA5joyTGl9kkSP1J//LtHjV6/2V4T+j7RusscB7Ct6iFaD3Z3KeU
         2dco0qUccYO4eeNv/C5nBOLw7GuAnl1HuwqQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G9Pra/HIrTIdZzogTmPr0pWDqZgp6mkljxVwg8UNDhk=;
        b=Nbw+Mo5u+oMPJLF/8j5FuC80mzCbjDDnV2LQg4g+463XcMdNToIcKQzeeDI03RH3uD
         IIJDp/oiePrnBlgXBy1KX5jeQBJwbuA3HKigua5n9jT9uv/cs7pEpnT/P+Clx7zwR39a
         QSWDsa8KJ1+wtUzlg8CzSUuvKcCiA7x4BMaRUuAvNIl73Ys7RBPZ9AJkxM0QNmeIzkUi
         xDmLIdrEhxREoaeWmMzrWb1mdWZHcznt6XyJBXhj9KQjLPWnWuB3yS7mINqcP1YL74Qa
         wnuklimGgoLdBQ/OjT0Kn8gpZiGHv+JosGkXIdLBsyEnoMv02uTX3q2Jlbt6ho1gw1Z+
         5MjA==
X-Gm-Message-State: AOUpUlHwYs0MNmEwq69Cp/MI+yOiuqowgk/O2YvTPUZiGSKNjvuNvTqn
        yW6rMInrhQTZ81pqHlxqWs/i
X-Google-Smtp-Source: AAOMgpdrmWLMivxYejgf0I0/AeESAwBncP++dwLCGgbxKhALzvl1h64ZUM96+gFK8SGuMJSG520JxA==
X-Received: by 2002:a63:1a20:: with SMTP id a32-v6mr10609077pga.446.1532317284176;
        Sun, 22 Jul 2018 20:41:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:802:a98c:b568:c01f:49a2:2aa5])
        by smtp.gmail.com with ESMTPSA id s184-v6sm11340248pfb.56.2018.07.22.20.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:41:23 -0700 (PDT)
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
Subject: [PATCH v6 2/6] arm64: dts: actions: Add pinctrl definition for S900 I2C controller
Date:   Mon, 23 Jul 2018 09:10:21 +0530
Message-Id: <20180723034025.5763-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
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

