Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738A2C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3002620671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAOQ9G5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3002620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389263AbeG0ULE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:11:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36548 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389244AbeG0ULE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:11:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id d14-v6so2027010pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DwKugHCgj7TpoVeG3f0Y/2LdewKxgh4h4yjO9QRfsGI=;
        b=KAOQ9G5/n0DYQdaQvRpc4Ejd/NG+ar4PlWyFTAr6EXs/oJFjvOLClwfOdwkBmnwcpm
         X9bOulqroRDdIAr3lbnW4a4go8g3/i1R2TTNhrEnCNwLbtWYqTJeO2KN2nQgtWbOVTST
         eR4SZe/Y5LQB5U/+FF7+DgQtsocAdef2k6cdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DwKugHCgj7TpoVeG3f0Y/2LdewKxgh4h4yjO9QRfsGI=;
        b=ijTL3g4s97vJsb44wOiMPMDzEphG9QBLuvu+9lyBLn/nKDpgzzkOjesCSVZkZIj/CE
         N2yPBDCEi3HVDyHj55uWIvPFV4dnfByAFvgQbNsFLn6c73N0DAAebJ9dSos1jq4MIVB2
         Gu94vshk1A4QTfHba+V2d8mWVJkrAqJn2BNz7VPkEysnpAjskNH/K2aATgmwhD4hilgz
         JvTwPZqz+ZW3HFj2yxxtv33T76Bn+b7MW+mb42K9VqbFf5CDQ1NTdst2990dBzqg+n2U
         a/toWPciZN2ZytUcz4I5Id0UlGJSYDidtY0taAQDLhxT+UDSWMOsYP1XSTbC5ci6aSMH
         jyjQ==
X-Gm-Message-State: AOUpUlELA+I/ntu9aByI6t9gFuZiYmdie0Nn7lw4CcuWbPa1VL0fZcey
        O4zGV5FN5CkIDXB5s19WYtlA
X-Google-Smtp-Source: AAOMgpdGA/YeJkhlJFREHcWFT5WHx90rPyCel5adMKEuTFyTsE3YWn9myWKREr5dNDAOYPDlnxL5KA==
X-Received: by 2002:a63:2ec3:: with SMTP id u186-v6mr7085281pgu.225.1532717274622;
        Fri, 27 Jul 2018 11:47:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7308:c330:41b:cc59:b463:ec7b])
        by smtp.gmail.com with ESMTPSA id t69-v6sm13817959pfj.7.2018.07.27.11.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 11:47:54 -0700 (PDT)
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
Subject: [PATCH 6/9] arm64: dts: actions: Add Reset Controller support for S900 SoC
Date:   Sat, 28 Jul 2018 00:15:24 +0530
Message-Id: <20180727184527.13287-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
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

