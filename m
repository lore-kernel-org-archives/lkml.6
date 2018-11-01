Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F496C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E4620820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEEWNzYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E4620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeKAPVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 11:21:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43496 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbeKAPVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 11:21:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id h4-v6so8796923pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 23:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v+EkBGJYgP5l8roNkAIcHxwpqxLvNbg8+WmAulqw8rE=;
        b=VEEWNzYJqVxzRp5nUEcf4low8ru4KTj/4fucaPtLl4MAP/WEoaPAcOaKIAVOocYWLR
         xT8tsrmemLd1/oW4p/0AoxJJk4f9XmDm8n0Oloc8b9SUMccsjLBQTfPxw5gwVmUHW85Q
         k1Z4q5rJjkphEx5AFQRw9S5ZpXmqYXuUaMQ1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v+EkBGJYgP5l8roNkAIcHxwpqxLvNbg8+WmAulqw8rE=;
        b=jexZGj9vlUWX2R3pYgrtrdoVEMgQbzlCruj8lXsT0VwPXESCcaJZB3mup5atd9bVV0
         fqkOHXyUNOl1MZAftimAXVu4C/tCQN4aGxNA4jj+x/BYztc1BFtX7IdwkRdbEV+CIrm5
         I/msKJG3krDreqeVCqsDBOk2UrpxT441e65xzU0b+Ghb53gBCCe6wMVIbLBCSFKxbeGs
         drAf15MuWNadu1y47rxHC5vxb9iHh8fwB0AtpTLZFAZPL1cYHLA0yx5HDuCC6PUKJgwt
         Vb6w/an4sE8Iiv+KORQLxOnm66su0Nlnp8pSUYBwfPsjCAQ40rEbDvF2mzGqXV722Nze
         LNzw==
X-Gm-Message-State: AGRZ1gISpeWtTzbNR4pYXUAEFQdTzj9zETt/kHABvFdjjnNoLVpS/l4i
        Fl3ISl94XYBtxrb3AfvqOXNI
X-Google-Smtp-Source: AJdET5eu6kg2rs9okVZyGbY7ZM1UYUipbIE1DM0inIYY/dk8lqAYcd/IbVfzkdz36O9HdDPIIaawQw==
X-Received: by 2002:a63:4c4e:: with SMTP id m14-v6mr6063895pgl.173.1541053179877;
        Wed, 31 Oct 2018 23:19:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:900:77c6:7824:4800:6aa6:75b4])
        by smtp.gmail.com with ESMTPSA id u190-v6sm71346726pgu.3.2018.10.31.23.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 23:19:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sean.wang@mediatek.com, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/4] arm64: dts: mediatek: x20: Add pinmux support for UART1
Date:   Thu,  1 Nov 2018 11:49:06 +0530
Message-Id: <20181101061907.20224-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101061907.20224-1-manivannan.sadhasivam@linaro.org>
References: <20181101061907.20224-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinmux support for UART1 on MediatekX20 Development board based
on Mediatek MT6797 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts | 2 ++
 arch/arm64/boot/dts/mediatek/mt6797.dtsi        | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
index 742938a1a548..13939d55b85b 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
@@ -30,4 +30,6 @@
 
 &uart1 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_a>;
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 231230d32d09..a64bb84bdec3 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -141,6 +141,13 @@
 			    "iocfgr", "iocfgt";
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		uart1_pins_a: uart1 {
+			pins1 {
+				pinmux = <MT6797_GPIO232__FUNC_URXD1>,
+					 <MT6797_GPIO233__FUNC_UTXD1>;
+			};
+		};
 	};
 
 	scpsys: scpsys@10006000 {
-- 
2.17.1

