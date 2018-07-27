Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A8EC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA72720671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1IH1gnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA72720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbeG0UKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:10:51 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42952 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389143AbeG0UKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:10:50 -0400
Received: by mail-pl0-f66.google.com with SMTP id z7-v6so2671317plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+h5D13GSotrJieezx8G24YEI6Zi+Dguu/+8gIPE1s38=;
        b=H1IH1gnYQuZijzkcUdiOIDp80WWJbIlUn1jiFDOA0IX2iEiSccF/s3tG7VTslAZNb0
         tLDowkGl/jBvOY/UF4oHli3Tg6oQtpieTTnM+3VR0Qo/lGJ746ye9i0CENffmeRXRwVr
         YbsxH9nDACOlFHYFZ7rZ/K8pz+MFyBNVUrir0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+h5D13GSotrJieezx8G24YEI6Zi+Dguu/+8gIPE1s38=;
        b=LsWGIOKIZrQ3mxTdxrAvuyaM2xFCoQwb4oDoxfAmQu09KGdpaP4R+E++TgpS13x4WO
         QR3YR0WbaqSOEvNoNX8YEkEXmreSo7bwEqaupluMuOXvmXNr8jxUSzQVrZ6HjUhVfz6B
         5KAzsvRgJjAa/KS/btLa/pYU47EOken2bNV38wIO7nXe/Sn+KLi2leVK8/PMP068zGVX
         E0R4Ryz9eErosVR+98D2EKzgBilSP3h+FXsNxC6bfEX4IAi5Ik4st8EYAClhPHz65Nkx
         ROLZ8bEcM44qybI9qfLTBS1bjIqFW3GQ5zMv5APNuOzTxByl39h8A4UX7Td4O05fVHKG
         kFpg==
X-Gm-Message-State: AOUpUlHLaib0aU7R0MV64sTC9osg+tTiAYylCECUM8vkdTnygLLo4x8l
        12vFYTTIsE8tazNOiw6KrXz9
X-Google-Smtp-Source: AAOMgpcovtQuc4W8ifnqPLM2KkvN331PgSG84LNW9MYJo8oZOJry3yW1WwHztgapIXb+kpePEjR6YQ==
X-Received: by 2002:a17:902:50ec:: with SMTP id c41-v6mr7104865plj.269.1532717261277;
        Fri, 27 Jul 2018 11:47:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7308:c330:41b:cc59:b463:ec7b])
        by smtp.gmail.com with ESMTPSA id t69-v6sm13817959pfj.7.2018.07.27.11.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 11:47:40 -0700 (PDT)
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
Subject: [PATCH 5/9] arm64: dts: actions: Add Reset Controller support for S700 SoC
Date:   Sat, 28 Jul 2018 00:15:23 +0530
Message-Id: <20180727184527.13287-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller property and bindings header for the
Actions Semi S700 SoC DTS.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 59d29e4ca404..db4c544d5311 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/actions,s700-cmu.h>
+#include <dt-bindings/reset/actions,s900-reset.h>
 
 / {
 	compatible = "actions,s700";
@@ -165,6 +166,7 @@
 			reg = <0x0 0xe0168000 0x0 0x1000>;
 			clocks = <&hosc>, <&losc>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		sps: power-controller@e01b0100 {
-- 
2.17.1

