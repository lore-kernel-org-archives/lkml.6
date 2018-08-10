Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C785C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A56223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGzonvUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A56223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeHJMWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:22:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38516 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeHJMWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:22:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so4292036pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DwKugHCgj7TpoVeG3f0Y/2LdewKxgh4h4yjO9QRfsGI=;
        b=GGzonvUF2OOViZIuHzjTHGOGvFHbqBl53HWKD/tv73dIQX5FCb3GLLr0FuY4sllsix
         ry0HAI66zHg12LUwcglH4NkEvn3hT+QSdEmEwg3C3F6uHPtyRZdE2pECvxu+d2W4vT5l
         /EOy8/omAC5eBy+o2hNWITlQEEetFDaWd/vGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DwKugHCgj7TpoVeG3f0Y/2LdewKxgh4h4yjO9QRfsGI=;
        b=Qvc3BuZyb7uDE0c34SuI+3L9s3d7VfFr0HxZFxn02Wr4PXRB/jXMsbbn8SOuzkA3yf
         xR24lTFtlfdp+OWZIAScU1dbvJwj73fAXjo+CThq17SM6zzDzjEobV7/HQpFaTpNkfdZ
         HFvbnVlEODyphh9qr19cPFKNJskBUZej1eKvUG1IFTs98vFssTIJNoMLVVfZ1VtS04QQ
         BUzZW8SqeOHJCcrPWZb5h7AbfGpyqpbAu0o1B9vrgXeCiLTkfmQoqHrm4wLXvu4SKyT1
         4Y6IgFN9sWNcpMtnZCDGVo8ZC4nbFM+dDwW5zxnXNy3kUk7Wxdc4Or/FxtFYhSZAscvp
         x3XA==
X-Gm-Message-State: AOUpUlHYDj8vbYSQGnsBPR8BjvEy9+WERDF8NOETTbUnchF/5OWt3SGx
        eFD9aVheB4xgLpaM5lalBB16
X-Google-Smtp-Source: AA+uWPzDQWBaFU/lVCBg9Wh8mU20nRpV+LcSXWgPSoNzCcc0jPabpzDeAQSndBKpgl51+mkmqHibKw==
X-Received: by 2002:a63:ce43:: with SMTP id r3-v6mr5707205pgi.439.1533894804162;
        Fri, 10 Aug 2018 02:53:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id n83-v6sm25315120pfk.19.2018.08.10.02.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:53:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 6/9] arm64: dts: actions: Add Reset Controller support for S900 SoC
Date:   Fri, 10 Aug 2018 15:21:10 +0530
Message-Id: <20180810095113.25292-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller property and bindings header for the
Actions Semi S900 SoC DTS.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index aa3a49b0d646..4fbb39fd7971 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/actions,s900-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/actions,s900-reset.h>
 
 / {
 	compatible = "actions,s900";
@@ -172,6 +173,7 @@
 			reg = <0x0 0xe0160000 0x0 0x1000>;
 			clocks = <&hosc>, <&losc>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		pinctrl: pinctrl@e01b0000 {
-- 
2.17.1

